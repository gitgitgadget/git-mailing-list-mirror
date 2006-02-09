From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] "Assume unchanged" git: do not set CE_VALID with --refresh
Date: Wed, 08 Feb 2006 21:49:47 -0800
Message-ID: <7virrpgjyc.fsf_-_@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<1138529385.9919.185.camel@evo.keithp.com>
	<43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home>
	<Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
	<20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
	<Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
	<Pine.LNX.4.64.0601311807470.7301@g5.osdl.org>
	<7vek2di043.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>, cworth@cworth.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 06:50:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F74gj-0000OS-Sa
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 06:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422803AbWBIFtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 00:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWBIFtv
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 00:49:51 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:31730 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1422803AbWBIFtu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 00:49:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209054842.WAKB15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 00:48:42 -0500
To: git@vger.kernel.org
In-Reply-To: <7vek2di043.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 08 Feb 2006 21:15:24 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15790>

When working with automatic assume-unchanged mode using
core.ignorestat, setting CE_VALID after --refresh makes things
more cumbersome to use.  Consider this scenario:

 (1) the working tree is on a filesystem with slow lstat(2).
     The user sets core.ignorestat = true.

 (2) "git checkout" to switch to a different branch (or initial
     checkout) updates all paths and the index starts out with
     "all clean".

 (3) The user knows she wants to edit certain paths.  She uses
     update-index --no-assume-unchanged (we could call it --edit;
     the name is inmaterial) to mark these paths and starts
     editing.

 (4) After editing half of the paths marked to be edited, she
     runs "git status".  This runs "update-index --refresh" to
     reduce the false hits from diff-files.

 (5) Now the other half of the paths, since she has not changed
     them, are found to match the index, and CE_VALID is set on
     them again.

For this reason, this commit makes update-index --refresh not to
set CE_VALID even after the path without CE_VALID are verified
to be up to date.  The user still can run --really-refresh to
force lstat() to match the index entries to the reality.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 update-index.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

fd4e57f17733d85ed5346d70005ea900cb80b9ff
diff --git a/update-index.c b/update-index.c
index 767fd49..bb73050 100644
--- a/update-index.c
+++ b/update-index.c
@@ -172,6 +172,15 @@ static struct cache_entry *refresh_entry
 	memcpy(updated, ce, size);
 	fill_stat_cache_info(updated, &st);
 
+	/* In this case, if really is not set, we should leave
+	 * CE_VALID bit alone.  Otherwise, paths marked with
+	 * --no-assume-unchanged (i.e. things to be edited) will
+	 * reacquire CE_VALID bit automatically, which is not
+	 * really what we want.
+	 */
+	if (!really && assume_unchanged && !(ce->ce_flags & htons(CE_VALID)))
+		updated->ce_flags &= ~htons(CE_VALID);
+
 	return updated;
 }
 
-- 
1.1.6.gbb042
