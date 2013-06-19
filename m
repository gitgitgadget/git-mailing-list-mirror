From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 5/7] checkout: respect GIT_REFLOG_ACTION
Date: Wed, 19 Jun 2013 13:34:47 +0530
Message-ID: <1371629089-27008-6-git-send-email-artagnon@gmail.com>
References: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 10:08:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDRk-0002Ty-GL
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 10:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab3FSIIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 04:08:38 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:42654 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab3FSIIK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 04:08:10 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so4779121pdd.6
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 01:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DKdpCPZuPcJ4owM5ZigpbJ2G3QWGoYn7D1ayxelkcLQ=;
        b=y3fRVQuF+GA35jzDnhjpA3vaB+yJ1rKezVnAQVdMDqwE6/5Oy1rt3aHibz7NflYVA1
         n4jMr0/KKs3Zd8l1EqIn8Uy+PtxMN8vcF4p3Lv3UnXLabhVNca9fTtZ/+isMmiLnfBZS
         QlK+2lV4IW7wXvjaY5fmK7YME+vM2Ww6ACFodWyNXqs0qDtzWpZwoAqb8w3YXfkuNjot
         TSCw3/TWCek67Wo5cD6XVax+2PHafptaCxsArqlc/HCCDWxLBmxjL3S4iz/7ZC/WfRW5
         RTJ9NygSOO+9/HdPoSGTCKcrc75NLq3tiElO3htj3AnUzkn1+BBUYVRNAGVjXdi/p+v7
         ptHg==
X-Received: by 10.68.111.228 with SMTP id il4mr1693833pbb.134.1371629289367;
        Wed, 19 Jun 2013 01:08:09 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id vz8sm23663400pac.20.2013.06.19.01.08.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 01:08:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.449.g41b32a4.dirty
In-Reply-To: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228376>

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
1.8.3.1.449.g41b32a4.dirty
