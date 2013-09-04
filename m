From: Brad King <brad.king@kitware.com>
Subject: [PATCH v4 2/8] refs: report ref type from lock_any_ref_for_update
Date: Wed,  4 Sep 2013 11:22:39 -0400
Message-ID: <b06a2a1878e1140949f4bce1760e6ac3a5633d4c.1378307529.git.brad.king@kitware.com>
References: <cover.1378142795.git.brad.king@kitware.com> <cover.1378307529.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 04 17:25:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHEx7-0008E7-Db
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 17:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935134Ab3IDPY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 11:24:57 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:60237 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934999Ab3IDPYi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 11:24:38 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 773169FB8E; Wed,  4 Sep 2013 11:22:45 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <cover.1378307529.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233844>

Expose lock_ref_sha1_basic's type_p argument to callers of
lock_any_ref_for_update.  Update all call sites to ignore it by passing
NULL for now.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 branch.c               | 2 +-
 builtin/commit.c       | 2 +-
 builtin/fetch.c        | 3 ++-
 builtin/receive-pack.c | 3 ++-
 builtin/reflog.c       | 2 +-
 builtin/replace.c      | 2 +-
 builtin/tag.c          | 2 +-
 fast-import.c          | 2 +-
 refs.c                 | 7 ++++---
 refs.h                 | 2 +-
 sequencer.c            | 3 ++-
 11 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/branch.c b/branch.c
index c5c6984..f2d383f 100644
--- a/branch.c
+++ b/branch.c
@@ -291,7 +291,7 @@ void create_branch(const char *head,
 	hashcpy(sha1, commit->object.sha1);
 
 	if (!dont_change_ref) {
-		lock = lock_any_ref_for_update(ref.buf, NULL, 0);
+		lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
 		if (!lock)
 			die_errno(_("Failed to lock ref for update"));
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 10acc53..be08f41 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1618,7 +1618,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 					   !current_head
 					   ? NULL
 					   : current_head->object.sha1,
-					   0);
+					   0, NULL);
 
 	nl = strchr(sb.buf, '\n');
 	if (nl)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index d784b2e..28e4025 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -246,7 +246,8 @@ static int s_update_ref(const char *action,
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 	lock = lock_any_ref_for_update(ref->name,
-				       check_old ? ref->old_sha1 : NULL, 0);
+				       check_old ? ref->old_sha1 : NULL,
+				       0, NULL);
 	if (!lock)
 		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 					  STORE_REF_ERROR_OTHER;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3eb5fc..a323070 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -524,7 +524,8 @@ static const char *update(struct command *cmd)
 		return NULL; /* good */
 	}
 	else {
-		lock = lock_any_ref_for_update(namespaced_name, old_sha1, 0);
+		lock = lock_any_ref_for_update(namespaced_name, old_sha1,
+					       0, NULL);
 		if (!lock) {
 			rp_error("failed to lock %s", name);
 			return "failed to lock";
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 54184b3..28d756a 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -366,7 +366,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	 * we take the lock for the ref itself to prevent it from
 	 * getting updated.
 	 */
-	lock = lock_any_ref_for_update(ref, sha1, 0);
+	lock = lock_any_ref_for_update(ref, sha1, 0, NULL);
 	if (!lock)
 		return error("cannot lock ref '%s'", ref);
 	log_file = git_pathdup("logs/%s", ref);
diff --git a/builtin/replace.c b/builtin/replace.c
index 59d3115..1ecae8d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -105,7 +105,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 
-	lock = lock_any_ref_for_update(ref, prev, 0);
+	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
 	if (!lock)
 		die("%s: cannot lock the ref", ref);
 	if (write_ref_sha1(lock, repl, NULL) < 0)
diff --git a/builtin/tag.c b/builtin/tag.c
index af3af3f..2c867d2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -577,7 +577,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (annotate)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
-	lock = lock_any_ref_for_update(ref.buf, prev, 0);
+	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
 	if (!lock)
 		die(_("%s: cannot lock the ref"), ref.buf);
 	if (write_ref_sha1(lock, object, NULL) < 0)
diff --git a/fast-import.c b/fast-import.c
index 23f625f..5c329f6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1678,7 +1678,7 @@ static int update_branch(struct branch *b)
 		return 0;
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
-	lock = lock_any_ref_for_update(b->name, old_sha1, 0);
+	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
 	if (!lock)
 		return error("Unable to lock %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
diff --git a/refs.c b/refs.c
index 7922261..c69fd68 100644
--- a/refs.c
+++ b/refs.c
@@ -2121,11 +2121,12 @@ struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha
 }
 
 struct ref_lock *lock_any_ref_for_update(const char *refname,
-					 const unsigned char *old_sha1, int flags)
+					 const unsigned char *old_sha1,
+					 int flags, int *type_p)
 {
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		return NULL;
-	return lock_ref_sha1_basic(refname, old_sha1, flags, NULL);
+	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
 /*
@@ -3174,7 +3175,7 @@ int update_ref(const char *action, const char *refname,
 		int flags, enum action_on_err onerr)
 {
 	static struct ref_lock *lock;
-	lock = lock_any_ref_for_update(refname, oldval, flags);
+	lock = lock_any_ref_for_update(refname, oldval, flags, NULL);
 	if (!lock) {
 		const char *str = "Cannot lock the ref '%s'.";
 		switch (onerr) {
diff --git a/refs.h b/refs.h
index 9e5db3a..2cd307a 100644
--- a/refs.h
+++ b/refs.h
@@ -137,7 +137,7 @@ extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *
 #define REF_NODEREF	0x01
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
-						int flags);
+						int flags, int *type_p);
 
 /** Close the file descriptor owned by a lock and return the status */
 extern int close_ref(struct ref_lock *lock);
diff --git a/sequencer.c b/sequencer.c
index 351548f..06e52b4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -279,7 +279,8 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from, 0);
+	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
+					   0, NULL);
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 	ret = write_ref_sha1(ref_lock, to, sb.buf);
 	strbuf_release(&sb);
-- 
1.8.4.rc3
