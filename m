From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/3] Disallow git branch -m for symrefs.
Date: Mon, 27 Oct 2008 20:50:20 +0100
Message-ID: <a18363084130c4c23279667f6f0bd26d585a061d.1225136865.git.vmiklos@frugalware.org>
References: <cover.1225136865.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 20:51:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuY7E-0008Rs-5m
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 20:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbYJ0Ttv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 15:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634AbYJ0Ttu
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 15:49:50 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:38270 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbYJ0Ttq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 15:49:46 -0400
Received: from vmobile.example.net (dsl5401C086.pool.t-online.hu [84.1.192.134])
	by yugo.frugalware.org (Postfix) with ESMTPA id 4592E446CCF;
	Mon, 27 Oct 2008 20:49:43 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 6913114E36; Mon, 27 Oct 2008 20:50:23 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <cover.1225136865.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1225136865.git.vmiklos@frugalware.org>
References: <cover.1225136865.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99257>

This had two problems with symrefs. First, it copied the actual sha1
instead of the "pointer", second it failed to remove the old ref after a
successful rename.

Given that till now delete_ref() always dereferenced symrefs, a new
parameters has been introduced to delete_ref() to allow deleting refs
without a dereference.

For now, we just don't allow renaming symref as no real-word workflow
needs it and doing so would be just an accent.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-branch.c       |    2 +-
 builtin-receive-pack.c |    2 +-
 builtin-remote.c       |    4 ++--
 builtin-reset.c        |    2 +-
 builtin-send-pack.c    |    2 +-
 builtin-tag.c          |    2 +-
 builtin-update-ref.c   |    2 +-
 cache.h                |    2 +-
 refs.c                 |   33 +++++++++++++++++++++++----------
 t/t3200-branch.sh      |    9 +++++++++
 10 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 8d634ff..2b3613f 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -160,7 +160,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			continue;
 		}
 
-		if (delete_ref(name, sha1)) {
+		if (delete_ref(name, sha1, 0)) {
 			error("Error deleting %sbranch '%s'", remote,
 			       argv[i]);
 			ret = 1;
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 45e3cd9..ab5fa1c 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -224,7 +224,7 @@ static const char *update(struct command *cmd)
 			warning ("Allowing deletion of corrupt ref.");
 			old_sha1 = NULL;
 		}
-		if (delete_ref(name, old_sha1)) {
+		if (delete_ref(name, old_sha1, 0)) {
 			error("failed to delete %s", name);
 			return "failed to delete";
 		}
diff --git a/builtin-remote.c b/builtin-remote.c
index df2be06..e396a3a 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -337,7 +337,7 @@ static int remove_branches(struct string_list *branches)
 		const char *refname = item->string;
 		unsigned char *sha1 = item->util;
 
-		if (delete_ref(refname, sha1))
+		if (delete_ref(refname, sha1, 0))
 			result |= error("Could not remove branch %s", refname);
 	}
 	return result;
@@ -565,7 +565,7 @@ static int prune(int argc, const char **argv)
 			const char *refname = states.stale.items[i].util;
 
 			if (!dry_run)
-				result |= delete_ref(refname, NULL);
+				result |= delete_ref(refname, NULL, 0);
 
 			printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
 			       abbrev_ref(refname, "refs/remotes/"));
diff --git a/builtin-reset.c b/builtin-reset.c
index 16e6bb2..9514b77 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -279,7 +279,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		update_ref(msg, "ORIG_HEAD", orig, old_orig, 0, MSG_ON_ERR);
 	}
 	else if (old_orig)
-		delete_ref("ORIG_HEAD", old_orig);
+		delete_ref("ORIG_HEAD", old_orig, 0);
 	prepend_reflog_action("updating HEAD", msg, sizeof(msg));
 	update_ref_status = update_ref(msg, "HEAD", sha1, orig, 0, MSG_ON_ERR);
 
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 910db92..bbf6e0a 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -234,7 +234,7 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 		if (args.verbose)
 			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
 		if (ref->deletion) {
-			delete_ref(rs.dst, NULL);
+			delete_ref(rs.dst, NULL, 0);
 		} else
 			update_ref("update by push", rs.dst,
 					ref->new_sha1, NULL, 0, 0);
diff --git a/builtin-tag.c b/builtin-tag.c
index b13fa34..1ff7b37 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -125,7 +125,7 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
 static int delete_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	if (delete_ref(ref, sha1))
