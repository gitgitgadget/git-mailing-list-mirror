X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Lars Hjemli <hjemli@gmail.com>
Subject: [RFC] git-branch: add options and tests for branch renaming
Date: Tue, 28 Nov 2006 15:47:40 +0100
Message-ID: <11647252603530-git-send-email-hjemli@gmail.com>
NNTP-Posting-Date: Tue, 28 Nov 2006 14:57:50 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.gf0df
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32529>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp4P1-0007Zi-EN for gcvg-git@gmane.org; Tue, 28 Nov
 2006 15:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935091AbWK1O52 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 09:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758681AbWK1O52
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 09:57:28 -0500
Received: from mail45.e.nsc.no ([193.213.115.45]:8330 "EHLO mail45.e.nsc.no")
 by vger.kernel.org with ESMTP id S1757379AbWK1O51 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 09:57:27 -0500
Received: from localhost.localdomain (ti231210a080-2784.bb.online.no
 [80.213.122.226]) by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id
 kASEvJUT009140; Tue, 28 Nov 2006 15:57:20 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Extend git-branch with the following options:

  git-branch -m|-M [<oldbranch>] newbranch

The -M variation is required to force renaming over an exsisting
branchname.

This also indroduces $GIT_DIR/RENAME_REF which is a "metabranch"
used when renaming branches. It will always hold the original sha1
for the latest renamed branch.

Additionally, if $GIT_DIR/logs/RENAME_REF exists, all branch rename
events are logged there.

Finally, some testcases are added to verify the new options.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-branch.txt |   23 +++++-
 builtin-branch.c             |   49 ++++++++++++-
 refs.c                       |  169 ++++++++++++++++++++++++++++++++++++------
 refs.h                       |    3 +
 t/t3200-branch.sh            |   34 +++++++++
 5 files changed, 251 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 4f5b5d5..71417fe 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,8 +8,9 @@ git-branch - List, create, or delete branches.
 SYNOPSIS
 --------
 [verse]
-'git-branch' [-r] [-a] [-v] [--abbrev=<length>]
+'git-branch' [-r | -a] [-v [--abbrev=<length>]]
 'git-branch' [-l] [-f] <branchname> [<start-point>]
+'git-branch' (-m | -M) [<oldbranch>] <newbranch>
 'git-branch' (-d | -D) <branchname>...
 
 DESCRIPTION
@@ -24,6 +25,12 @@ It will start out with a head equal to the one given as <start-point>.
 If no <start-point> is given, the branch will be created with a head
 equal to that of the currently checked out branch.
 
+With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
+If <oldbranch> had a corresponding reflog, it is renamed to match
+<newbranch>, and a reflog entry is created to remember the branch
+renaming. If <newbranch> exists, -M must be used to force the rename
+to happen.
+
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
 has a ref log then the ref log will also be deleted.
@@ -46,6 +53,12 @@ OPTIONS
 	Force the creation of a new branch even if it means deleting
 	a branch that already exists with the same name.
 
+-m::
+	Move/rename a branch and the corresponding reflog.
+
+-M::
+	Move/rename a branch even if the new branchname already exists.
+
 -r::
 	List the remote-tracking branches.
 
@@ -53,7 +66,7 @@ OPTIONS
 	List both remote-tracking branches and local branches.
 
 -v::
-	Show sha1 and subject message for each head.
+	Show sha1 and commit subjectline for each head.
 
 --abbrev=<length>::
 	Alter minimum display length for sha1 in output listing,
@@ -70,6 +83,12 @@ OPTIONS
 	be given as a branch name, a commit-id, or a tag.  If this option
 	is omitted, the current branch is assumed.
 
+<oldbranch>::
+	The name of an existing branch to rename.
+
+<newbranch>::
+	The new name for an existing branch. The same restrictions as for
+	<branchname> applies.
 
 
 Examples
