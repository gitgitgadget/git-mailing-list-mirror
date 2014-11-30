From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/34] nd/multiple-work-trees reroll
Date: Sun, 30 Nov 2014 15:24:25 +0700
Message-ID: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:25:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuzog-0006xq-9O
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbaK3IZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 03:25:07 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:46505 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbaK3IZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:25:05 -0500
Received: by mail-pd0-f170.google.com with SMTP id fp1so8939312pdb.15
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=vwIFo+UrNyDngVfq9oobIsP+FubD52RKMEKaC668x+E=;
        b=VtHQvaPVQZG+p/nPrgxK2vxKo9JSXl1ZcFJsethNe5nUZJbh/EyyUfM9p0kEGqLFC7
         o/p3VvxIatKH/nDHtT/4rQ1IDR/Ju1SJ9CUAfKz0usQSQjNlAfAF0JOpy+3UqqkKbEYy
         FtIG+s/3n99vBiABm4a6B1e70bSQjYkyZhmaEm8/Sr6XUoPUmvfmWqqQ0OHOFCfevVXB
         QAbGoe2V8xk1T0KZDnETEUz1WvnkuwC4Plweq0+jZ/tHeVqPMCoyyK28GuQ8guncCd2H
         KE98KWYhYCgsAXDLKkpWaDRBOu4tX/RER2n0+k70WC3NmgApTu+nRpV+Vmb4chVgTf7A
         sCRQ==
X-Received: by 10.70.133.72 with SMTP id pa8mr87474337pdb.59.1417335904572;
        Sun, 30 Nov 2014 00:25:04 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id hj2sm14228843pbc.69.2014.11.30.00.25.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:25:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:25:02 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260387>

This is rebased so the diff below (against the version on Junio's
repo) is only approximate. Changes include test fixes for Windows
port, $GIT_COMMON_DIR and $GIT_DIR/modules problems with submodules.
Patch 03/34 is rewritten to touch less in refs.c to reduce conflicts.
A lot of changes there are just revert.

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 2b30a92..7173b38 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -248,9 +248,7 @@ commondir::
 	incomplete without the repository pointed by "commondir".
 
 modules::
-	Contains the git-repositories of the submodules. This
-	directory is ignored if $GIT_COMMON_DIR is set and
-	"$GIT_COMMON_DIR/modules" will be used instead.
+	Contains the git-repositories of the submodules.
 
 worktrees::
 	Contains worktree specific information of linked
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 01d0f2f..e70e66c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -865,7 +865,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 
 	if (!new->commit)
 		die(_("no branch specified"));
-	if (file_exists(path))
+	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
 
 	len = strlen(path);
