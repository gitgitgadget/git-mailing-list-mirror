From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] This patch is to allow 12 different OS's to compile and
 run git.
Date: Fri, 06 Jun 2008 17:16:50 -0500
Message-ID: <zT6Kk5prw6MLDU9U02XgwHxqkW1_ihaulXp9SEp2upryFMd7jIWyVw@cipher.nrlssc.navy.mil>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com> <87bq2ez72u.fsf@jeremyms.com> <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Harning <harningt@gmail.com>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 00:18:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4kGQ-0002j8-1L
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 00:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759785AbYFFWRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 18:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759481AbYFFWRa
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 18:17:30 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53564 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758948AbYFFWR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 18:17:29 -0400
Received: by mail.nrlssc.navy.mil id m56MGp5b025900; Fri, 6 Jun 2008 17:16:51 -0500
In-Reply-To: <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com>
X-OriginalArrivalTime: 06 Jun 2008 22:16:51.0583 (UTC) FILETIME=[0525C0F0:01C8C823]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84123>

Boyd Lynn Gerber wrote:
> On Fri, 6 Jun 2008, Jeremy Maitin-Shepard wrote:
>> This change will result in the allocated memory being leaked, which is
>> probably not correct.  Perhaps change it to alloca instead.
> 
> OK below is a new version with the suggestions.


Comments below basically amount to:

  1) Use tab when indenting.
  2) Remove commented-out dead code
  3) Don't put space between function name and open parenthesis.


> diff --git a/Makefile b/Makefile
> index cce5a6e..6df008a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -165,6 +165,20 @@ uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>  
>  CFLAGS = -g -O2 -Wall
> +ifeq ($(uname_S),SCO_SV)
> +  ifeq ($(uname_R),3.2)

Indent with a tab not 2 spaces.

> +#    CFLAGS = -g -O2

These commented out assignments should not be included in the final patch.

> +    CFLAGS = -g

Use tab.

> +  endif
> +  ifeq ($(uname_R),5)
> +    CFLAGS = -g -O2 -Wall
> +#    CFLAGS = -g -O2

ditto on comment and tab.

> +  endif
> +endif
> +ifeq ($(uname_S),UnixWare)
> +    CFLAGS = -g -O2 -Wall
> +#    CFLAGS = -g -O2

ditto

> +endif
>  LDFLAGS =
>  ALL_CFLAGS = $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
> @@ -207,7 +221,8 @@ GITWEB_SITE_FOOTER =
>  
>  export prefix bindir gitexecdir sharedir template_dir htmldir sysconfdir
>  
> -CC = gcc
> +#CC = gcc
> +CC = "cc"

This one is up to Junio. Perhaps he has some reason for specifically configuring
gcc. In which case this CC selection maybe should go in the UnixWare section.

>  AR = ar
>  RM = rm -f
>  TAR = tar
> @@ -564,6 +579,42 @@ endif
>  ifeq ($(uname_S),GNU/kFreeBSD)
>  	NO_STRLCPY = YesPlease
>  endif
> +ifeq ($(uname_S),UnixWare)
> +	NEEDS_SOCKET = YesPlease
> +#	NEEDS_NSL = YesPlease

Commented out. Why is it in the patch?

> +	NEEDS_SSL_WITH_CRYPTO = YesPlease
> +	NEEDS_LIBICONV = YesPlease
> +	SHELL_PATH = /usr/local/bin/bash
> +	NO_IPV6 = YesPlease
> +	NO_HSTRERROR = YesPlease
> +#	BASIC_CFLAGS +=  -E -H

ummhmm.

> +	BASIC_CFLAGS +=  -Kalloca -Kthread
> +	BASIC_CFLAGS += -I/usr/local/include
> +	BASIC_LDFLAGS += -L/usr/local/lib
> +	INSTALL = ginstall
> +	TAR = gtar
> +	NO_STRCASESTR = YesPlease
> +	NO_MEMMEM = YesPlease
> +endif
> +ifeq ($(uname_S),SCO_SV)
> +	NEEDS_SOCKET = YesPlease
> +#	NEEDS_NSL = YesPlease


> +	NEEDS_SSL_WITH_CRYPTO = YesPlease
> +	NEEDS_LIBICONV = YesPlease
> +	SHELL_PATH = /usr/bin/bash
> +	NO_IPV6 = YesPlease
> +#	NO_HSTRERROR = YesPlease
> +#	BASIC_CFLAGS +=  -E -H


> +      ifeq ($(uname_R),5)

tabs

> +	BASIC_CFLAGS +=  -Kalloca -Kthread
> +      endif

tab.

> +#	BASIC_CFLAGS += -I/usr/local/include
> +#	BASIC_LDFLAGS += -L/usr/local/lib


> +	NO_STRCASESTR = YesPlease
> +	NO_MEMMEM = YesPlease
> +	INSTALL = ginstall
> +	TAR = gtar
> +endif
>  ifeq ($(uname_S),Darwin)
>  	NEEDS_SSL_WITH_CRYPTO = YesPlease
>  	NEEDS_LIBICONV = YesPlease
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 01c4045..f27aea3 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -39,7 +39,8 @@
>  /* Approximation of the length of the decimal representation of this type. */
>  #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
>  
> -#if !defined(__APPLE__) && !defined(__FreeBSD__)
> +#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !de
> +fined(_M_UNIX)
>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>  #endif
> diff --git a/progress.c b/progress.c
> index d19f80c..295c4e3 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -241,7 +241,8 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
>  	*p_progress = NULL;
>  	if (progress->last_value != -1) {
>  		/* Force the last update */
> -		char buf[strlen(msg) + 5];
> +		/* char buf[strlen(msg) + 5]; */

       This should just be deleted.

> +		char *buf = alloca (strlen(msg) + 5 );
                                  ^
       we don't put spaces between function name and open parens.


-brandon
