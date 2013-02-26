From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Tue, 26 Feb 2013 09:25:04 -0800
Message-ID: <20130226172504.GA2271@ftbfs.org>
Reply-To: CAHXAxrMRxKKiEarSQ0fCLt6-zyS=52B+kmZMLDf8SQAGzGbjjQ@mail.gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 18:25:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAOHY-0005qb-3k
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 18:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186Ab3BZRZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 12:25:09 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:42961 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754773Ab3BZRZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 12:25:08 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1UAOH2-0000eG-Pu; Tue, 26 Feb 2013 09:25:04 -0800
Mail-Followup-To: CAHXAxrMRxKKiEarSQ0fCLt6-zyS=52B+kmZMLDf8SQAGzGbjjQ@mail.gmail.com,
	Mike Gorchak <mike.gorchak.qnx@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217151>

Hi Mike,

Mike Gorchak wrote:
> diff --git a/config.mak.uname b/config.mak.uname
> index 8743a6d..2d42ffe 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -527,14 +527,21 @@ ifeq ($(uname_S),QNX)
>  	HAVE_STRINGS_H = YesPlease
>  	NEEDS_SOCKET = YesPlease
>  	NO_FNMATCH_CASEFOLD = YesPlease
> -	NO_GETPAGESIZE = YesPlease
>  	NO_ICONV = YesPlease
>  	NO_MEMMEM = YesPlease
> -	NO_MKDTEMP = YesPlease
> -	NO_MKSTEMPS = YesPlease
>  	NO_NSEC = YesPlease
> -	NO_PTHREADS = YesPlease
>  	NO_R_TO_GCC_LINKER = YesPlease
> -	NO_STRCASESTR = YesPlease
>  	NO_STRLCPY = YesPlease
> +	# All QNX 6.x versions have pthread functions in libc
> +	# and getpagesize. Leave mkstemps/mkdtemp/strcasestr for
> +	# autodetection.
> +	ifeq ($(shell expr "$(uname_R)" : '6\.[0-9]\.[0-9]'),5)
> +		PTHREAD_LIBS = ""
> +	else
> +		NO_PTHREADS = YesPlease
> +		NO_GETPAGESIZE = YesPlease
> +		NO_STRCASESTR = YesPlease
> +		NO_MKSTEMPS = YesPlease
> +		NO_MKDTEMP = YesPlease
> +	endif
>  endif

Is there a point to the version checking?  I don't know that anyone
has tried to build Git on QNX 4, so adding a case for it seems
misleading.

I didn't realize that QNX 6.3.2 provided getpagesize.  Its header
files don't provide a prototype, so when I saw the warning, I assumed
it wasn't available.  Since NO_GETPAGESIZE is only used by QNX, if
it's OK to reintroduce the warning, NO_GETPAGESIZE might as well be
removed entirely.

I don't think it's a good idea to just enable thread support.  On QNX,
once a process creates a thread, fork stops working.  This breaks
commands that create threads and then try to run other programs, such
as "git fetch" with an https remote.  If threads are enabled, I think
that the uses of fork need to be audited and, if they can be called
after a thread is created, fixed.
