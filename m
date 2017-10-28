Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0132055E
	for <e@80x24.org>; Sat, 28 Oct 2017 18:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbdJ1SQA (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 14:16:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55558 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751430AbdJ1SP5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 14:15:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 90F8D6044B;
        Sat, 28 Oct 2017 18:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509214557;
        bh=DOm+cJBgoiNfXzMv7Fl/G6Xl90sSZjl80mh59OXysLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=eVkiaWya/zSJlXIgHBrQPrMG2DCTXq2Xm8CqTpaxh0u5arHFr3N3uqn+8WEElVTOg
         TyvgjZMeicmHYXT8XOm4rH5WCiYi1pTBeeilBMfOaS/YrjJKRDpUbX3YmGlrOOsDxX
         l8Cd4pIOVyU1n10Bo118Jr8l/BufdCxl7cMf4qWZoVhTIG20uP0afRJPKXLZ5V/zId
         IUe87kmhn1n2nq1UfaTpcx9zRNfhEK/LcLcaD7VtknyVGqDyB8d9Xs2RaO4fv0Nwj8
         itPScyVuVKd/Ka0H7dTEt09bMP4eSimdNXGAiZVot3I/j8//GQ4UVVil3jBlhEdErT
         cKppgIDI88RV4kP0dsIAobkakFLWlMIduJqUSmtBKTdNxB9s1ULGmAUR74OYgECber
         py7youb/tIa8AFp2X/aG0e9KaH6SMGKOyoOu+pv8vFdz8Sl+zY2qZMcQ0zPGIJ1rBL
         wWutZUgYAr4o3zKmqFjwpqlPgceHiF8SVl2yY11aTyLg2CdDfpS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 1/4] setup: expose enumerated repo info
Date:   Sat, 28 Oct 2017 18:12:36 +0000
Message-Id: <20171028181239.59458-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc2
In-Reply-To: <20171028181239.59458-1-sandals@crustytoothpaste.net>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We enumerate several different items as part of struct
repository_format, but then actually set up those values using the
global variables we've initialized from them.  Instead, let's pass a
pointer to the structure down to the code where we enumerate these
values, so we can later on use those values directly to perform setup.

This technique makes it easier for us to determine additional items
about the repository format (such as the hash algorithm) and then use
them for setup later on, without needing to add additional global
variables.  We can't avoid using the existing global variables since
they're intricately intertwined with how things work at the moment, but
this improves things for the future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 setup.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/setup.c b/setup.c
index 03f51e056c..f0f509fe85 100644
--- a/setup.c
+++ b/setup.c
@@ -432,16 +432,15 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 	return 0;
 }
 
-static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
+static int check_repository_format_gently(const char *gitdir, struct repository_format *candidate, int *nongit_ok)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
-	struct repository_format candidate;
 	int has_common;
 
 	has_common = get_common_dir(&sb, gitdir);
 	strbuf_addstr(&sb, "/config");
-	read_repository_format(&candidate, sb.buf);
+	read_repository_format(candidate, sb.buf);
 	strbuf_release(&sb);
 
 	/*
@@ -449,10 +448,10 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	 * we treat a missing config as a silent "ok", even when nongit_ok
 	 * is unset.
 	 */
-	if (candidate.version < 0)
+	if (candidate->version < 0)
 		return 0;
 
