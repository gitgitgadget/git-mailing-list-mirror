From: Kyle Hayes <kyle@marchex.com>
Subject: Re: [patch] fixup GECOS handling
Date: Fri, 22 Apr 2005 13:46:55 -0700
Organization: Marchex Inc.
Message-ID: <1114202815.31076.444.camel@axer.marchex.com>
References: <1113820589.16288.5.camel@nosferatu.lan>
	 <1113827713.5286.13.camel@localhost.localdomain>
	 <1114179795.29271.18.camel@nosferatu.lan>
	 <1114186599.31076.409.camel@axer.marchex.com>
	 <1114189105.29271.36.camel@nosferatu.lan>
	 <20050422171818.GE7173@pasky.ji.cz>
	 <1114192702.31076.428.camel@axer.marchex.com>
	 <1114196803.29271.52.camel@nosferatu.lan>
Reply-To: kyle@marchex.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 22:43:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP4yq-0003uB-5S
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 22:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVDVUrD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 16:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVDVUrD
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 16:47:03 -0400
Received: from peer.sef.marchex.com ([66.150.8.204]:18180 "HELO
	nosecone.marchex.com") by vger.kernel.org with SMTP id S262127AbVDVUq5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 16:46:57 -0400
Received: (qmail 72692 invoked from network); 22 Apr 2005 20:46:55 -0000
Received: from unknown (HELO axer.marchex.com) (10.101.11.64)
  by nosecone.marchex.com with SMTP; 22 Apr 2005 20:46:55 -0000
To: azarah@nosferatu.za.org
In-Reply-To: <1114196803.29271.52.camel@nosferatu.lan>
X-Mailer: Evolution 2.0.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-22 at 21:06 +0200, Martin Schlemmer wrote:
> Right, but ';' is not cutoff on linux for one, and from what you said
> freebsd as well.  How about this rather (note that I assumed that the
> use of ';' as delimiter will be in the minority, but we can switch
> things around if it turns out the other way):

I'm not sure that __aix__ is defined, but it is close enough.  Someone
with an AIX compiler can correct it if needed.  Anyone know about HP-UX
and Tru64 and all those other ones?

Note that the original code also cuts on '.'.  Is that used by some *nix
in GECOS?

Best,
Kyle

> ----
> (not signed off, etc, as just for comments)
> 
> Index: commit-tree.c
> ===================================================================
> --- 5f61aecb06c2f2579bbb5951b1b53e0dedc434eb/commit-tree.c  (mode:100644 sha1:c0b07f89286c3f6cceae8122b4c3142c8efaf8e1)
> +++ uncommitted/commit-tree.c  (mode:100644)
> @@ -96,21 +96,6 @@
>                 if (!c)
>                         break;
>         }
> -
> -       /*
> -        * Go back, and remove crud from the end: some people
> -        * have commas etc in their gecos field
> -        */
> -       dst--;
> -       while (--dst >= p) {
> -               unsigned char c = *dst;
> -               switch (c) {
> -               case ',': case ';': case '.':
> -                       *dst = 0;
> -                       continue;
> -               }
> -               break;
> -       }
>  }
> 
>  static const char *month_names[] = {
> @@ -311,6 +296,17 @@
>         if (!pw)
>                 die("You don't exist. Go away!");
>         realgecos = pw->pw_gecos;
> +       /*
> +        * The GECOS fields are seperated via ',' on Linux, FreeBSD, etc,
> +        * and ';' on AIX.
> +        */
> +#if defined(__aix__)
> +       if (strchr(realgecos, ';'))
> +               *strchr(realgecos, ';') = 0;
> +#else
> +       if (strchr(realgecos, ','))
> +               *strchr(realgecos, ',') = 0;
> +#endif
>         len = strlen(pw->pw_name);
>         memcpy(realemail, pw->pw_name, len);
>         realemail[len] = '@';
> 
> 
-- 
Kyle Hayes <kyle@marchex.com>
Marchex Inc.

