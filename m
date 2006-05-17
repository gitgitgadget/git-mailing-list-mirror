From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 16 May 2006 18:25:10 -0700
Message-ID: <4648.1147829110@lotus.CS.Berkeley.EDU>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 03:25:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgAmu-0003Gn-Rv
	for gcvg-git@gmane.org; Wed, 17 May 2006 03:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWEQBZP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 21:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWEQBZP
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 21:25:15 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:65460 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751051AbWEQBZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 21:25:12 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k4H1PAgH004651;
	Tue, 16 May 2006 18:25:10 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k4H1PAA0004650;
	Tue, 16 May 2006 18:25:10 -0700 (PDT)
To: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
In-reply-to: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20153>

And "Stefan Pfetzing" writes:
 - I've been trying to get git to work on the latest Solaris Express
 - release (with the help of NetBSD's pkgsrc).

I've been using it on Solaris 8 and 9 with the GNU tools
in pkgsrc for quite a while, as well as on AIX with the
GNU tools available as modules (but I haven't compiled a
new AIX version for a month or two).

 - It mostly miserabely fails because of common "shell commands" being
 - used with GNU options. (like xargs, diff, tr and prob. some more) On
 - my box (and thats AFAIK the default when you install gnu coreutils on
 - Solaris) the commands do have a g prefix.

In your pkgsrc mk.conf, use:
GNU_PROGRAM_PREFIX=
GTAR_PROGRAM_PREFIX=

I tried your first suggestion (patch all the commands) back
in February.  It's pretty fragile against future changes, and
I wouldn't recommend it.

 - 2.  setup a dir which contains symlinks to the "right" binaries and
 - put that dir into PATH.

Setting a GIT_COMPAT_PATH in the Makefile and prepending
it to the path in git.c and git-sh-setup.sh might be more
sane.  A fragment like the following in git.c before adding
GIT_EXEC_PATH:
#ifdef GIT_COMPAT_PATH
	/* Search for sane external utilities */
	prepend_to_path(GIT_COMPAT_PATH, strlen(GIT_COMPAT_PATH));
#endif

And maybe in git-sh-setup.sh to help those of us who
use git-foo rather than git foo:
if [ ! -z "@GIT_COMPAT_PATH@" ] ; then
	PATH="@GIT_COMPAT_PATH@:${PATH}"
	export PATH
fi

Plus Makefile fun.

Jason
