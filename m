From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 5 Aug 2006 14:18:21 +0200
Message-ID: <20060805121821.GB20807@moooo.ath.cx>
References: <20060805031418.GA11102@coredump.intra.peff.net> <20060805105953.GA5410@moooo.ath.cx> <7vejvve8ci.fsf@assigned-by-dhcp.cox.net> <20060805112851.GA20807@moooo.ath.cx> <7v64h7e7dm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 14:18:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9L79-0003FU-Qb
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 14:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161309AbWHEMSY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 08:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161310AbWHEMSY
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 08:18:24 -0400
Received: from moooo.ath.cx ([85.116.203.178]:6123 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1161309AbWHEMSY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 08:18:24 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v64h7e7dm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24915>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> Arrrrrrrgh!  The message I wanted to send you went to Jeff.
> 
> Your Mail-Followup-To: fooled me.  Please do not do this.
Sorry.

> > Is there any reason not checking isatty()?
> 
> Not that I can think of, but do people really run "git status"?
I do :)

> I think Jeff's follow-up "vim colorizer" makes a lot more sense
> than colorizing "git status" output -- it gives reminder during
> the last chance the user has to notice such problems, which is
> while composing the commit log message.
I like the colored git status.  Here is a patch to honor isatty(1) and
pager_in_use (exporting GIT_PAGER_IN_USE) with pager.color.

---
From c01b26cd332283d3b3feaeae4a8218bb409aea2c Mon Sep 17 00:00:00 2001
From: Matthias Lederhofer <matled@gmx.net>
Date: Sat, 5 Aug 2006 14:09:49 +0200
Subject: [PATCH] git-status: do not use colors all the time

Either [ -t 1 ] has to be true or the pager is used and pager.color is
not false.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 git-commit.sh |    6 +++++-
 pager.c       |    1 +
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index b7269c2..ad0cbb1 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -20,7 +20,11 @@ case "$0" in
 *status)
 	status_only=t
 	unmerged_ok_if_status=--unmerged
-	color=`git-repo-config --bool --get status.color`
+	[ "`git-repo-config --bool --get status.color`" = 'true' ] &&
+		([ -t 1 ] || (
+			[ -n "$GIT_PAGER_IN_USE" ] &&
+			[ "`git-repo-config --bool --get pager.color`" != 'false' ]
+		)) && color=true
 	eval `git-repo-config --get-regexp status.color. \
 	      | while read k v; do
 	          echo color_${k#status.color.}=$v
diff --git a/pager.c b/pager.c
index dcb398d..3ba4166 100644
--- a/pager.c
+++ b/pager.c
@@ -27,6 +27,7 @@ void setup_pager(void)
 		return;
 
 	pager_in_use = 1; /* means we are emitting to terminal */
+	setenv("GIT_PAGER_IN_USE", "1", 1);
 
 	if (pipe(fd) < 0)
 		return;
-- 
1.4.2.rc2.gd71a
