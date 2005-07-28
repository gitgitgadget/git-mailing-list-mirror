From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Thu, 28 Jul 2005 00:04:47 -0700
Message-ID: <7v64uvh0mo.fsf@assigned-by-dhcp.cox.net>
References: <20050727083910.GG19290@mythryan2.michonline.com>
	<7v4qafrk8w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 09:05:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy2Rr-0006zL-39
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 09:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVG1HEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 03:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVG1HEu
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 03:04:50 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:30407 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261314AbVG1HEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 03:04:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050728070437.SPOT19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Jul 2005 03:04:37 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <7v4qafrk8w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed, 27 Jul 2005 14:50:55 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan, I am dropping this patch, at least for now, after keeping
it in the "pu" (proposed updates) branch and using it myself.
There are two complaints from me.

I am used to "make bin=$HOME/bin/i386 install install-tools",
which the patch breaks (I do not want to build docs for myself).
This is minor; I could say "install-bin install-toolsxx"
instead.

I do not deal with RPM packages myself, but guessing by reading
git-core.spec.in, I think it relies on the install target not
touching the documentation, in order for it to be able to build
doc-full and/or doc-less binary packages.  The patch makes
install target to also build and install docs.

The Debian build is not affected because it does not produce
separate git-core and doc-git-core packages[*1*]; probably this
was the reason you did not notice this.

I think what is installed from the toplevel and what comes from
tools/ subdirectory are divided mostly for historical reasons
and nothing else[*2*], and I do not mind the install target
depending on install-bin and install-tools, but I suspect that
binary packaging folks would appreciate to have a separate doc
target that is not done by a normal install.

Speeding up the build procedure by defining dependencies
correctly is a worthy goal.  Personally I feel a low hanging
fruit is in the main Makefile, before worrying about the make
recursion.  Many things are in libgit.a and when I touch
something only relevant to small number of things, say
csum-file.c, all "git-%: %.c" programs are recompiled and
relinked, even most of them do not link with csum-file.o (this
particular one is only used by git-pack-objects, by the way).

[Footnote]

*1* Which, BTW, would be the Debian way, if I am not mistaken.

*2* Although one _could_ argue that tools/ is primarily meant
for "project lead" role users who accept and incorporate patches
obtained via e-mails.
