Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233B720373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbdCMUL1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:11:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:50941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753247AbdCMUL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:11:26 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWCgz-1clT1X2l7R-00XLhA; Mon, 13
 Mar 2017 21:11:14 +0100
Date:   Mon, 13 Mar 2017 21:11:12 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v6 08/12] read_early_config(): really discover .git/
In-Reply-To: <cover.1489435755.git.johannes.schindelin@gmx.de>
Message-ID: <c17676fd4fe5de06c62f316511150255e3d79d5c.1489435755.git.johannes.schindelin@gmx.de>
References: <cover.1489098170.git.johannes.schindelin@gmx.de> <cover.1489435755.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aXniGvIGtYHMAgeoYXn0aPfhcJuY13wgECvrb32y93UEWmA2TBl
 S5vnaTw4LfDrN4nhwGFBVmK8lACMwML+ZeCYtxs/wPtIRKgLkVG3MRIjO4Nj09KcL/3ffAs
 oyRR1M96uefSyUpGRGnhf6GUgvNtxKOsiPvfXMlpUcoKvSDdeCOhhh/QTpsYYI1XhhrLfix
 vylCeoHhxLhUlVC9wS4yg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hbp4XLyooKo=:pNy6CRJlvDq14sHL/CmBKa
 d5kmmr1nHgLggWXPsGm0Z8iaN1K3sywFjSJHrgYuBQIVEvLKax3u4YfPQtt2fAuAlMR7XUfvj
 MG1FMpksH52fb6mCR3hxUXqpvrgF0kVseEgzpnNWB5blSliFA9oTio0MZyvGHIhV4kX+wWwV2
 GA3HVIVpHwlgLt2xhdEPQv0zmlAWKrub+NCdYDrnQWTnWVdSCDrxDqc4EN6XOEkqLkihsHFUL
 wy5GvR+bADoSZQs5ITBobQwDERca0+UeGc76F7cn7JF4BU8X84ERLNA/1vQbZkOj/GDSRsHcU
 uZgysIY/4rWPZ2YmBr6YaWqQrxghjZ9KAhiDepS0ibUf72+hqfcoyMQm5QfL8TtJtk4MyDxPw
 eEmREoijGsNWm6fkNtuyptN+NeVjqSAcvUN+J1uxbwmbBvumclwCijHB4nsFQ3BAsGEZ+My1b
 Ys+WPjusbGM5Wd7znBm2tnS4Mu5OV1KnV1JLM/7Z3FD+kF85DjrMn3NhFRhv1d3VeRHVBruNU
 oI80DSWyKre4G+/e7v+NHu6RKVkNI63ha3aPoHAC8vBT76s+HIh6nby4fhh4hkcPLNhgU8ArU
 fQ6rkS0pVFXEu4YGstDzJmpjleDl/uQiDDV2d67U77tlmFkKrvF8dKJpGTxi7r7FGxODUJkqX
 69pEkrb+q+KjjCcNS+EnlsQk5J8by4DYXJZ3r+XtW7BmfQkxZ0x8wYHUPBcVtiJP2xwk5euic
 BXt0BWT/fjsVZ6W/U5iVGIHXml7h5TbO8cmk6Fz/4BczGuZdOtDjS11p1DHzOBBKC85zx0S5G
 swIHp04
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier, we punted and simply assumed that we are in the top-level
directory of the project, and that there is no .git file but a .git/
directory so that we can read directly from .git/config.

However, that is not necessarily true. We may be in a subdirectory. Or
.git may be a gitfile. Or the environment variable GIT_DIR may be set.

To remedy this situation, we just refactored the way
setup_git_directory() discovers the .git/ directory, to make it
reusable, and more importantly, to leave all global variables and the
current working directory alone.

Let's discover the .git/ directory correctly in read_early_config() by
using that new function.

This fixes 4 known breakages in t7006.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c         | 31 ++++++++++++-------------------
 t/t7006-pager.sh |  8 ++++----
 2 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/config.c b/config.c
