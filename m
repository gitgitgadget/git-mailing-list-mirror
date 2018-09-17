Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804171F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeIRDF3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:05:29 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49802 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbeIRDF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:05:28 -0400
Received: by mail-pf1-f201.google.com with SMTP id d1-v6so9024671pfo.16
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dGBUGTNog18hlMse2uaY+4/W+OqsYZ7k0qYZST7kDUI=;
        b=RAPofrgmqb1Zn/UIjSFgg/+pIDqhNWZpW3PkcOAEXnqciilU5yPOqKOcI9VFw97r3b
         cZ+EZGLQqbIfFBHiwR1odP3N7agx+kG3M8vXUghT4NiHfLGfkUkVPRNSr7l4ySoA7DRt
         rqQXLWCmudd1DI9n604GaVq1B9/03L8gkwCOIdwMiNMKTWKmu0fsLh7YbFNeCptX7pOP
         Q1LL2x1Ijjlc2e2b72EfiyQjg1uZkKfWTOOGUGzyMYs41ZbrKqm6ENg8orQKN4TzUht1
         xI2bygy14UVwffqWbZrqgCpIMzOL2RqbCTC8/7TQFf2BFrCnumf+b9X4O/XgevO6PEvE
         wKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dGBUGTNog18hlMse2uaY+4/W+OqsYZ7k0qYZST7kDUI=;
        b=O/sbl1JL1aWRPg3VBoJi3PDKGAMp7VONxkDuIxd+8egxLbIlHpHAzv2yXv85hKySDd
         Q2VHWHQaVp803ABZYX7aXBsKK5tzffQ+ls079Iy+hVSlnSr4/ZuosSzBqid5CvaZ5c6N
         NVqWWfVSpB3t8DNAESNkBvoczL5iS61EA0P2TPWL/cEU1gFNF9HRUj4o6cgjJe1etOzD
         k6Y+tn2aeXOo9uo4L16N1e2g19019V+ubCvKaB9qbByfSQKE/kAB11Hjh6xhodvZ3zmD
         MaVxcKvNMBOS5bZGp2L3ISQLMWESj+xbr21grOd5xKuOPHRSFZ8Q9q4oUuYMFsEF/wJE
         5exQ==
X-Gm-Message-State: APzg51AHtUWbQdYWk5Io2I1K2M4cmtClF0NcAMvrKs2CVfoLuYCNrPyh
        scPwonBkCpBLhlOxAVepGSk7EXGJeCcf
X-Google-Smtp-Source: ANB0VdbgkO4JzzxuPsLVZEpP5VyNLK2Pyhohw98+3DWhney9TCR5+UbJYszqfUUM/ZlsDqHx+M2hgy1f7QWt
X-Received: by 2002:a63:f90a:: with SMTP id h10-v6mr1203296pgi.130.1537220178966;
 Mon, 17 Sep 2018 14:36:18 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:35:57 -0700
In-Reply-To: <20180917213559.126404-1-sbeller@google.com>
Message-Id: <20180917213559.126404-8-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com> <20180917213559.126404-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 7/9] submodule: fetch in submodules git directory instead of
 in worktree
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch started as a refactoring to make 'get_next_submodule' more
readable, but upon doing so, I realized that "git fetch" of the submodule
actually doesn't need to be run in the submodules worktree. So let's run
it in its git dir instead.

That should pave the way towards fetching submodules that are currently
not checked out.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                 | 45 +++++++++++++++++++++++++++----------
 t/t5526-fetch-submodules.sh |  7 +++++-
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/submodule.c b/submodule.c
index 00a9a3c6b12..88bce534268 100644
--- a/submodule.c
+++ b/submodule.c
@@ -481,6 +481,12 @@ void prepare_submodule_repo_env(struct argv_array *out)
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
+static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
+{
+	prepare_submodule_repo_env_no_git_dir(out);
+	argv_array_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
@@ -1227,6 +1233,27 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 	return spf->default_option;
 }
 
+static char *get_submodule_git_dir(struct repository *r, const char *path)
+{
+	struct repository subrepo;
+	const char *ret;
+
+	if (repo_submodule_init(&subrepo, r, path)) {
+		/* no entry in .gitmodules? */
+		struct strbuf gitdir = STRBUF_INIT;
+		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", path);
+		if (repo_init(&subrepo, gitdir.buf, NULL)) {
+			strbuf_release(&gitdir);
+			return NULL;
+		}
+	}
+
+	ret = xstrdup(subrepo.gitdir);
+	repo_clear(&subrepo);
+
+	return ret;
+}
+
 static int get_next_submodule(struct child_process *cp,
 			      struct strbuf *err, void *data, void **task_cb)
 {
@@ -1234,8 +1261,6 @@ static int get_next_submodule(struct child_process *cp,
 	struct submodule_parallel_fetch *spf = data;
 
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
-		struct strbuf submodule_path = STRBUF_INIT;
-		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
 		const char *git_dir, *default_argv;
@@ -1274,16 +1299,12 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		strbuf_repo_worktree_path(&submodule_path, spf->r, "%s", ce->name);
-		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
-		git_dir = read_gitfile(submodule_git_dir.buf);
-		if (!git_dir)
-			git_dir = submodule_git_dir.buf;
-		if (is_directory(git_dir)) {
+		git_dir = get_submodule_git_dir(spf->r, ce->name);
+		if (git_dir) {
 			child_process_init(cp);
-			cp->dir = strbuf_detach(&submodule_path, NULL);
-			prepare_submodule_repo_env(&cp->env_array);
+			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+			cp->dir = git_dir;
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
@@ -1293,10 +1314,10 @@ static int get_next_submodule(struct child_process *cp,
 			argv_array_push(&cp->args, default_argv);
 			argv_array_push(&cp->args, "--submodule-prefix");
 			argv_array_push(&cp->args, submodule_prefix.buf);
+
+			free(git_dir);
 			ret = 1;
 		}
-		strbuf_release(&submodule_path);
-		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
 		if (ret) {
 			spf->count++;
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 6c2f9b2ba26..42692219a1a 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -566,7 +566,12 @@ test_expect_success 'fetching submodule into a broken repository' '
 
 	test_must_fail git -C dst status &&
 	test_must_fail git -C dst diff &&
-	test_must_fail git -C dst fetch --recurse-submodules
+
+	# git-fetch cannot find the git directory of the submodule,
+	# so it will do nothing, successfully, as it cannot distinguish between
+	# this broken submodule and a submodule that was just set active but
+	# not cloned yet
+	git -C dst fetch --recurse-submodules
 '
 
 test_expect_success "fetch new commits when submodule got renamed" '
-- 
2.19.0.397.gdd90340f6a-goog

