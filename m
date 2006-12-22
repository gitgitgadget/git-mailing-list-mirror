From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't define _XOPEN_SOURCE on MacOSX and FreeBSD as it is too restricting
Date: Thu, 21 Dec 2006 16:52:52 -0800
Message-ID: <7v64c492fv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	<86wt4mximh.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
	<caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
	<7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net>
	<caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com>
	<7vodpy3vxi.fsf@assigned-by-dhcp.cox.net>
	<86vek6vyc7.fsf@blue.stonehenge.com>
	<caf068570612201735o776e01a8he2e9ab90fc2ee4f@mail.gmail.com>
	<20061221103938.GA7055@fiberbit.xs4all.nl>
	<20061221112835.GA7713@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Terje Sten Bjerkseth <terje@bjerkseth.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:53:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYem-0003SN-JP
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423168AbWLVAwy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423169AbWLVAwy
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:52:54 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56902 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423168AbWLVAwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 19:52:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222005253.OIRV29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 Dec 2006 19:52:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1ct51W00B1kojtg0000000; Thu, 21 Dec 2006 19:53:06 -0500
To: Marco Roeland <marco.roeland@xs4all.nl>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35105>

Marco Roeland <marco.roeland@xs4all.nl> writes:

> We want our symbols "avilable" so lets not use _XOPEN_SOURCE on Darwin!

Personally, I think hiding interfaces such as strXXX and memXXX
based on _XOPEN_SOURCE level is already a bug in the system
header implementation.  The symbols that begin with str are
already reserved by the standard and I do not see any point
in the system headers to try avoiding namespace contamination.

But we are not in the business of fixing the system headers.

> The preferred way of checking specific Apple specific issues is by using
> the __APPLE__ predefined macro.
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index bc296b3..6f46f36 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -11,7 +11,14 @@
>  
>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
>  
> +#if !defined(__APPLE__) && !defined(__FreeBSD)
>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
> +#else
> +			/*
> +			 * On Darwin and FreeBSD defining _XOPEN_SOURCE always restricts available
> +			 * functions and symbols.
> +			 */
> +#endif
>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>  #define _GNU_SOURCE
>  #define _BSD_SOURCE

Two and half questions.

 #0.5 Have you checked the tip of 'master' that has Terje's
      patch?  It was reported to work yesterday and that is what
      was committed already.

 #1   __APPLE__ vs __APPLE_CC__ is not something I can decide (I
      do not run a Mac).  If MaxOS is derived from FreeBSD, does
      it by chance define __FreeBSD as well?

 #2   Terje's patch excludes _XOPEN_SOURCE_EXTENDED as well on a
      Mac, but yours doesn't.  Is there a reason that you would
      want '#define _XOPEN_SOURCE_EXTENDED 1'?  Do both FreeBSD
      and Mac behave well with it defined?
