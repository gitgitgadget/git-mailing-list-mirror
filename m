From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 11/21] builtin/notes.c: Refactor creation of notes commits.
Date: Sat,  9 Oct 2010 03:13:29 +0200
Message-ID: <1286586819-3636-12-git-send-email-johan@herland.net>
References: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:14:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4O1P-0003NB-4E
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932986Ab0JIBOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:14:30 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:51254 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428Ab0JIBO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:14:29 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4O16-0001lM-4g; Sat, 09 Oct 2010 03:14:28 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158563>

Create new function create_notes_commit() which is slightly more general than
commit_notes() (accepts multiple commit parents and does not auto-update the
notes ref). This function will be used by the notes-merge functionality in
future patches.

Also rewrite builtin/notes.c:commit_notes() to reuse this new function.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin.h       |    2 +-
 builtin/notes.c |   28 +++++-----------------------
 notes-merge.c   |   27 +++++++++++++++++++++++++++
 notes-merge.h   |   14 ++++++++++++++
 4 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/builtin.h b/builtin.h
index ed6ee26..908d850 100644
--- a/builtin.h
+++ b/builtin.h
@@ -17,7 +17,7 @@ extern void prune_packed_objects(int);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
 	struct strbuf *out);
 extern int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out);
-extern int commit_notes(struct notes_tree *t, const char *msg);
+extern void commit_notes(struct notes_tree *t, const char *msg);
 
 struct notes_rewrite_cfg {
 	struct notes_tree **trees;
diff --git a/builtin/notes.c b/builtin/notes.c
index fbabdc7..97d8baa 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -288,18 +288,17 @@ static int parse_reedit_arg(const struct option *opt, const char *arg, int unset
 	return parse_reuse_arg(opt, arg, unset);
 }
 
-int commit_notes(struct notes_tree *t, const char *msg)
+void commit_notes(struct notes_tree *t, const char *msg)
 {
-	struct commit_list *parent;
-	unsigned char tree_sha1[20], prev_commit[20], new_commit[20];
 	struct strbuf buf = STRBUF_INIT;
+	unsigned char commit_sha1[20];
 
 	if (!t)
 		t = &default_notes_tree;
 	if (!t->initialized || !t->ref || !*t->ref)
 		die("Cannot commit uninitialized/unreferenced notes tree");
 	if (!t->dirty)
-		return 0; /* don't have to commit an unchanged tree */
+		return; /* don't have to commit an unchanged tree */
 
 	/* Prepare commit message and reflog message */
 	strbuf_addstr(&buf, "notes: "); /* commit message starts at index 7 */
@@ -307,27 +306,10 @@ int commit_notes(struct notes_tree *t, const char *msg)
 	if (buf.buf[buf.len - 1] != '\n')
 		strbuf_addch(&buf, '\n'); /* Make sure msg ends with newline */
 
-	/* Convert notes tree to tree object */
-	if (write_notes_tree(t, tree_sha1))
-		die("Failed to write current notes tree to database");
-
-	/* Create new commit for the tree object */
-	if (!read_ref(t->ref, prev_commit)) { /* retrieve parent commit */
-		parent = xmalloc(sizeof(*parent));
-		parent->item = lookup_commit(prev_commit);
-		parent->next = NULL;
-	} else {
-		hashclr(prev_commit);
-		parent = NULL;
-	}
-	if (commit_tree(buf.buf + 7, tree_sha1, parent, new_commit, NULL))
-		die("Failed to commit notes tree to database");
-
-	/* Update notes ref with new commit */
-	update_ref(buf.buf, t->ref, new_commit, prev_commit, 0, DIE_ON_ERR);
+	create_notes_commit(t, NULL, buf.buf + 7, commit_sha1);
+	update_ref(buf.buf, t->ref, commit_sha1, NULL, 0, DIE_ON_ERR);
 
 	strbuf_release(&buf);
-	return 0;
 }
 
 combine_notes_fn parse_combine_notes_fn(const char *v)
diff --git a/notes-merge.c b/notes-merge.c
index 293848a..fc978c4 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "notes.h"
 #include "notes-merge.h"
 
 void init_notes_merge_options(struct notes_merge_options *o)
@@ -16,6 +17,32 @@ static int show(struct notes_merge_options *o, int v)
 #define OUTPUT(o, v, ...) \
 	do { if (show((o), (v))) { printf(__VA_ARGS__); puts(""); } } while (0)
 
+void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
+			 const char *msg, unsigned char *result_sha1)
+{
+	unsigned char tree_sha1[20];
+
+	assert(t->initialized);
+
+	if (write_notes_tree(t, tree_sha1))
+		die("Failed to write notes tree to database");
+
+	if (!parents) {
+		/* Deduce parent commit from t->ref */
+		unsigned char parent_sha1[20];
+		if (!read_ref(t->ref, parent_sha1)) {
+			struct commit *parent = lookup_commit(parent_sha1);
+			if (!parent || parse_commit(parent))
+				die("Failed to find/parse commit %s", t->ref);
+			commit_list_insert(parent, &parents);
+		}
+		/* else: t->ref points to nothing, assume root/orphan commit */
+	}
+
+	if (commit_tree(msg, tree_sha1, parents, result_sha1, NULL))
+		die("Failed to commit notes tree to database");
+}
+
 int notes_merge(struct notes_merge_options *o,
 		unsigned char *result_sha1)
 {
diff --git a/notes-merge.h b/notes-merge.h
index bd1e530..2319c12 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -15,6 +15,20 @@ struct notes_merge_options {
 void init_notes_merge_options(struct notes_merge_options *o);
 
 /*
+ * Create new notes commit from the given notes tree
+ *
+ * Properties of the created commit:
+ * - tree: the result of converting t to a tree object with write_notes_tree().
+ * - parents: the given parents OR (if NULL) the commit referenced by t->ref.
+ * - author/committer: the default determined by commmit_tree().
+ * - commit message: msg
+ *
+ * The resulting commit SHA1 is stored in result_sha1.
+ */
+void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
+			 const char *msg, unsigned char *result_sha1);
+
+/*
  * Merge notes from o->remote_ref into o->local_ref
  *
  * The commits given by the two refs are merged, producing one of the following
-- 
1.7.3.1.104.g92b87a