index fc4625a71dd..030acc50aa2 100644
--- a/config.c
+++ b/config.c
@@ -1505,34 +1505,27 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 
 void read_early_config(config_fn_t cb, void *data)
 {
+	struct strbuf buf = STRBUF_INIT;
+
 	git_config_with_options(cb, data, NULL, 1);
 
 	/*
-	 * Note that this is a really dirty hack that does the wrong thing in
-	 * many cases. The crux of the problem is that we cannot run
-	 * setup_git_directory() early on in git's setup, so we have no idea if
-	 * we are in a repository or not, and therefore are not sure whether
-	 * and how to read repository-local config.
-	 *
-	 * So if we _aren't_ in a repository (or we are but we would reject its
-	 * core.repositoryformatversion), we'll read whatever is in .git/config
-	 * blindly. Similarly, if we _are_ in a repository, but not at the
-	 * root, we'll fail to find .git/config (because it's really
-	 * ../.git/config, etc), unless setup_git_directory() was already called.
-	 * See t7006 for a complete set of failures.
-	 *
-	 * However, we have historically provided this hack because it does
-	 * work some of the time (namely when you are at the top-level of a
-	 * valid repository), and would rarely make things worse (i.e., you do
-	 * not generally have a .git/config file sitting around).
+	 * When setup_git_directory() was not yet asked to discover the
+	 * GIT_DIR, we ask discover_git_directory() to figure out whether there
+	 * is any repository config we should use (but unlike
+	 * setup_git_directory_gently(), no global state is changed, most
+	 * notably, the current working directory is still the same after the
+	 * call).
 	 */
-	if (!have_git_dir()) {
+	if (!have_git_dir() && discover_git_directory(&buf)) {
 		struct git_config_source repo_config;
 
 		memset(&repo_config, 0, sizeof(repo_config));
-		repo_config.file = ".git/config";
+		strbuf_addstr(&buf, "/config");
+		repo_config.file = buf.buf;
 		git_config_with_options(cb, data, &repo_config, 1);
 	}
+	strbuf_release(&buf);
 }
 
 static void git_config_check_init(void);
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 304ae06c600..4f3794d415e 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -360,19 +360,19 @@ test_pager_choices                       'git aliasedlog'
 test_default_pager        expect_success 'git -p aliasedlog'
 test_PAGER_overrides      expect_success 'git -p aliasedlog'
 test_core_pager_overrides expect_success 'git -p aliasedlog'
-test_core_pager_subdir    expect_failure 'git -p aliasedlog'
+test_core_pager_subdir    expect_success 'git -p aliasedlog'
 test_GIT_PAGER_overrides  expect_success 'git -p aliasedlog'
 
 test_default_pager        expect_success 'git -p true'
 test_PAGER_overrides      expect_success 'git -p true'
 test_core_pager_overrides expect_success 'git -p true'
-test_core_pager_subdir    expect_failure 'git -p true'
+test_core_pager_subdir    expect_success 'git -p true'
 test_GIT_PAGER_overrides  expect_success 'git -p true'
 
 test_default_pager        expect_success test_must_fail 'git -p request-pull'
 test_PAGER_overrides      expect_success test_must_fail 'git -p request-pull'
 test_core_pager_overrides expect_success test_must_fail 'git -p request-pull'
-test_core_pager_subdir    expect_failure test_must_fail 'git -p request-pull'
+test_core_pager_subdir    expect_success test_must_fail 'git -p request-pull'
 test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p request-pull'
 
 test_default_pager        expect_success test_must_fail 'git -p'
@@ -380,7 +380,7 @@ test_PAGER_overrides      expect_success test_must_fail 'git -p'
 test_local_config_ignored expect_failure test_must_fail 'git -p'
 test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p'
 
-test_expect_failure TTY 'core.pager in repo config works and retains cwd' '
+test_expect_success TTY 'core.pager in repo config works and retains cwd' '
 	sane_unset GIT_PAGER &&
 	test_config core.pager "cat >cwd-retained" &&
 	(
-- 
2.12.0.windows.1.7.g94dafc3b124


