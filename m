From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Sun, 14 Apr 2013 00:53:27 +0530
Message-ID: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 13 21:24:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR63R-0006YV-0C
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 21:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606Ab3DMTXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 15:23:51 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:61977 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab3DMTXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 15:23:49 -0400
Received: by mail-pd0-f175.google.com with SMTP id g10so1900990pdj.6
        for <git@vger.kernel.org>; Sat, 13 Apr 2013 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=+uvaI6HE8mOAPmBo85oEWTCy5sz+oXK4N9W3Acs0FOc=;
        b=QYeLMiLlq38P+puGf2/YMGQaJDXM8Ocofh9jLOIo3xA6ZK4fnNNsQSj/5XfBejDjjY
         VUPQv3yhAlmz4xb29QdYhixn0GMtwMd91HjH6zE5sMdwmD8QR5CSTXVm/gymPx5HqhHF
         MHCsZZ2wh9oGWlHXKL+ye7M3grL27B4bIOIZmu8IKWw/TPmq1O1NUSXQ6w9Xyfy3Pakj
         MX2NRIS276AWKdVuX6vDGoCzn+LOtezRMrIaBZNIPjJ6tVVbwpA7hdGwEa5Sp75yIs46
         7/BdLGf/ebO1Rkuvode/kcrppKCIxnDaz7FqxSp746qofAWSf4qeGUezPX16h5la3gH8
         fLbw==
X-Received: by 10.68.170.66 with SMTP id ak2mr20992276pbc.123.1365881029300;
        Sat, 13 Apr 2013 12:23:49 -0700 (PDT)
Received: from localhost.localdomain ([122.164.25.24])
        by mx.google.com with ESMTPS id ts3sm13592614pbc.12.2013.04.13.12.23.45
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 13 Apr 2013 12:23:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.389.gcaa7d79.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221066>

This configuration variable comes into effect when 'git clone' is
invoked inside an existing git repository's worktree.  When set,
instead of cloning the given repository as-is, it relocates the gitdir
of the repository to the path specified by this variable.  This
setting is especially useful when working with submodules.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Okay, so this is part of my evil plan to make 'git add' DTRT wrt
 submodules, and deprecate 'git submodule add' (I have some code
 written down, but this is a prerequisite: I don't like the
 .git/modules nonsense).

 Unfortunately, this patch is in pathetic shape and is an RFC for
 three reasons:

 1. I've used setup_git_directory_gently() at the start of
    builtin/clone.c to check if I'm inside a git directory.  This
    breaks a lot of existing tests (I'm yet to understand these
    failures fully).

 2. setup_git_directory_gently() has the side-effect of changing the
    current directory and calling set_git_work_tree(), both of which
    must be done away with if we want the rest of clone.c to work.
    I've hacked around the issue in a very dirty manner.  What is the
    solution to this?

  3. I don't know how to test the case "clone.submoduleGitDir has no
     effect outside a git repository", because our entire test
     environment is a git repository.  Even if I remove the .git
     directory, we're still inside the soure tree's git repository.
     What do I do about this?  Even if we decide that this patch is
     fundamentally unworkable, we should try to fix this issue so that
     we can verify that a plain 'git clone' works outside a git
     repository.

  Thanks for reading.  And I'm truly sorry for making you read through
  such ugly code.

 Documentation/config.txt | 11 +++++++++++
 builtin/clone.c          | 33 ++++++++++++++++++++++++++++++++-
 environment.c            | 11 -----------
 t/t5702-clone-options.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3d750e0..aac26c3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -798,6 +798,17 @@ clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f
 	or -n.   Defaults to true.
 
+clone.submoduleGitDir::
+	An absolute path on the filesystem where gitdirs of submodules
+	should be stored away safely.  When not set, a 'git clone'
+	executed inside a git repository will do exactly what it does
+	outside a git repository.  When set, a 'git clone' executed
+	inside a git repository will create the worktree in place of
+	the full repository, and put the object store in a
+	subdirectory of clone.submoduleGitDir, choosing the name to be
+	the "humanish" part of the source repository (`repo.git` for
+	`/path/to/repo.git` and `foo.git` for `host.xz:foo/.git`).
+
 color.branch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-branch[1]. May be set to `always`,
diff --git a/builtin/clone.c b/builtin/clone.c
index f9c380e..4a845a4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -44,6 +44,7 @@ static char *option_template, *option_depth;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
 static const char *real_git_dir;
+static const char *submodule_gitdir;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
 static int option_progress = -1;
