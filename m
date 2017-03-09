Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A31A202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbdCIWZM (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:25:12 -0500
Received: from mout.gmx.net ([212.227.15.18]:63679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753033AbdCIWZK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:25:10 -0500
Received: from virtualbox ([37.201.193.18]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBFUT-1cvl930Qa5-00AC71; Thu, 09
 Mar 2017 23:25:04 +0100
Date:   Thu, 9 Mar 2017 23:25:03 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v5 08/11] read_early_config(): really discover .git/
In-Reply-To: <cover.1489098170.git.johannes.schindelin@gmx.de>
Message-ID: <40053216acd5190a3f26564664d09b35def8cced.1489098170.git.johannes.schindelin@gmx.de>
References: <cover.1488897111.git.johannes.schindelin@gmx.de> <cover.1489098170.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3A7RdUAFyvj1bEVkzvduvquG5+/vsJjZTqWJT6poHEM4ALlLfZZ
 mTEwR4ObKs1dF+yMkvEU8eIQ6vynZ8qc1rWAl6QV04ZvIqqwxrVb47TQ8LabE8y/tE0ORxC
 UqI9l4cy66EYXGskgG6JyStsU7Sx0LE+2ZRpCqEiqyeLP53KjEwaCz2IC/KAXhFIy0a2nDy
 TG44QQs3kf33N7ik0nR3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KVTjaEzx9ec=:0As+8zHD0QBpUk41SgdEZ5
 Mnw3+PAVpD2uehXWUFCFHbSk50RHgXhNPUmUAIMOgEmpAdDQQSkd/BDdfMJGpGr206pQMIulH
 sO2eXyeopMupTJdd6dEfW53iG838/ckrCi6acrdEr57/DVdSpk400zPEzeJeEIjnEf66bn5sP
 w16a/3F3i7SmNwlLMe9rn9j9fcLAvnb+ZK1Y2N+E54plRC09Yy9/287Y7QzdemSS11FC5i6tJ
 vhHWnIP5d4gp3aQLAfCNnkSrVOs5++K2w9eacIbM+gSCAI2RyvxpeaDFKqTS9SQLexwlqgDFF
 AaF9oJgOFihbuois3Nss3dad2JmYaJj3Z3+gKfQ6MwdjYXUAVvPG1Dn7dP6EuhgeE20Bgh+ma
 F98sGHTdCZj+XLd1Ij5C+VcQkVcT4nL0xUe7i5+UZkEVwjGuWIKiAG/tmlwu45PoqJyFo/+T7
 Yb6ruVdbP7rNVPQDFEH+NYWrPLgAXcOA38b7r+XM1g8QdQ0ZHAPiShRY77pyagKzPZj7uHTZg
 WSlbtBd7jmDFOtSSTJtygjEv6CJ57DG2slP7p7pLkem5Cmhe/CaxH8Pv5de2KQ2f7CwJQXEtJ
 GzXWTNOf/Ze3Rx11u7Yl5wjwCMdEOZzVQpOv+0ipXolpAMr3m7CeLInQmJqhl8vbMI+F95bkL
 7ku8XBqiAaO4XHqQRa8UCvUvOQvsqL+iyvd2cIn8IBPkOosHfeD4glHeJaw0tJPXwPL9rCTKx
 x/4Ppjer/4VZiqBXpFeziCuSev00BcFUW35WX+1AGygkG1S9jz93Ra/4i+mA1DN2nMwTiysNZ
 9AlOdEr
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
index 068fa4dcfa6..a88df53fdbc 100644
--- a/config.c
+++ b/config.c
@@ -1414,34 +1414,27 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 
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


