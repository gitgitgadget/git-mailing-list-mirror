From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Make the git-fsck-objects diagnostics more useful
Date: Wed, 21 Sep 2005 10:19:54 +0200
Message-ID: <20050921081954.GB24902@pasky.or.cz>
References: <20050920185605.GA28621@pasky.or.cz> <200509201955.j8KJtWAr003157@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 10:22:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHzpg-000590-31
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 10:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVIUIT5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 04:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVIUIT5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 04:19:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29580 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750760AbVIUIT5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 04:19:57 -0400
Received: (qmail 25690 invoked by uid 2001); 21 Sep 2005 10:19:55 +0200
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200509201955.j8KJtWAr003157@laptop11.inf.utfsm.cl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9031>

Dear diary, on Tue, Sep 20, 2005 at 09:55:32PM CEST, I got a letter
where Horst von Brand <vonbrand@inf.utfsm.cl> told me that...
> > +static void objreport(struct object *obj, const char *severity,
> > +                      const char *err, va_list params)
> > +{
> > +	fprintf(stderr, "%s in %s %s: ",
> > +	        severity, obj->type, sha1_to_hex(obj->sha1));
> > +	vfprintf(stderr, err, params);
> > +	fputs("\n", stderr);
> > +}
> 
> Is this legal? I am under the impression you have to call
> va_start()/va_end() always, even if you just pass the va_list down.

va_list will probably be/contain some pointer, and with va_start() you
"seed" it to point at the stack after the given parameter and slurp the
additional function parameters from there. If you already have it
initialized, va_start() makes no sense.

> The comp.lang.c FAQ <http://www.eskimo.com/~scs/C-faq/q15.5.html> agrees
> with me here... it should be:

That says nothing about passing va_list down.

> static void objreport(struct object *obj, const char *severity,
>                       const char *err, ...)
> {
> 	va_list params;
> 	
> 	fprintf(stderr, "%s in %s %s: ",
> 	        severity, obj->type, sha1_to_hex(obj->sha1));
> 	va_start(params, err);
>         vfprintf(stderr, err, params);	
> 	va_end(params);
> 	fputs("\n", stderr);
> }

How do you then call objreport() ? params would contain another va_list
if you called it the same as before, which would probably surprise
vfprintf() a bit.

BTW, we do the same in usage.c.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
