Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10B12013E
	for <e@80x24.org>; Fri,  3 Mar 2017 02:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdCCCHK (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 21:07:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:55724 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbdCCCFu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 21:05:50 -0500
Received: from virtualbox ([89.204.153.4]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lz3rc-1cEfYH2oHQ-014Dmn; Fri, 03
 Mar 2017 03:04:33 +0100
Date:   Fri, 3 Mar 2017 03:04:32 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 8/9] read_early_config(): really discover .git/
In-Reply-To: <cover.1488506615.git.johannes.schindelin@gmx.de>
Message-ID: <921faef822901715fa877d6969255ce00d80b925.1488506615.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:L9Bw9Kl5KLEsT2oQOwsUJhM3CPfQ/L07MaArGquUQhAuxOrbPa1
 CF7BBWvT0/52C0DqBJzyCVC+z08VjLBGfs9pHFJdL4k8eE0NiowF5WGHLfE1wsQwMwbpiAR
 /4pkwh7nLRzln3cE3pJ53Wy1Gogarm4drUV1F0mXRLfmfHa1ujcSY+phkX5ep4uNTFY5OpF
 0JxTwgSkJOk2WMfZAWAEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4jDdl8XHHoo=:yF6QY1j8n6KrS1SKEqneaQ
 e9vbU999+OrAMbjBmkU2MVMbUtGD4WjWS34l1EGnuLeNMaY/Up7QOiiLFJ+zt6U+IFQAKb1Di
 uk5QXm4VOp2ZmGTOM82j5DGLWJzeV+MW+7V4sKmkc761DZLd5VMD9UxTxmNqyxUOzgC1dIL6o
 fZ1kpsawIb38MqfSMmzVxfENKm5dILDEWvx69uucexzf92h/oba3XEVdDmv2XbjT3P4JggARA
 eGlOeW9CEMuBpahRIGM/nlHE0O+owj9mI38uDlg6nTKyFP0E5oOVWmz1ibRFK9j5fk5C378zQ
 ozFdqFZ6GkQGPKaztswUUrjTWOAENo5gTT2kCgu/HUYcqss24JzKxpLl5Jz8QuyPK0FeY5KOq
 9qthsDakRMPrOa1Q1KVfXb9ATJ52GKJs1ikA/R88Uq08AGHDQwcO2j2V5ihvYaEj88dFoplz0
 SYWp/k6jI+flt6kup/CuNHYevZF9Vl3XF4i3qzAyGgPfDpA6J7XPRyuwqTaK0f5y9GphXtbnm
 2Qwa5t1KaJNDwcXtsqb19puO2oVKtxcUMTv75qdPaUsk1jQh0UQiMH9C0F3jHzJ5L/rS7YrUq
 mimTdPNSUshhLdpS1mrryNrEuZxv0X/EarTDdUd7o3v3cFcaUkhX73qx/3eZGRCZIiH2VgROF
 Q2te4ULfu0OVYWfenOiItnz7ZqUnqd5oR4QZ30Mutk7TtwMQwQXN6YfAHJM7aXF8m73g/Anqg
 szJTi9tQnU3DD4BD2B/GSo676iqfUFK/g7HzfNLAR4PdjtPUBg1oPK4ORHuSd+KiMMiSvLPsv
 FVG74rg
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
 config.c         | 9 +++++++--
 t/t7006-pager.sh | 8 ++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index 3ee5e5a15d6..bcda397d42e 100644
--- a/config.c
+++ b/config.c
@@ -1414,6 +1414,8 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 
 void read_early_config(config_fn_t cb, void *data)
 {
+	struct strbuf buf = STRBUF_INIT;
+
 	git_config_with_options(cb, data, NULL, 1);
 
 	/*
@@ -1434,13 +1436,16 @@ void read_early_config(config_fn_t cb, void *data)
 	 * valid repository), and would rarely make things worse (i.e., you do
 	 * not generally have a .git/config file sitting around).
 	 */
-	if (!startup_info->creating_repository && !have_git_dir()) {
+	if (!startup_info->creating_repository && !have_git_dir() &&
+	    discover_git_directory(&buf)) {
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
index 427bfc605ad..bf89340988b 100755
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
2.12.0.windows.1.3.g8a117c48243