diff --git a/builtin-branch.c b/builtin-branch.c
index 3d5cb0e..3e206b9 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -10,8 +10,8 @@
 #include "commit.h"
 #include "builtin.h"
 
-static const char builtin_branch_usage[] =
-"git-branch (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | [-r | -a] [-v] [--abbrev=<length>] ";
+static const char builtin_branch_usage[] =
+  "git-branch (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [-r | -a] [-v [--abbrev=<length>]]";
 
 
 static const char *head;
@@ -245,9 +245,37 @@ static void create_branch(const char *name, const char *start,
 		die("Failed to write ref: %s.", strerror(errno));
 }
 
+static void rename_branch(const char *oldname, const char *newname, int force)
+{
+	char oldref[PATH_MAX], newref[PATH_MAX];
+	unsigned char sha1[20];
+
+	if (snprintf(oldref, sizeof(oldref), "refs/heads/%s", oldname) > sizeof(oldref))
+		die("Old branchname too long");
+
+	if (check_ref_format(oldref))
+		die("Invalid branch name: %s", oldref);
+
+	if (snprintf(newref, sizeof(newref), "refs/heads/%s", newname) > sizeof(newref))
+		die("New branchname too long");
+
+	if (check_ref_format(newref))
+		die("Invalid branch name: %s", newref);
+
+	if (resolve_ref(newref, sha1, 1, NULL) && !force)
+		die("A branch named '%s' already exists.", newname);
+
+	if (rename_ref(oldref, newref))
+		die("Branch rename failed");
+
+	if (!strcmp(oldname, head) && create_symref("HEAD", newref))
+		die("Branch renamed to %s, but HEAD is not updated!", newname);
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, force_delete = 0, force_create = 0;
+	int rename = 0, force_rename = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV;
 	int reflog = 0;
 	int kinds = REF_LOCAL_BRANCH;
@@ -277,6 +305,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			force_create = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-m")) {
+			rename = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-M")) {
+			rename = 1;
+			force_rename = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-r")) {
 			kinds = REF_REMOTE_BRANCH;
 			continue;
@@ -300,6 +337,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		usage(builtin_branch_usage);
 	}
 
+	if ((delete && rename) || (delete && force_create) ||
+	    (rename && force_create))
+		usage(builtin_branch_usage);
+
 	head = xstrdup(resolve_ref("HEAD", head_sha1, 0, NULL));
 	if (!head)
 		die("Failed to resolve HEAD as a valid ref.");
@@ -311,6 +352,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		delete_branches(argc - i, argv + i, force_delete);
 	else if (i == argc)
 		print_ref_list(kinds, verbose, abbrev);
+	else if (rename && (i == argc - 1))
+		rename_branch(head, argv[i], force_rename);
+	else if (rename && (i == argc - 2))
+		rename_branch(argv[i], argv[i + 1], force_rename);
 	else if (i == argc - 1)
 		create_branch(argv[i], head, force_create, reflog);
 	else if (i == argc - 2)
diff --git a/refs.c b/refs.c
index 96ea8b6..479f18c 100644
--- a/refs.c
+++ b/refs.c
@@ -610,6 +610,29 @@ static int remove_empty_directories(char *file)
 	return remove_empty_dir_recursive(path, len);
 }
 
+static int is_refname_available(const char *ref, const char *oldref,
+				struct ref_list *list, int quiet)
+{
+	int namlen = strlen(ref); /* e.g. 'foo/bar' */
+	while (list) {
+		/* list->name could be 'foo' or 'foo/bar/baz' */
+		if (!oldref || strcmp(oldref, list->name)) {
+			int len = strlen(list->name);
+			int cmplen = (namlen < len) ? namlen : len;
+			const char *lead = (namlen < len) ? list->name : ref;
+			if (!strncmp(ref, list->name, cmplen) &&
+			    lead[cmplen] == '/') {
+				if (!quiet)
+					error("'%s' exists; cannot create '%s'",
+					      list->name, ref);
+				return 0;
+			}
+		}
+		list = list->next;
+	}
+	return 1;
+}
+
 static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char *old_sha1, int *flag)
 {
 	char *ref_file;
@@ -643,29 +666,14 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 			orig_ref, strerror(errno));
 		goto error_return;
 	}
