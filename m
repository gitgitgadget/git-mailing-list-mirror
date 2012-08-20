From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 3/4] vcs-svn/svndump: rewrite handle_node(), begin|end_revision()
Date: Mon, 20 Aug 2012 23:57:56 +0200
Message-ID: <1345499877-16024-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499877-16024-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499877-16024-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499877-16024-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:58:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ZzV-0003JM-99
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768Ab2HTV6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:58:21 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:44474 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885Ab2HTV6T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:58:19 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so4179693wey.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=I+L8DQDpryB9NcanwW+vriXVvVVi2m07ZpHpOoghUdc=;
        b=ir9EDmVU4qiVpXcPrXgC9VbxhWIDi7AHCvjJ17PDuLJt3msLtVb0Q8XvvD6bD0zxeH
         zflnrPamv01gmh1m1tow+S0y3HL8Htz4s5FAUYom4ZH0pQV7eGRSNH4L1zZihqoXVhiW
         Rdf371qoGLmP01saPQBANF1kQhUk6F8mdbJFYEDFyeETj0l7zt5cBru3NHFnX+1vBmKM
         OEkO6KQYbcuguhmdfyPj8p/YjJVcOzGR2zIIyN4uPJnVDV5Xzm2wSEng3xraV8QcPcIl
         042y1tJ+dAkv1gG60COGa/WxxWkPNg6PIz6nRxTI/qmW/hUDCCjZ4Xtd0r6RwCRh2CxH
         wODQ==
Received: by 10.180.80.134 with SMTP id r6mr32214983wix.1.1345499898991;
        Mon, 20 Aug 2012 14:58:18 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id o2sm44859731wiz.11.2012.08.20.14.58.16
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:58:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499877-16024-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203896>

Split the decision of what to do and actually doing it in
handle_node() to allow for detection of branches from svn nodes.
Split it into handle_node() and apply_node().

svn dumps are structured in revisions, which contain multiple nodes.
Nodes represent operations on data. Currently the function
handle_node() strongly mixes the interpretation of the node data with
the output of processed data to fast-import.

In a fast-import stream a commit object requires a branch name to
which the new commit is added at its beginning.

We want to detect branches in svn. This can only be done by analyzing
node operations, like copyfrom. This conflicts with the current
implementation, where at the beginning of each new revision in the svn
dump, a new commit on a hard-coded git branch is created, before even
reading the first node.

To allow analyzing the nodes before deciding on which branch the
commit will be placed, store the node metadata of one complete
revision, and create a commit from it, when it ends.

Each node can have file data appended. It's desirable to not store the
actual file data, as it is unbounded.  fast-import has a 'blob'
command that allows writing blobs, independent of commits. Use this
feature instead of sending data inline and send the actual file data
immediately when it is read in.

Use marks to reference a blob later. fast-import's marks are currently
used for marking commits, where the mark number corresponds to exactly
one svn revision.
Store the marks for blobs in the upper half of the marks number space
where the MSB is 1.

Change handle_node() to interpret the node data, store it in a
node_ctx, send blobs to fast-import, and append the new node_ctx to
the list of node_ctx.  Do this until the end of a revision.

Just clear the list of note_ctx in begin_revision().

At end_revision() all node metadata is available in the node_ctx list.
Future's branch detectors can decide what branches are to be changed.
Then, call apply_node() for each of them to actually create a commit
and change/add/delete files according to the node_ctx using the
already added blobs.

