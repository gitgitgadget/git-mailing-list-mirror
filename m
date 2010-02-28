From: Thomas Schwinge <thomas@schwinge.name>
Subject: [PATCH] tg-delete: Handle the case where the branch has been removed already, but the base is still left.
Date: Sun, 28 Feb 2010 12:39:34 +0100
Message-ID: <1267357174-21417-1-git-send-email-thomas@schwinge.name>
Cc: git@vger.kernel.org, Thomas Schwinge <thomas@schwinge.name>
To: u.kleine-koenig@pengutronix.de
X-From: git-owner@vger.kernel.org Sun Feb 28 12:40:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlhW1-0002Mz-5l
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 12:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab0B1Lkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 06:40:47 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:48123 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab0B1Lkq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 06:40:46 -0500
Received: from [79.210.50.103] (helo=stokes.schwinge.homeip.net)
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <thomas@dirichlet.schwinge.homeip.net>)
	id 1NlhVr-0007Gj-7s
	for git@vger.kernel.org; Sun, 28 Feb 2010 12:40:43 +0100
Received: (qmail 32225 invoked from network); 28 Feb 2010 11:40:36 -0000
Received: from dslb-084-057-207-194.pools.arcor-ip.net (84.57.207.194)
  by stokes.schwinge.homeip.net with QMQP; 28 Feb 2010 11:40:36 -0000
Received: (nullmailer pid 21440 invoked by uid 1000);
	Sun, 28 Feb 2010 11:39:34 -0000
X-Mailer: git-send-email 1.6.0.4
X-Df-Sender: thomas@schwinge.name
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141247>

A user might have used 'git branch -D B' to remove the branch B, and then
certain TopGit commands complain, because the base of branch B is still there.
---
 README       |    4 ++++
 tg-delete.sh |   15 ++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/README b/README
index 495c70b..fc74ff8 100644
--- a/README
+++ b/README
@@ -244,6 +244,10 @@ tg delete
 	only empty branch (base == head); use '-f' to remove
 	non-empty branch.
 
+	The '-f' option is also useful to force removal of a branch's base, if
+	you used 'git branch -D B' to remove the branch B, and then certain
+	TopGit commands complain, because the base of branch B is still there.
+
 	Currently, this command will _NOT_ remove the branch from
 	the dependency list in other branches. You need to take
 	care of this _manually_. This is even more complicated
diff --git a/tg-delete.sh b/tg-delete.sh
index ab121c2..e1eea17 100644
--- a/tg-delete.sh
+++ b/tg-delete.sh
@@ -3,7 +3,7 @@
 # (c) Petr Baudis <pasky@suse.cz>  2008
 # GPLv2
 
-force= # Whether to delete non-empty branch
+force= # Whether to delete non-empty branch, or branch where only the base is left.
 name=
 
 
@@ -28,21 +28,22 @@ done
 
 [ -n "$name" ] || die "no branch name specified"
 branchrev="$(git rev-parse --verify "$name" 2>/dev/null)" ||
-	die "invalid branch name: $name"
+	if [ -n "$force" ]; then
+		info "invalid branch name: $name; assuming it has been deleted already"
+	else
+		die "invalid branch name: $name"
+	fi
 baserev="$(git rev-parse --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not a TopGit topic branch: $name"
 ! git symbolic-ref HEAD >/dev/null || [ "$(git symbolic-ref HEAD)" != "refs/heads/$name" ] ||
 	die "cannot delete your current branch"
 
-nonempty=
-branch_empty "$name" || nonempty=1
-
-[ -z "$nonempty" ] || [ -n "$force" ] || die "branch is non-empty: $name"
+[ -z "$force" ] && { branch_empty "$name" || die "branch is non-empty: $name"; }
 
 
 ## Wipe out
 
 git update-ref -d "refs/top-bases/$name" "$baserev"
-git update-ref -d "refs/heads/$name" "$branchrev"
+[ -z "$branchrev" ] || git update-ref -d "refs/heads/$name" "$branchrev"
 
 # vim:noet
-- 
1.6.0.4
