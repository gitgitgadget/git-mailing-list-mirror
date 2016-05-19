From: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] upload-pack.c: use of parse-options API
Date: Thu, 19 May 2016 12:10:31 +0200 (CEST)
Message-ID: <721240639.4127450.1463652631815.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr> <20160518180800.GC5796@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Antoine Queru <antoine.queru@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 19 12:04:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Koz-0007sL-Pd
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 12:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538AbcESKEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 06:04:45 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:54361 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754535AbcESKEo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 06:04:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 1A0512513;
	Thu, 19 May 2016 12:04:40 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SKhG-osv6PrF; Thu, 19 May 2016 12:04:40 +0200 (CEST)
Received: from zm-int-mbx6.grenet.fr (zm-int-mbx6.grenet.fr [130.190.242.145])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0932324D7;
	Thu, 19 May 2016 12:04:40 +0200 (CEST)
In-Reply-To: <20160518180800.GC5796@sigill.intra.peff.net>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF44 (Linux)/8.0.9_GA_6191)
Thread-Topic: upload-pack.c: use of parse-options API
Thread-Index: s4jMZVJjDDaLsBkDwuZ6ZhO1gJgGOw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295052>

Thanks for your input.

> > -static const char upload_pack_usage[] = "git upload-pack [--strict]
> > [--timeout=<n>] <dir>";
> > +static const char * const upload_pack_usage[] = {
> > +	N_("git upload-pack [--strict] [--timeout=<n>] <dir>"),
> > +	NULL
> > +};
> 
> Do we need to enumerate the options here now? The usage message should
> list the options from "struct options", which make these redundant.
> 
> Something like:
> 
>   git -upload-pack [options] <dir>
> 
> probably makes more sense.
> 

Yes, you are right.

> Of course, it's hard to read the usage message because...
> 
> > +	struct option options[] = {
> > +		OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
> > +		OPT_HIDDEN_BOOL(0, "advertise-refs", &advertise_refs, NULL),
> > +		OPT_BOOL(0, "strict", &strict, NULL),
> > +		OPT_INTEGER(0, "timeout", &timeout, NULL),
> > +		OPT_END()
> > +	};
> 
> You've left the description text for each of these options as NULL, so
> running "git-upload-pack -h" segfaults.
> 
> I'm not sure whether it is worth hiding the first two options. We
> typically hide "internal" options like this for user-facing programs, so
> as not to clutter the "-h" output. But upload-pack isn't a user-facing
> program. Anybody who is calling it directly with "-h" may be interested
> in even its more esoteric options.
> 

In fact, to do this, I looked at builtin/receive-pack.c, where the parser API
was already implemented, and these first two options were hidden. There were 
also no description for any options, so I thought it was not needed. Maybe we 
could update this file too ?

> As a style nit, we usually spell comparison-with-zero as just:
> 
>   if (timeout)
> 	daemon_mode = 1;

Because timeout is an int, I personnally think it is more understable to 
treat it as it. But I'll update itfor consistency. 

> > +	argc = parse_options(argc, (const char **)argv, NULL, options,
> > upload_pack_usage, 0);
> 
> Perhaps this is a good opportunity to use "const" in the declaration of
> main(), as most other git programs do. Then you can drop this cast.
> 

Ok.

> >  	setup_path();
> >  
> > -	dir = argv[i];
> > +	dir = argv[0];
> >  
> >  	if (!enter_repo(dir, strict))
> >  		die("'%s' does not appear to be a git repository", dir);
> 
> Prior to your patch, we used to check:
> 
>   -       if (i != argc-1)
>   -               usage(upload_pack_usage);
> 
> which ensured that "dir" was non-NULL. But with your patch, we may pass
> NULL to enter_repo. It fortunately catches this, but then we pass the
> NULL to die, which can segfault (though on glibc systems, stdio is kind
> enough to replace it with the "(null)").
> 
> Related, we silently accept extra arguments after your patch (whereas
> before we showed the usage message). You probably want to check "argc ==
> 1", and otherwise show the usage message.

Ok.

-Antoine
