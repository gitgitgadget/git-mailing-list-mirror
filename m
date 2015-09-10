From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] rebase: support --no-autostash
Date: Thu, 10 Sep 2015 23:30:51 +0100
Message-ID: <549b3289ee263b25a241c823444a99420e5a8bfb.1441924193.git.john@keeping.me.uk>
References: <55F1EE67.3090401@thequod.de>
 <cover.1441924193.git.john@keeping.me.uk>
Cc: Daniel Hahler <genml+git-2014@thequod.de>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 00:31:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaAMy-0000TS-CE
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 00:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbbIJWa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 18:30:59 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:32861 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbbIJWa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 18:30:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5389CCDA5E5;
	Thu, 10 Sep 2015 23:30:56 +0100 (BST)
X-Quarantine-ID: <BFgoIDH973s7>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BFgoIDH973s7; Thu, 10 Sep 2015 23:30:55 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B87BD866023;
	Thu, 10 Sep 2015 23:30:46 +0100 (BST)
X-Mailer: git-send-email 2.6.0.rc0.162.gb2d3693
In-Reply-To: <cover.1441924193.git.john@keeping.me.uk>
In-Reply-To: <cover.1441924193.git.john@keeping.me.uk>
References: <cover.1441924193.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277647>

This is documented as an option but we don't actually accept it.
Support it so that it is possible to override the "rebase.autostash"
config variable.

Reported-by: Daniel Hahler <genml+git-2014@thequod.de>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-rebase.sh               |  5 ++++-
 t/t3420-rebase-autostash.sh | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 1757404..af7ba5f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -14,7 +14,7 @@ git-rebase --continue | --abort | --skip | --edit-todo
  Available options are
 v,verbose!         display a diffstat of what changed upstream
 q,quiet!           be quiet. implies --no-stat
-autostash!         automatically stash/stash pop before and after
+autostash          automatically stash/stash pop before and after
 fork-point         use 'merge-base --fork-point' to refine upstream
 onto=!             rebase onto given branch instead of upstream
 p,preserve-merges! try to recreate merges instead of ignoring them
@@ -292,6 +292,9 @@ do
 	--autostash)
 		autostash=true
 		;;
+	--no-autostash)
+		autostash=false
+		;;
 	--verbose)
 		verbose=t
 		diffstat=t
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index d783f03..944154b 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -37,6 +37,16 @@ testrebase() {
 	type=$1
 	dotest=$2
 
+	test_expect_success "rebase$type: dirty worktree, --no-autostash" '
+		test_config rebase.autostash true &&
+		git reset --hard &&
+		git checkout -b rebased-feature-branch feature-branch &&
+		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished git checkout feature-branch &&
+		echo dirty >>file3 &&
+		test_must_fail git rebase$type --no-autostash unrelated-onto-branch
+	'
+
 	test_expect_success "rebase$type: dirty worktree, non-conflicting rebase" '
 		test_config rebase.autostash true &&
 		git reset --hard &&
-- 
2.6.0.rc0.162.gb2d3693
