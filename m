Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAB3C4727F
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 12:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2204A2075F
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 12:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbgJAMpD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 1 Oct 2020 08:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgJAMpC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 08:45:02 -0400
X-Greylist: delayed 2326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Oct 2020 05:45:02 PDT
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ADAC0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 05:45:02 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id 277843AB215
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 12:06:18 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id 17214160047
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 12:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id 0747816007D
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 12:06:18 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kqvwJiIHw10N for <git@vger.kernel.org>;
        Thu,  1 Oct 2020 12:06:17 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id 703A3160047
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 12:06:17 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <michal@isc.org>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] t: add -I<regex> tests
Date:   Thu,  1 Oct 2020 14:06:06 +0200
Message-Id: <20201001120606.25773-3-michal@isc.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001120606.25773-1-michal@isc.org>
References: <20201001120606.25773-1-michal@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Exercise the new 'git diff -I<regex>' option in various scenarios to
ensure it behaves as expected.

Signed-off-by: Michał Kępień <michal@isc.org>
---
 t/t4069-diff-ignore-regex.sh | 330 +++++++++++++++++++++++++++++++++++
 1 file changed, 330 insertions(+)
 create mode 100755 t/t4069-diff-ignore-regex.sh

diff --git a/t/t4069-diff-ignore-regex.sh b/t/t4069-diff-ignore-regex.sh
new file mode 100755
index 0000000000..323687f1dc
--- /dev/null
+++ b/t/t4069-diff-ignore-regex.sh
@@ -0,0 +1,330 @@
+#!/bin/sh
+
+test_description='Test diff -I<regex>'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+test_expect_success setup '
+	test_seq 20 >x &&
+	git update-index --add x
+'
+
+test_expect_success 'one line changed' '
+	test_seq 20 | sed "s/10/100/" >x &&
+
+	# Get plain diff
+	git diff >plain &&
+	cat >expected <<-EOF &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -7,7 +7,7 @@
+	 7
+	 8
+	 9
+	-10
+	+100
+	 11
+	 12
+	 13
+	EOF
+	compare_diff_patch expected plain &&
+
+	# Both old and new line match regex - ignore change
+	git diff -I "^10" >actual &&
+	test_must_be_empty actual &&
+
+	# Only old line matches regex - do not ignore change
+	git diff -I "^10\$" >actual &&
+	compare_diff_patch plain actual &&
+
+	# Only new line matches regex - do not ignore change
+	git diff -I "^100" >actual &&
+	compare_diff_patch plain actual
+'
+
+test_expect_success 'one line removed' '
+	test_seq 20 | sed "10d" >x &&
+
+	# Get plain diff
+	git diff >plain &&
+	cat >expected <<-EOF &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -7,7 +7,6 @@
+	 7
+	 8
+	 9
+	-10
+	 11
+	 12
+	 13
+	EOF
+	compare_diff_patch expected plain &&
+
+	# Removed line matches regex - ignore change
+	git diff -I "^10" >actual &&
+	test_must_be_empty actual &&
+
+	# Removed line does not match regex - do not ignore change
+	git diff -I "^101" >actual &&
+	compare_diff_patch plain actual
+'
+
+test_expect_success 'one line added' '
+	test_seq 21 >x &&
+
+	# Get plain diff
+	git diff >plain &&
+	cat >expected <<-EOF &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -18,3 +18,4 @@
+	 18
+	 19
+	 20
+	+21
+	EOF
+	compare_diff_patch expected plain &&
+
+	# Added line matches regex - ignore change
+	git diff -I "^21" >actual &&
+	test_must_be_empty actual &&
+
+	# Added line does not match regex - do not ignore change
+	git diff -I "^212" >actual &&
+	compare_diff_patch plain actual
+'
+
+test_expect_success 'last two lines changed' '
+	test_seq 20 | sed "s/19/21/; s/20/22/" >x &&
+
+	# Get plain diff
+	git diff >plain &&
+	cat >expected <<-EOF &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -16,5 +16,5 @@
+	 16
+	 17
+	 18
+	-19
+	-20
+	+21
+	+22
+	EOF
+	compare_diff_patch expected plain &&
+
+	# All changed lines match regex - ignore change
+	git diff -I "^[12]" >actual &&
+	test_must_be_empty actual &&
+
+	# Not all changed lines match regex - do not ignore change
+	git diff -I "^2" >actual &&
+	compare_diff_patch plain actual
+'
+
+test_expect_success 'two non-adjacent lines removed in the same hunk' '
+	test_seq 20 | sed "1d; 3d" >x &&
+
+	# Get plain diff
+	git diff >plain &&
+	cat >expected <<-EOF &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -1,6 +1,4 @@
+	-1
+	 2
+	-3
+	 4
+	 5
+	 6
+	EOF
+	compare_diff_patch expected plain &&
+
+	# Both removed lines match regex - ignore hunk
+	git diff -I "^[1-3]" >actual &&
+	test_must_be_empty actual &&
+
+	# First removed line does not match regex - do not ignore hunk
+	git diff -I "^[2-3]" >actual &&
+	compare_diff_patch plain actual &&
+
+	# Second removed line does not match regex - do not ignore hunk
+	git diff -I "^[1-2]" >actual &&
+	compare_diff_patch plain actual
+'
+
+test_expect_success 'two non-adjacent lines removed in the same hunk, with -U1' '
+	test_seq 20 | sed "1d; 3d" >x &&
+
+	# Get plain diff
+	git diff -U1 >plain &&
+	cat >expected <<-EOF &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -1,4 +1,2 @@
+	-1
+	 2
+	-3
+	 4
+	EOF
+	compare_diff_patch expected plain &&
+
+	# Both removed lines match regex - ignore hunk
+	git diff -U1 -I "^[1-3]" >actual &&
+	test_must_be_empty actual &&
+
+	# First removed line does not match regex, but is out of context - ignore second change
+	git diff -U1 -I "^[2-3]" >actual &&
+	cat >second-change-ignored <<-EOF &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -1,2 +1 @@
+	-1
+	 2
+	EOF
+	compare_diff_patch second-change-ignored actual &&
+
+	# Second removed line does not match regex, but is out of context - ignore first change
+	git diff -U1 -I "^[1-2]" >actual &&
+	cat >first-change-ignored <<-EOF &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -2,3 +1,2 @@
+	 2
+	-3
+	 4
+	EOF
+	compare_diff_patch first-change-ignored actual
+'
+
+test_expect_success 'multiple hunks' '
+	test_seq 20 | sed "1d; 20d" >x &&
+
+	# Get plain diff
+	git diff >plain &&
+	cat >expected <<-EOF &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -1,4 +1,3 @@
+	-1
+	 2
+	 3
+	 4
+	@@ -17,4 +16,3 @@
+	 17
+	 18
+	 19
+	-20
+	EOF
+	compare_diff_patch expected plain &&
+
+	# Ignore both hunks
+	git diff -I "^[12]" >actual &&
+	test_must_be_empty actual &&
+
+	# Only ignore first hunk
+	git diff -I "^1" >actual &&
+	cat >first-hunk-ignored <<-EOF &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -17,4 +16,3 @@
+	 17
+	 18
+	 19
+	-20
+	EOF
+	compare_diff_patch first-hunk-ignored actual &&
+
+	# Only ignore second hunk
+	git diff -I "^2" >actual &&
+	cat >second-hunk-ignored <<-EOF &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -1,4 +1,3 @@
+	-1
+	 2
+	 3
+	 4
+	EOF
+	compare_diff_patch second-hunk-ignored actual
+'
+
+test_expect_success 'multiple hunks, with --ignore-blank-lines' '
+	echo >x &&
+	test_seq 21 >>x &&
+
+	# Get plain diff
+	git diff >plain &&
+	cat >expected <<-EOF &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -1,3 +1,4 @@
+	+
+	 1
+	 2
+	 3
+	@@ -18,3 +19,4 @@
+	 18
+	 19
+	 20
+	+21
+	EOF
+	compare_diff_patch expected plain &&
+
+	# -I does not override --ignore-blank-lines - ignore both hunks
+	git diff --ignore-blank-lines -I ^21 >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'diffstat' '
+	test_seq 20 | sed "s/^5/0/p; s/^15/10/; 16d" >x &&
+
+	# Get plain diffstat
+	git diff --stat >actual &&
+	cat >expected <<-EOF &&
+	 x | 6 +++---
+	 1 file changed, 3 insertions(+), 3 deletions(-)
+	EOF
+	test_cmp expected actual &&
+
+	# Ignore both hunks
+	git diff --stat -I "^[0-5]" >actual &&
+	test_must_be_empty actual &&
+
+	# Only ignore first hunk
+	git diff --stat -I "^[05]" >actual &&
+	cat >expected <<-EOF &&
+	 x | 3 +--
+	 1 file changed, 1 insertion(+), 2 deletions(-)
+	EOF
+	test_cmp expected actual &&
+
+	# Only ignore second hunk
+	git diff --stat -I "^1" >actual &&
+	cat >expected <<-EOF &&
+	 x | 3 ++-
+	 1 file changed, 2 insertions(+), 1 deletion(-)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'invalid regex' '
+	>x &&
+	git diff -I "^[1" 2>&1 | grep "invalid regex: "
+'
+
+test_done
-- 
2.28.0

