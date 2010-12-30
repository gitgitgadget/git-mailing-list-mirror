From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH] Use a temporary index for interactive git-commit
Date: Thu, 30 Dec 2010 00:47:18 +0000
Message-ID: <1293670038-8606-1-git-send-email-conrad.irwin@gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 30 01:47:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY6g4-00078K-0S
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 01:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab0L3Arb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 19:47:31 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48728 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab0L3Ara (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 19:47:30 -0500
Received: by wyb28 with SMTP id 28so10590622wyb.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 16:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=vkjNSbR9riGkdU168+wVME6uLrIhgIUWTboDkXhJtjI=;
        b=u8p74NJHKHno3nTfWb3G6UhOd/xRPPmDnacwwRnR+DIrfblsIIk+c6P+igpk28XkVg
         fxDXp15YyEQRNZ+3JLkr1iDMxMMz/8TeDe4CJjASuNvogbsUSkdIq2YbA65bqequ1Rwc
         1d/9BN9vqkD5Fn/XS65cetFqZY8MjN9RbxlNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hDUbNCpTctWAWyufLmmOrnvZkaUmJU+qR0Pk2rsk6//DUNQo9MvlsN5m565jOzsXbV
         yUHbQDpjm6MPMfBCX0MF4b8w5Kbx6d6GqUXpdRDQvMl7fsjlTX1ZZEF8yewRKQC/hbzX
         VIdBXZe27ugM6tjAXsTqidias9i1jOwv656ys=
Received: by 10.216.17.3 with SMTP id i3mr11600124wei.80.1293670048408;
        Wed, 29 Dec 2010 16:47:28 -0800 (PST)
Received: from scarlatti.dunvegan.biz (host86-159-223-152.range86-159.btcentralplus.com [86.159.223.152])
        by mx.google.com with ESMTPS id 7sm7431582wet.0.2010.12.29.16.47.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 16:47:27 -0800 (PST)
Received: from conrad by scarlatti.dunvegan.biz with local (Exim 4.72)
	(envelope-from <conrad@scarlatti.dunvegan.biz>)
	id 1PY6ft-0002Fd-WA; Thu, 30 Dec 2010 00:47:26 +0000
X-Mailer: git-send-email 1.7.3.4.629.g17fdc.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164344>

Hitherto even an aborted git commit -p or git commit --interactive has
added the selected changes to the index.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---

Following up to my email and patch of a few days ago to add support for
git commit -p (http://marc.info/?l=git&m=129338900419850&w=2).

I'm not sure that adding parameters to functions willy-nilly is the best
way of doing this. Can anyone suggest a cleaner mechanism?

Conrad

 Documentation/git-commit.txt |    2 +-
 builtin/add.c                |   18 +++++++++++++-----
 builtin/checkout.c           |    2 +-
 builtin/commit.c             |   27 +++++++++++++++++++--------
 builtin/reset.c              |    2 +-
 commit.h                     |    4 ++--
 6 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 6e7ab5a..81156f0 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -43,7 +43,7 @@ The content to be added can be specified in several ways:
 5. by using the --interactive or --patch switches with the 'commit' command
    to decide one by one which files or hunks should be part of the commit,
    before finalizing the operation.  Currently, this is done by invoking
-   'git add --interactive' or 'git add --patch'.
+   'git add --interactive' or 'git add --patch' on a temporary index.
 
 The `--dry-run` option can be used to obtain a
 summary of what is included by any of the above for the next
diff --git a/builtin/add.c b/builtin/add.c
index 3d074b3..6941fd6 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -214,10 +214,17 @@ static const char **validate_pathspec(int argc, const char **argv, const char *p
 }
 
 int run_add_interactive(const char *revision, const char *patch_mode,
-			const char **pathspec)
+			const char **pathspec, const char *index_file)
 {
 	int status, ac, pc = 0;
 	const char **args;
+	char index[PATH_MAX];
+	const char *env[2] = { NULL };
+
+	if (index_file && *index_file) {
+		env[0] =  index;
+		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
+	}
 
 	if (pathspec)
 		while (pathspec[pc])
@@ -237,12 +244,13 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 	}
 	args[ac] = NULL;
 
-	status = run_command_v_opt(args, RUN_GIT_CMD);
+	status = run_command_v_opt_cd_env(args, RUN_GIT_CMD, NULL, env);
 	free(args);
 	return status;
 }
 
