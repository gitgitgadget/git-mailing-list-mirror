Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D6941FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 22:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbcLSWAW (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 17:00:22 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:35561 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbcLSWAV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 17:00:21 -0500
Received: by mail-io0-f173.google.com with SMTP id h30so164219703iod.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 14:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/P3AIHZw2TraXEt0m1N4rgKk42AW7tU+7UqFYaOLeyA=;
        b=vCNCw7YLFuv5JY4RGPGZvwlndzKtVICsiHreMPnsuAvpvToEwSMlgH9a3oWSIPt7u2
         FY5pay2qy0tZZJ+aiYypLOsHzCehbhdDlckIJ6V5EUd3WQ7GTK2AmD+PxQenjiFdOIqk
         aQPeoWkCTF+ORYtC7jO/6gMQFzOWDwGQXIW6RZw4N0K4MpK7Rym42Q0JuHcTf9f0YpIM
         AOKAiFrc0ARTEyutpf3syyaGTGgE5diFOwRPNz4srEcSzdd0mJ4n9MPCeYY4uexLE9K/
         4awFxOYbexSRZf37fJ/6R/u11CLD6Fk0dL3ywzRgTFQBOrR3yD1S8LNwiBYrpcO8yT+w
         srnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/P3AIHZw2TraXEt0m1N4rgKk42AW7tU+7UqFYaOLeyA=;
        b=ROdQbtw250zpDDaHF4httcXNjitcFbnRhChooeS+w3m808pFRhiOe4rciZCl/BT+/W
         5v0Cw0SmXX1di2V7oEEA28LGqYU3eMvqVeVemu5RbtJfEMdjJBGvqEa6QLUexRtUA+Dl
         lHErteYqrTLKQomYjuqhFdiP6EBLtJbr/C+VZFlDP/QXATEzrKv0mBtiiNZICLnb12PM
         JuQgOXbeOvtZzECL5kwHwO/RwBqxp4sF4pW3brg/Ls8JGZvn0bz0uNKFvm8PSmjY5ABt
         wnZCWJ3Py3jILeg6W/6FZw4E0w6CPAEDArHVb8vem6Bj0hLRCYxISjvuhHRpBsBeLAU9
         MnkQ==
X-Gm-Message-State: AIkVDXIuiz5yKYtkk0WN1W8AFKNVLZCUJYQI0sBUownEhLhX1lC1dnsLQ/Vi7Vth/fk3C8ci
X-Received: by 10.107.175.94 with SMTP id y91mr17427608ioe.86.1482184819612;
        Mon, 19 Dec 2016 14:00:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2c2e:3e21:f7c2:2ccc])
        by smtp.gmail.com with ESMTPSA id 123sm305536itm.16.2016.12.19.14.00.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 14:00:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com, bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] dir.c: add retry logic to relocate_gitdir
Date:   Mon, 19 Dec 2016 13:57:09 -0800
Message-Id: <20161219215709.24620-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
In-Reply-To: <20161219215709.24620-1-sbeller@google.com>
References: <20161219215709.24620-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Relocating a git directory consists of 3 steps:
1) Move the directory.
2) Update the gitlink file.
3) Set core.worktree correctly.

In an ideal world all three steps would be part of one transaction, such
that either all of them happen correctly or none of them.
However currently we just execute these three steps sequentially and die
in case of an error in any of these 3 steps.

Dying is ok in 1) as the transaction hasn't started and the state is
recoverable.

When dying in 2), this is a problem as the repo state is left in an
inconsistent state, e.g. the git link file of a submodule could be
empty and hence even the superproject appears to be broken as basic
commands such as git-status would die as there is it cannot tell the
state of the submodule.
So in that case try to undo 1) to be in a less sufferable state.

3) is less of an issue as experiments with submodules show. When
core.worktree is unset or set incorrectly, git-status still works
both in the superproject as well as the working tree of the submodule.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 dir.c       | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 dir.h       |  6 ++--
 submodule.c |  3 +-
 3 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/dir.c b/dir.c
index b2cb23fe88..e4e3f69869 100644
--- a/dir.c
+++ b/dir.c
@@ -2749,30 +2749,66 @@ void untracked_cache_add_to_index(struct index_state *istate,
 	untracked_cache_invalidate_path(istate, path);
 }
 
