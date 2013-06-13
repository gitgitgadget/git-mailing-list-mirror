From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/6] checkout: respect GIT_REFLOG_ACTION
Date: Thu, 13 Jun 2013 19:02:29 +0530
Message-ID: <1371130349-30651-7-git-send-email-artagnon@gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 15:31:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un7cC-0003x5-Fu
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 15:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758574Ab3FMNav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 09:30:51 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:44413 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758178Ab3FMNat (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 09:30:49 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so5235936pab.36
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mQuPNNuQfjtwolr9nIg5phFrzEZXpiQolcFN9n/zFuQ=;
        b=K4KB7/Z298wF+jWSQT4A6k17VcJfRWSCBCXHTcBBh6VL6oG8dijVPdtyIc9FomFKXS
         dV4ylAzo218gEbSfu0NWkIWaq30mXMPYM+P2OaQxEz6msEPEb9QbhEyPOEVDvSCAAoCR
         XvG2OIsPVwKjizg7PTNqQmZ+4BcuMqLeUAKa1GxAu5nIHXyAEfYPJulomV6GCSLIwU2w
         PgrwArdrwEIE9YXAI9JrRwzYRvO/CO3aXqY/vziTEoFnhdP6p721OzPjaoIaueQGbwdB
         mJ9JaqmR6IwQcoFzgRKcjK3HKjjhoNCwYEuLqzGjwyfhfs7rpPzN/EgtQs4dsn2e9V6m
         9AGw==
X-Received: by 10.68.106.196 with SMTP id gw4mr830688pbb.126.1371130248821;
        Thu, 13 Jun 2013 06:30:48 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id re16sm4581222pac.16.2013.06.13.06.30.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 06:30:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.384.g7cec0b4
In-Reply-To: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227732>

GIT_REFLOG_ACTION is an environment variable specifying the reflog
message to write after an action is completed.  Several other commands
including merge, reset, and commit respect it.

Fix the failing tests in t/checkout-last by making checkout respect it
too.  You can now expect

  $ git checkout -

to work as expected after any rebase operation.

Also update the tests in t/status-help that rely on rebase writing
"checkout: " messages to the reflog.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/checkout.c       | 11 ++++++++---
 t/t2012-checkout-last.sh |  4 ++--
 t/t7512-status-help.sh   | 13 ++++++-------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f5b50e5..1e2af85 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -587,7 +587,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				   struct branch_info *new)
 {
 	struct strbuf msg = STRBUF_INIT;
-	const char *old_desc;
+	const char *old_desc, *reflog_msg;
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
@@ -620,8 +620,13 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	old_desc = old->name;
 	if (!old_desc && old->commit)
 		old_desc = sha1_to_hex(old->commit->object.sha1);
-	strbuf_addf(&msg, "checkout: moving from %s to %s",
-		    old_desc ? old_desc : "(invalid)", new->name);
+
+	reflog_msg = getenv("GIT_REFLOG_ACTION");
+	if (!reflog_msg)
+		strbuf_addf(&msg, "checkout: moving from %s to %s",
+			old_desc ? old_desc : "(invalid)", new->name);
+	else
+		strbuf_insert(&msg, 0, reflog_msg, strlen(reflog_msg));
 
 	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) {
 		/* Nothing to do. */
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index ae6d319..336b6f2 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -116,7 +116,7 @@ test_expect_success 'master...' '
 	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
 '
 
-test_expect_failure '"checkout -" works after a rebase' '
+test_expect_success '"checkout -" works after a rebase' '
 	git checkout master &&
 	git checkout other &&
 	git rebase master &&
@@ -124,7 +124,7 @@ test_expect_failure '"checkout -" works after a rebase' '
 	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
 '
 
-test_expect_failure '"checkout -" works after an interactive rebase' '
+test_expect_success '"checkout -" works after an interactive rebase' '
 	git checkout master &&
 	git checkout other &&
 	git rebase -i master &&
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index ed9d57c..f8661e4 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -77,7 +77,7 @@ test_expect_success 'status when rebase in progress before resolving conflicts'
 	ONTO=$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	cat >expected <<-EOF &&
-	# HEAD detached at $ONTO
+	# Not currently on any branch.
 	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
 	#   (fix conflicts and then run "git rebase --continue")
 	#   (use "git rebase --skip" to skip this patch)
@@ -104,7 +104,7 @@ test_expect_success 'status when rebase in progress before rebase --continue' '
 	echo three >main.txt &&
 	git add main.txt &&
 	cat >expected <<-EOF &&
-	# HEAD detached at $ONTO
+	# Not currently on any branch.
 	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
 	#   (all conflicts fixed: run "git rebase --continue")
 	#
@@ -136,7 +136,7 @@ test_expect_success 'status during rebase -i when conflicts unresolved' '
 	ONTO=$(git rev-parse --short rebase_i_conflicts) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	cat >expected <<-EOF &&
-	# HEAD detached at $ONTO
+	# Not currently on any branch.
 	# You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
 	#   (fix conflicts and then run "git rebase --continue")
 	#   (use "git rebase --skip" to skip this patch)
@@ -162,7 +162,7 @@ test_expect_success 'status during rebase -i after resolving conflicts' '
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	git add main.txt &&
 	cat >expected <<-EOF &&
-	# HEAD detached at $ONTO
+	# Not currently on any branch.
 	# You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
 	#   (all conflicts fixed: run "git rebase --continue")
 	#
@@ -215,9 +215,8 @@ test_expect_success 'status when splitting a commit' '
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
-	TGT=$(git rev-parse --short HEAD) &&
 	cat >expected <<-EOF &&
-	# HEAD detached at $TGT
+	# Not currently on any branch.
 	# You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
@@ -599,7 +598,7 @@ test_expect_success 'status when rebase conflicts with statushints disabled' '
 	ONTO=$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	cat >expected <<-EOF &&
-	# HEAD detached at $ONTO
+	# Not currently on any branch.
 	# You are currently rebasing branch '\''statushints_disabled'\'' on '\''$ONTO'\''.
 	#
 	# Unmerged paths:
-- 
1.8.3.1.384.g7cec0b4
