Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121C6C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 19:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D5B206D8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 19:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfLTTlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:41:17 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:65204 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbfLTTlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 14:41:16 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 4B5D68D18D;
        Fri, 20 Dec 2019 19:41:15 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [96.47.72.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47ffHv0Ytyz4JxZ;
        Fri, 20 Dec 2019 19:41:15 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id 0C9FA16421; Fri, 20 Dec 2019 19:41:15 +0000 (UTC)
From:   Ed Maste <emaste@FreeBSD.org>
To:     git mailing list <git@vger.kernel.org>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ed Maste <emaste@FreeBSD.org>
Subject: [PATCH v4] sparse-checkout: improve OS ls compatibility
Date:   Fri, 20 Dec 2019 19:41:14 +0000
Message-Id: <20191220194114.95509-1-emaste@FreeBSD.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191219015833.49314-1-emaste@FreeBSD.org>
References: <20191219015833.49314-1-emaste@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On FreeBSD, when executed by root ls enables the '-A' option:

  -A  Include directory entries whose names begin with a dot (`.')
      except for . and ...  Automatically set for the super-user unless
      -I is specified.

As a result the .git directory appeared in the output when run as root.
Simulate no-dotfile ls behaviour using a shell glob.

Helped-by: Eric Wong <e@80x24.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ed Maste <emaste@FreeBSD.org>
---
Since v3, adjust the comment to be an explicit caution against replacing
with ls.

 t/t1091-sparse-checkout-builtin.sh | 36 ++++++++++++++++++------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index cee98a1c8a..6f7e2d0c9e 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -4,6 +4,14 @@ test_description='sparse checkout builtin tests'
 
 . ./test-lib.sh
 
+list_files() {
+	# Do not replace this with 'ls "$1"', as "ls" with BSD-lineage
+	# enables "-A" by default for root and ends up including ".git" and
+	# such in its output. (Note, though, that running the test suite as
+	# root is generally not recommended.)
+	(cd "$1" && printf '%s\n' *)
+}
+
 test_expect_success 'setup' '
 	git init repo &&
 	(
@@ -50,7 +58,7 @@ test_expect_success 'git sparse-checkout init' '
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
 	test_cmp_config -C repo true core.sparsecheckout &&
-	ls repo >dir  &&
+	list_files repo >dir  &&
 	echo a >expect &&
 	test_cmp expect dir
 '
@@ -73,7 +81,7 @@ test_expect_success 'init with existing sparse-checkout' '
 		*folder*
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	ls repo >dir  &&
+	list_files repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		folder1
@@ -90,7 +98,7 @@ test_expect_success 'clone --sparse' '
 		!/*/
 	EOF
 	test_cmp expect actual &&
-	ls clone >dir &&
+	list_files clone >dir &&
 	echo a >expect &&
 	test_cmp expect dir
 '
@@ -119,7 +127,7 @@ test_expect_success 'set sparse-checkout using builtin' '
 	git -C repo sparse-checkout list >actual &&
 	test_cmp expect actual &&
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	ls repo >dir  &&
+	list_files repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		folder1
@@ -139,7 +147,7 @@ test_expect_success 'set sparse-checkout using --stdin' '
 	git -C repo sparse-checkout list >actual &&
 	test_cmp expect actual &&
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	ls repo >dir  &&
+	list_files repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		folder1
@@ -154,7 +162,7 @@ test_expect_success 'cone mode: match patterns' '
 	git -C repo read-tree -mu HEAD 2>err &&
 	test_i18ngrep ! "disabling cone patterns" err &&
 	git -C repo reset --hard &&
-	ls repo >dir  &&
+	list_files repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		folder1
@@ -177,7 +185,7 @@ test_expect_success 'sparse-checkout disable' '
 	test_path_is_file repo/.git/info/sparse-checkout &&
 	git -C repo config --list >config &&
 	test_must_fail git config core.sparseCheckout &&
-	ls repo >dir &&
+	list_files repo >dir &&
 	cat >expect <<-EOF &&
 		a
 		deep
@@ -191,24 +199,24 @@ test_expect_success 'cone mode: init and set' '
 	git -C repo sparse-checkout init --cone &&
 	git -C repo config --list >config &&
 	test_i18ngrep "core.sparsecheckoutcone=true" config &&
-	ls repo >dir  &&
+	list_files repo >dir  &&
 	echo a >expect &&
 	test_cmp expect dir &&
 	git -C repo sparse-checkout set deep/deeper1/deepest/ 2>err &&
 	test_must_be_empty err &&
-	ls repo >dir  &&
+	list_files repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		deep
 	EOF
 	test_cmp expect dir &&
-	ls repo/deep >dir  &&
+	list_files repo/deep >dir  &&
 	cat >expect <<-EOF &&
 		a
 		deeper1
 	EOF
 	test_cmp expect dir &&
-	ls repo/deep/deeper1 >dir  &&
+	list_files repo/deep/deeper1 >dir  &&
 	cat >expect <<-EOF &&
 		a
 		deepest
@@ -234,7 +242,7 @@ test_expect_success 'cone mode: init and set' '
 		folder1
 		folder2
 	EOF
-	ls repo >dir &&
+	list_files repo >dir &&
 	test_cmp expect dir
 '
 
@@ -256,7 +264,7 @@ test_expect_success 'revert to old sparse-checkout on bad update' '
 	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
 	test_i18ngrep "cannot set sparse-checkout patterns" err &&
 	test_cmp repo/.git/info/sparse-checkout expect &&
-	ls repo/deep >dir &&
+	list_files repo/deep >dir &&
 	cat >expect <<-EOF &&
 		a
 		deeper1
@@ -313,7 +321,7 @@ test_expect_success 'cone mode: set with core.ignoreCase=true' '
 		/folder1/
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	ls repo >dir &&
+	list_files repo >dir &&
 	cat >expect <<-EOF &&
 		a
 		folder1
-- 
2.24.0

