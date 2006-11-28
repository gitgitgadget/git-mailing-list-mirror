X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Teach git-branch howto rename a branch
Date: Tue, 28 Nov 2006 03:01:27 +0100
Message-ID: <1164679287192-git-send-email-hjemli@gmail.com>
NNTP-Posting-Date: Tue, 28 Nov 2006 02:01:43 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.gf64d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32479>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GosHy-0004Kg-18 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 03:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934223AbWK1CBe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 21:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934284AbWK1CBe
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 21:01:34 -0500
Received: from mail45.e.nsc.no ([193.213.115.45]:46741 "EHLO
 mail45.e.nsc.no") by vger.kernel.org with ESMTP id S934223AbWK1CBd (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 21:01:33 -0500
Received: from localhost.localdomain (ti231210a080-2784.bb.online.no
 [80.213.122.226]) by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id
 kAS21Tc0002717; Tue, 28 Nov 2006 03:01:29 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This adds a '--rename' option to git branch. If specified, branch
creation becomes branch renaming.

With a single branchname, the current branch is renamed and .git/HEAD is
updated.

With two branchnames, the second name is renamed to the first.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

This seems to do the right thing for both refs and reflogs, but 'make test' 
probably should be expanded with some evil test-cases to confirm my manual
testing.


 builtin-branch.c |   30 ++++++++++-
 refs.c           |  162 ++++++++++++++++++++++++++++++++++++++++++++++--------
 refs.h           |    3 +
 3 files changed, 171 insertions(+), 24 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 3d5cb0e..2a21263 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -245,9 +245,29 @@ static void create_branch(const char *name, const char *start,
 		die("Failed to write ref: %s.", strerror(errno));
 }
 
+static void rename_branch(const char *oldname, const char *newname, int force)
+{
+	char oldref[PATH_MAX], newref[PATH_MAX];
+	unsigned char sha1[20];
+
+	snprintf(oldref, sizeof oldref, "refs/heads/%s", oldname);
+	if (check_ref_format(oldref))
+		die("Invalid branch name: %s", oldref);
+
+	snprintf(newref, sizeof newref, "refs/heads/%s", newname);
+	if (check_ref_format(newref))
+		die("Invalid branch name: %s", newref);
+
+	if (resolve_ref(newref, sha1, 1, NULL) && !force)
+		die("A branch named '%s' already exists.\n", newname);
+
+	if (!rename_ref(oldref, newref) && !strcmp(oldname, head))
+		create_symref("HEAD", newref);
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, force_delete = 0, force_create = 0;
+	int delete = 0, rename = 0, force_delete = 0, force_create = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV;
 	int reflog = 0;
 	int kinds = REF_LOCAL_BRANCH;
@@ -277,6 +297,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			force_create = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--rename")) {
+			rename = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-r")) {
 			kinds = REF_REMOTE_BRANCH;
 			continue;
@@ -311,6 +335,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		delete_branches(argc - i, argv + i, force_delete);
 	else if (i == argc)
 		print_ref_list(kinds, verbose, abbrev);
+	else if (rename && (i == argc - 1))
+		rename_branch(head, argv[i], force_create);
+	else if (rename && (i == argc - 2))
+		rename_branch(argv[i + 1], argv[i], force_create);
 	else if (i == argc - 1)
 		create_branch(argv[i], head, force_create, reflog);
 	else if (i == argc - 2)
diff --git a/refs.c b/refs.c
index 0e156c5..1cb610f 100644
--- a/refs.c
+++ b/refs.c
@@ -534,6 +534,29 @@ static int remove_empty_directories(char *file)
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
@@ -567,29 +590,14 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
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
 
@@ -700,6 +708,114 @@ int delete_ref(const char *refname, unsigned char *sha1)
 	return ret;
 }
 
+int rename_ref(const char *oldref, const char *newref)
+{
+	unsigned char sha1[20], orig_sha1[20];
+	int flag = 0, logmoved = 0;
+	struct ref_lock *lock;
+	char msg[PATH_MAX*2 + 100];
+	struct stat stat;
+	int log = !lstat(git_path("logs/%s", oldref), &stat);
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
+	lock = lock_ref_sha1_basic("tmp-renamed-ref", NULL, NULL);
+	if (!lock)
+		return error("unable to lock tmp-renamed-ref");
+	lock->force_write = 1;
+	if (write_ref_sha1(lock, orig_sha1, msg))
+		return error("unable to save current sha1 in tmp-renamed-ref");
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
+	snprintf(msg, sizeof msg, "renamed from %s to %s", oldref, newref);
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
index a57d437..61419db 100644
--- a/refs.h
+++ b/refs.h
@@ -44,4 +44,7 @@ extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned
 /** Returns 0 if target has the right format for a ref. **/
 extern int check_ref_format(const char *target);
 
+/** rename ref, return 0 on success **/
+extern int rename_ref(const char *oldref, const char *newref);
+
 #endif /* REFS_H */
-- 
1.4.4.1.gf64d
