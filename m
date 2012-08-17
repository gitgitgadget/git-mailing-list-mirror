From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 4/5] vcs-svn/svndump: rewrite handle_node(), begin|end_revision()
Date: Fri, 17 Aug 2012 22:40:09 +0200
Message-ID: <1345236010-1648-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345236010-1648-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345236010-1648-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345236010-1648-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:41:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2TLw-0006qS-CL
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510Ab2HQUk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:40:59 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57580 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932475Ab2HQUkc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:40:32 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3671472wgb.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BUpfyDmqfsNgifbJzcxUQnqrQwsWLHMDP5Jslc4/CtU=;
        b=s96YcX3rjIv66R055anKDSq4QvK9AHdjpM1gQNex/baRSo0vGImLU9IsfUyfaC9vx3
         uZ0Bgw8hFK/6N6VpqDkte+BRtEQkYuMW0UcwfiNRoRli5xRF8fYEr/Q/H4HbFTIcxLaT
         77vDIKhxbi8UmLAa/sHP1E2YXWG7HsJS2wmNW+YB8qO3OJxTJSX6s7RltZTadpPDBZhz
         CgOBLVtx0xUbg6vcndCQ1rEpdr4yb7VfIytiLPccP+zHLY1Bx//c/k8SxFYWa7YbuXAk
         kIj0HaxPzCnQCQacUN9n1vO7amXjxi8ePevK5UgKDWiEWyTxgH82ggxUgMMZ2ry9FPFE
         eyrg==
Received: by 10.180.100.37 with SMTP id ev5mr8046921wib.5.1345236031928;
        Fri, 17 Aug 2012 13:40:31 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id b7sm17480686wiz.9.2012.08.17.13.40.30
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:40:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345236010-1648-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203664>

Split the decision of what to do and actually doing it in
handle_node() to allow for detection of branches from svn nodes.
Split it into handle_node() and apply_node().

svn dumps are structured in revisions, which contain multiple nodes.
Nodes represent operations on data. Currently the function
handle_node() strongly mixes the interpretation of the node data
with the output of processed data to fast-import.

In a fast-import stream a commit object requires a branch name to
which the new commit is added at its beginning.

We want to detect branches in svn. This can only be done by analyzing
node operations, like copyfrom. This conflicts with the current
implementation, where at the beginning of each new revision in the svn
dump, a new commit on a hard-coded git branch is created, before even
reading the first node.

To allow analyzing the nodes before deciding on which branch the commit
will be placed, store the node metadata of one complete revision, and
create a commit from it, when it ends.

Each node can have file data appended. It's desirable to not store the
actual file data, as it is unbounded.
fast-import has a 'blob' command that allows writing blobs, independent
of commits. Use this feature instead of sending data inline and send
the actual file data immediately when it is read in.

Use the previously added SHA1 calculation feature of fast_export_data
and fast_export_blob_delta to retrieve the SHA1 of the written blob
and reference it later. fast-import's marks can not be used for that,
because they are already used for marking commits, where the mark
number corresponds to exactly one svn revision.

Change handle_node() to interpret the node data, store it in a node_ctx,
send blobs to fast-import, and append the new node_ctx to the list of
node_ctx.
Do this until the end of a revision.

Just clear the list of note_ctx in begin_revision().

At end_revision() all node metadata is available in the node_ctx list.
Future's branch detectors can decide what branches are to be changed.
Then, call apply_node() for each of them to actually create a commit
and change/add/delete files according to the node_ctx using the already
added blobs.

This can also be used to create commits if the node metadata does not
come from a svndump, but is stored in e.g. notes, for later branch
detection.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 vcs-svn/svndump.c |  165 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 107 insertions(+), 58 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 2fca9f8..6feedd9 100644
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
 static void free_node_list()
 {
 	struct node_ctx_t *p = node_list, *n;
-	trace_printf("free_node_list head %p tail %p\n", node_list, node_list_tail);
 	while (p) {
 		n = p->next;
 		free_node_ctx(p);
@@ -88,7 +85,6 @@ static void free_node_list()
 
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
+	unsigned char data_sha1[20];
+	struct strbuf sb = STRBUF_INIT;
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
@@ -304,48 +320,81 @@ static void handle_node(struct node_ctx_t *node)
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
+				printf("blob\n");
+				fast_export_data(node->type, node->text_length, &input, data_sha1);
+			}
+			else {
+				printf("blob\n");
+				fast_export_blob_delta(node->type, old_mode, old_data,
+						node->text_length, &input, data_sha1);
+			}
+
+			strbuf_addstr(&sb, sha1_to_hex(data_sha1));
+			node->dataref = sb.buf;
+		}
 	}
-	if (!node->text_delta) {
-		fast_export_modify(node->dst.buf, node->type, "inline");
-		fast_export_data(node->type, node->text_length, &input, NULL);
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
-				node->text_length, &input, NULL);
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
+static void apply_node_list()
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
