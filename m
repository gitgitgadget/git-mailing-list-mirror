From: Junio C Hamano <junkio@cox.net>
Subject: Re: patches
Date: Wed, 07 Sep 2005 19:06:38 -0700
Message-ID: <7vr7c0xqhd.fsf@assigned-by-dhcp.cox.net>
References: <1125962642.15293.20.camel@divert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 04:07:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDBoJ-0006Kz-DV
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 04:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVIHCGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 22:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVIHCGl
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 22:06:41 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51419 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932541AbVIHCGk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2005 22:06:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050908020638.EOJC6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Sep 2005 22:06:38 -0400
To: Patrick Mauritz <oxygene@studentenbude.ath.cx>
In-Reply-To: <1125962642.15293.20.camel@divert> (Patrick Mauritz's message of
	"Tue, 06 Sep 2005 01:24:03 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8189>

Patrick Mauritz <oxygene@studentenbude.ath.cx> writes:

I would have appreciated if you said "Solaris portability patch"
or somesuch on the subject line.

> diff -ur git-core-0.99.4.orig/convert-cache.c git-core-0.99.4/convert-cache.c
> --- git-core-0.99.5.orig/convert-cache.c	Wed Aug 17 09:55:00 2005
> +++ git-core-0.99.5/convert-cache.c	Wed Aug 17 09:58:48 2005
> @@ -1,4 +1,5 @@
>  #define _XOPEN_SOURCE /* glibc2 needs this */
> +#define __EXTENSIONS__ /* solaris needs this */
>  #include <time.h>
>  #include <ctype.h>
>  #include "cache.h"

I'll take this; thanks.

> diff -ur git-core-0.99.4.orig/ident.c git-core-0.99.4/ident.c
> --- git-core-0.99.5.orig/ident.c	Wed Aug 17 09:55:00 2005
> +++ git-core-0.99.5/ident.c	Wed Aug 17 09:57:54 2005
> @@ -36,12 +36,13 @@
>  	memcpy(real_email, pw->pw_name, len);
>  	real_email[len++] = '@';
>  	gethostname(real_email + len, sizeof(real_email) - len);
> +#ifndef __sun
>  	if (!strchr(real_email+len, '.')) {
>  		len = strlen(real_email);
>  		real_email[len++] = '.';
>  		getdomainname(real_email+len, sizeof(real_email)-len);
>  	}
> -
> +#endif
>  	/* And set the default date */
>  	datestamp(real_date, sizeof(real_date));
>  	return 0;

I'll do this slightly differently, because I do not want to have
"ifdef __platform_name" in the code when possible.

> --- git-core-0.99.5/Makefile~	Thu Aug 25 03:54:24 2005
> +++ git-core-0.99.5/Makefile	Tue Sep  6 01:18:32 2005
> @@ -146,7 +146,11 @@
>  		endif
>  	endif
>  endif
> +ifeq ($(shell uname -s),SunOS)
> +  LIBS += -lsocket
> +endif
>  
> +
>  DEFINES += '-DSHA1_HEADER=$(SHA1_HEADER)'

I'll do this in the way similar to how I did -liconv for Darwin.

> +ifdef CURLDIR
> +git-http-pull: LIBS += -lcurl -L$(CURLDIR)/lib -R$(CURLDIR)/lib
> +else
>  git-http-pull: LIBS += -lcurl
> +endif

Curious.  Doesn't the order of -l and -L/-R matter these days?

I am sympathetic to the reason why you need this, but if we go
this route we should also do openssl as well.  I'd drop this
part for now.
