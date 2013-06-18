From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 5/7] checkout: respect GIT_REFLOG_ACTION
Date: Wed, 19 Jun 2013 00:25:35 +0530
Message-ID: <1371581737-10013-6-git-send-email-artagnon@gmail.com>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:59:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up17W-0002gV-7I
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933705Ab3FRS7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:59:00 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:39180 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933697Ab3FRS65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:58:57 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so4167065pbc.40
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 11:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8WqnZvcmDYn9BN1ilwC6VrSal2UnoQdzT+eqPlwb/2Q=;
        b=yoeR1Vh9WFfU5Xvpe5/vrd+OyXQCa9ri396ajXQOmb6sdR+fnpn8kYqrF5o3Zua/2s
         C0lUkpSR37f+4Q2UsvsFum5/o4f+wc/p0uhwwdD5g3dPYvwd1H+CTEgf3cRB1CXnBrgx
         x+jUrZ5k6WAymoM0mCCwfNe0nuVL+RCH1eWuW6Huz2KhNI61ER34XXJA5N8yuMvuzo2a
         ABlZ0ApQ2YAVAleH1+3kQfKe903DTY/QCW/7D2Df3fh/jL6CDNhJqq7edefeWFaq1RMw
         30yRQyXqM0rVv91u72osPlvga6Dy74Ds8x8j6xGTTM5Su5R3KUFGq+umt23y9MZkUTsn
         WTnA==
X-Received: by 10.66.197.165 with SMTP id iv5mr3363871pac.67.1371581937150;
        Tue, 18 Jun 2013 11:58:57 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id ag4sm19432751pbc.20.2013.06.18.11.58.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 11:58:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.455.g5932b31
In-Reply-To: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228300>

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
1.8.3.1.455.g5932b31
