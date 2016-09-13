Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F082207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754922AbcIMDYT (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:24:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:42329 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754778AbcIMDYS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:24:18 -0400
Received: (qmail 20408 invoked by uid 109); 13 Sep 2016 03:24:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:24:18 +0000
Received: (qmail 18633 invoked by uid 111); 13 Sep 2016 03:24:28 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:24:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:24:15 -0700
Date:   Mon, 12 Sep 2016 20:24:15 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 14/16] config: only read .git/config from configured repos
Message-ID: <20160913032414.dpurefnzkvtjulld@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git_config() runs, it looks in the system, user-wide,
and repo-level config files. It gets the latter by calling
git_pathdup(), which in turn calls get_git_dir(). If we
haven't set up the git repository yet, this may simply
return ".git", and we will look at ".git/config".  This
seems like it would be helpful (presumably we haven't set up
the repository yet, so it tries to find it), but it turns
out to be a bad idea for a few reasons:

  - it's not sufficient, and therefore hides bugs in a
    confusing way. Config will be respected if commands are
    run from the top-level of the working tree, but not from
    a subdirectory.

  - it's not always true that we haven't set up the
    repository _yet_; we may not want to do it at all. For
    instance, if you run "git init /some/path" from inside
    another repository, it should not load config from the
    existing repository.

  - there might be a path ".git/config", but it is not the
    actual repository we would find via setup_git_directory().
    This may happen, e.g., if you are storing a git
    repository inside another git repository, but have
    munged one of the files in such a way that the
    inner repository is not valid (e.g., by removing HEAD).

We have at least two bugs of the second type in git-init,
introduced by ae5f677 (lazily load core.sharedrepository,
2016-03-11). It causes init to use git_configset(), which
loads all of the config, including values from the current
repo (if any).  This shows up in two ways:

  1. If we happen to be in an existing repository directory,
     we'll read and respect core.sharedrepository from it,
     even though it should have no bearing on the new
     repository. A new test in t1301 covers this.

  2. Similarly, if we're in an existing repo that sets
     core.logallrefupdates, that will cause init to fail to
     set it in a newly created repository (because it thinks
     that the user's templates already did so). A new test
     in t0001 covers this.

We also need to adjust an existing test in t1302, which
gives another example of why this patch is an improvement.

That test creates an embedded repository with a bogus
core.repositoryformatversion of "99". It wants to make sure
that we actually stop at the bogus repo rather than
continuing upward to find the outer repo. So it checks that
"git config core.repositoryformatversion" returns 99. But
that only works because we blindly read ".git/config", even
though we _know_ we're in a repository whose vintage we do
not understand.

After this patch, we avoid reading config from the unknown
vintage repository at all, which is a safer choice.  But we
need to tweak the test, since core.repositoryformatversion
will not return 99; it will claim that it could not find the
variable at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h                 | 6 ++++++
 config.c                | 2 +-
 environment.c           | 7 +++++++
 t/t0001-init.sh         | 9 +++++++++
 t/t1301-shared-repo.sh  | 9 +++++++++
 t/t1302-repo-version.sh | 4 +---
 6 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 4f23952..e9592d3 100644
--- a/cache.h
+++ b/cache.h
@@ -453,6 +453,12 @@ static inline enum object_type object_type(unsigned int mode)
  */
 extern const char * const local_repo_env[];
 
+/*
+ * Returns true iff we have a configured git repository (either via
+ * setup_git_directory, or in the environment via $GIT_DIR).
+ */
+int have_git_dir(void);
+
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
diff --git a/config.c b/config.c
index 8b28447..1e4b617 100644
--- a/config.c
+++ b/config.c
@@ -1286,7 +1286,7 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
 	int ret = 0;
 	char *xdg_config = xdg_config_home("config");
 	char *user_config = expand_user_path("~/.gitconfig");
-	char *repo_config = git_pathdup("config");
+	char *repo_config = have_git_dir() ? git_pathdup("config") : NULL;
 
 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
diff --git a/environment.c b/environment.c
index c266428..c0cce6b 100644
--- a/environment.c
+++ b/environment.c
@@ -195,6 +195,13 @@ int is_bare_repository(void)
 	return is_bare_repository_cfg && !get_git_work_tree();
 }
 
+int have_git_dir(void)
+{
+	return startup_info->have_repository
+		|| git_dir
+		|| getenv(GIT_DIR_ENVIRONMENT);
+}
+
 const char *get_git_dir(void)
 {
 	if (!git_dir)
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index a6fdd5e..8ffbbea 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -384,4 +384,13 @@ test_expect_success MINGW 'bare git dir not hidden' '
 	! is_hidden newdir
 '
 
+test_expect_success 'remote init from does not use config from cwd' '
+	rm -rf newdir &&
+	test_config core.logallrefupdates true &&
+	git init newdir &&
+	echo true >expect &&
+	git -C newdir config --bool core.logallrefupdates >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index ac10875..7c28642 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -172,4 +172,13 @@ test_expect_success POSIXPERM 'forced modes' '
 	}" actual)"
 '
 
+test_expect_success POSIXPERM 'remote init does not use config from cwd' '
+	git config core.sharedrepository 0666 &&
+	umask 0022 &&
+	git init --bare child.git &&
+	echo "-rw-r--r--" >expect &&
+	modebits child.git/config >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index f859809..ce4cff1 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -32,9 +32,7 @@ test_expect_success 'gitdir selection on normal repos' '
 
 test_expect_success 'gitdir selection on unsupported repo' '
 	# Make sure it would stop at test2, not trash
-	echo 99 >expect &&
-	git -C test2 config core.repositoryformatversion >actual &&
-	test_cmp expect actual
+	test_expect_code 1 git -C test2 config core.repositoryformatversion >actual
 '
 
 test_expect_success 'gitdir not required mode' '
-- 
2.10.0.230.g6f8d04b

