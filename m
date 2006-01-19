From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Wed, 18 Jan 2006 17:18:50 -0800
Message-ID: <7vmzhtqakl.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
	<7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4q41zd1t.fsf@assigned-by-dhcp.cox.net>
	<20060118185229.GA3001@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 02:19:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzORz-0004rJ-OC
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 02:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbWASBSx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 20:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWASBSx
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 20:18:53 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49543 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030277AbWASBSw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 20:18:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119011651.POFL17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 20:16:51 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060118185229.GA3001@steel.home> (Alex Riesen's message of
	"Wed, 18 Jan 2006 19:52:29 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14876>

Alex Riesen <raa.lkml@gmail.com> writes:

> this is probable unsafe too: not all systems export inodes
> (the recent cygwin breakage comes to mind).

Hmph.  I thought that breakage was about struct dirent, not what
we read from struct stat; d_ino is XSI extension so that may
have been the reason cygwin folks removed it, but st_ino is in
BASE --- did they remove that as well?

But you are right.  Among "struct stat" members, only S_IFMT
part from st_mode and st_size are meaningful for symlinks after
lstat() and other members are unspecified.  Which means that, in
the strictest sense, the original test that tried to see if the
timestamp change makes the entry for the symlink cache-dirty,
was pointless.

HOWEVER.

We live in the real world, not in a strict POSIX world.  We (the
index file) relies on lstat() to update st_mtime and/or st_ino,
and I think it is OK (IOW, we declare that platforms on which we
cannot rely on these members are not worth supporting).


By the way, if you have an access to git on cygwin with FAT,
could you test your patch ($SECONDS) and then i-num patch (the
machine with cygwin I can borrow has only NTFS) please?
