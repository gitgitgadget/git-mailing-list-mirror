Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DFDF1F428
	for <e@80x24.org>; Tue,  2 Jan 2018 21:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbeABVLm (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 16:11:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:51050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750745AbeABVLl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 16:11:41 -0500
Received: (qmail 11272 invoked by uid 109); 2 Jan 2018 21:11:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Jan 2018 21:11:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19474 invoked by uid 111); 2 Jan 2018 21:12:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 02 Jan 2018 16:12:11 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jan 2018 16:11:39 -0500
Date:   Tue, 2 Jan 2018 16:11:39 -0500
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Stephan Janssen <sjanssen@you-get.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 4/4] clone: do not clean up directories we didn't create
Message-ID: <20180102211139.GD22556@sigill.intra.peff.net>
References: <20180102210753.GA10430@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180102210753.GA10430@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time, git-clone would refuse to write into a
directory that it did not itself create. The cleanup
routines for a failed clone could therefore just remove the
git and worktree dirs completely.

In 55892d2398 (Allow cloning to an existing empty directory,
2009-01-11), we learned to write into an existing directory.
Which means that doing:

  mkdir foo
  git clone will-fail foo

ends up deleting foo. This isn't a huge catastrophe, since
by definition foo must be empty. But it's somewhat
confusing; we should leave the filesystem as we found it.

Because we know that the only directory we'll write into is
an empty one, we can handle this case by just passing the
KEEP_TOPLEVEL flag to our recursive delete (if we could
write into populated directories, we'd have to keep track of
what we wrote and what we did not, which would be much
harder).

Note that we need to handle the work-tree and git-dir
separately, though, as only one might exist (and the new
tests in t5600 cover all cases).

Reported-by: Stephan Janssen <sjanssen@you-get.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c               | 20 ++++++++++++----
 t/t5600-clone-fail-cleanup.sh | 56 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 04b0d7283f..284651797e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -473,7 +473,9 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 }
 
 static const char *junk_work_tree;
+static int junk_work_tree_flags;
 static const char *junk_git_dir;
+static int junk_git_dir_flags;
 static enum {
 	JUNK_LEAVE_NONE,
 	JUNK_LEAVE_REPO,
@@ -502,12 +504,12 @@ static void remove_junk(void)
 
 	if (junk_git_dir) {
 		strbuf_addstr(&sb, junk_git_dir);
-		remove_dir_recursively(&sb, 0);
+		remove_dir_recursively(&sb, junk_git_dir_flags);
 		strbuf_reset(&sb);
 	}
 	if (junk_work_tree) {
 		strbuf_addstr(&sb, junk_work_tree);
-		remove_dir_recursively(&sb, 0);
+		remove_dir_recursively(&sb, junk_work_tree_flags);
 	}
 	strbuf_release(&sb);
 }
@@ -972,14 +974,24 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (safe_create_leading_directories_const(work_tree) < 0)
 			die_errno(_("could not create leading directories of '%s'"),
 				  work_tree);
-		if (!dest_exists && mkdir(work_tree, 0777))
+		if (dest_exists)
+			junk_work_tree_flags |= REMOVE_DIR_KEEP_TOPLEVEL;
+		else if (mkdir(work_tree, 0777))
 			die_errno(_("could not create work tree dir '%s'"),
 				  work_tree);
 		junk_work_tree = work_tree;
 		set_git_work_tree(work_tree);
 	}
 
-	junk_git_dir = real_git_dir ? real_git_dir : git_dir;
+	if (real_git_dir) {
+		if (dir_exists(real_git_dir))
+			junk_git_dir_flags |= REMOVE_DIR_KEEP_TOPLEVEL;
+		junk_git_dir = real_git_dir;
+	} else {
+		if (dest_exists)
+			junk_git_dir_flags |= REMOVE_DIR_KEEP_TOPLEVEL;
+		junk_git_dir = git_dir;
+	}
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die(_("could not create leading directories of '%s'"), git_dir);
 
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index 7b2a8052f8..5cd94d5558 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -7,10 +7,21 @@ test_description='test git clone to cleanup after failure
 
 This test covers the fact that if git clone fails, it should remove
 the directory it created, to avoid the user having to manually
-remove the directory before attempting a clone again.'
+remove the directory before attempting a clone again.
+
+Unless the directory already exists, in which case we clean up only what we
+wrote.
+'
 
 . ./test-lib.sh
 
+corrupt_repo () {
+	test_when_finished "rmdir foo/.git/objects.bak" &&
+	mkdir foo/.git/objects.bak/ &&
+	test_when_finished "mv foo/.git/objects.bak/* foo/.git/objects/" &&
+	mv foo/.git/objects/* foo/.git/objects.bak/
+}
+
 test_expect_success 'clone of non-existent source should fail' '
 	test_must_fail git clone foo bar
 '
@@ -42,13 +53,48 @@ test_expect_success 'successful clone must leave the directory' '
 '
 
 test_expect_success 'failed clone --separate-git-dir should not leave any directories' '
-	test_when_finished "rmdir foo/.git/objects.bak" &&
-	mkdir foo/.git/objects.bak/ &&
-	test_when_finished "mv foo/.git/objects.bak/* foo/.git/objects/" &&
-	mv foo/.git/objects/* foo/.git/objects.bak/ &&
+	corrupt_repo &&
 	test_must_fail git clone --separate-git-dir gitdir foo worktree &&
 	test_path_is_missing gitdir &&
 	test_path_is_missing worktree
 '
 
+test_expect_success 'failed clone into empty leaves directory (vanilla)' '
+	mkdir -p empty &&
+	corrupt_repo &&
+	test_must_fail git clone foo empty &&
+	test_dir_is_empty empty
+'
+
+test_expect_success 'failed clone into empty leaves directory (bare)' '
+	mkdir -p empty &&
+	corrupt_repo &&
+	test_must_fail git clone --bare foo empty &&
+	test_dir_is_empty empty
+'
+
+test_expect_success 'failed clone into empty leaves directory (separate)' '
+	mkdir -p empty-git empty-wt &&
+	corrupt_repo &&
+	test_must_fail git clone --separate-git-dir empty-git foo empty-wt &&
+	test_dir_is_empty empty-git &&
+	test_dir_is_empty empty-wt
+'
+
+test_expect_success 'failed clone into empty leaves directory (separate, git)' '
+	mkdir -p empty-git &&
+	corrupt_repo &&
+	test_must_fail git clone --separate-git-dir empty-git foo no-wt &&
+	test_dir_is_empty empty-git &&
+	test_path_is_missing no-wt
+'
+
+test_expect_success 'failed clone into empty leaves directory (separate, git)' '
+	mkdir -p empty-wt &&
+	corrupt_repo &&
+	test_must_fail git clone --separate-git-dir no-git foo empty-wt &&
+	test_path_is_missing no-git &&
+	test_dir_is_empty empty-wt
+'
+
 test_done
-- 
2.16.0.rc0.384.gc477e89267