@@ -1207,7 +1207,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (new->path && !force_detach && !*new_branch) {
 		unsigned char sha1[20];
 		int flag;
-		char *head_ref = resolve_refdup("HEAD", sha1, 0, &flag);
+		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
 		if (head_ref &&
 		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
 			check_linked_checkouts(new);
diff --git a/environment.c b/environment.c
index d5b0788..8351007 100644
--- a/environment.c
+++ b/environment.c
@@ -101,6 +101,7 @@ const char * const local_repo_env[] = {
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
+	GIT_COMMON_DIR_ENVIRONMENT,
 	NULL
 };
 
diff --git a/path.c b/path.c
index 35d498e..a5c51a3 100644
--- a/path.c
+++ b/path.c
@@ -92,7 +92,7 @@ static void replace_dir(struct strbuf *buf, int len, const char *newdir)
 }
 
 static const char *common_list[] = {
-	"/branches", "/hooks", "/info", "!/logs", "/lost-found", "/modules",
+	"/branches", "/hooks", "/info", "!/logs", "/lost-found",
 	"/objects", "/refs", "/remotes", "/worktrees", "/rr-cache", "/svn",
 	"config", "!gc.pid", "packed-refs", "shallow",
 	NULL
diff --git a/refs.c b/refs.c
index 3cefbd3..f7e48b0 100644
--- a/refs.c
+++ b/refs.c
@@ -1398,14 +1398,16 @@ static const char *handle_missing_loose_ref(const char *refname,
 }
 
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
+static const char *resolve_ref_unsafe_1(const char *refname,
+					unsigned char *sha1,
+					int reading,
+					int *flags,
+					struct strbuf *sb_path)
 {
-	struct strbuf sb_path = STRBUF_INIT;
 	int depth = MAXDEPTH;
 	ssize_t len;
 	char buffer[256];
 	static char refname_buffer[256];
-	const char *ret;
 
 	if (flag)
 		*flag = 0;
@@ -1423,12 +1425,12 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 
 		if (--depth < 0) {
 			errno = ELOOP;
-			goto fail;
+			return NULL;
 		}
 
-		strbuf_reset(&sb_path);
-		strbuf_git_path(&sb_path, "%s", refname);
-		path = sb_path.buf;
+		strbuf_reset(sb_path);
+		strbuf_git_path(sb_path, "%s", refname);
+		path = sb_path->buf;
 
 		/*
 		 * We might have to loop back here to avoid a race
@@ -1442,11 +1444,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 	stat_ref:
 		if (lstat(path, &st) < 0) {
 			if (errno == ENOENT)
-				ret = handle_missing_loose_ref(refname, sha1,
-							       reading, flag);
+				return handle_missing_loose_ref(refname, sha1,
+								reading, flag);
 			else
-				ret = NULL;
-			goto done;
+				return NULL;
 		}
 
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
@@ -1457,7 +1458,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 					/* inconsistent with lstat; retry */
 					goto stat_ref;
 				else
-					goto fail;
+					return NULL;
 			}
 			buffer[len] = 0;
 			if (starts_with(buffer, "refs/") &&
@@ -1473,7 +1474,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		/* Is it a directory? */
 		if (S_ISDIR(st.st_mode)) {
 			errno = EISDIR;
-			goto fail;
+			return NULL;
 		}
 
 		/*
@@ -1486,15 +1487,14 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 				/* inconsistent with lstat; retry */
 				goto stat_ref;
 			else
-				goto fail;
+				return NULL;
 		}
-
 		len = read_in_full(fd, buffer, sizeof(buffer)-1);
 		if (len < 0) {
 			int save_errno = errno;
 			close(fd);
 			errno = save_errno;
-			goto fail;
+			return NULL;
 		}
 		close(fd);
 		while (len && isspace(buffer[len-1]))
@@ -1514,10 +1514,9 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 				if (flag)
 					*flag |= REF_ISBROKEN;
 				errno = EINVAL;
-				goto fail;
+				return NULL;
 			}
-			ret = refname;
-			goto done;
+			return refname;
 		}
 		if (flag)
 			*flag |= REF_ISSYMREF;
@@ -1528,13 +1527,17 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 			if (flag)
 				*flag |= REF_ISBROKEN;
 			errno = EINVAL;
-			goto fail;
+			return NULL;
 		}
 		refname = strcpy(refname_buffer, buf);
 	}
-fail:
-	ret = NULL;
-done:
+}
+
+const char *resolve_ref_unsafe(const char *refname, int reading,
+			       unsigned char *sha1, int *flags)
+{
+	struct strbuf sb_path = STRBUF_INIT;
+	const char *ret = resolve_ref_unsafe_1(refname, reading,, sha1, flags, &sb_path);
 	strbuf_release(&sb_path);
 	return ret;
 }
@@ -2844,62 +2847,66 @@ static int copy_msg(char *buf, const char *msg)
 }
 
 /* This function must set a meaningful errno on failure */
-int log_ref_setup(const char *refname, struct strbuf *logfile)
+int log_ref_setup(const char *refname, struct strbuf *sb_logfile)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
+	char *logfile;
 