-	if (is_null_sha1(lock->old_sha1)) {
-		/* The ref did not exist and we are creating it.
-		 * Make sure there is no existing ref that is packed
-		 * whose name begins with our refname, nor a ref whose
-		 * name is a proper prefix of our refname.
-		 */
-		int namlen = strlen(ref); /* e.g. 'foo/bar' */
-		struct ref_list *list = get_packed_refs();
-		while (list) {
-			/* list->name could be 'foo' or 'foo/bar/baz' */
-			int len = strlen(list->name);
-			int cmplen = (namlen < len) ? namlen : len;
-			const char *lead = (namlen < len) ? list->name : ref;
-
-			if (!strncmp(ref, list->name, cmplen) &&
-			    lead[cmplen] == '/') {
-				error("'%s' exists; cannot create '%s'",
-				      list->name, ref);
-				goto error_return;
-			}
-			list = list->next;
-		}
-	}
+	/* When the ref did not exist and we are creating it,
+	 * make sure there is no existing ref that is packed
+	 * whose name begins with our refname, nor a ref whose
+	 * name is a proper prefix of our refname.
+	 */
+	if (is_null_sha1(lock->old_sha1) &&
+            !is_refname_available(ref, NULL, get_packed_refs(), 0))
+		goto error_return;
 
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
@@ -776,6 +784,121 @@ int delete_ref(const char *refname, unsigned char *sha1)
 	return ret;
 }
 
