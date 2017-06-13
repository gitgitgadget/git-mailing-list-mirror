Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D944D20282
	for <e@80x24.org>; Tue, 13 Jun 2017 11:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbdFMLiX (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 07:38:23 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41345 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752081AbdFMLiW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Jun 2017 07:38:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0E0EC20A89;
        Tue, 13 Jun 2017 07:38:22 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 13 Jun 2017 07:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=kxtaDP
        LPv4Bbg2sBZn8RuQ02jDdU1GlOhZoWspPGJ1g=; b=L8Ly3dfuGQRSaVudlBqqQ/
        9x70/HaQWVr6f5SIv/Ejv9UoV3Q+ZHrwPGj2bMEkoN0vYSRG4O78jogF1i85z3n4
        o3EtLtorkaIGf1SSSuxk42/fqU5v8w/EcHrFypClynF3QhFqSsFbSx0D9suLM00i
        XdKI++trNLYoCAhoacH09KnIOVvue85K6ISzJnakPEfrAUARvAHMwikGHdRKEahL
        vpqCtTrHwwWj9jDv92o1r+eDLgh+wfuO+3+HtxbPNqUlRTUhu9mxuaByl8ZWvD1F
        dL+05PQMagl5qZj1s+pE/a63UiWw0b6JsrtIgyTiHDOXVSkZpuJ1L3IQuRCmaBJQ
        ==
X-ME-Sender: <xms:rc4_WWOMAPk3P5h8i6S1HJqNAx-Nizio8i63fQaWZgPFtaUroqXTVQ>
X-Sasl-enc: V1UA4axCA5U0vfDmSNgaelSaXhw3CYLttO/I5KFFqO8s 1497353900
Received: from localhost (x4e348a7b.dyn.telefonica.de [78.52.138.123])
        by mail.messagingengine.com (Postfix) with ESMTPA id E0E4A248EF;
        Tue, 13 Jun 2017 07:38:20 -0400 (EDT)
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-stash: fix pushing stash with pathspec from subdir
Date:   Tue, 13 Jun 2017 13:38:34 +0200
Message-Id: <6200f6bf1a9ac81d02391b898d203d650c6af962.1497353866.git.ps@pks.im>
X-Mailer: git-send-email 2.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git stash push` command recently gained the ability to get a
pathspec as its argument to only stash matching files. Calling this
command from a subdirectory does not work, though, as one of the first
things we do is changing to the top level directory without keeping
track of the prefix from which the command is being run.

Fix the shortcoming by storing the prefix previous to the call to
`cd_to_toplevel` and then subsequently using `git rev-parse --prefix` to
correctly resolve the pathspec. Add a test to catch future breakage of
this usecase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-stash.sh     |  3 +++
 t/t3903-stash.sh | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index 2fb651b2b..e7b85932d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -19,6 +19,7 @@ OPTIONS_SPEC=
 START_DIR=$(pwd)
 . git-sh-setup
 require_work_tree
+prefix=$(git rev-parse --show-prefix) || exit 1
 cd_to_toplevel
 
 TMP="$GIT_DIR/.git-stash.$$"
@@ -273,6 +274,8 @@ push_stash () {
 		shift
 	done
 
+	eval "set $(git rev-parse --sq --prefix "$prefix" -- "$@")"
+
 	if test -n "$patch_mode" && test -n "$untracked"
 	then
 		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3b4bed5c9..4046817d7 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -812,6 +812,22 @@ test_expect_success 'stash -- <pathspec> stashes and restores the file' '
 	test_path_is_file bar
 '
 
+test_expect_success 'stash -- <pathspec> stashes in subdirectory' '
+	mkdir sub &&
+	>foo &&
+	>bar &&
+	git add foo bar &&
+	(
+		cd sub &&
+		git stash push -- ../foo
+	) &&
+	test_path_is_file bar &&
+	test_path_is_missing foo &&
+	git stash pop &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_expect_success 'stash with multiple pathspec arguments' '
 	>foo &&
 	>bar &&
-- 
2.13.1

