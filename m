Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFFCC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6801C21655
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 15:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLTPiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:38:20 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:19767 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfLTPiU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 10:38:20 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id F116368B81;
        Fri, 20 Dec 2019 15:38:18 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [96.47.72.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47fXvZ5Sw5z45D4;
        Fri, 20 Dec 2019 15:38:18 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id 997C3139B8; Fri, 20 Dec 2019 15:38:18 +0000 (UTC)
From:   Ed Maste <emaste@FreeBSD.org>
To:     git mailing list <git@vger.kernel.org>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Ed Maste <emaste@FreeBSD.org>
Subject: [PATCH v3] sparse-checkout: improve OS ls compatibility
Date:   Fri, 20 Dec 2019 15:38:14 +0000
Message-Id: <20191220153814.54899-1-emaste@FreeBSD.org>
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
Signed-off-by: Ed Maste <emaste@FreeBSD.org>
---
Since v2, rename the function list_files and add a comment explaining why
it's not just using ls.  Note that this change is not necessary when running
the tests as an unprivileged user on FreeBSD, and the proposed FreeBSD CI
patch has been updated to do so.  That said I still believe we should make
either this change or add a prerequisite so this test does not run as root
on FreeBSD.

 t/t1091-sparse-checkout-builtin.sh | 35 ++++++++++++++++++------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index cee98a1c8a..168702784d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -4,6 +4,13 @@ test_description='sparse checkout builtin tests'
 
 . ./test-lib.sh
 
+# List files in a directory, excluding hidden dot files (such as .git).
+# This is similar to ls, but some ls implementations include dot files by
+# default when run as root.
+list_files() {
+	(cd "$1" && printf '%s\n' *)
+}
+
 test_expect_success 'setup' '
 	git init repo &&
 	(
@@ -50,7 +57,7 @@ test_expect_success 'git sparse-checkout init' '
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
 	test_cmp_config -C repo true core.sparsecheckout &&
-	ls repo >dir  &&
+	list_files repo >dir  &&
 	echo a >expect &&
 	test_cmp expect dir
 '
@@ -73,7 +80,7 @@ test_expect_success 'init with existing sparse-checkout' '
 		*folder*
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	ls repo >dir  &&
+	list_files repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		folder1
@@ -90,7 +97,7 @@ test_expect_success 'clone --sparse' '
 		!/*/
 	EOF
 	test_cmp expect actual &&
-	ls clone >dir &&
+	list_files clone >dir &&
 	echo a >expect &&
 	test_cmp expect dir
 '
@@ -119,7 +126,7 @@ test_expect_success 'set sparse-checkout using builtin' '
 	git -C repo sparse-checkout list >actual &&
 	test_cmp expect actual &&
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	ls repo >dir  &&
+	list_files repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		folder1
@@ -139,7 +146,7 @@ test_expect_success 'set sparse-checkout using --stdin' '
 	git -C repo sparse-checkout list >actual &&
 	test_cmp expect actual &&
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	ls repo >dir  &&
+	list_files repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		folder1
@@ -154,7 +161,7 @@ test_expect_success 'cone mode: match patterns' '
 	git -C repo read-tree -mu HEAD 2>err &&
 	test_i18ngrep ! "disabling cone patterns" err &&
 	git -C repo reset --hard &&
-	ls repo >dir  &&
+	list_files repo >dir  &&
 	cat >expect <<-EOF &&
 		a
 		folder1
@@ -177,7 +184,7 @@ test_expect_success 'sparse-checkout disable' '
 	test_path_is_file repo/.git/info/sparse-checkout &&
 	git -C repo config --list >config &&
 	test_must_fail git config core.sparseCheckout &&
-	ls repo >dir &&
+	list_files repo >dir &&
 	cat >expect <<-EOF &&
 		a
 		deep
@@ -191,24 +198,24 @@ test_expect_success 'cone mode: init and set' '
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
@@ -234,7 +241,7 @@ test_expect_success 'cone mode: init and set' '
 		folder1
 		folder2
 	EOF
-	ls repo >dir &&
+	list_files repo >dir &&
 	test_cmp expect dir
 '
 
@@ -256,7 +263,7 @@ test_expect_success 'revert to old sparse-checkout on bad update' '
 	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
 	test_i18ngrep "cannot set sparse-checkout patterns" err &&
 	test_cmp repo/.git/info/sparse-checkout expect &&
-	ls repo/deep >dir &&
+	list_files repo/deep >dir &&
 	cat >expect <<-EOF &&
 		a
 		deeper1
@@ -313,7 +320,7 @@ test_expect_success 'cone mode: set with core.ignoreCase=true' '
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

