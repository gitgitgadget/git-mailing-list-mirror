From: Brad King <brad.king@kitware.com>
Subject: [PATCH v3 6/8] refs: add update_refs for multiple simultaneous updates
Date: Mon,  2 Sep 2013 13:48:54 -0400
Message-ID: <ba16eca38ff0577710089de2f626abca26fdc2c1.1378142796.git.brad.king@kitware.com>
References: <cover.1377885441.git.brad.king@kitware.com> <cover.1378142795.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 19:51:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGYHO-0006Dn-O0
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 19:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758882Ab3IBRuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 13:50:52 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:55781 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758842Ab3IBRuo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 13:50:44 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id ABC399FB8E; Mon,  2 Sep 2013 13:48:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1378142795.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233652>

Add 'struct ref_update' to encode the information needed to update or
delete a ref (name, new sha1, optional old sha1, no-deref flag).  Add
function 'update_refs' accepting an array of updates to perform.  First
sort the input array to order locks consistently everywhere and reject
multiple updates to the same ref.  Then acquire locks on all refs with
verified old values.  Then update or delete all refs accordingly.  Fail
if any one lock cannot be obtained or any one old value does not match.

Though the refs themselves cannot be modified together in a single
atomic transaction, this function does enable some useful semantics.
For example, a caller may create a new branch starting from the head of
another branch and rewind the original branch at the same time.  This
transfers ownership of commits between branches without risk of losing
commits added to the original branch by a concurrent process, or risk of
a concurrent process creating the new branch first.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 refs.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h |   20 +++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/refs.c b/refs.c
index 599504b..53e8774 100644
--- a/refs.c
+++ b/refs.c
@@ -3237,6 +3237,106 @@ int update_ref(const char *action, const char *refname,
 	return update_ref_write(action, refname, sha1, lock, onerr);
 }
 
+static int ref_update_compare(const void *r1, const void *r2)
+{
+	const struct ref_update * const *u1 = r1;
+	const struct ref_update * const *u2 = r2;
+	return strcmp((*u1)->ref_name, (*u2)->ref_name);
+}
+
+static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					enum action_on_err onerr)
+{
+	int i;
+	for (i = 1; i < n; i++)
+		if (!strcmp(updates[i - 1]->ref_name, updates[i]->ref_name)) {
+			const char *str =
+				"Multiple updates for ref '%s' not allowed.";
+			switch (onerr) {
+			case MSG_ON_ERR:
+				error(str, updates[i]->ref_name); break;
+			case DIE_ON_ERR:
+				die(str, updates[i]->ref_name); break;
+			case QUIET_ON_ERR:
+				break;
+			}
+			return 1;
+		}
+	return 0;
+}
+
+int update_refs(const char *action, const struct ref_update **updates_orig,
+		int n, enum action_on_err onerr)
+{
+	int ret = 0, delnum = 0, i;
+	struct ref_update **updates;
+	int *types;
+	struct ref_lock **locks;
+	const char **delnames;
+
+	if (!updates_orig || !n)
+		return 0;
+
+	/* Allocate work space: */
+	updates = xmalloc(sizeof(*updates) * n);
+	types = xmalloc(sizeof(*types) * n);
+	locks = xcalloc(n, sizeof(*locks));
+	delnames = xmalloc(sizeof(*delnames) * n);
+
+	/* Copy, sort, and reject duplicate refs: */
+	memcpy(updates, updates_orig, sizeof(*updates) * n);
+	qsort(updates, n, sizeof(*updates), ref_update_compare);
+	ret = ref_update_reject_duplicates(updates, n, onerr);
+	if (ret)
+		goto cleanup;
+
+	/* Acquire all locks while verifying old values: */
+	for (i = 0; i < n; i++) {
+		locks[i] = update_ref_lock(updates[i]->ref_name,
+					   (updates[i]->have_old ?
+					    updates[i]->old_sha1 : NULL),
+					   updates[i]->flags,
+					   &types[i], onerr);
+		if (!locks[i]) {
+			ret = 1;
+			goto cleanup;
+		}
+	}
+
+	/* Perform updates first so live commits remain referenced: */
+	for (i = 0; i < n; i++)
+		if (!is_null_sha1(updates[i]->new_sha1)) {
+			ret = update_ref_write(action,
+					       updates[i]->ref_name,
+					       updates[i]->new_sha1,
+					       locks[i], onerr);
+			locks[i] = NULL; /* freed by update_ref_write */
+			if (ret)
+				goto cleanup;
+		}
+
+	/* Perform deletes now that updates are safely completed: */
+	for (i = 0; i < n; i++)
+		if (locks[i]) {
+			delnames[delnum++] = locks[i]->ref_name;
+			ret |= delete_ref_loose(locks[i], types[i]);
+		}
+	ret |= repack_without_refs(delnames, delnum);
+	for (i = 0; i < delnum; i++)
+		unlink_or_warn(git_path("logs/%s", delnames[i]));
+	clear_loose_ref_cache(&ref_cache);
+
+cleanup:
+	for (i = 0; i < n; i++)
+		if (locks[i])
+			unlock_ref(locks[i]);
+	free(updates);
+	free(types);
+	free(locks);
+	free(delnames);
+	return ret;
+}
+
 struct ref *find_ref_by_name(const struct ref *list, const char *name)
 {
 	for ( ; list; list = list->next)
diff --git a/refs.h b/refs.h
index 2cd307a..b113377 100644
--- a/refs.h
+++ b/refs.h
@@ -10,6 +10,20 @@ struct ref_lock {
 	int force_write;
 };
 
+/**
+ * Information needed for a single ref update.  Set new_sha1 to the
+ * new value or to zero to delete the ref.  To check the old value
+ * while locking the ref, set have_old to 1 and set old_sha1 to the
+ * value or to zero to ensure the ref does not exist before update.
+ */
+struct ref_update {
+	const char *ref_name;
+	unsigned char new_sha1[20];
+	unsigned char old_sha1[20];
+	int flags; /* REF_NODEREF? */
+	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
+};
+
 /*
  * Bit values set in the flags argument passed to each_ref_fn():
  */
@@ -214,6 +228,12 @@ int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
 		int flags, enum action_on_err onerr);
 
+/**
+ * Lock all refs and then perform all modifications.
+ */
+int update_refs(const char *action, const struct ref_update **updates,
+		int n, enum action_on_err onerr);
+
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
 
-- 
1.7.10.4
