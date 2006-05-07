From: Junio C Hamano <junkio@cox.net>
Subject: Re: [patch] munmap-before-rename, cygwin need
Date: Sun, 07 May 2006 14:14:56 -0700
Message-ID: <7vslnlk04v.fsf@assigned-by-dhcp.cox.net>
References: <f36b08ee0605071258s7a0cb085r3f08e9981234255a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 23:15:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcqaq-0001eY-PY
	for gcvg-git@gmane.org; Sun, 07 May 2006 23:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWEGVO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 17:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWEGVO7
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 17:14:59 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42702 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932231AbWEGVO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 17:14:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060507211457.CLUZ27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 17:14:57 -0400
To: "Yakov Lerner" <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0605071258s7a0cb085r3f08e9981234255a@mail.gmail.com>
	(Yakov Lerner's message of "Sun, 7 May 2006 22:58:48 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19718>

"Yakov Lerner" <iler.ml@gmail.com> writes:

> I found that mmap() works on cygwin, but needs a patch.
> On Cygwin, rename() fails if target file has active mmap().
> The patch below adds  munmap() before rename().

This is interesting in three counts.

 - I from time to time test Cygwin version on my day-job machine
   (W2K) and my wife's machine (XP); on both machines I usually
   have less than two weeks old Cygwin installation, and I have
   not seen the breakage.  I wonder how reproducible this is.
   Also previously people reported mmap() works for some and
   fake mmap is needed for others.  Would this patch make things
   work for everybody?

 - The part you patched is commit_index_file().  This typically
   is called just before program exit, but some callers, like
   apply.c, may want to still look at the index after calling
   it, fully aware that the changes after commit_index will not
   be written out.  Although I haven't traced the codepath fully
   in apply.c yet, unmapping would break the access to the index
   (i.e. active_cache[]).  Does apply still work with your
   patch?

 - As long as you can clear the second point, I do not see a
   particular reason to make this an option; we should be able
   to do so everywhere.
