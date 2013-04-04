From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/7] clone: introduce clone.submodulegitdir
Date: Fri,  5 Apr 2013 00:00:42 +0530
Message-ID: <1365100243-13676-7-git-send-email-artagnon@gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:30:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNovE-0007fT-Ff
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764553Ab3DDS33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:29:29 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37427 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764543Ab3DDS31 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:29:27 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1572045pbb.5
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9GfspP5avNn8OGdeMkDtCboWISOujhbkJB2j3/dihZI=;
        b=FzoKeNY0Z2kuLAyz56VF807VEG8FWTCgogzKlY/KmA/NxsgUl78LCY8W7zRKnPXY63
         i17N4KyqHMuWpPog7Y9IynzUx1nPAqqMJqB8HQ8o5RLIKDO7C8mYfX9APppRNRvKvX5Z
         EC7zFJMW0fiIYfcDvoXe3FUMxq8EVmFA0RdYaok3nNi9XQqoSBJpq0xqiVSW/AriLM67
         Aest4gw/RqBMgFS/mC1T8+NqCGXLPi/hTPFDYzXnsRWwjnCHWlvNC2e6YvYqy81q0kCN
         HX5PT1DJni4le0YI6xZNFpeyXWByaRJ8sSWE8Bf1xi5g69nctN8kSw7egormBl7X+0TA
         iKQw==
X-Received: by 10.68.180.227 with SMTP id dr3mr10181408pbc.56.1365100167154;
        Thu, 04 Apr 2013 11:29:27 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.36])
        by mx.google.com with ESMTPS id xl10sm12418525pac.15.2013.04.04.11.29.24
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:29:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.380.g0d4e79b
In-Reply-To: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220053>

This configuration variable comes into effect when 'git clone' is
invoked in an existing git repository.  Instead of cloning the
repository as-is, it relocates the gitdir of the repository to the
path specified by this variable.  Arguably, it does the right thing
when working with submodules.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/clone.c | 29 +++++++++++++++++++++++++++++
 environment.c   | 11 -----------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index e0aaf13..1b798e6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -43,6 +43,7 @@ static char *option_template, *option_depth;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
 static const char *real_git_dir;
+static const char *submodule_gitdir;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
 static int option_progress = -1;
@@ -658,11 +659,22 @@ static void write_refspec_config(const char* src_ref_prefix,
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
+	char dest_git_dir[PATH_MAX];
+	char cwd[PATH_MAX];
 	char *path, *dir;
 	int dest_exists;
 	const struct ref *refs, *remote_head;
@@ -676,6 +688,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const char *src_ref_prefix = "refs/heads/";
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
+	int nongit = 1;
 
 	struct refspec *refspec;
 	const char *fetch_pattern;
@@ -683,6 +696,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
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
 
@@ -736,6 +757,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die(_("destination path '%s' already exists and is not "
 			"an empty directory."), dir);
 
+	if (!nongit && submodule_gitdir) {
+		sprintf(dest_git_dir, "%s/%s.git", real_path(submodule_gitdir), dir);
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
 
-- 
1.8.2.380.g0d4e79b