+int rename_ref(const char *oldref, const char *newref)
+{
+	static const char renamed_ref[] = "RENAMED-REF";
+	unsigned char sha1[20], orig_sha1[20];
+	int flag = 0, logmoved = 0;
+	struct ref_lock *lock;
+	char msg[PATH_MAX*2 + 100];
+	struct stat loginfo;
+	int log = !stat(git_path("logs/%s", oldref), &loginfo);
+
+	if (S_ISLNK(loginfo.st_mode))
+		return error("reflog for %s is a symlink", oldref);
+
+	if (!resolve_ref(oldref, orig_sha1, 1, &flag))
+		return error("refname %s not found", oldref);
+
+	if (!is_refname_available(newref, oldref, get_packed_refs(), 0))
+		return 1;
+
+	if (!is_refname_available(newref, oldref, get_loose_refs(), 0))
+		return 1;
+
+	if (snprintf(msg, sizeof(msg), "renamed %s to %s", oldref, newref) > sizeof(msg))
+		return error("Refnames to long");
+
+	lock = lock_ref_sha1_basic(renamed_ref, NULL, NULL);
+	if (!lock)
+		return error("unable to lock %s", renamed_ref);
+	lock->force_write = 1;
+	if (write_ref_sha1(lock, orig_sha1, msg))
+		return error("unable to save current sha1 in %s", renamed_ref);
+
+	if (log && rename(git_path("logs/%s", oldref), git_path("tmp-renamed-log")))
+		return error("unable to move logfile logs/%s to tmp-renamed-log: %s",
+			oldref, strerror(errno));
+
+	if (delete_ref(oldref, orig_sha1)) {
+		error("unable to delete old %s", oldref);
+		goto rollback;
+	}
+
+	if (resolve_ref(newref, sha1, 1, &flag) && delete_ref(newref, sha1)) {
+		if (errno==EISDIR) {
+			if (remove_empty_directories(git_path("%s", newref))) {
+				error("Directory not empty: %s", newref);
+				goto rollback;
+			}
+		} else {
+			error("unable to delete existing %s", newref);
+			goto rollback;
+		}
+	}
+
+	if (log && safe_create_leading_directories(git_path("logs/%s", newref))) {
+		error("unable to create directory for %s", newref);
+		goto rollback;
+	}
+
+ retry:
+	if (log && rename(git_path("tmp-renamed-log"), git_path("logs/%s", newref))) {
+		if (errno==EISDIR) {
+			if (remove_empty_directories(git_path("logs/%s", newref))) {
+				error("Directory not empty: logs/%s", newref);
+				goto rollback;
+			}
+			goto retry;
+		} else {
+			error("unable to move logfile tmp-renamed-log to logs/%s: %s",
+				newref, strerror(errno));
+			goto rollback;
+		}
+	}
+	logmoved = log;
+
+	lock = lock_ref_sha1_basic(newref, NULL, NULL);
+	if (!lock) {
+		error("unable to lock %s for update", newref);
+		goto rollback;
+	}
+
+	lock->force_write = 1;
+	hashcpy(lock->old_sha1, orig_sha1);
+	if (write_ref_sha1(lock, orig_sha1, msg)) {
+		error("unable to write current sha1 into %s", newref);
+		goto rollback;
+	}
+
+	return 0;
+
+ rollback:
+	lock = lock_ref_sha1_basic(oldref, NULL, NULL);
+	if (!lock) {
+		error("unable to lock %s for rollback", oldref);
+		goto rollbacklog;
+	}
+
+	lock->force_write = 1;
+	flag = log_all_ref_updates;
+	log_all_ref_updates = 0;
+	if (write_ref_sha1(lock, orig_sha1, NULL))
+		error("unable to write current sha1 into %s", oldref);
+	log_all_ref_updates = flag;
+
+ rollbacklog:
+	if (logmoved && rename(git_path("logs/%s", newref), git_path("logs/%s", oldref)))
+		error("unable to restore logfile %s from %s: %s",
+			oldref, newref, strerror(errno));
+	if (!logmoved && log &&
+	    rename(git_path("tmp-renamed-log"), git_path("logs/%s", oldref)))
+		error("unable to restore logfile %s from tmp-renamed-log: %s",
+			oldref, strerror(errno));
+
+	return 1;
+}
+
 void unlock_ref(struct ref_lock *lock)
 {
 	if (lock->lock_fd >= 0) {
diff --git a/refs.h b/refs.h
index cd1e1d6..ce73d5c 100644
--- a/refs.h
+++ b/refs.h
@@ -47,4 +47,7 @@ extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned
 /** Returns 0 if target has the right format for a ref. **/
 extern int check_ref_format(const char *target);
 
+/** rename ref, return 0 on success **/
+extern int rename_ref(const char *oldref, const char *newref);
+
 #endif /* REFS_H */
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index acb54b6..afaa853 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -70,4 +70,38 @@ test_expect_success \
         git-branch -d l/m &&
         git-branch l'
 
+test_expect_success \
+    'git branch -m m m/m should work' \
+       'git-branch -l m &&
+        git-branch -m m m/m &&
+        test -f .git/logs/refs/heads/m/m'
+
+test_expect_success \
+    'git branch -m n/n n should work' \
+       'git-branch -l n/n &&
+        git-branch -m n/n n
+        test -f .git/logs/refs/heads/n'
+
+test_expect_failure \
+    'git branch -m o/o o should fail when o/p exists' \
+       'git-branch o/o &&
+        git-branch o/p &&
+        git-branch -m o/o o'
+
+test_expect_failure \
+    'git branch -m q r/q should fail when r exists' \
+       'git-branch q &&
+         git-branch r &&
+         git-branch -m q r/q'
+
+test_expect_success \
+    'git branch -m s/s s should work when s/t is deleted' \
+       'git-branch -l s/s &&
+        test -f .git/logs/refs/heads/s/s &&
+        git-branch -l s/t &&
+        test -f .git/logs/refs/heads/s/t &&
+        git-branch -d s/t &&
+        git-branch -m s/s s &&
+        test -f .git/logs/refs/heads/s'
+
 test_done
-- 
1.4.4.1.gf0df
