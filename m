From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: fix for optional [branch] parameter
Date: Wed, 1 Aug 2007 23:31:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708012329560.14781@racer.site>
References: <Pine.LNX.4.64.0707080300440.4093@racer.site>
 <20070712222640.GA30532@steel.home> <Pine.LNX.4.64.0708011654510.14781@racer.site>
 <20070801214556.GA2911@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:31:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMj7-0006TJ-2G
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbXHAWba (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbXHAWba
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:31:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:57202 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755818AbXHAWb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:31:29 -0400
Received: (qmail invoked by alias); 01 Aug 2007 22:31:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 02 Aug 2007 00:31:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bzzwx6k+b5wKnTUI1XR392lRs9HFl3e77vuWmwP
	Diz5QfWiB0OOX7
X-X-Sender: gene099@racer.site
In-Reply-To: <20070801214556.GA2911@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54489>


When calling "git rebase -i <upstream> <branch>", git should switch
to <branch> first.  This worked before, but I broke it by my
"Shut git rebase -i up" patch.

Fix that, and add a test to make sure that it does not break again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 1 Aug 2007, Alex Riesen wrote:

	> Johannes Schindelin, Wed, Aug 01, 2007 17:57:25 +0200:
	> > On Fri, 13 Jul 2007, Alex Riesen wrote:
	> >
	> > > Could we also have "git rebase <base> <branch>"?
	> > 
	> > Don't we do that already?  AFAICT it is already in the 
	> > synopsis, ever since rebase -i was introduced into the "next" 
	> > branch, on June 25...
	> > 
	> 
	> Err... "git rebase -i <base> <branch>"
	> 
	> Does not work, just checked:
	> 
	>     $ git rebase -i base branch
	>     /usr/local/bin/git-rebase--interactive: 482: cannot create /home/user/projects/tmp/.git/.dotest-merge/output: Directory nonexistent
	>     cat: /home/user/projects/tmp/.git/.dotest-merge/output: No such file or directory
	>     Invalid branchname: branch

	Sorry...

 git-rebase--interactive.sh    |    2 +-
 t/t3404-rebase-interactive.sh |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d3addd4..bdec462 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -405,6 +405,7 @@ do
 
 		require_clean_work_tree
 
+		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
 		if test ! -z "$2"
 		then
 			output git show-ref --verify --quiet "refs/heads/$2" ||
@@ -418,7 +419,6 @@ do
 
 		test -z "$ONTO" && ONTO=$UPSTREAM
 
-		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
 		: > "$DOTEST"/interactive || die "Could not mark as interactive"
 		git symbolic-ref HEAD > "$DOTEST"/head-name ||
 			die "Could not get HEAD"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index dc436d7..a9b552f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -98,6 +98,14 @@ test_expect_success 'no changes are a nop' '
 	test $(git rev-parse I) = $(git rev-parse HEAD)
 '
 
+test_expect_success 'test the [branch] option' '
+	git checkout -b dead-end &&
+	git rm file6 &&
+	git commit -m "stop here" &&
+	git rebase -i F branch2 &&
+	test $(git rev-parse I) = $(git rev-parse HEAD)
+'
+
 test_expect_success 'rebase on top of a non-conflicting commit' '
 	git checkout branch1 &&
 	git tag original-branch1 &&
-- 
1.5.3.rc3.112.gf60b6