+	if (delete_ref(ref, sha1, 0))
 		return 1;
 	printf("Deleted tag '%s'\n", name);
 	return 0;
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 56a0b1b..d8f3142 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -48,7 +48,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("%s: not a valid old SHA1", oldval);
 
 	if (delete)
-		return delete_ref(refname, oldval ? oldsha1 : NULL);
+		return delete_ref(refname, oldval ? oldsha1 : NULL, 0);
 	else
 		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
 				  no_deref ? REF_NODEREF : 0, DIE_ON_ERR);
diff --git a/cache.h b/cache.h
index b0edbf9..a3c77f0 100644
--- a/cache.h
+++ b/cache.h
@@ -434,7 +434,7 @@ extern int commit_locked_index(struct lock_file *);
 extern void set_alternate_index_output(const char *);
 extern int close_lock_file(struct lock_file *);
 extern void rollback_lock_file(struct lock_file *);
-extern int delete_ref(const char *, const unsigned char *sha1);
+extern int delete_ref(const char *, const unsigned char *sha1, int delopt);
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
diff --git a/refs.c b/refs.c
index 0a126fa..31a2057 100644
--- a/refs.c
+++ b/refs.c
@@ -921,25 +921,33 @@ static int repack_without_ref(const char *refname)
 	return commit_lock_file(&packlock);
 }
 
-int delete_ref(const char *refname, const unsigned char *sha1)
+int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
 	struct ref_lock *lock;
-	int err, i, ret = 0, flag = 0;
+	int err, i = 0, ret = 0, flag = 0;
 
 	lock = lock_ref_sha1_basic(refname, sha1, 0, &flag);
 	if (!lock)
 		return 1;
 	if (!(flag & REF_ISPACKED)) {
 		/* loose */
-		i = strlen(lock->lk->filename) - 5; /* .lock */
-		lock->lk->filename[i] = 0;
-		err = unlink(lock->lk->filename);
+		const char *path;
+
+		if (!(delopt & REF_NODEREF)) {
+			i = strlen(lock->lk->filename) - 5; /* .lock */
+			lock->lk->filename[i] = 0;
+			path = lock->lk->filename;
+		} else {
+			path = git_path(refname);
+		}
+		err = unlink(path);
 		if (err && errno != ENOENT) {
 			ret = 1;
 			error("unlink(%s) failed: %s",
-			      lock->lk->filename, strerror(errno));
+			      path, strerror(errno));
 		}
-		lock->lk->filename[i] = '.';
+		if (!(delopt & REF_NODEREF))
+			lock->lk->filename[i] = '.';
 	}
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
@@ -964,11 +972,16 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	struct ref_lock *lock;
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldref), &loginfo);
+	const char *symref = NULL;
 
 	if (S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldref);
 
-	if (!resolve_ref(oldref, orig_sha1, 1, &flag))
+	symref = resolve_ref(oldref, orig_sha1, 1, &flag);
+	if (flag & REF_ISSYMREF)
+		return error("refname %s is a symbolic ref, renaming it is not supported",
+				oldref);
+	if (!symref)
 		return error("refname %s not found", oldref);
 
 	if (!is_refname_available(newref, oldref, get_packed_refs(), 0))
@@ -988,12 +1001,12 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 		return error("unable to move logfile logs/%s to tmp-renamed-log: %s",
 			oldref, strerror(errno));
 
-	if (delete_ref(oldref, orig_sha1)) {
+	if (delete_ref(oldref, orig_sha1, 0)) {
 		error("unable to delete old %s", oldref);
 		goto rollback;
 	}
 
-	if (resolve_ref(newref, sha1, 1, &flag) && delete_ref(newref, sha1)) {
+	if (resolve_ref(newref, sha1, 1, &flag) && delete_ref(newref, sha1, 0)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newref))) {
 				error("Directory not empty: %s", newref);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 2147eac..20b6c18 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -112,6 +112,15 @@ test_expect_success 'config information was renamed, too' \
 	"test $(git config branch.s.dummy) = Hello &&
 	 test_must_fail git config branch.s/s/dummy"
 
+test_expect_success 'renaming a symref should fail' \
+'
+	git symbolic-ref refs/heads/master2 refs/heads/master &&
+	test_must_fail git branch -m master2 master3 &&
+	git symbolic-ref refs/heads/master2 &&
+	test -f .git/refs/heads/master &&
+	! test -f .git/refs/heads/master3
+'
+
 test_expect_success \
     'git branch -m u v should fail when the reflog for u is a symlink' '
      git branch -l u &&
-- 
1.6.0.2