-	strbuf_git_path(logfile, "logs/%s", refname);
+	strbuf_git_path(sb_logfile, "logs/%s", refname);
+	logfile = sb_logfile->buf;
+	/* make sure the rest of the function can't change "logfile" */
+	sb_logfile = NULL;
 	if (log_all_ref_updates &&
 	    (starts_with(refname, "refs/heads/") ||
 	     starts_with(refname, "refs/remotes/") ||
 	     starts_with(refname, "refs/notes/") ||
 	     !strcmp(refname, "HEAD"))) {
-		if (safe_create_leading_directories(logfile->buf) < 0) {
+		if (safe_create_leading_directories(logfile) < 0) {
 			int save_errno = errno;
-			error("unable to create directory for %s", logfile->buf);
+			error("unable to create directory for %s", logfile);
 			errno = save_errno;
 			return -1;
 		}
 		oflags |= O_CREAT;
 	}
 
-	logfd = open(logfile->buf, oflags, 0666);
+	logfd = open(logfile, oflags, 0666);
 	if (logfd < 0) {
 		if (!(oflags & O_CREAT) && errno == ENOENT)
 			return 0;
 
 		if ((oflags & O_CREAT) && errno == EISDIR) {
-			if (remove_empty_directories(logfile->buf)) {
+			if (remove_empty_directories(logfile)) {
 				int save_errno = errno;
 				error("There are still logs under '%s'",
-				      logfile->buf);
+				      logfile);
 				errno = save_errno;
 				return -1;
 			}
-			logfd = open(logfile->buf, oflags, 0666);
+			logfd = open(logfile, oflags, 0666);
 		}
 
 		if (logfd < 0) {
 			int save_errno = errno;
-			error("Unable to append to %s: %s", logfile->buf,
+			error("Unable to append to %s: %s", logfile,
 			      strerror(errno));
 			errno = save_errno;
 			return -1;
 		}
 	}
 
-	adjust_shared_perm(logfile->buf);
+	adjust_shared_perm(logfile);
 	close(logfd);
 	return 0;
 }
 
-static int log_ref_write(const char *refname, const unsigned char *old_sha1,
-			 const unsigned char *new_sha1, const char *msg)
+static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
+			   const unsigned char *new_sha1, const char *msg,
+			   struct strbuf *sb_log_file)
 {
 	int logfd, result, written, oflags = O_APPEND | O_WRONLY;
 	unsigned maxlen, len;
 	int msglen;
-	struct strbuf sb_log_file = STRBUF_INIT;
 	const char *log_file;
 	char *logrec;
 	const char *committer;
@@ -2907,14 +2914,16 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, &sb_log_file);
+	result = log_ref_setup(refname, sb_log_file);
 	if (result)
-		goto done;
-	log_file = sb_log_file.buf;
+		return result;
+	log_file = sb_log_file->buf;
+	/* make sure the rest of the function can't change "log_file" */
+	sb_log_file = NULL;
 
 	logfd = open(log_file, oflags);
 	if (logfd < 0)
-		goto done;
+		return 0;
 	msglen = msg ? strlen(msg) : 0;
 	committer = git_committer_info(0);
 	maxlen = strlen(committer) + msglen + 100;
@@ -2932,19 +2941,24 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 		close(logfd);
 		error("Unable to append to %s", log_file);
 		errno = save_errno;
-		result = -1;
-		goto done;
+		return -1;
 	}
 	if (close(logfd)) {
 		int save_errno = errno;
 		error("Unable to append to %s", log_file);
 		errno = save_errno;
-		result = -1;
-		goto done;
+		return -1;
 	}
-done:
-	strbuf_release(&sb_log_file);
-	return result;
+	return 0;
+}
+
+static int log_ref_write(const char *refname, const unsigned char *old_sha1,
+			 const unsigned char *new_sha1, const char *msg)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb);
+	strbuf_release(&sb);
+	return ret;
 }
 
 int is_branch(const char *refname)
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index e6ac7a4..4df7a2f 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -366,7 +366,7 @@ test_expect_success 'GIT_DIR set (1)' '
 
 test_expect_success 'GIT_DIR set (2)' '
 	echo "gitdir: repo.git/repos/foo" >gitfile &&
