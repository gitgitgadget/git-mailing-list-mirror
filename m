Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8830C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 01:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710732176D
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 01:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLSB6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 20:58:50 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:38475 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfLSB6u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 20:58:50 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 47D9694F32;
        Thu, 19 Dec 2019 01:58:48 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [IPv6:2610:1c1:1:6074::16:84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47dZmS09c6z443G;
        Thu, 19 Dec 2019 01:58:48 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id D8CA11ABF0; Thu, 19 Dec 2019 01:58:47 +0000 (UTC)
From:   Ed Maste <emaste@FreeBSD.org>
To:     git mailing list <git@vger.kernel.org>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Ed Maste <emaste@FreeBSD.org>
Subject: [PATCH] sparse-checkout: improve OS ls compatibility
Date:   Thu, 19 Dec 2019 01:58:33 +0000
Message-Id: <20191219015833.49314-1-emaste@FreeBSD.org>
X-Mailer: git-send-email 2.22.0
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

Pipe ls's output to grep -v .git to remove the undesired entry.  Also
pass the -1 option to ensure one entry per line.

Signed-off-by: Ed Maste <emaste@FreeBSD.org>
---
There are several different ways this could be solved; this approach
felt cleanest to me, but there are at least two other reasonable
alternatives:

  * Add -a to the invocations and .git to the expected output

  * Add LSFLAGS and set it to -I on BSDs, to turn off the special dot
    behaviour

I'll submit a new patch if a different approach is preferred.

 t/t1091-sparse-checkout-builtin.sh | 33 +++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index cee98a1c8a..3a3eafa653 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -4,6 +4,11 @@ test_description='sparse checkout builtin tests'
 
 . ./test-lib.sh
 
+ls_no_git()
+{
+	ls -1 "$1" | grep -v .git
+}
+
 test_expect_success 'setup' '
 	git init repo &&
 	(
@@ -50,7 +55,7 @@ test_expect_success 'git sparse-checkout init' '
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
 	test_cmp_config -C repo true core.sparsecheckout &&
-	ls repo >dir  &&
+	ls_no_git repo >dir  &&
 	echo a >expect &&
 	test_cmp expect dir
 '
@@ -73,7 +78,7 @@ test_expect_success 'init with existing sparse-checkout' '
 		*folder*
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	ls repo >dir  &&
+	ls_no_git repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		folder1
@@ -90,7 +95,7 @@ test_expect_success 'clone --sparse' '
 		!/*/
 	EOF
 	test_cmp expect actual &&
-	ls clone >dir &&
+	ls_no_git clone >dir &&
 	echo a >expect &&
 	test_cmp expect dir
 '
@@ -119,7 +124,7 @@ test_expect_success 'set sparse-checkout using builtin' '
 	git -C repo sparse-checkout list >actual &&
 	test_cmp expect actual &&
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	ls repo >dir  &&
+	ls_no_git repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		folder1
@@ -139,7 +144,7 @@ test_expect_success 'set sparse-checkout using --stdin' '
 	git -C repo sparse-checkout list >actual &&
 	test_cmp expect actual &&
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	ls repo >dir  &&
+	ls_no_git repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		folder1
@@ -154,7 +159,7 @@ test_expect_success 'cone mode: match patterns' '
 	git -C repo read-tree -mu HEAD 2>err &&
 	test_i18ngrep ! "disabling cone patterns" err &&
 	git -C repo reset --hard &&
-	ls repo >dir  &&
+	ls_no_git repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		folder1
@@ -177,7 +182,7 @@ test_expect_success 'sparse-checkout disable' '
 	test_path_is_file repo/.git/info/sparse-checkout &&
 	git -C repo config --list >config &&
 	test_must_fail git config core.sparseCheckout &&
-	ls repo >dir &&
+	ls_no_git repo >dir &&
 	cat >expect <<-EOF &&
 		a
 		deep
@@ -191,24 +196,24 @@ test_expect_success 'cone mode: init and set' '
 	git -C repo sparse-checkout init --cone &&
 	git -C repo config --list >config &&
 	test_i18ngrep "core.sparsecheckoutcone=true" config &&
-	ls repo >dir  &&
+	ls_no_git repo >dir  &&
 	echo a >expect &&
 	test_cmp expect dir &&
 	git -C repo sparse-checkout set deep/deeper1/deepest/ 2>err &&
 	test_must_be_empty err &&
-	ls repo >dir  &&
+	ls_no_git repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		deep
 	EOF
 	test_cmp expect dir &&
-	ls repo/deep >dir  &&
+	ls_no_git repo/deep >dir  &&
 	cat >expect <<-EOF &&
 		a
 		deeper1
 	EOF
 	test_cmp expect dir &&
-	ls repo/deep/deeper1 >dir  &&
+	ls_no_git repo/deep/deeper1 >dir  &&
 	cat >expect <<-EOF &&
 		a
 		deepest
@@ -234,7 +239,7 @@ test_expect_success 'cone mode: init and set' '
 		folder1
 		folder2
 	EOF
-	ls repo >dir &&
+	ls_no_git repo >dir &&
 	test_cmp expect dir
 '
 
@@ -256,7 +261,7 @@ test_expect_success 'revert to old sparse-checkout on bad update' '
 	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
 	test_i18ngrep "cannot set sparse-checkout patterns" err &&
 	test_cmp repo/.git/info/sparse-checkout expect &&
-	ls repo/deep >dir &&
+	ls_no_git repo/deep >dir &&
 	cat >expect <<-EOF &&
 		a
 		deeper1
@@ -313,7 +318,7 @@ test_expect_success 'cone mode: set with core.ignoreCase=true' '
 		/folder1/
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	ls repo >dir &&
+	ls_no_git repo >dir &&
 	cat >expect <<-EOF &&
 		a
 		folder1
-- 
2.24.0

