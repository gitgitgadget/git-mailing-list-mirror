Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC40020133
	for <e@80x24.org>; Fri,  3 Mar 2017 17:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbdCCReB (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:34:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:61696 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751945AbdCCReA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:34:00 -0500
Received: from virtualbox ([89.204.154.17]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1zFf-1cQFxi0a9D-00txju; Fri, 03
 Mar 2017 18:33:29 +0100
Date:   Fri, 3 Mar 2017 18:33:27 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v3 8/9] read_early_config(): really discover .git/
In-Reply-To: <cover.1488562287.git.johannes.schindelin@gmx.de>
Message-ID: <3952d78fa82b2cb5394369ae0be2f5992f418ff2.1488562287.git.johannes.schindelin@gmx.de>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tFPh605y3+WlG/klNsMK0l7XZ2QSO6MS1hG4AzMaXfuyz7410Bq
 MyYegjNJEaq+sggMgHnizuHqIBkH10CAQAd9ieVk81p92uu7VKXYKM4KfeL140i9xINxZTP
 pt2t0B/GAes2TDjvvifierupehJrysVrRnxwUC5LLA5m3CoP1D5yFjNRuGQWTf6g+RC5DLX
 fETFqv4ZUQ5U5BJctaUSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+7nhuRbxhic=:zteEWqJ/bHUrtAfgBqBnUT
 OMBrWqBY+6e4TTO/tzx74PtE5ZL1QMxXtpRzIXXvSKogj+CqLFIK1nmNbNo/jQhAzWgoZN/Kx
 DGe28QRIe2fYhgULTX5aGvrzE+5rtGla65YXsZQO1zBxVAtj0jdHFLxIkx0APXgpbUWaLtF+i
 C/IhAJFS7bKpWHsP1OKjgJsEaYwu/CeHw4bdFESi2MbxF6JDzxFMjDHVXYe+rnjHI/1/TK24R
 yqoO4gaFWDNjOKF047Ef51nPzl8MLYDk28w0s2RvZd6awSrsjCZv1l74yrgoR1MuW6CQyzYZv
 7FbAN+lBJieMWWl7C/NdL5sEcso2Uj714wLokMD26qlYj8jgRA0toQI3Kzi38+Unw23yvaMtD
 e8rOV7/HlmX8Z33gP4bJXYceaJp7jiMWc0zBkiW8FLAtEHd4YLzklJ+4XL1TPD56p8uZ8xiN+
 N67r13vcGgxgvYuWwUAgRj7+57z6TdJ4qDmYraifAiPYWWr/JQ4UO+3La6Wg14BbnT/d/AkL6
 VwULeypSkXPjpsRle4AfQgjJrneqOTismEyk8FPxY42ayAMmcsW7KGqztPL96Jg3lyAwobbob
 74glD0wxm6qNOg2jlkWR5eLpo0icbItoLidDgryR3uKfZCm8ZhOiAHSMLlOMIw9R3KsCSgxrm
 womG94YxK5LE67klv9sC0mrUSdoWOZlpAjIR/Pilx7mIhJDM75z4iJW4vZ5V1CnVnXCt3HMlk
 2fwxLlmdJnaA0060QnhynRdF59vTYxexoOhxE/KMadiStLHTObvQtQl1hJieApDF9bjbtaf8R
 nqARBeO
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
 config.c         | 33 ++++++++++++++-------------------
 setup.c          | 14 +++++++++++++-
 t/t7006-pager.sh |  8 ++++----
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/config.c b/config.c
index 068fa4dcfa6..749623a9649 100644
--- a/config.c
+++ b/config.c
@@ -1414,34 +1414,29 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 
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
+	 * When we are not about to create a repository ourselves (init or
+	 * clone) and when no .git/ directory was set up yet (in which case
+	 * git_config_with_options() would already have picked up the
+	 * repository config), we ask discover_git_directory() to figure out
+	 * whether there is any repository config we should use (but unlike
+	 * setup_git_directory_gently(), no global state is changed, most
+	 * notably, the current working directory is still the same after
+	 * the call).
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
diff --git a/setup.c b/setup.c
index 32ce023638a..5320ae37314 100644
--- a/setup.c
+++ b/setup.c
@@ -925,8 +925,9 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 
 const char *discover_git_directory(struct strbuf *gitdir)
 {
-	struct strbuf dir = STRBUF_INIT;
+	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
 	size_t gitdir_offset = gitdir->len, cwd_len;
+	struct repository_format candidate;
 
 	if (strbuf_getcwd(&dir))
 		return NULL;
@@ -949,8 +950,19 @@ const char *discover_git_directory(struct strbuf *gitdir)
 			strbuf_addch(&dir, '/');
 		strbuf_insert(gitdir, gitdir_offset, dir.buf, dir.len);
 	}
+
+	strbuf_reset(&dir);
+	strbuf_addf(&dir, "%s/config", gitdir->buf + gitdir_offset);
+	read_repository_format(&candidate, dir.buf);
 	strbuf_release(&dir);
 
+	if (verify_repository_format(&candidate, &err) < 0) {
+		warning("ignoring git dir '%s': %s",
+			gitdir->buf + gitdir_offset, err.buf);
+		strbuf_release(&err);
+		return NULL;
+	}
+
 	return gitdir->buf;
 }
 
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