This can also be used to create commits if the node metadata does not
come from a svndump, but is stored in e.g. notes, for later branch
detection.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 vcs-svn/svndump.c |  167 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 109 insertions(+), 58 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 385523a..28ce2aa 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -48,7 +48,6 @@ static struct node_ctx_t *node_list, *node_list_tail;
 static struct node_ctx_t *new_node_ctx(char *fname)
 {
 	struct node_ctx_t *node = xmalloc(sizeof(struct node_ctx_t));
-	trace_printf("new_node_ctx %p\n", node);
 	node->type = 0;
 	node->action = NODEACT_UNKNOWN;
 	node->prop_length = -1;
@@ -67,7 +66,6 @@ static struct node_ctx_t *new_node_ctx(char *fname)
 
 static void free_node_ctx(struct node_ctx_t *node)
 {
-	trace_printf("free_node_ctx %p\n", node);
 	strbuf_release(&node->src);
 	strbuf_release(&node->dst);
 	free((char*)node->dataref);
@@ -77,7 +75,6 @@ static void free_node_ctx(struct node_ctx_t *node)
 static void free_node_list(void)
 {
 	struct node_ctx_t *p = node_list, *n;
-	trace_printf("free_node_list head %p tail %p\n", node_list, node_list_tail);
 	while (p) {
 		n = p->next;
 		free_node_ctx(p);
@@ -88,7 +85,6 @@ static void free_node_list(void)
 
 static void append_node_list(struct node_ctx_t *n)
 {
-	trace_printf("append_node_list %p head %p tail %p\n", n, node_list, node_list_tail);
 	if (!node_list)
 		node_list = node_list_tail = n;
 	else {
@@ -246,23 +242,10 @@ static void handle_node(struct node_ctx_t *node)
 	static const char *const empty_blob = "::empty::";
 	const char *old_data = NULL;
 	uint32_t old_mode = REPO_MODE_BLB;
+	struct strbuf sb = STRBUF_INIT;
+	static uintmax_t blobmark = 1UL << (bitsizeof(uintmax_t) - 1);
+
 
-	if (node->action == NODEACT_DELETE) {
-		if (have_text || have_props || node->srcRev)
-			die("invalid dump: deletion node has "
-				"copyfrom info, text, or properties");
-		repo_delete(node->dst.buf);
-		return;
-	}
-	if (node->action == NODEACT_REPLACE) {
-		repo_delete(node->dst.buf);
-		node->action = NODEACT_ADD;
-	}
-	if (node->srcRev) {
-		repo_copy(node->srcRev, node->src.buf, node->dst.buf);
-		if (node->action == NODEACT_ADD)
-			node->action = NODEACT_CHANGE;
-	}
 	if (have_text && type == REPO_MODE_DIR)
 		die("invalid dump: directories cannot have text attached");
 
@@ -270,28 +253,61 @@ static void handle_node(struct node_ctx_t *node)
 	 * Find old content (old_data) and decide on the new mode.
 	 */
 	if (node->action == NODEACT_CHANGE && !*node->dst.buf) {
+		/*
+		 * changes the root of the tree (empty dst), e.g. adding properties.
+		 * see 9e8c5321
+		 */
 		if (type != REPO_MODE_DIR)
-			die("invalid dump: root of tree is not a regular file");
+			die("invalid dump: root of tree is not a directory");
 		old_data = NULL;
 	} else if (node->action == NODEACT_CHANGE) {
 		uint32_t mode;
-		old_data = repo_read_path(node->dst.buf, &mode); /* malloced buffer */
+		if (fast_export_ls_rev(rev_ctx.revision - 1, node->dst.buf, &mode, &sb)) {
+			if (errno != ENOENT)
+				die_errno("BUG: unexpected fast_export_ls error");
+			/* Treat missing paths as directories. */
+			mode = REPO_MODE_DIR;
+			old_data = NULL;
+		} else
+			old_data = strbuf_detach(&sb, NULL);
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
-			die("invalid dump: cannot modify a directory into a file");
+			die("invalid dump: cannot modify a directory into a file: "
+					"%s. old_data %s", node->dst.buf, old_data);
 		if (mode != REPO_MODE_DIR && type == REPO_MODE_DIR)
-			die("invalid dump: cannot modify a file into a directory");
+			die("invalid dump: cannot modify a file into a directory: %s",
+					node->dst.buf);
 		node->type = mode;
 		old_mode = mode;
-	} else if (node->action == NODEACT_ADD) {
-		if (type == REPO_MODE_DIR)
+	} else if (node->action == NODEACT_ADD || node->action == NODEACT_REPLACE) {
+		if (node->srcRev) {	/* was copied */
+			/* read dataref and mode from src blob */
+			strbuf_reset(&sb);
+			if (fast_export_ls_rev(node->srcRev, node->src.buf, &node->type, &sb)) {
+				if (errno != ENOENT)
+					die_errno("BUG: unexpected fast_export_ls_rev error");
+				/*
+				 * if the dataref is not available, it may be a copy of an empty
+				 * dir. We delete the target, and write it when the first file
+				 * is added.
+				 */
+				node->action = NODEACT_DELETE;
+				node->dataref = NULL;
+			} else
+				node->dataref = strbuf_detach(&sb, NULL);
+			old_data = NULL;
+		} else if (type == REPO_MODE_DIR)
 			old_data = NULL;
 		else if (have_text)
 			old_data = empty_blob;
 		else
 			die("invalid dump: adds node without text");
-	} else {
+	} else if (node->action == NODEACT_DELETE) {
+		old_data = empty_blob;
+		if (have_text || have_props || node->srcRev)
+			die("invalid dump: deletion node has "
+				"copyfrom info, text, or properties");
+	} else
 		die("invalid dump: Node-path block lacks Node-action");
-	}
 
 	/*
 	 * Adjust mode to reflect properties.
@@ -304,48 +320,83 @@ static void handle_node(struct node_ctx_t *node)
 	}
 
 	/*
-	 * Save the result.
+	 * Send the data and save the node_ctx.
 	 */
-	if (type == REPO_MODE_DIR)	/* directories are not tracked. */
-		return;
-	assert(old_data);
-	if (old_data == empty_blob)
-		/* For the fast_export_* functions, NULL means empty. */
-		old_data = NULL;
-	if (!have_text) {
-		fast_export_modify(node->dst.buf, node->type, old_data);
-		return;
+	if (type != REPO_MODE_DIR) {	/* directories are not tracked. */
+		assert(old_data);
+		if (old_data == empty_blob)
+			/* For the fast_export_* functions, NULL means empty. */
+			old_data = NULL;
+		if (!have_text)
+			node->dataref = old_data;
+		else {
+			if (!node->text_delta) {
+				printf("blob\n"
+						"mark :%"PRIuMAX"\n", ++blobmark);
+				fast_export_data(node->type, node->text_length, &input);
+			}
+			else {
+				printf("blob\n"
+						"mark :%"PRIuMAX"\n", ++blobmark);
+				fast_export_blob_delta(node->type, old_mode, old_data,
+						node->text_length, &input);
+			}
+
+			strbuf_addf(&sb, ":%lu", blobmark);
+			node->dataref = sb.buf;
+		}
 	}
-	if (!node->text_delta) {
-		fast_export_modify(node->dst.buf, node->type, "inline");
-		fast_export_data(node->type, node->text_length, &input);
+	append_node_list(node);
+}
+
+static void apply_node(struct node_ctx_t *node)
+{
+	if (node->action == NODEACT_DELETE) {
+		fast_export_delete(node->dst.buf);
 		return;
 	}
-	fast_export_modify(node->dst.buf, node->type, "inline");
-	fast_export_blob_delta(node->type, old_mode, old_data,
-				node->text_length, &input);
+	if (node->action == NODEACT_REPLACE)
+		fast_export_delete(node->dst.buf);
+	/*
+	 * apply the previously sent node-data to a commit
+	 */
+	if (node->dataref)
+		fast_export_modify(node->dst.buf, node->type, node->dataref);
+}
+
+
+static void apply_node_list(void)
+{
+	struct node_ctx_t *p = node_list, *n;
+	while (p) {
+		n = p->next;
+		apply_node(p);
+		p = n;
+	}
+}
+
+static void begin_revision(const char *remote_ref_)
+{
+	current_ref = remote_ref_;
+	free_node_list();
 }
 
-static void begin_revision(const char *remote_ref)
+static void end_revision(const char *note_ref)
 {
+	struct strbuf mark = STRBUF_INIT;
 	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
 		return;
 	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author.buf,
 		&rev_ctx.log, dump_ctx.uuid.buf, dump_ctx.url.buf,
-		rev_ctx.timestamp, remote_ref);
-}
+		rev_ctx.timestamp, current_ref);
+	apply_node_list();
+	fast_export_end_commit(rev_ctx.revision);
 
-static void end_revision(const char *note_ref)
-{
-	struct strbuf mark = STRBUF_INIT;
-	if (rev_ctx.revision) {
-		fast_export_end_commit(rev_ctx.revision);
-		fast_export_begin_note(rev_ctx.revision, "remote-svn",
-				"Note created by remote-svn.", rev_ctx.timestamp, note_ref);
-		strbuf_addf(&mark, ":%"PRIu32, rev_ctx.revision);
-		fast_export_note(mark.buf, "inline");
-		fast_export_buf_to_data(&rev_ctx.note);
-	}
+	fast_export_begin_note(rev_ctx.revision, "remote-svn",
+			"Note created by remote-svn.", rev_ctx.timestamp, note_ref);
+	strbuf_addf(&mark, ":%"PRIu32, rev_ctx.revision);
+	fast_export_note(mark.buf, "inline");
+	fast_export_buf_to_data(&rev_ctx.note);
 }
 
 void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
-- 
1.7.9.5
