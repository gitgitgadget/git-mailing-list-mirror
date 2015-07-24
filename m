From: David Turner <dturner@twopensource.com>
Subject: [PATCH 9/9] refs: forbid pseudoref updates through ref update API
Date: Fri, 24 Jul 2015 00:45:29 -0400
Message-ID: <1437713129-19373-10-git-send-email-dturner@twopensource.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jul 24 06:46:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUs8-0003xD-L2
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbbGXEqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:46:04 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34368 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbbGXEp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:45:59 -0400
Received: by qgeu79 with SMTP id u79so6102858qge.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ivzOjtSTBKp0g9aDeceBnMgCgNm/8c9Id6XtkiwbwK4=;
        b=Q5pVS9+MT4HDr9fLFDdCXiG7i3FfnjoLpH2maTR69VgEIMmOge0bx2baWiCFHh95oJ
         neVtb3jCTx55q69RGnNtP0i/Kf/yRFFj5oag9n423KcbJ9U4uFLOW1RjDsUCZBfqyg7a
         H1IscdQfkUsnU/myrj20sighGTxByv6MPm2ww0VIJDB7fHjcamXgc2ZfSRuXFA6ZuxxQ
         wHmP4RBW9t+lMnsXWLF779eb7lQQwKzpVnWLbTO08Vd13Z/xiR5RCc5jfi+lPpO18Dbj
         MzdY6Hibqlrt3qXIjRvNzFS/u8MnjpalNBgBhsX5UN41KFT99Kj0mW3mGwuMWEEJxsay
         No8w==
X-Gm-Message-State: ALoCoQnim2Gck+3y2OaY2ZzbhE7HIJWfSULY2YQrsnyzFImSUDZCEKGDhXWyUxd9eR4McTWbhxQr
X-Received: by 10.140.92.165 with SMTP id b34mr17371090qge.13.1437713158695;
        Thu, 23 Jul 2015 21:45:58 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p74sm3541579qkp.11.2015.07.23.21.45.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:45:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274549>

It is now forbidden to update pseudorefs through the ref update
framework.

Because of the pseudoref update rules change, test cases that used git
update-ref on a pseudoref now operate on plain refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 bisect.c              |  2 +-
 refs.c                |  2 ++
 t/t1400-update-ref.sh | 24 ++++++++++++------------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/bisect.c b/bisect.c
index 3a9fd63..47cc778 100644
--- a/bisect.c
+++ b/bisect.c
@@ -969,7 +969,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
-		printf("%s is the first %s commit\n", bisect_rev_hex,
+		printf("%s is the first %s commit\n", sha1_to_hex(bisect_rev),
 			term_bad);
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
diff --git a/refs.c b/refs.c
index efa84e3..f8dc877 100644
--- a/refs.c
+++ b/refs.c
@@ -3902,6 +3902,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	struct ref_update *update;
 
 	assert(err);
+	if (is_pseudoref(refname))
+		return error(_("BUG: Cannot update pseudorefs (all-caps files in .git) through the refs API"));
 
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 0038f28..b05657c 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -608,13 +608,13 @@ test_expect_success 'stdin delete ref fails with zero old value' '
 '
 
 test_expect_success 'stdin update symref works option no-deref' '
-	git symbolic-ref TESTSYMREF $b &&
+	git symbolic-ref refs/TESTSYMREF $b &&
 	cat >stdin <<-EOF &&
 	option no-deref
-	update TESTSYMREF $a $b
+	update refs/TESTSYMREF $a $b
 	EOF
 	git update-ref --stdin <stdin &&
-	git rev-parse TESTSYMREF >expect &&
+	git rev-parse refs/TESTSYMREF >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual &&
 	git rev-parse $m~1 >expect &&
@@ -623,13 +623,13 @@ test_expect_success 'stdin update symref works option no-deref' '
 '
 
 test_expect_success 'stdin delete symref works option no-deref' '
-	git symbolic-ref TESTSYMREF $b &&
+	git symbolic-ref refs/TESTSYMREF $b &&
 	cat >stdin <<-EOF &&
 	option no-deref
-	delete TESTSYMREF $b
+	delete refs/TESTSYMREF $b
 	EOF
 	git update-ref --stdin <stdin &&
-	test_must_fail git rev-parse --verify -q TESTSYMREF &&
+	test_must_fail git rev-parse --verify -q refs/TESTSYMREF &&
 	git rev-parse $m~1 >expect &&
 	git rev-parse $b >actual &&
 	test_cmp expect actual
@@ -983,10 +983,10 @@ test_expect_success 'stdin -z delete ref fails with zero old value' '
 '
 
 test_expect_success 'stdin -z update symref works option no-deref' '
-	git symbolic-ref TESTSYMREF $b &&
-	printf $F "option no-deref" "update TESTSYMREF" "$a" "$b" >stdin &&
+	git symbolic-ref refs/TESTSYMREF $b &&
+	printf $F "option no-deref" "update refs/TESTSYMREF" "$a" "$b" >stdin &&
 	git update-ref -z --stdin <stdin &&
-	git rev-parse TESTSYMREF >expect &&
+	git rev-parse refs/TESTSYMREF >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual &&
 	git rev-parse $m~1 >expect &&
@@ -995,10 +995,10 @@ test_expect_success 'stdin -z update symref works option no-deref' '
 '
 
 test_expect_success 'stdin -z delete symref works option no-deref' '
-	git symbolic-ref TESTSYMREF $b &&
-	printf $F "option no-deref" "delete TESTSYMREF" "$b" >stdin &&
+	git symbolic-ref refs/TESTSYMREF $b &&
+	printf $F "option no-deref" "delete refs/TESTSYMREF" "$b" >stdin &&
 	git update-ref -z --stdin <stdin &&
-	test_must_fail git rev-parse --verify -q TESTSYMREF &&
+	test_must_fail git rev-parse --verify -q refs/TESTSYMREF &&
 	git rev-parse $m~1 >expect &&
 	git rev-parse $b >actual &&
 	test_cmp expect actual
-- 
2.0.4.315.gad8727a-twtrsrc
