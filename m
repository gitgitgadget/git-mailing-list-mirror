Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D268F1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 14:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754463AbdCGOfK (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:35:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:64489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755183AbdCGOfI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 09:35:08 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWTfu-1cmu4p1si2-00Xbq0; Tue, 07
 Mar 2017 15:33:21 +0100
Date:   Tue, 7 Mar 2017 15:33:15 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v4 08/10] read_early_config(): really discover .git/
In-Reply-To: <cover.1488897111.git.johannes.schindelin@gmx.de>
Message-ID: <9b87d8b78e3b94b6e269eb8db2f76a68ea102f6d.1488897111.git.johannes.schindelin@gmx.de>
References: <cover.1488562287.git.johannes.schindelin@gmx.de> <cover.1488897111.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GTbwwXTFndnV3gETU5BTHifomfl7pu0DdXYIkmnct/juOO9Dy07
 /WQty/MUITRbQW7sQ9Y8tIJRBStzZaY/lPGsd5WIwk7BKt63YJ15X8UMGQeLrAEwMWmYrZD
 ltuQIx88t2qLt4I/j6XgdlESkeQvKABzjBWv9hftXfpeYCqmIIMBH6tAkf20b+5Pjs451TL
 Knnq75g70rloYpVq8Denw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pLfdYeipN1U=:Fo+n50/gZdYzPg5vdOGGQb
 FQS4GhFjmTfua0FZWWGm41ce7Rc1KNs2M2mRnI06zlOzk3bT7iCrmXio3mFeKrXCpLEFZrkvu
 4zOOzjpHTdOMXxTmrFWuaC+oKDOSfb7YeV19/+wFL0TWA0DNIw8o6L0/EN1JGYV+9iTsh0WHV
 Gc3POBGP2YuCKhQ8pxByesLZWoy631D78I5mZXuLy9bcgaCQwE8fgwY6vQTCLz1t4zrrX8/nM
 JUHcvE5DXr11wx2xJ7/zhzOLMKW4QA0r/1dJ4Jc/GXS/Zo/ocDzbnYi0tmrBiKcaljAGt5SmJ
 iQuySR5ouqsH7KvQd3phhkiiUQ2541yJPXShlEyv6IPERz+P6fXdux0XFyBySaOEjjNi/fJKA
 RG+mpQYbkuYE0vMNLxfjLl+DKUp2Xb2s5LaNZj46Rv7/2ASYzUmNeNBfLq0zDJ3DUmAeGXVJf
 6ZVhRhTcnAkF+TZ8/VQ5OmIXs2oNryXQq9mXX+a5N41Mpq+D0rPRtZTPiTAMjx5losdKrRUFh
 k8AebycVWiUkQUO23HZglx12/AlSdsHqKgkWnYcuktPfn+Fswu3cWmkiuF0YNUMUqJLChwgvY
 FB3Yv2e/Tv3fhvxfZkhQUj29YMke326gnLo+YdNDZ3Ip0u6gvyBY0SZiKjONZQZP9dGWqQUZP
 DFUYRO1kecr6SkHVX3xjNfJ4Vm2VVUsey1rRT7KPz4kEOKYF++WWpBksbufpMcL4lY7YKn81Q
 IwHr4zEiy+hCNadFJmPsBxpDA9PfNrGFsfEQrP53JTUGfdMqeqysF5IS0/16AIuWqj5oKb+Kv
 jw+83Tj
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


