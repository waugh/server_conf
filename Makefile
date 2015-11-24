F = etc/nginx/nginx.conf
D = etc/nginx

goose_it: /$(F)
	if test -f /var/run/nginx.pid; then \
	    sudo kill -HUP `cat /var/run/nginx.pid`; \
	else \
	    sudo service nginx start; \
	fi

/$(F): c1/$(F)
	sudo cp $? $@

c1/$(F): ngnx_conf_tpl.sh servers servers/* c1/$(D)
	bash ngnx_conf_tpl.sh >$@.t
	mv $@.t $@


c1:
	test -d $@ || mkdir $@

c1/etc: c1
	test -d $@ || mkdir $@

c1/etc/nginx: c1/etc
	test -d $@ || mkdir $@
