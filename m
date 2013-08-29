From: Brad King <brad.king@kitware.com>
Subject: [PATCH/RFC 6/7] refs: add update_refs for multiple simultaneous updates
Date: Thu, 29 Aug 2013 10:11:54 -0400
Message-ID: <518ba77096664a679e4c7212e4cc4d496c6b38d3.1377784597.git.brad.king@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 16:22:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF37L-0000xR-9j
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 16:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab3H2OW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 10:22:28 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:48740 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754451Ab3H2OWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 10:22:15 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 7CF749FB8D; Thu, 29 Aug 2013 10:11:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1377784597.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233263>

Add 'struct ref_update' to encode the information needed to update or
delete a ref (name, new sha1, optional old sha1, no-deref flag).  Add
function 'update_refs' accepting an array of updates to perform.  First
acquire locks on all refs with verified old values.  Then update or
delete all refs accordingly.  Fail if any one lock cannot be obtained or
any one old value does not match.

Though the refs themeselves cannot be modified together in a single
atomic transaction, this function does enable some useful semantics.
For example, a caller may create a new branch starting from the head of
another branch and rewind the original branch at the same time.  This
transfers ownership of commits between branches without risk of losing
commits added to the original branch by a concurrent process, or risk of
a concurrent process creating the new branch first.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 refs.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h |   11 +++++++++++
 2 files changed, 77 insertions(+)

diff --git a/refs.c b/refs.c
index 5a6c14e..0a0c19e 100644
--- a/refs.c
+++ b/refs.c
@@ -3238,6 +3238,72 @@ int update_ref(const char *action, const char *refname,
 	return update_ref_write(action, refname, sha1, lock, onerr);
 }
 
+int update_refs(const char *action, struct ref_update *updates,
+		int n, enum action_on_err onerr)
+{
+	int ret = 0, delnum = 0, i;
+	int *types;
+	struct ref_lock **locks;
+	const char **delnames;
+
+	if (!updates || !n)
+		return 0;
+
+	/* Allocate work space: */
+	types = xmalloc(sizeof(int)*n);
+	locks = xmalloc(sizeof(struct ref_lock*)*n);
+	delnames = xmalloc(sizeof(const char*)*n);
+
+	/* Acquire all locks while verifying old values: */
+	for (i=0; i < n; ++i) {
+		locks[i] = update_ref_lock(updates[i].ref_name,
+					   updates[i].old_sha1,
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
+		free(types);
+		free(locks);
+		free(delnames);
+		return 1;
+	}
+
+	/* Perform updates first so live commits remain referenced: */
+	for (i=0; i < n; ++i)
+		if (!is_null_sha1(updates[i].new_sha1)) {
+			ret |= update_ref_write(action,
+						updates[i].ref_name,
+						updates[i].new_sha1,
+						locks[i], onerr);
+			locks[i] = 0; /* freed by update_ref_write */
+		}
+
+	/* Perform deletes now that updates are safely completed: */
+	for (i=0; i < n; ++i)
+		if (locks[i]) {
+			delnames[delnum++] = locks[i]->ref_name;
+			ret |= delete_ref_loose(locks[i], types[i]);
+		}
+	ret |= repack_without_refs(delnames, delnum);
+	for (i=0; i < delnum; ++i)
+		unlink_or_warn(git_path("logs/%s", delnames[i]));
+	clear_loose_ref_cache(&ref_cache);
+	for (i=0; i < n; ++i)
+		if (locks[i])
+			unlock_ref(locks[i]);
+
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
index 2cd307a..5763f3a 100644
--- a/refs.h
+++ b/refs.h
@@ -214,6 +214,17 @@ int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
 		int flags, enum action_on_err onerr);
 
+struct ref_update {
+	const char *ref_name;
+	unsigned char new_sha1[20];
+	unsigned char *old_sha1;
+	int flags;
+};
+
+/** lock all refs and then write all of them */
+int update_refs(const char *action, struct ref_update *updates,
+		int n, enum action_on_err onerr);
+
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
 
-- 
1.7.10.4
