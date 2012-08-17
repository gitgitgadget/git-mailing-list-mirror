From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 3/5] vcs-svn/svndump: restructure node_ctx, rev_ctx handling
Date: Fri, 17 Aug 2012 22:40:08 +0200
Message-ID: <1345236010-1648-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345236010-1648-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345236010-1648-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:41:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2TLv-0006qS-LQ
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509Ab2HQUk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:40:56 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57580 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464Ab2HQUka (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:40:30 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3671472wgb.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2LtqD+fn9ZVRwlRDbyv8nsFNdDwI//Dm/x4Gb7KaUns=;
        b=Kwf8TQKdHJwrOjrykfaLS9RR4VlgS49cV3JholWwGhbImLMQtaumSYAtoeSrA6Dipg
         wly2EESpSqhrAhBAC8BXMZOccI4vk+vNNU4gnkLYIcBdZM+J38dOM5BXnDfMV/78sUob
         X3qw0ipuycdtPq1QD1W6bmqO3goW7lU4QzdCy+llZIWAX4WnS+Zz2AS7r7GU9pMIe0S3
         0FcYsInznfTvjvpUoNb3g6GIEeKJ6bEB+9LzKrc6PcqQpuJavfSQOLhTAKMCpFQxxp+q
         VrxM/2qPPvspBh96ZEZX8NQ5nf0FPYFKkPIoMi4J9UM8AgEWosHvkM2uMk/b117FCXib
         4akw==
Received: by 10.216.122.203 with SMTP id t53mr3422057weh.5.1345236029991;
        Fri, 17 Aug 2012 13:40:29 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id b7sm17480686wiz.9.2012.08.17.13.40.28
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:40:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345236010-1648-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203662>

As a preparation for handling branches in svndumps, make rev_ctx
and node_ctx more flexible.

Add the object to work on to the arguments of reset_*_ctx() and to
handle_node() to allow for multiple *_ctx objects.

Convert the static global node_ctx to a linked list ofsuch objects
to be able to accumulate all Node data of a revision in memory
before processing it.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 vcs-svn/svndump.c |  207 +++++++++++++++++++++++++++++++----------------------
 vcs-svn/svndump.h |    2 +
 2 files changed, 124 insertions(+), 85 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 296be8c..2fca9f8 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -38,42 +38,81 @@
 
 static struct line_buffer input = LINE_BUFFER_INIT;
 
-static struct node_ctx_t node_ctx;
+static struct node_ctx_t *node_ctx;
 static struct rev_ctx_t rev_ctx;
 static struct dump_ctx_t dump_ctx;
+static const char *current_ref;
 
+static struct node_ctx_t *node_list, *node_list_tail;
 
-static void reset_node_ctx(char *fname)
+static struct node_ctx_t *new_node_ctx(char *fname)
 {
-	node_ctx.type = 0;
-	node_ctx.action = NODEACT_UNKNOWN;
-	node_ctx.prop_length = -1;
-	node_ctx.text_length = -1;
-	strbuf_reset(&node_ctx.src);
-	node_ctx.srcRev = 0;
-	strbuf_reset(&node_ctx.dst);
+	struct node_ctx_t *node = xmalloc(sizeof(struct node_ctx_t));
+	trace_printf("new_node_ctx %p\n", node);
+	node->type = 0;
+	node->action = NODEACT_UNKNOWN;
+	node->prop_length = -1;
+	node->text_length = -1;
+	strbuf_init(&node->src, 4096);
+	node->srcRev = 0;
+	strbuf_init(&node->dst, 4096);
 	if (fname)
-		strbuf_addstr(&node_ctx.dst, fname);
-	node_ctx.text_delta = 0;
-	node_ctx.prop_delta = 0;
+		strbuf_addstr(&node->dst, fname);
+	node->text_delta = 0;
+	node->prop_delta = 0;
+	node->dataref = NULL;
+	node->next = NULL;
+	return node;
 }
 
-static void reset_rev_ctx(uint32_t revision)
+static void free_node_ctx(struct node_ctx_t *node)
 {
-	rev_ctx.revision = revision;
-	rev_ctx.timestamp = 0;
-	strbuf_reset(&rev_ctx.log);
-	strbuf_reset(&rev_ctx.author);
-	strbuf_reset(&rev_ctx.note);
+	trace_printf("free_node_ctx %p\n", node);
+	strbuf_release(&node->src);
+	strbuf_release(&node->dst);
+	free((char*)node->dataref);
+	free(node);
 }
 
-static void reset_dump_ctx(const char *url)
+static void free_node_list()
 {
-	strbuf_reset(&dump_ctx.url);
+	struct node_ctx_t *p = node_list, *n;
+	trace_printf("free_node_list head %p tail %p\n", node_list, node_list_tail);
+	while (p) {
+		n = p->next;
+		free_node_ctx(p);
+		p = n;
+	}
+	node_list = node_list_tail = NULL;
+}
+
+static void append_node_list(struct node_ctx_t *n)
+{
+	trace_printf("append_node_list %p head %p tail %p\n", n, node_list, node_list_tail);
+	if (!node_list)
+		node_list = node_list_tail = n;
+	else {
+		node_list_tail->next = n;
+		node_list_tail = n;
+	}
+}
+
+static void reset_rev_ctx(struct rev_ctx_t *rev, uint32_t revision)
+{
+	rev->revision = revision;
+	rev->timestamp = 0;
+	strbuf_reset(&rev->log);
+	strbuf_reset(&rev->author);
+	strbuf_reset(&rev->note);
+}
+
+static void reset_dump_ctx(struct dump_ctx_t *dump, const char *url)
+{
+	strbuf_reset(&dump->url);
 	if (url)
-		strbuf_addstr(&dump_ctx.url, url);
-	dump_ctx.version = 1;
-	strbuf_reset(&dump_ctx.uuid);
+		strbuf_addstr(&dump->url, url);
+	dump->version = 1;
+	strbuf_reset(&dump->uuid);
 }
 
 static void handle_property(const struct strbuf *key_buf,
@@ -121,11 +160,11 @@ static void handle_property(const struct strbuf *key_buf,
 			die("invalid dump: sets type twice");
 		}
 		if (!val) {
-			node_ctx.type = REPO_MODE_BLB;
+			node_ctx->type = REPO_MODE_BLB;
 			return;
 		}
 		*type_set = 1;
-		node_ctx.type = keylen == strlen("svn:executable") ?
+		node_ctx->type = keylen == strlen("svn:executable") ?
 				REPO_MODE_EXE :
 				REPO_MODE_LNK;
 	}
@@ -193,11 +232,11 @@ static void read_props(void)
 	}
 }
 