@@ -707,12 +708,22 @@ static void write_refspec_config(const char* src_ref_prefix,
 	strbuf_release(&value);
 }
 
+static int git_clone_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "clone.submodulegitdir")) {
+		git_config_string(&submodule_gitdir, var, value);
+		return 0;
+	}
+	return git_default_config(var, value, cb);
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
 	struct stat buf;
 	const char *repo_name, *repo, *work_tree, *git_dir;
-	char *path, *dir;
+	char *path, *dir, *dest_git_dir;
+	char cwd[PATH_MAX];
 	int dest_exists;
 	const struct ref *refs, *remote_head;
 	const struct ref *remote_head_points_at;
@@ -725,6 +736,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const char *src_ref_prefix = "refs/heads/";
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
+	int nongit = 1;
 
 	struct refspec *refspec;
 	const char *fetch_pattern;
@@ -732,6 +744,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_pid = getpid();
 
 	packet_trace_identity("clone");
+
+	/* setup_git_directory_gently without changing directories */
+	getcwd(cwd, sizeof(cwd) - 1);
+	setup_git_directory_gently(&nongit);
+	chdir(cwd);
+
+	git_config(git_clone_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
@@ -785,6 +805,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die(_("destination path '%s' already exists and is not "
 			"an empty directory."), dir);
 
+	if (!nongit && submodule_gitdir) {
+		char  *user_path = expand_user_path(submodule_gitdir);
+		if (!user_path)
+			die(_("Unable to expand path in clone.submoduleGitDir: %s"), submodule_gitdir);
+		dest_git_dir = mkpathdup("%s/%s.git", user_path, dir);
+		if (!stat(dest_git_dir, &buf) && !is_empty_dir(dest_git_dir))
+			die(_("destination path '%s' already exists and is not "
+					"an empty directory."), dest_git_dir);
+		real_git_dir = dest_git_dir;
+	}
+
 	strbuf_addf(&reflog_msg, "clone: from %s", repo);
 
 	if (option_bare)
diff --git a/environment.c b/environment.c
index e2e75c1..9dce4c7 100644
--- a/environment.c
+++ b/environment.c
@@ -182,8 +182,6 @@ const char *strip_namespace(const char *namespaced_ref)
 	return namespaced_ref + namespace_len;
 }
 
-static int git_work_tree_initialized;
-
 /*
  * Note.  This works only before you used a work tree.  This was added
  * primarily to support git-clone to work in a new repository it just
@@ -191,15 +189,6 @@ static int git_work_tree_initialized;
  */
 void set_git_work_tree(const char *new_work_tree)
 {
-	if (git_work_tree_initialized) {
-		new_work_tree = real_path(new_work_tree);
-		if (strcmp(new_work_tree, work_tree))
-			die("internal error: work tree has already been set\n"
-			    "Current worktree: %s\nNew worktree: %s",
-			    work_tree, new_work_tree);
-		return;
-	}
-	git_work_tree_initialized = 1;
 	work_tree = xstrdup(real_path(new_work_tree));
 }
 
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index 02cb024..9b845d8 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -33,4 +33,45 @@ test_expect_success 'redirected clone -v' '
 
 '
 
+test_expect_success 'clone.submoduleGitDir takes effect in a git repository' '
+	cd ~ &&
+	rm -rf bare newrepo superproject &&
+	mkdir bare &&
+	bare_path="$(pwd)/bare" &&
+	git init newrepo &&
+	(
+		cd newrepo &&
+		echo quux >foo &&
+		git add foo &&
+		git commit -m "Add foo"
+	) &&
+	git init superproject &&
+	cd superproject &&
+	test_config clone.submoduleGitDir "$bare_path" &&
+	git clone ../newrepo &&
+	test_path_is_file newrepo/.git &&
+	cd ../bare/newrepo.git &&
+	git rev-parse --is-bare-repository
+'
+
+test_expect_success 'clone.submoduleGitDir path get tilde-expansion' '
+	cd ~ &&
+	rm -rf bare newrepo superproject &&
+	mkdir bare &&
+	git init newrepo &&
+	(
+		cd newrepo &&
+		echo quux >foo &&
+		git add foo &&
+		git commit -m "Add foo"
+	) &&
+	git init superproject &&
+	cd superproject &&
+	test_config clone.submoduleGitDir ~/bare &&
+	git clone ../newrepo &&
+	test_path_is_file newrepo/.git &&
+	cd ../bare/newrepo.git &&
+	git rev-parse --is-bare-repository
+'
+
 test_done
-- 
1.8.2.1.389.gcaa7d79.dirty
