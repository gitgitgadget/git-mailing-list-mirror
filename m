From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] git-gui: fix "Explore Working Copy" for Windows again
Date: Thu, 25 Feb 2010 01:14:22 +0100
Message-ID: <201002250114.23322.markus.heidelberg@web.de>
References: <20100223225243.GC11271@book.hvoigt.net> <cb7bb73a1002232222r354a2ec7l9ea4cfd1c101e8c6@mail.gmail.com> <a5b261831002240412x30490e25wbec74cdbc1d0ebd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@googlemail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:14:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkRMf-0003D7-FL
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 01:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758662Ab0BYAN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 19:13:57 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:52019 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758523Ab0BYAN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 19:13:56 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 33ECE14FC3D51;
	Thu, 25 Feb 2010 01:13:55 +0100 (CET)
Received: from [91.19.13.83] (helo=pluto.localnet)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1NkRMY-00021E-00; Thu, 25 Feb 2010 01:13:55 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.30-gentoo-r8; KDE/4.3.3; i686; ; )
In-Reply-To: <a5b261831002240412x30490e25wbec74cdbc1d0ebd2@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/6QEHiPiqaoKCcGu/IvrosheHllj5g2i/99xh3
	jX0Y7d9Kin/HxSf6Ug/PRnMru/uPOVOHHcwXCEx2ckGlv5x1wT
	GDLzdJ7ouoCHQ7pjOoeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141016>

It has already been fixed in commit 454efb47 (git-gui (Win): make
"Explore Working Copy" more robust, 2009-04-01), but has been broken in
commit 21985a11 (git-gui: handle non-standard worktree locations,
2010-01-23) by accidentally replacing too much with a new variable.

The problem can be reproduced when starting git-gui from within a
subdirectory. The solution is to convert the path name, explorer.exe is
invoked with, to a platform native name.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

> > > Maybe _gitworktree should be normalized or nativenamified when it is set
> > > and then will work everywhere it is used for every platform?
> > 
> > The only issue with that would be that GIT_DIR and GIT_WORK_TREE are
> > (re)inizialized
> > from _gitdir and _gitworktree, so it would not be safe if git on
> > Windows works better with unix-style rather than native paths. If git
> > on windows handles native paths fine, it should be no problem.
> 
> Tcl internally uses unix type path separators but once you export this
> path to the operating system you may need to ensure it is a native
> path. Typically that means when calling [exec]. [open] is a tcl
> command and will deal with a path variable in either style. The Tcl
> exec man page has some notes on the compatibility issues.

So this should be the obvious solution.

 git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8996d2d..7184afa 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2101,7 +2101,7 @@ proc do_explore {} {
 		# freedesktop.org-conforming system is our best shot
 		set explorer "xdg-open"
 	}
-	eval exec $explorer $_gitworktree &
+	eval exec $explorer [list [file nativename $_gitworktree]] &
 }
 
 set is_quitting 0
-- 
1.7.0.52.gb3f79
