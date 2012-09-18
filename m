From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Port to HP NonStop
Date: Tue, 18 Sep 2012 00:56:30 -0700
Message-ID: <7vvcfbojbl.fsf@alter.siamese.dyndns.org>
References: <000201cd9569$d16515e0$742f41a0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:56:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDsfi-0001LX-PY
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 09:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189Ab2IRH4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 03:56:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52172 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab2IRH4d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 03:56:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18ABC4D59;
	Tue, 18 Sep 2012 03:56:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OrRlTDzOayIlqaFOV7X/gN0VrP0=; b=Eee7yw
	yhgfIthb8/YqeKKR8gSJawqi9DVbmOXs7yH7I684KKjGSDwEO2kQfsF5tznvJtj0
	0nIoe4cO+WeEWKlHIaOIe+n1KxCSp3IAahXuhh1sedHx56K9u4Ju7PrkwJNsK//e
	ABfgmstaPzw8mjWDMXAjhzvJYkx/SU8HboPqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iBhvC6djzLd985ASSfTPrkWywfrRx6Vg
	esVLcLady61jUXA/3uZ3uB8Wof9JYFrBhPq+04VkDEvGOTXLy6vYGLJM6e33UEB8
	ygu2WwubQBto3g4dlQwgrVrbZNv6kiK6XD3serkcEnWPIQG+88XQXpVtzXirNaXW
	3hwvCQCak9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0636C4D58;
	Tue, 18 Sep 2012 03:56:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 224754D57; Tue, 18 Sep 2012
 03:56:32 -0400 (EDT)
In-Reply-To: <000201cd9569$d16515e0$742f41a0$@schmitz-digital.de> (Joachim
 Schmitz's message of "Tue, 18 Sep 2012 08:49:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C4E8C50-0166-11E2-882F-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205807>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Needs a different link order in Makefile: libintl before libiconv.
> This may affect other platforms, so needs some checking.

It will, and it needs customization, not checking.

> Also I'm not really sure how to best #ifdef the #include <strings.h> 
> and the typedef (u)intptr_t. 

For now, nobody needs these, so enclosing in TANDEM is fine. When
another platform is found to need the same change, which might be
unlikely, new symbols that NONSTOP_KERNEL and that other platform
share can be introduced to replace these #ifdefs.

> Furthermore the -DHAVE_STRING_H=1, needed for
> compat/fnmatch/fnmatch.c doesn't look quite right to me?
>
>  Makefile          | 54 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  git-compat-util.h | 10 +++++++++-
>  2 files changed, 58 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 3d40860..b1d4ef5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1324,6 +1324,52 @@ ifeq ($(uname_S),Minix)
>  	NO_CURL =
>  	NO_EXPAT =
>  endif
> +ifeq ($(uname_S),NONSTOP_KERNEL)
> +	CC = cc -c99 # needs some C99 features, "inline" is just one of them
> +	# INLINE='' would just replace one set of warnings with another and
> +	# still not compile in c89 mode, for non-const array initializations
> +	CFLAGS = -g -O0 # disable all optimization, seems to result in bad code,
> +	# with -O1 or -O0 /usr/local/libexec/git-core/git-pack-objects
> +	# abends on "git push"
> +	prefix = /usr/local
> +	# our's are in ${prefix}/bin
> +	PERL_PATH = ${prefix}/bin/perl
> +	PYTHON_PATH = ${prefix}/bin/python
> +
> +	# as detected by './configure'
> +	#NO_CURL = YesPlease # missdetected, disabled, see below
> +	NEEDS_SSL_WITH_CURL = YesPlease # added manually, see above
> +	HAVE_LIBCHARSET_H=YesPlease
> +	NEEDS_LIBICONV = YesPlease # needs libiconv first, changed further down
> +	NO_SYS_SELECT_H=UnfortunatelyYes
> +	NO_D_TYPE_IN_DIRENT = YesPlease
> +	NO_HSTRERROR=YesPlease
> +	NO_STRCASESTR=YesPlease
> +	NO_FNMATCH_CASEFOLD = YesPlease
> +	NO_MEMMEM = YesPlease
> +	NO_STRLCPY = YesPlease
> +	NO_SETENV = YesPlease
> +	NO_UNSETENV = YesPlease
> +	NO_MKDTEMP = YesPlease
> +	NO_MKSTEMPS = YesPlease
> +	OLD_ICONV=UnfortunatelyYes # currently libiconv-1.9.1
> +	NO_REGEX=YesPlease # Why? ToDo?
> +	NO_PTHREADS=UnfortunatelyYes # ToDo? Using PUT, maybe?
> +	#CFLAGS += -put # not suffient? Seems the wrong fnmatch.h gets included?
> +	#CFLAGS += -DFNM_CASEFOLD=16 # (1 << 4), to get dir.c compiled!?!
> +	#CFLAGS += -Icompat/fnmatch # this doesn't help
> +
> +	# not detected (nor checked for) by './configure'
> +	COMPAT_CFLAGS += -DSA_RESTART=0 # we don't have SA_RESTART on NonStop
> +	COMPAT_CFLAGS += -DHAVE_STRING_H=1 # needed in compat/fnmatch/fnmatch.c
> +	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
> +	NO_NSEC = YesPlease
> +	NO_PREAD = YesPlease
> +	NO_MMAP = YesPlease
> +	NO_POLL = YesPlease
> +	MKDIR_WO_TRAILING_SLASH = YesPlease
> +	NO_SETITIMER = UnfortunatelyYes
> +endif
>  ifneq (,$(findstring MINGW,$(uname_S)))
>  	pathsep = ;
>  	NO_PREAD = YesPlease
> @@ -1555,6 +1599,11 @@ else
>  	LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto
>  endif
>  endif
> +ifndef NO_GETTEXT
> +ifndef LIBC_CONTAINS_LIBINTL
> +	EXTLIBS += -lintl
> +endif
> +endif
>  ifdef NEEDS_LIBICONV
>  	ifdef ICONVDIR
>  		BASIC_CFLAGS += -I$(ICONVDIR)/include
> @@ -1567,11 +1616,6 @@ endif
>  ifdef NEEDS_LIBGEN
>  	EXTLIBS += -lgen
>  endif
> -ifndef NO_GETTEXT
> -ifndef LIBC_CONTAINS_LIBINTL
> -	EXTLIBS += -lintl
> -endif
> -endif
>  ifdef NEEDS_SOCKET
>  	EXTLIBS += -lsocket
>  endif
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 24b5432..7e70361 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -74,7 +74,8 @@
>  # define _XOPEN_SOURCE 500
>  # endif
>  #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
> -      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__)
> +      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
> +      !defined(__TANDEM)
>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>  #endif
> @@ -98,6 +99,9 @@
>  #include <stdlib.h>
>  #include <stdarg.h>
>  #include <string.h>
> +#ifdef __TANDEM /* or HAVE_STRINGS_H or !NO_STRINGS_H? */
> +#include <strings.h> /* for strcasecmp() */
> +#endif
>  #include <errno.h>
>  #include <limits.h>
>  #include <sys/param.h>
> @@ -141,6 +145,10 @@
>  #else
>  #include <stdint.h>
>  #endif
> +#ifdef __TANDEM /* or NO_INTPTR_T resp. NO_UINTPTR_T? */
> +typedef int intptr_t;
> +typedef unsigned int uintptr_t;
> +#endif
>  #if defined(__CYGWIN__)
>  #undef _XOPEN_SOURCE
>  #include <grp.h>