-static void handle_node(void)
+static void handle_node(struct node_ctx_t *node)
 {
-	const uint32_t type = node_ctx.type;
-	const int have_props = node_ctx.prop_length != -1;
-	const int have_text = node_ctx.text_length != -1;
+	const uint32_t type = node->type;
+	const int have_props = node->prop_length != -1;
+	const int have_text = node->text_length != -1;
 	/*
 	 * Old text for this node:
 	 *  NULL	- directory or bug
@@ -208,21 +247,21 @@ static void handle_node(void)
 	const char *old_data = NULL;
 	uint32_t old_mode = REPO_MODE_BLB;
 
-	if (node_ctx.action == NODEACT_DELETE) {
-		if (have_text || have_props || node_ctx.srcRev)
+	if (node->action == NODEACT_DELETE) {
+		if (have_text || have_props || node->srcRev)
 			die("invalid dump: deletion node has "
 				"copyfrom info, text, or properties");
-		repo_delete(node_ctx.dst.buf);
+		repo_delete(node->dst.buf);
 		return;
 	}
-	if (node_ctx.action == NODEACT_REPLACE) {
-		repo_delete(node_ctx.dst.buf);
-		node_ctx.action = NODEACT_ADD;
+	if (node->action == NODEACT_REPLACE) {
+		repo_delete(node->dst.buf);
+		node->action = NODEACT_ADD;
 	}
-	if (node_ctx.srcRev) {
-		repo_copy(node_ctx.srcRev, node_ctx.src.buf, node_ctx.dst.buf);
-		if (node_ctx.action == NODEACT_ADD)
-			node_ctx.action = NODEACT_CHANGE;
+	if (node->srcRev) {
+		repo_copy(node->srcRev, node->src.buf, node->dst.buf);
+		if (node->action == NODEACT_ADD)
+			node->action = NODEACT_CHANGE;
 	}
 	if (have_text && type == REPO_MODE_DIR)
 		die("invalid dump: directories cannot have text attached");
@@ -230,20 +269,20 @@ static void handle_node(void)
 	/*
 	 * Find old content (old_data) and decide on the new mode.
 	 */
-	if (node_ctx.action == NODEACT_CHANGE && !*node_ctx.dst.buf) {
+	if (node->action == NODEACT_CHANGE && !*node->dst.buf) {
 		if (type != REPO_MODE_DIR)
 			die("invalid dump: root of tree is not a regular file");
 		old_data = NULL;
-	} else if (node_ctx.action == NODEACT_CHANGE) {
+	} else if (node->action == NODEACT_CHANGE) {
 		uint32_t mode;
-		old_data = repo_read_path(node_ctx.dst.buf, &mode);
+		old_data = repo_read_path(node->dst.buf, &mode); /* malloced buffer */
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
 			die("invalid dump: cannot modify a directory into a file");
 		if (mode != REPO_MODE_DIR && type == REPO_MODE_DIR)
 			die("invalid dump: cannot modify a file into a directory");
-		node_ctx.type = mode;
+		node->type = mode;
 		old_mode = mode;
-	} else if (node_ctx.action == NODEACT_ADD) {
+	} else if (node->action == NODEACT_ADD) {
 		if (type == REPO_MODE_DIR)
 			old_data = NULL;
 		else if (have_text)
@@ -258,9 +297,9 @@ static void handle_node(void)
 	 * Adjust mode to reflect properties.
 	 */
 	if (have_props) {
-		if (!node_ctx.prop_delta)
-			node_ctx.type = type;
-		if (node_ctx.prop_length)
+		if (!node->prop_delta)
+			node->type = type;
+		if (node->prop_length)
 			read_props();
 	}
 
@@ -274,17 +313,17 @@ static void handle_node(void)
 		/* For the fast_export_* functions, NULL means empty. */
 		old_data = NULL;
 	if (!have_text) {
-		fast_export_modify(node_ctx.dst.buf, node_ctx.type, old_data);
+		fast_export_modify(node->dst.buf, node->type, old_data);
 		return;
 	}
-	if (!node_ctx.text_delta) {
-		fast_export_modify(node_ctx.dst.buf, node_ctx.type, "inline");
-		fast_export_data(node_ctx.type, node_ctx.text_length, &input, NULL);
+	if (!node->text_delta) {
+		fast_export_modify(node->dst.buf, node->type, "inline");
+		fast_export_data(node->type, node->text_length, &input, NULL);
 		return;
 	}
-	fast_export_modify(node_ctx.dst.buf, node_ctx.type, "inline");
-	fast_export_blob_delta(node_ctx.type, old_mode, old_data,
-				node_ctx.text_length, &input, NULL);
+	fast_export_modify(node->dst.buf, node->type, "inline");
+	fast_export_blob_delta(node->type, old_mode, old_data,
+				node->text_length, &input, NULL);
 }
 
 static void begin_revision(const char *remote_ref)
@@ -316,7 +355,7 @@ void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 	uint32_t active_ctx = DUMP_CTX;
 	uint32_t len;
 
-	reset_dump_ctx(url);
+	reset_dump_ctx(&dump_ctx, url);
 	while ((t = buffer_read_line(&input))) {
 		val = strchr(t, ':');
 		if (!val)
@@ -346,13 +385,13 @@ void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 			if (constcmp(t, "Revision-number"))
 				continue;
 			if (active_ctx == NODE_CTX)
-				handle_node();
+				handle_node(node_ctx);
 			if (active_ctx == REV_CTX)
 				begin_revision(local_ref);
 			if (active_ctx != DUMP_CTX)
 				end_revision(notes_ref);
 			active_ctx = REV_CTX;
-			reset_rev_ctx(atoi(val));
+			reset_rev_ctx(&rev_ctx, atoi(val));
 			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			break;
 		case sizeof("Node-path"):
@@ -360,11 +399,11 @@ void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 				continue;
 			if (!constcmp(t + strlen("Node-"), "path")) {
 				if (active_ctx == NODE_CTX)
-					handle_node();
+					handle_node(node_ctx);
 				if (active_ctx == REV_CTX)
 					begin_revision(local_ref);
 				active_ctx = NODE_CTX;
-				reset_node_ctx(val);
+				node_ctx = new_node_ctx(val);
 				strbuf_addf(&rev_ctx.note, "%s\n", t);
 				break;
 			}
@@ -372,9 +411,9 @@ void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 				continue;
 			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			if (!strcmp(val, "dir"))
-				node_ctx.type = REPO_MODE_DIR;
+				node_ctx->type = REPO_MODE_DIR;
 			else if (!strcmp(val, "file"))
-				node_ctx.type = REPO_MODE_BLB;
+				node_ctx->type = REPO_MODE_BLB;
 			else
 				fprintf(stderr, "Unknown node-kind: %s\n", val);
 			break;
@@ -383,29 +422,29 @@ void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 				continue;
 			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			if (!strcmp(val, "delete")) {
-				node_ctx.action = NODEACT_DELETE;
+				node_ctx->action = NODEACT_DELETE;
 			} else if (!strcmp(val, "add")) {
-				node_ctx.action = NODEACT_ADD;
+				node_ctx->action = NODEACT_ADD;
 			} else if (!strcmp(val, "change")) {
-				node_ctx.action = NODEACT_CHANGE;
+				node_ctx->action = NODEACT_CHANGE;
 			} else if (!strcmp(val, "replace")) {
-				node_ctx.action = NODEACT_REPLACE;
+				node_ctx->action = NODEACT_REPLACE;
 			} else {
 				fprintf(stderr, "Unknown node-action: %s\n", val);
-				node_ctx.action = NODEACT_UNKNOWN;
+				node_ctx->action = NODEACT_UNKNOWN;
 			}
 			break;
 		case sizeof("Node-copyfrom-path"):
 			if (constcmp(t, "Node-copyfrom-path"))
 				continue;
-			strbuf_reset(&node_ctx.src);
-			strbuf_addstr(&node_ctx.src, val);
+			strbuf_reset(&node_ctx->src);
+			strbuf_addstr(&node_ctx->src, val);
 			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			break;
 		case sizeof("Node-copyfrom-rev"):
 			if (constcmp(t, "Node-copyfrom-rev"))
 				continue;
-			node_ctx.srcRev = atoi(val);
+			node_ctx->srcRev = atoi(val);
 			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			break;
 		case sizeof("Text-content-length"):
@@ -424,19 +463,19 @@ void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 					die("unrepresentable length in dump: %s", val);
 
 				if (*t == 'T')
-					node_ctx.text_length = (off_t) len;
+					node_ctx->text_length = (off_t) len;
 				else
-					node_ctx.prop_length = (off_t) len;
+					node_ctx->prop_length = (off_t) len;
 				break;
 			}
 		case sizeof("Text-delta"):
 			if (!constcmp(t, "Text-delta")) {
-				node_ctx.text_delta = !strcmp(val, "true");
+				node_ctx->text_delta = !strcmp(val, "true");
 				break;
 			}
 			if (constcmp(t, "Prop-delta"))
 				continue;
-			node_ctx.prop_delta = !strcmp(val, "true");
+			node_ctx->prop_delta = !strcmp(val, "true");
 			break;
 		case sizeof("Content-length"):
 			if (constcmp(t, "Content-length"))
@@ -450,7 +489,7 @@ void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 			if (active_ctx == REV_CTX) {
 				read_props();
 			} else if (active_ctx == NODE_CTX) {
-				handle_node();
+				handle_node(node_ctx);
 				active_ctx = INTERNODE_CTX;
 			} else {
 				fprintf(stderr, "Unexpected content length header: %"PRIu32"\n", len);
@@ -462,7 +501,7 @@ void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 	if (buffer_ferror(&input))
 		die_short_read();
 	if (active_ctx == NODE_CTX)
-		handle_node();
+		handle_node(node_ctx);
 	if (active_ctx == REV_CTX)
 		begin_revision(local_ref);
 	if (active_ctx != DUMP_CTX)
@@ -477,11 +516,10 @@ static void init(int report_fd)
 	strbuf_init(&rev_ctx.log, 4096);
 	strbuf_init(&rev_ctx.author, 4096);
 	strbuf_init(&rev_ctx.note, 4096);
-	strbuf_init(&node_ctx.src, 4096);
-	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(NULL);
-	reset_rev_ctx(0);
-	reset_node_ctx(NULL);
+	reset_dump_ctx(&dump_ctx, NULL);
+	reset_rev_ctx(&rev_ctx, 0);
+	node_ctx = new_node_ctx(NULL);
+	node_list = node_list_tail = NULL;
 	return;
 }
 
@@ -504,14 +542,12 @@ int svndump_init_fd(int in_fd, int back_fd)
 void svndump_deinit(void)
 {
 	fast_export_deinit();
-	reset_dump_ctx(NULL);
-	reset_rev_ctx(0);
-	reset_node_ctx(NULL);
+	reset_dump_ctx(&dump_ctx, NULL);
+	reset_rev_ctx(&rev_ctx, 0);
 	strbuf_release(&rev_ctx.log);
 	strbuf_release(&rev_ctx.author);
 	strbuf_release(&rev_ctx.note);
-	strbuf_release(&node_ctx.src);
-	strbuf_release(&node_ctx.dst);
+	free_node_list();
 	if (buffer_deinit(&input))
 		fprintf(stderr, "Input error\n");
 	if (ferror(stdout))
@@ -524,4 +560,5 @@ void svndump_reset(void)
 	strbuf_release(&dump_ctx.url);
 	strbuf_release(&rev_ctx.log);
 	strbuf_release(&rev_ctx.author);
+	free_node_list();
 }
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index d545453..29794df 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -13,6 +13,8 @@ struct node_ctx_t {
 	off_t prop_length, text_length;
 	struct strbuf src, dst;
 	uint32_t text_delta, prop_delta;
+	const char *dataref;
+	struct node_ctx_t *next;
 };
 
 struct rev_ctx_t {
-- 
1.7.9.5
