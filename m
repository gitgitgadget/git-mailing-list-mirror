Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 28485 invoked by uid 107); 28 Feb 2010 14:01:29 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 28 Feb 2010 09:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898Ab0B1OBF (ORCPT <rfc822;peff@peff.net>);
	Sun, 28 Feb 2010 09:01:05 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:52787 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935913Ab0B1OBE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 09:01:04 -0500
Received: from [79.210.50.103] (helo=stokes.schwinge.homeip.net)
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <thomas@dirichlet.schwinge.homeip.net>)
	id 1Nljhe-00046L-J2
	for git@vger.kernel.org; Sun, 28 Feb 2010 15:01:02 +0100
Received: (qmail 1340 invoked from network); 28 Feb 2010 14:00:40 -0000
Received: from dslb-084-057-207-194.pools.arcor-ip.net (84.57.207.194)
  by stokes.schwinge.homeip.net with QMQP; 28 Feb 2010 14:00:40 -0000
Received: (nullmailer pid 30411 invoked by uid 1000);
	Sun, 28 Feb 2010 14:00:39 -0000
From:	Thomas Schwinge <thomas@schwinge.name>
To:	u.kleine-koenig@pengutronix.de
Cc:	Thomas Schwinge <thomas@schwinge.name>, git@vger.kernel.org
Subject: [PATCH] tg-delete: Handle the case where the branch has been removed already, but the base is still left.
Date:	Sun, 28 Feb 2010 15:00:39 +0100
Message-Id: <1267365639-30387-1-git-send-email-thomas@schwinge.name>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1267357174-21417-1-git-send-email-thomas@schwinge.name>
References: <1267357174-21417-1-git-send-email-thomas@schwinge.name>
To:	u.kleine-koenig@pengutronix.de
X-Df-Sender: thomas@schwinge.name
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A user might have used 'git branch -D B' to remove the branch B, and then
certain TopGit commands complain, because the base of branch B is still there.

Signed-off-by: Thomas Schwinge <thomas@schwinge.name>

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
tg: (341a371..) t/tg_delete_already_deleted (depends on: master)