-int interactive_add(int argc, const char **argv, const char *prefix, int patch)
+int interactive_add(int argc, const char **argv, const char *prefix, int patch,
+			const char *index_file)
 {
 	const char **pathspec = NULL;
 
@@ -254,7 +262,7 @@ int interactive_add(int argc, const char **argv, const char *prefix, int patch)
 
 	return run_add_interactive(NULL,
 				   patch ? "--patch" : NULL,
-				   pathspec);
+				   pathspec, index_file);
 }
 
 static int edit_patch(int argc, const char **argv, const char *prefix)
@@ -378,7 +386,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
-		exit(interactive_add(argc - 1, argv + 1, prefix, patch_interactive));
+		exit(interactive_add(argc - 1, argv + 1, prefix, patch_interactive, NULL));
 
 	if (edit_interactive)
 		return(edit_patch(argc, argv, prefix));
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 757f9a0..7212e42 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -636,7 +636,7 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 static int interactive_checkout(const char *revision, const char **pathspec,
 				struct checkout_opts *opts)
 {
-	return run_add_interactive(revision, "--patch=checkout", pathspec);
+	return run_add_interactive(revision, "--patch=checkout", pathspec, NULL);
 }
 
 struct tracking_name_data {
diff --git a/builtin/commit.c b/builtin/commit.c
index f3cdf1d..599d9ff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -297,14 +297,6 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 
 	if (is_status)
 		refresh_flags |= REFRESH_UNMERGED;
-	if (interactive || patch_interactive) {
-		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
-			die("interactive add failed");
-		if (read_cache_preload(NULL) < 0)
-			die("index file corrupt");
-		commit_style = COMMIT_AS_IS;
-		return get_index_file();
-	}
 
 	if (*argv)
 		pathspec = get_pathspec(prefix, argv);
@@ -312,6 +304,25 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	if (read_cache_preload(pathspec) < 0)
 		die("index file corrupt");
 
+	if (interactive || patch_interactive) {
+		fd = hold_locked_index(&index_lock, 1);
+
+		refresh_cache_or_die(refresh_flags);
+
+		if (write_cache(fd, active_cache, active_nr) ||
+		    close_lock_file(&index_lock))
+			die("unable to write new_index file");
+
+		if (interactive_add(argc, argv, prefix, patch_interactive, index_lock.filename) != 0)
+			die("interactive add failed");
+
+		discard_cache();
+		read_cache_from(index_lock.filename);
+
+		commit_style = COMMIT_NORMAL;
+		return index_lock.filename;
+	}
+
 	/*
 	 * Non partial, non as-is commit.
 	 *
diff --git a/builtin/reset.c b/builtin/reset.c
index 5de2bce..67d604e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -184,7 +184,7 @@ static int interactive_reset(const char *revision, const char **argv,
 	if (*argv)
 		pathspec = get_pathspec(prefix, argv);
 
-	return run_add_interactive(revision, "--patch=reset", pathspec);
+	return run_add_interactive(revision, "--patch=reset", pathspec, NULL);
 }
 
 static int read_from_tree(const char *prefix, const char **argv,
diff --git a/commit.h b/commit.h
index 951c22e..1a47bd4 100644
--- a/commit.h
+++ b/commit.h
@@ -160,9 +160,9 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit **, int);
 
-extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
+extern int interactive_add(int argc, const char **argv, const char *prefix, int patch, const char *index_file);
 extern int run_add_interactive(const char *revision, const char *patch_mode,
-			       const char **pathspec);
+			       const char **pathspec, const char *index_file);
 
 static inline int single_parent(struct commit *commit)
 {
-- 
1.7.3.4.629.g17fdc.dirty
