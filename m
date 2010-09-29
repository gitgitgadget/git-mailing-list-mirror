From: Johan Herland <johan@herland.net>
Subject: [PATCH 09/18] builtin/notes.c: Refactor creation of notes commits.
Date: Wed, 29 Sep 2010 02:23:22 +0200
Message-ID: <1285719811-10871-10-git-send-email-johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 02:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0kTV-0001F0-2O
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 02:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab0I2AY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 20:24:26 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44298 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420Ab0I2AXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 20:23:51 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H003ZOFRMTS70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:46 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 5B90C1EEF853_CA28712B	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:46 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1A4361EEF848_CA28712F	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:45 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H00IQEFRHZC10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:42 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1285719811-10871-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157513>

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
index ec1d042..717548d 100644
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
index 5461827..9a4dc6d 100644
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
index c4416e1..b570123 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -10,6 +10,20 @@ struct notes_merge_options {
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
1.7.3.98.g5ad7d9
