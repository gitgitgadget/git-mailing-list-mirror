From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/8] checkout: respect GIT_REFLOG_ACTION
Date: Tue, 18 Jun 2013 17:44:27 +0530
Message-ID: <1371557670-12534-6-git-send-email-artagnon@gmail.com>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:17:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uour8-00080s-HY
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133Ab3FRMRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:17:47 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:43038 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672Ab3FRMRp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:17:45 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so3933578pac.29
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WYlXPWDWqBjLt3YBOUgb3jword4M4kjQJpkgYtqBhio=;
        b=lB76qvKlSdHAAoL39LJrmMjIXXr41eyBLRIRE6mWFqYpn83hVsnr+5PfdN621+ASFv
         HWNRaMLrakvyU8zmcrP2Wt9bfhWDlPKcMl6pkmXT0vpfpk0a2/2YIrhbum+BwaA7gU4N
         9csQzFI+4EeT1w2tq4TNUxItx1re2RRCxJeTf7C0GbR2byODS/1CzS24V4ll7XzEtWxZ
         xr/MtyrQxQ6UVZJ8lXnLQCNmRzlb0I3jhJGACOCYS1jNB00Zjn14CWVNsleuH8uEZ4mQ
         dfw6UvNZcQkSkDZGAfJ6AAkGPHxYWlKEj8zC5xpWyVzJS81XXvyWSjQe7zN8TMY5FWfI
         oOkA==
X-Received: by 10.68.143.5 with SMTP id sa5mr16953131pbb.106.1371557865107;
        Tue, 18 Jun 2013 05:17:45 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id fm2sm19398332pab.13.2013.06.18.05.17.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 05:17:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6
In-Reply-To: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228203>

GIT_REFLOG_ACTION is an environment variable specifying the reflog
message to write after an action is completed.  Several other commands
including merge, reset, and commit respect it.

Fix the failing tests in t/checkout-last by making checkout respect it
too.  You can now expect

  $ git checkout -

to work as expected after any a rebase [-i].  It will also work with any
other scripts provided they set an appropriate GIT_REFLOG_ACTION if they
internally use "git checkout".

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c       | 11 ++++++++---
 t/t2012-checkout-last.sh |  8 ++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

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
index 6ad6edf..e7ba8c5 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -116,7 +116,7 @@ test_expect_success 'master...' '
 	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
 '
 
-test_expect_failure '"checkout -" works after a rebase A' '
+test_expect_success '"checkout -" works after a rebase A' '
 	git checkout master &&
 	git checkout other &&
 	git rebase master &&
@@ -124,7 +124,7 @@ test_expect_failure '"checkout -" works after a rebase A' '
 	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
 '
 
-test_expect_failure '"checkout -" works after a rebase A B' '
+test_expect_success '"checkout -" works after a rebase A B' '
 	git branch moodle master~1 &&
 	git checkout master &&
 	git checkout other &&
@@ -133,7 +133,7 @@ test_expect_failure '"checkout -" works after a rebase A B' '
 	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
 '
 
-test_expect_failure '"checkout -" works after a rebase -i A' '
+test_expect_success '"checkout -" works after a rebase -i A' '
 	git checkout master &&
 	git checkout other &&
 	git rebase -i master &&
@@ -141,7 +141,7 @@ test_expect_failure '"checkout -" works after a rebase -i A' '
 	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
 '
 
-test_expect_failure '"checkout -" works after a rebase -i A B' '
+test_expect_success '"checkout -" works after a rebase -i A B' '
 	git branch foodle master~1 &&
 	git checkout master &&
 	git checkout other &&
-- 
1.8.3.1.456.gb7f4cb6
