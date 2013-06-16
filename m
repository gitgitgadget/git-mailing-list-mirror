From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 6/6] checkout: respect GIT_REFLOG_ACTION
Date: Sun, 16 Jun 2013 14:15:16 +0530
Message-ID: <1371372316-16059-7-git-send-email-artagnon@gmail.com>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 16 10:47:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo8ch-00028h-Dt
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 10:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab3FPIrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 04:47:32 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33839 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab3FPIrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 04:47:19 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so1826123pdc.33
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Zs6ZkNLH33Ki5aYIcJkyQAGbwm2Xw6t434zpNGpKAdY=;
        b=ACJO2AOYVSjX9HIYsex5kKQIo9c4It+iEWtRAfqX4kidhmDwcI7JoSuQN0jywTnJ4q
         08CNeqlK7u/OrzG7PqVfQMAYNnJygcAU7U+/F8k/QJQlbTYlu2Um09kXvsQvvWtDODbI
         YOLr2/2pd8I4AaG2V0lCP41YZaXKr9wH66oQ3lTI9cH5QoBqXvub2NBVNgvrX6NpkEtV
         v/8tVhmmFQemwaMTovv/S5zihCQ6FzaL0bgEImHLac5S1sfdGDFrXcpeqsD8PYrv6Q+X
         P7KDxg4+hUZsVFDHToGOGZpDKYY7TkyYuYliC8mTElDN5YcqIspTaGrh3QgriOFbAErY
         Tvpw==
X-Received: by 10.66.224.73 with SMTP id ra9mr8714523pac.163.1371372439104;
        Sun, 16 Jun 2013 01:47:19 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id vu5sm9917919pab.10.2013.06.16.01.47.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 01:47:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.443.g4fd77b9
In-Reply-To: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227997>

GIT_REFLOG_ACTION is an environment variable specifying the reflog
message to write after an action is completed.  Several other commands
including merge, reset, and commit respect it.

Fix the failing tests in t/checkout-last by making checkout respect it
too.  You can now expect

  $ git checkout -

to work as expected after any rebase operation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
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
1.8.3.1.443.g4fd77b9
