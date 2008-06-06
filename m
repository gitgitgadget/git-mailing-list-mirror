From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] This patch is to allow 12 different OS's to compile and
 run git.
Date: Fri, 6 Jun 2008 18:58:38 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806061835430.19665@iabervon.org>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 00:59:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4kuF-00040m-8J
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 00:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200AbYFFW6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 18:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754941AbYFFW6k
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 18:58:40 -0400
Received: from iabervon.org ([66.92.72.58]:50227 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbYFFW6k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 18:58:40 -0400
Received: (qmail 29171 invoked by uid 1000); 6 Jun 2008 22:58:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jun 2008 22:58:38 -0000
In-Reply-To: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84130>

On Fri, 6 Jun 2008, Boyd Lynn Gerber wrote:

> This patch has patches to
> 
> Makefile
> git-compat-util.h
> progress.c
> 
> This patch allows some older OS's, SCO OpenServer 5.0.X, SCO UnixWare 7.1.4,
> and OpenServer 6.0.X to build and run git.
> 
>         Developer's Certificate of Origin 1.1
> 
>         By making a contribution to this project, I certify that:
> 
>         (a) The contribution was created in whole or in part by me and I
>             have the right to submit it under the open source license
>             indicated in the file; or
> 
>         (b) The contribution is based upon previous work that, to the best
>             of my knowledge, is covered under an appropriate open source
>             license and I have the right under that license to submit that
>             work with modifications, whether created in whole or in part
>             by me, under the same open source license (unless I am
>             permitted to submit under a different license), as indicated
>             in the file; or
> 
>         (c) The contribution was provided directly to me by some other
>             person who certified (a), (b) or (c) and I have not modified
>             it.
> 
> 	(d) I understand and agree that this project and the contribution
> 	    are public and that a record of the contribution (including all
> 	    personal information I submit with it, including my sign-off) is
> 	    maintained indefinitely and may be redistributed consistent with
> 	    this project or the open source license(s) involved.
> 
> Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>
> 
> --
> Boyd Gerber <gerberb@zenez.com>
> ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
> 
> 
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
> +#    CFLAGS = -g -O2
> +    CFLAGS = -g
> +  endif
> +  ifeq ($(uname_R),5)
> +    CFLAGS = -g -O2 -Wall
> +#    CFLAGS = -g -O2
> +  endif
> +endif
> +ifeq ($(uname_S),UnixWare)
> +    CFLAGS = -g -O2 -Wall
> +#    CFLAGS = -g -O2
> +endif

Might be better to have something for CFLAGS to filter out. Also, as a 
general rule, remove old lines instead of commentting them out. If we want 
to undo a change, we can get it out of the version control. :) (More of 
these below)

Also, only the SCO_SV 3.2 one actually does anything here, right?

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

Probably ought to make this conditional on a flag that says that "cc" 
works and "gcc" isn't better; there are a lot of systems, IIRC, where "cc" 
is a lousy vendor compiler (unless you bought the expensive vendor 
compiler) and "gcc" is the modern working compiler that everybody has 
installed.

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
> +	NEEDS_SSL_WITH_CRYPTO = YesPlease
> +	NEEDS_LIBICONV = YesPlease
> +	SHELL_PATH = /usr/local/bin/bash
> +	NO_IPV6 = YesPlease
> +	NO_HSTRERROR = YesPlease
> +#	BASIC_CFLAGS +=  -E -H
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
> +	BASIC_CFLAGS +=  -Kalloca -Kthread
> +      endif
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
> index 01c4045..b57041c 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -39,7 +39,7 @@
>  /* Approximation of the length of the decimal representation of this type. */
>  #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
>  
> -#if !defined(__APPLE__) && !defined(__FreeBSD__)
> +#if !defined(__APPLE__) && !defined(__FreeBSD__ ) && !defined(__USLC__) && !defined(_M_UNIX)
>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>  #endif
> @@ -89,6 +89,10 @@
>  #include <grp.h>
>  #define _ALL_SOURCE 1
>  #endif
> +#if defined(__USLC__)
> +#undef _XOPEN_SOURCE
> +#include <grp.h>
> +#endif

Didn't you avoid defining _XOPEN_SOURCE in this case?

>  
>  #ifndef NO_ICONV
>  #include <iconv.h>
> @@ -206,12 +210,15 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
>  #endif
>  
>  #ifdef FREAD_READS_DIRECTORIES
> +#if !defined (__USLC__)

Can't you not define FREAD_READS_DIRECTORIES?

>  #ifdef fopen
>  #undef fopen
>  #endif
>  #define fopen(a,b) git_fopen(a,b)
>  extern FILE *git_fopen(const char*, const char*);
>  #endif
> +#endif
> +#endif

This seems wrong; it looks like you've added more #endifs than #ifs.

>  
>  #ifdef SNPRINTF_RETURNS_BOGUS
>  #define snprintf git_snprintf
> diff --git a/progress.c b/progress.c
> index d19f80c..11a0841 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -241,7 +241,8 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
>  	*p_progress = NULL;
>  	if (progress->last_value != -1) {
>  		/* Force the last update */
> -		char buf[strlen(msg) + 5];
> +		/* char buf[strlen(msg) + 5]; */
> +		char *buf = malloc (strlen(msg) + 5 );

Do we really have exactly one use of this pattern? I thought we either did 
it more or excluded it by policy. Aside from not leaking the memory and 
not leaving the old version in a comment, it's probably the right change.

Incidentally, you might want to look into "sparse", and getting them have 
an optional warning for code like this that might not be supported by some 
compilers the project wants to support but doesn't actually use for 
development regularly.

	-Daniel
*This .sig left intentionally blank*
