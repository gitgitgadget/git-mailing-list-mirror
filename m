From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2 6/8] refs: add update_refs for multiple simultaneous updates
Date: Fri, 30 Aug 2013 14:12:04 -0400
Message-ID: <edaddbd4e303866f789f1a4f755a9da77590aeef.1377885441.git.brad.king@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 20:14:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFTCr-0007jF-SH
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 20:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802Ab3H3SNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 14:13:52 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:50950 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756720Ab3H3SNr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 14:13:47 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id DA5269FB8E; Fri, 30 Aug 2013 14:12:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1377885441.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233453>

Add 'struct ref_update' to encode the information needed to update or
delete a ref (name, new sha1, optional old sha1, no-deref flag).  Add
function 'update_refs' accepting an array of updates to perform.  First
sort the input array to order locks consistently everywhere and reject
multiple updates to the same ref.  Then acquire locks on all refs with
verified old values.  Then update or delete all refs accordingly.  Fail
if any one lock cannot be obtained or any one old value does not match.

Though the refs themeselves cannot be modified together in a single
atomic transaction, this function does enable some useful semantics.
For example, a caller may create a new branch starting from the head of
another branch and rewind the original branch at the same time.  This
transfers ownership of commits between branches without risk of losing
commits added to the original branch by a concurrent process, or risk of
a concurrent process creating the new branch first.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 refs.c |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h |   14 ++++++++
 2 files changed, 135 insertions(+)

diff --git a/refs.c b/refs.c
index 3bcd26e..901a38a 100644
--- a/refs.c
+++ b/refs.c
@@ -3238,6 +3238,127 @@ int update_ref(const char *action, const char *refname,
 	return update_ref_write(action, refname, sha1, lock, onerr);
 }
 
+static int ref_update_compare(const void *r1, const void *r2)
+{
+	struct ref_update *u1 = (struct ref_update *)(r1);
+	struct ref_update *u2 = (struct ref_update *)(r2);
+	int ret;
+	ret = strcmp(u1->ref_name, u2->ref_name);
+	if (ret)
+		return ret;
+	ret = hashcmp(u1->new_sha1, u2->new_sha1);
+	if (ret)
+		return ret;
+	ret = hashcmp(u1->old_sha1, u2->old_sha1);
+	if (ret)
+		return ret;
+	ret = u1->flags - u2->flags;
+	if (ret)
+		return ret;
+	return u1->have_old - u2->have_old;
+}
+
+static int ref_update_reject_duplicates(struct ref_update *updates, int n,
+					enum action_on_err onerr)
+{
+	int i;
+	for (i = 1; i < n; ++i)
+		if (!strcmp(updates[i - 1].ref_name, updates[i].ref_name))
+			break;
+	if (i < n) {
+		const char *str = "Multiple updates for ref '%s' not allowed.";
+		switch (onerr) {
+		case MSG_ON_ERR: error(str, updates[i].ref_name); break;
+		case DIE_ON_ERR: die(str, updates[i].ref_name); break;
+		case QUIET_ON_ERR: break;
+		}
+		return 1;
+	}
+	return 0;
+}
+
+int update_refs(const char *action, const struct ref_update *updates_orig,
+		int n, enum action_on_err onerr)
+{
+	int ret = 0, delnum = 0, i;
+	struct ref_update *updates;
+	int *types;
+	struct ref_lock **locks;
+	const char **delnames;
+
+	if (!updates_orig || !n)
+		return 0;
+
+	/* Allocate work space: */
+	updates = xmalloc(sizeof(struct ref_update) * n);
+	types = xmalloc(sizeof(int) * n);
+	locks = xmalloc(sizeof(struct ref_lock *) * n);
+	delnames = xmalloc(sizeof(const char *) * n);
+
+	/* Copy, sort, and reject duplicate refs: */
+	memcpy(updates, updates_orig, sizeof(struct ref_update) * n);
+	qsort(updates, n, sizeof(struct ref_update), ref_update_compare);
+	if (ref_update_reject_duplicates(updates, n, onerr)) {
+		free(updates);
+		free(types);
+		free(locks);
+		free(delnames);
+		return 1;
+	}
+
+	/* Acquire all locks while verifying old values: */
+	for (i = 0; i < n; ++i) {
+		locks[i] = update_ref_lock(updates[i].ref_name,
+					   (updates[i].have_old ?
+					    updates[i].old_sha1 : NULL),
+					   updates[i].flags,
+					   &types[i], onerr);
+		if (!locks[i])
+			break;
+	}
+
+	/* Abort if we did not get all locks: */
+	if (i < n) {
+		while (--i >= 0)
+			unlock_ref(locks[i]);
+		free(updates);
+		free(types);
+		free(locks);
+		free(delnames);
+		return 1;
+	}
+
+	/* Perform updates first so live commits remain referenced: */
+	for (i = 0; i < n; ++i)
+		if (!is_null_sha1(updates[i].new_sha1)) {
+			ret |= update_ref_write(action,
+						updates[i].ref_name,
+						updates[i].new_sha1,
+						locks[i], onerr);
+			locks[i] = 0; /* freed by update_ref_write */
+		}
+
+	/* Perform deletes now that updates are safely completed: */
+	for (i = 0; i < n; ++i)
+		if (locks[i]) {
+			delnames[delnum++] = locks[i]->ref_name;
+			ret |= delete_ref_loose(locks[i], types[i]);
+		}
+	ret |= repack_without_refs(delnames, delnum);
+	for (i = 0; i < delnum; ++i)
+		unlink_or_warn(git_path("logs/%s", delnames[i]));
+	clear_loose_ref_cache(&ref_cache);
+	for (i = 0; i < n; ++i)
+		if (locks[i])
+			unlock_ref(locks[i]);
+
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
index 2cd307a..a8a7cc6 100644
--- a/refs.h
+++ b/refs.h
@@ -214,6 +214,20 @@ int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
 		int flags, enum action_on_err onerr);
 
+struct ref_update {
+	const char *ref_name;
+	unsigned char new_sha1[20];
+	unsigned char old_sha1[20];
+	int flags;
+	int have_old;
+};
+
+/**
+ * Lock all refs and then perform all modifications.
+ */
+int update_refs(const char *action, const struct ref_update *updates,
+		int n, enum action_on_err onerr);
+
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
 
-- 
1.7.10.4
