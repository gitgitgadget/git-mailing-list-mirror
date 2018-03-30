Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7839C1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeC3SfL (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:35:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:49068 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752447AbeC3SfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:35:11 -0400
Received: (qmail 24192 invoked by uid 109); 30 Mar 2018 18:35:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 18:35:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31108 invoked by uid 111); 30 Mar 2018 18:36:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 14:36:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 14:35:08 -0400
Date:   Fri, 30 Mar 2018 14:35:08 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 4/5] set_work_tree: use chdir_notify
Message-ID: <20180330183508.GD31135@sigill.intra.peff.net>
References: <20180330183425.GA30575@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180330183425.GA30575@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we change to the top of the working tree, we manually
re-adjust $GIT_DIR and call set_git_dir() again, in order to
update any relative git-dir we'd compute earlier.

Instead of the work-tree code having to know to call the
git-dir code, let's use the new chdir_notify interface.
There are two spots that need updating, with a few
subtleties in each:

  1. the set_git_dir() code needs to chdir_notify_register()
     so it can be told when to update its path.

     Technically we could push this down into repo_set_gitdir(),
     so that even repository structs besides the_repository
     could benefit from this. But that opens up a lot of
     complications:

      - we'd still need to touch set_git_dir(), because it
        does some other setup (like setting $GIT_DIR in the
        environment)

      - submodules using other repository structs get
        cleaned up, which means we'd need to remove them
        from the chdir_notify list

      - it's unlikely to fix any bugs, since we shouldn't
        generally chdir() in the middle of working on a
        submodule

  2. setup_work_tree now needs to call chdir_notify(), and
     can lose its manual set_git_dir() call.

     Note that at first glance it looks like this undoes the
     absolute-to-relative optimization added by 044bbbcb63
     (Make git_dir a path relative to work_tree in
     setup_work_tree(), 2008-06-19). But for the most part
     that optimization was just _undoing_ the
     relative-to-absolute conversion which the function was
     doing earlier (and which is now gone).

     It is true that if you already have an absolute git_dir
     that the setup_work_tree() function will no longer make
     it relative as a side effect. But:

       - we generally do have relative git-dir's due to the
         way the discovery code works

       - if we really care about making git-dir's relative
         when possible, then we should be relativizing them
         earlier (e.g., when we see an absolute $GIT_DIR we
         could turn it relative, whether we are going to
         chdir into a worktree or not). That would cover all
         cases, including ones that 044bbbcb63 did not.

Signed-off-by: Jeff King <peff@peff.net>
---
 environment.c | 23 ++++++++++++++++++++++-
 setup.c       |  9 +++------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/environment.c b/environment.c
index e01acf8b11..903a6c9df7 100644
--- a/environment.c
+++ b/environment.c
@@ -13,6 +13,7 @@
 #include "refs.h"
 #include "fmt-merge-msg.h"
 #include "commit.h"
+#include "chdir-notify.h"
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
@@ -296,7 +297,7 @@ char *get_graft_file(void)
 	return the_repository->graft_file;
 }
 
-void set_git_dir(const char *path)
+static void set_git_dir_1(const char *path)
 {
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
 		die("could not set GIT_DIR to '%s'", path);
@@ -304,6 +305,26 @@ void set_git_dir(const char *path)
 	setup_git_env();
 }
 
+static void update_relative_gitdir(const char *name,
+				   const char *old_cwd,
+				   const char *new_cwd,
+				   void *data)
+{
+	char *path = reparent_relative_path(old_cwd, new_cwd, get_git_dir());
+	trace_printf_key(&trace_setup_key,
+			 "setup: move $GIT_DIR to '%s'",
+			 path);
+	set_git_dir_1(path);
+	free(path);
+}
+
+void set_git_dir(const char *path)
+{
+	set_git_dir_1(path);
+	if (!is_absolute_path(path))
+		chdir_notify_register(NULL, update_relative_gitdir, NULL);
+}
+
 const char *get_log_output_encoding(void)
 {
 	return git_log_output_encoding ? git_log_output_encoding
diff --git a/setup.c b/setup.c
index 7287779642..9eb2e808e1 100644
--- a/setup.c
+++ b/setup.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "dir.h"
 #include "string-list.h"
+#include "chdir-notify.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
@@ -378,7 +379,7 @@ int is_inside_work_tree(void)
 
 void setup_work_tree(void)
 {
-	const char *work_tree, *git_dir;
+	const char *work_tree;
 	static int initialized = 0;
 
 	if (initialized)
@@ -388,10 +389,7 @@ void setup_work_tree(void)
 		die(_("unable to set up work tree using invalid config"));
 
 	work_tree = get_git_work_tree();
-	git_dir = get_git_dir();
-	if (!is_absolute_path(git_dir))
-		git_dir = real_path(get_git_dir());
-	if (!work_tree || chdir(work_tree))
+	if (!work_tree || chdir_notify(work_tree))
 		die(_("this operation must be run in a work tree"));
 
 	/*
@@ -401,7 +399,6 @@ void setup_work_tree(void)
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
 		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
 
-	set_git_dir(remove_leading_path(git_dir, work_tree));
 	initialized = 1;
 }
 
-- 
2.17.0.rc2.594.gdb94a0ce02