-	echo "$TRASH_DIRECTORY/repo.git" >repo.git/repos/foo/commondir &&
+	echo "$(pwd)/repo.git" >repo.git/repos/foo/commondir &&
 	(
 		cd work &&
 		GIT_DIR=../gitfile git rev-parse --git-common-dir >actual &&
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index eddd325..915b506 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -13,10 +13,15 @@ test_expect_success 'checkout --to not updating paths' '
 '
 
 test_expect_success 'checkout --to an existing worktree' '
-	mkdir existing &&
+	mkdir -p existing/subtree &&
 	test_must_fail git checkout --detach --to existing master
 '
 
+test_expect_success 'checkout --to an existing empty worktree' '
+	mkdir existing_empty &&
+	git checkout --detach --to existing_empty master
+'
+
 test_expect_success 'checkout --to refuses to checkout locked branch' '
 	test_must_fail git checkout --to zere master &&
 	! test -d zere &&
diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-checkouts.sh
index 3622800..170aefe 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -57,7 +57,7 @@ test_expect_success 'prune directories with invalid gitdir' '
 test_expect_success 'prune directories with gitdir pointing to nowhere' '
 	mkdir -p .git/worktrees/def/abc &&
 	: >.git/worktrees/def/def &&
-	echo "$TRASH_DIRECTORY"/nowhere >.git/worktrees/def/gitdir &&
+	echo "$(pwd)"/nowhere >.git/worktrees/def/gitdir &&
 	git prune --worktrees --verbose >actual &&
 	test_i18ngrep "Removing worktrees/def: gitdir file points to non-existent location" actual &&
 	! test -d .git/worktrees/def &&
@@ -76,7 +76,7 @@ test_expect_success 'not prune recent checkouts' '
 	test_when_finished rm -r .git/worktrees
 	mkdir zz &&
 	mkdir -p .git/worktrees/jlm &&
-	echo "$TRASH_DIRECTORY"/zz >.git/worktrees/jlm/gitdir &&
+	echo "$(pwd)"/zz >.git/worktrees/jlm/gitdir &&
 	git prune --worktrees --verbose --expire=2.days.ago &&
 	test -d .git/worktrees/jlm
 '
diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
new file mode 100755
index 0000000..8f30aed
--- /dev/null
+++ b/t/t7410-submodule-checkout-to.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='Combination of submodules and multiple workdirs'
+
+. ./test-lib.sh
+
+base_path=$(pwd -P)
+
+test_expect_success 'setup: make origin' \
+    'mkdir -p origin/sub && ( cd origin/sub && git init &&
+	echo file1 >file1 &&
+	git add file1 &&
+	git commit -m file1 ) &&
+    mkdir -p origin/main && ( cd origin/main && git init &&
+	git submodule add ../sub &&
+	git commit -m "add sub" ) &&
+    ( cd origin/sub &&
+	echo file1updated >file1 &&
+	git add file1 &&
+	git commit -m "file1 updated" ) &&
+    ( cd origin/main/sub && git pull ) &&
+    ( cd origin/main &&
+	git add sub &&
+	git commit -m "sub updated" )'
+
+test_expect_success 'setup: clone' \
+    'mkdir clone && ( cd clone &&
+	git clone --recursive "$base_path/origin/main")'
+
+rev1_hash_main=$(git --git-dir=origin/main/.git show --pretty=format:%h -q "HEAD~1")
+rev1_hash_sub=$(git --git-dir=origin/sub/.git show --pretty=format:%h -q "HEAD~1")
+
+test_expect_success 'checkout main' \
+    'mkdir default_checkout &&
+    (cd clone/main &&
+	git checkout --to "$base_path/default_checkout/main" "$rev1_hash_main")'
+
+test_expect_failure 'can see submodule diffs just after checkout' \
+    '(cd default_checkout/main && git diff --submodule master"^!" | grep "file1 updated")'
+
+test_expect_success 'checkout main and initialize independed clones' \
+    'mkdir fully_cloned_submodule &&
+    (cd clone/main &&
+	git checkout --to "$base_path/fully_cloned_submodule/main" "$rev1_hash_main") &&
+    (cd fully_cloned_submodule/main && git submodule update)'
+
+test_expect_success 'can see submodule diffs after independed cloning' \
+    '(cd fully_cloned_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
+
+test_done
