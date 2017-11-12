Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58059201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 21:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbdKLV3H (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 16:29:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55964 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750909AbdKLV3E (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 16:29:04 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 80BE960488;
        Sun, 12 Nov 2017 21:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1510522144;
        bh=yUsDfBruh/hNAkIX/zXYogoRLzLhJ4qYAbv5E0o9slE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=M1jXlZ1q21198gRqykkGtypI/QHiw8myakEqQf0bVNFV2gPK058xk0t4AsEBdSPy3
         7D/rZuuU4bRGCUFIINcrHQWESFRENsuNliiXLJHjoN8xHVUt041n7qD0EX9PEwSdi6
         HjaFHQ0cw9MTOqzKhm11aA0OMNmxPu+Yn+5053Q3f4jVt+kguGN+GovlDSfjIWFZsl
         KNV+u7BMJtllgecCPG3CxIt5atTEzs0IQRcK5zBEVNOYMH/n6djXXMRPxAkM+p/yag
         6NZz/YQlZeloZvQiKuVgU35KGuESB+etluIR1LHmRohv0FdWMv2fZmGcmL79RIFsFf
         vIbVDdfdnga6vU4rGCOJQzz0O+vtg++nyMIFDtoIJu/89sLaZwRcbfTLjY+1BUoAVK
         EoSKvVF6t+gaGg2xBdkgx1gc2SKQtEz8KS5da+F4uUAyYXlVu2fTGq5AZgT5D9yIuS
         jq/julT8mXf8sYaINmjS9nizdYBh80AfnSW2KZdyUmh/QGJzP+9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 1/4] setup: expose enumerated repo info
Date:   Sun, 12 Nov 2017 21:28:51 +0000
Message-Id: <20171112212854.791179-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a
In-Reply-To: <20171112212854.791179-1-sandals@crustytoothpaste.net>
References: <20171112212854.791179-1-sandals@crustytoothpaste.net>
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
index 94768512b7..cf1b22cd30 100644
--- a/setup.c
+++ b/setup.c
@@ -434,16 +434,15 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
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
@@ -451,10 +450,10 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
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
@@ -464,21 +463,21 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
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
@@ -625,6 +624,7 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 
 static const char *setup_explicit_git_dir(const char *gitdirenv,
 					  struct strbuf *cwd,
+					  struct repository_format *repo_fmt,
 					  int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
@@ -650,7 +650,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		die("Not a git repository: '%s'", gitdirenv);
 	}
 
-	if (check_repository_format_gently(gitdirenv, nongit_ok)) {
+	if (check_repository_format_gently(gitdirenv, repo_fmt, nongit_ok)) {
 		free(gitfile);
 		return NULL;
 	}
@@ -723,9 +723,10 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 
 static const char *setup_discovered_git_dir(const char *gitdir,
 					    struct strbuf *cwd, int offset,
+					    struct repository_format *repo_fmt,
 					    int *nongit_ok)
 {
-	if (check_repository_format_gently(gitdir, nongit_ok))
+	if (check_repository_format_gently(gitdir, repo_fmt, nongit_ok))
 		return NULL;
 
 	/* --work-tree is set without --git-dir; use discovered one */
@@ -737,7 +738,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 			gitdir = to_free = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
-		ret = setup_explicit_git_dir(gitdir, cwd, nongit_ok);
+		ret = setup_explicit_git_dir(gitdir, cwd, repo_fmt, nongit_ok);
 		free(to_free);
 		return ret;
 	}
@@ -769,11 +770,12 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 
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
@@ -785,7 +787,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
+		return setup_explicit_git_dir(gitdir, cwd, repo_fmt, nongit_ok);
 	}
 
 	inside_git_dir = 1;
@@ -1026,6 +1028,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT;
 	const char *prefix;
+	struct repository_format repo_fmt;
 
 	/*
 	 * We may have read an incomplete configuration before
@@ -1053,18 +1056,18 @@ const char *setup_git_directory_gently(int *nongit_ok)
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
@@ -1171,7 +1174,8 @@ int git_config_perm(const char *var, const char *value)
 
 void check_repository_format(void)
 {
-	check_repository_format_gently(get_git_dir(), NULL);
+	struct repository_format repo_fmt;
+	check_repository_format_gently(get_git_dir(), &repo_fmt, NULL);
 	startup_info->have_repository = 1;
 }
 