-static void point_gitlink_file_to(const char *work_tree, const char *git_dir)
+/*
+ * Just like write_file, we try hard to write the full content to the file.
+ * If there is suspicion the write did not work correctly, make sure the file
+ * is removed again.
+ * Return 0 if the write succeeded, -1 if the file was removed,
+ * -2 if the (partial) file is still there.
+ */
+static int write_file_or_remove(const char *path, const char *buf, size_t len)
+{
+	int retries = 3;
+	int fd = xopen(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (write_in_full(fd, buf, len) != len) {
+		warning_errno(_("could not write '%s'"), path);
+		goto err;
+	}
+	if (close(fd)) {
+		warning_errno(_("could not close '%s'"), path);
+		goto err;
+	}
+	return 0;
+err:
+	while (retries-- > 0) {
+		if (file_exists(path))
+			unlink_or_warn(path);
+		else
+			return -1;
+	}
+	return -2;
+}
+
+static int point_gitlink_file_to(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
+	struct strbuf content = STRBUF_INIT;
+	int ret;
 
 	strbuf_addf(&file_name, "%s/.git", work_tree);
-	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, work_tree, &rel_path));
+	strbuf_addf(&content, "gitdir: %s",
+		    relative_path(git_dir, work_tree, &rel_path));
+	ret = write_file_or_remove(file_name.buf, content.buf, content.len);
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
+	return ret;
 }
 
-static void set_core_work_tree_to_connect(const char *work_tree, const char *git_dir)
+static int set_core_work_tree_to_connect(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
+	int ret;
 
 	strbuf_addf(&file_name, "%s/config", git_dir);
-	git_config_set_in_file(file_name.buf, "core.worktree",
+	ret = git_config_set_in_file_gently(file_name.buf, "core.worktree",
 			       relative_path(work_tree, git_dir, &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
+	return ret;
 }
 
 /* Update gitfile and core.worktree setting to connect work tree and git dir */
@@ -2790,12 +2826,54 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
 
 /*
  * Migrate the git directory of the given path from old_git_dir to new_git_dir.
+ * Return 0 on success and -1 on a minor issue. Die in case the repository is
+ * fatally messed up.
  */
-void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_git_dir)
+int relocate_gitdir(const char *path, const char *old_git_dir, const char *new_git_dir)
 {
+	char *git_dir = xstrdup(real_path(new_git_dir));
+	char *work_tree = xstrdup(real_path(path));
+	int c;
+
 	if (rename(old_git_dir, new_git_dir) < 0)
-		die_errno(_("could not migrate git directory from '%s' to '%s'"),
+		die_errno(_("could not rename git directory from '%s' to '%s'"),
 			old_git_dir, new_git_dir);
 
-	connect_work_tree_and_git_dir(path, new_git_dir);
+	c = point_gitlink_file_to(work_tree, git_dir);
+	if (c < 0) {
+		warning(_("tried to move the git directory from '%s' to '%s'"),
+			old_git_dir, new_git_dir);
+		warning(_("problems with creating a .git file in '%s' to point to '%s'"),
+			work_tree, new_git_dir);
+		if (c == -1) {
+			warning(_("try to undo the move"));
+			if (rename(new_git_dir, old_git_dir) < 0)
+				die_errno(_("could not rename git directory from '%s' to '%s'"),
+					new_git_dir, old_git_dir);
+			return -1;
+		} else if (c == -2) {
+			warning(_("The .git file is still there, "
+				"where the undo operation would move the git "
+				"directory"));
+			die(_("failed to undo the git directory relocation"));
+		}
+	};
+
+	if (set_core_work_tree_to_connect(work_tree, git_dir) < 0) {
+		/*
+		 * At this point the git dir was moved and the gitlink file
+		 * was updated correctly, this leaves the repository in a
+		 * state that is not totally broken.  Setting the core.worktree
+		 * correctly would have been the last step to perform a
+		 * complete git directory relocation, but this is good enough
+		 * to not die.
+		 */
+		warning(_("could not set core.worktree in '%s' to point at '%s'"),
+			git_dir, work_tree);
+		return -1;
+	}
+
+	free(work_tree);
+	free(git_dir);
+	return 0;
 }
diff --git a/dir.h b/dir.h
index bf23a470af..86f1cf790f 100644
--- a/dir.h
+++ b/dir.h
@@ -336,7 +336,7 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
-extern void relocate_gitdir(const char *path,
-			    const char *old_git_dir,
-			    const char *new_git_dir);
+extern int relocate_gitdir(const char *path,
+			   const char *old_git_dir,
+			   const char *new_git_dir);
 #endif
diff --git a/submodule.c b/submodule.c
index 45ccfb7ab4..fa1f44bb5a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1277,7 +1277,8 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 		prefix ? prefix : "", path,
 		real_old_git_dir, real_new_git_dir);
 
-	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
+	if (relocate_gitdir(path, real_old_git_dir, real_new_git_dir))
+		die(_("could not relocate git directory of '%s'"), path);
 
 	free(old_git_dir);
 	free(real_old_git_dir);
-- 
2.11.0.rc2.53.gb7b3fba.dirty