-	if (verify_repository_format(&candidate, &err) < 0) {
+	if (verify_repository_format(candidate, &err) < 0) {
 		if (nongit_ok) {
 			warning("%s", err.buf);
 			strbuf_release(&err);
@@ -462,21 +461,21 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 		die("%s", err.buf);
 	}
 
-	repository_format_precious_objects = candidate.precious_objects;
-	string_list_clear(&candidate.unknown_extensions, 0);
+	repository_format_precious_objects = candidate->precious_objects;
+	string_list_clear(&candidate->unknown_extensions, 0);
 	if (!has_common) {
-		if (candidate.is_bare != -1) {
-			is_bare_repository_cfg = candidate.is_bare;
+		if (candidate->is_bare != -1) {
+			is_bare_repository_cfg = candidate->is_bare;
 			if (is_bare_repository_cfg == 1)
 				inside_work_tree = -1;
 		}
-		if (candidate.work_tree) {
+		if (candidate->work_tree) {
 			free(git_work_tree_cfg);
-			git_work_tree_cfg = candidate.work_tree;
+			git_work_tree_cfg = candidate->work_tree;
 			inside_work_tree = -1;
 		}
 	} else {
-		free(candidate.work_tree);
+		free(candidate->work_tree);
 	}
 
 	return 0;
@@ -623,6 +622,7 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 
 static const char *setup_explicit_git_dir(const char *gitdirenv,
 					  struct strbuf *cwd,
+					  struct repository_format *repo_fmt,
 					  int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
@@ -648,7 +648,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		die("Not a git repository: '%s'", gitdirenv);
 	}
 
-	if (check_repository_format_gently(gitdirenv, nongit_ok)) {
+	if (check_repository_format_gently(gitdirenv, repo_fmt, nongit_ok)) {
 		free(gitfile);
 		return NULL;
 	}
@@ -721,9 +721,10 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 
 static const char *setup_discovered_git_dir(const char *gitdir,
 					    struct strbuf *cwd, int offset,
+					    struct repository_format *repo_fmt,
 					    int *nongit_ok)
 {
-	if (check_repository_format_gently(gitdir, nongit_ok))
+	if (check_repository_format_gently(gitdir, repo_fmt, nongit_ok))
 		return NULL;
 
 	/* --work-tree is set without --git-dir; use discovered one */
@@ -735,7 +736,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 			gitdir = to_free = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
-		ret = setup_explicit_git_dir(gitdir, cwd, nongit_ok);
+		ret = setup_explicit_git_dir(gitdir, cwd, repo_fmt, nongit_ok);
 		free(to_free);
 		return ret;
 	}
@@ -767,11 +768,12 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 
 /* #16.1, #17.1, #20.1, #21.1, #22.1 (see t1510) */
 static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
+				      struct repository_format *repo_fmt,
 				      int *nongit_ok)
 {
 	int root_len;
 
-	if (check_repository_format_gently(".", nongit_ok))
+	if (check_repository_format_gently(".", repo_fmt, nongit_ok))
 		return NULL;
 
 	setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
@@ -783,7 +785,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
+		return setup_explicit_git_dir(gitdir, cwd, repo_fmt, nongit_ok);
 	}
 
 	inside_git_dir = 1;
@@ -1024,6 +1026,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT;
 	const char *prefix;
+	struct repository_format repo_fmt;
 
 	/*
 	 * We may have read an incomplete configuration before
@@ -1051,18 +1054,18 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		prefix = NULL;
 		break;
 	case GIT_DIR_EXPLICIT:
-		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, nongit_ok);
+		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_DISCOVERED:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("Cannot change to '%s'"), dir.buf);
 		prefix = setup_discovered_git_dir(gitdir.buf, &cwd, dir.len,
-						  nongit_ok);
+						  &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_BARE:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("Cannot change to '%s'"), dir.buf);
-		prefix = setup_bare_git_dir(&cwd, dir.len, nongit_ok);
+		prefix = setup_bare_git_dir(&cwd, dir.len, &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
 		prefix = setup_nongit(cwd.buf, nongit_ok);
@@ -1169,7 +1172,8 @@ int git_config_perm(const char *var, const char *value)
 
 void check_repository_format(void)
 {
-	check_repository_format_gently(get_git_dir(), NULL);
+	struct repository_format repo_fmt;
+	check_repository_format_gently(get_git_dir(), &repo_fmt, NULL);
 	startup_info->have_repository = 1;
 }
 
-- 
2.15.0.rc2

