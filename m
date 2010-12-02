From: David Barr <david.barr@cordelta.com>
Subject: [PATCH] fast-import: add 'ls' command
Date: Thu,  2 Dec 2010 21:40:20 +1100
Message-ID: <1291286420-13591-2-git-send-email-david.barr@cordelta.com>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 02 13:46:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO8YD-0003Zl-JS
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 13:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114Ab0LBMqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 07:46:12 -0500
Received: from fallbackmx08.syd.optusnet.com.au ([211.29.132.10]:34240 "EHLO
	fallbackmx08.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932117Ab0LBMqK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 07:46:10 -0500
Received: from mail09.syd.optusnet.com.au (mail09.syd.optusnet.com.au [211.29.132.190])
	by fallbackmx08.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id oB2Ah9wU029770
	for <git@vger.kernel.org>; Thu, 2 Dec 2010 21:43:09 +1100
Received: from localhost.localdomain (d110-33-95-167.mit3.act.optusnet.com.au [110.33.95.167])
	by mail09.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id oB2Af6XH018562;
	Thu, 2 Dec 2010 21:41:38 +1100
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162700>

There are two forms of the 'ls' command, one that takes a tree-ish and
one relative to the index. Allow the tree-ish variant to be used anywhere
a comment is allowed. Allow the index variant to be used within a commit
where file change commands would be used.

The syntax is as such:

 'ls' SP <dataref> SP path LF

and

 'ls' SP 'index' SP path LF

Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 fast-import.c |  127 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index fbc70cd..854398a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -24,10 +24,12 @@ Format of STDIN stream:
     commit_msg
     ('from' sp committish lf)?
     ('merge' sp committish lf)*
-    file_change*
+    (file_change | ls)*
     lf?;
   commit_msg ::= data;
 
+  ls ::= 'ls' sp 'index' sp path_str lf;
+
   file_change ::= file_clr
     | file_del
     | file_rnm
@@ -132,7 +134,7 @@ Format of STDIN stream:
   ts    ::= # time since the epoch in seconds, ascii base10 notation;
   tz    ::= # GIT style timezone;
 
-     # note: comments and cat requests may appear anywhere
+     # note: comments, ls and cat requests may appear anywhere
      # in the input, except within a data command.  Any form
      # of the data command always escapes the related input
      # from comment processing.
@@ -141,7 +143,9 @@ Format of STDIN stream:
      # must be the first character on that line (an lf
      # preceded it).
      #
+
   cat_blob ::= 'cat-blob' sp (hexsha1 | idnum) lf;
+  ls_tree  ::= 'ls' sp (hexsha1 | idnum) sp path_str lf;
 
   comment ::= '#' not_lf* lf;
   not_lf  ::= # Any byte that is not ASCII newline (LF);
@@ -369,6 +373,7 @@ static int cat_blob_fd = STDOUT_FILENO;
 
 static void parse_argv(void);
 static void parse_cat_blob(void);
+static void parse_ls(struct branch *b);
 
 /* Signal handling */
 static volatile sig_atomic_t checkpoint_requested;
@@ -2607,6 +2612,8 @@ static void parse_new_commit(void)
 			note_change_n(b, prev_fanout);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
+		else if (!prefixcmp(command_buf.buf, "ls "))
+			parse_ls(b);
 		else {
 			unread_command_buf = 1;
 			break;
@@ -2830,6 +2837,120 @@ static void parse_cat_blob(void)
 	cat_blob(oe, sha1);
 }
 
+static struct object_entry *parse_treeish_dataref(const char** r)
+{
+	unsigned char sha1[20];
+	struct object_entry *e;
+
+	if (**r == ':') {
+		char *x;
+		e = find_mark(strtoumax(*r + 1, &x, 10));
+		if (x == *r + 1)
+			die("Invalid mark: %s", command_buf.buf);
+		if (!e)
+			die("Unknown mark: %s", command_buf.buf);
+		*r = x;
+		hashcpy(sha1, e->idx.sha1);
+	} else {
+		if (get_sha1_hex(*r, sha1))
+			die("Invalid SHA1: %s", command_buf.buf);
+		e = find_object(sha1);
+		*r += 40;
+	}
+
+	for (;;) {
+		unsigned long size;
+		void *buf;
+		if (!e) {
+			enum object_type type = sha1_object_info(sha1, NULL);
+			if (type < 0)
+				die("object not found: %s", sha1_to_hex(sha1));
+			e = insert_object(sha1);
+			e->type = type;
+			e->pack_id = MAX_PACK_ID;
+			e->idx.offset = 1;
+		}
+		if (e->type == OBJ_TREE)
+			break;
+
+		if (e->type != OBJ_COMMIT && e->type != OBJ_TAG)
+			die("Not a treeish: %s", command_buf.buf);
+
+		if (e->pack_id != MAX_PACK_ID) {
+			buf = gfi_unpack_entry(e, &size);
+		} else {
+			enum object_type type;
+			buf = read_sha1_file(sha1, &type, &size);
+		}
+		if (!buf)
+			die("Can't load object %s", sha1_to_hex(sha1));
+
+		if (e->type == OBJ_COMMIT) {
+			if (size < 40 + strlen("tree ") ||
+			    get_sha1_hex(buf + strlen("tree "), sha1))
+				die("Invalid SHA1 in commit: %s", command_buf.buf);
+		} else {
+			if (size < 40 + strlen("object ") ||
+			    get_sha1_hex(buf + strlen("object "), sha1))
+				die("Invalid SHA1 in tag: %s", command_buf.buf);
+		}
+		free(buf);
+		e = find_object(sha1);
+	}
+
+	return e;
+}
+
+static void print_ls(int mode, unsigned char *sha1, char *path)
+{
+	enum object_type type;
+	struct strbuf line = STRBUF_INIT;
+	type = sha1_object_info(sha1, NULL);
+	/* mode SP type SP object_name TAB path LF */
+	strbuf_addf(&line, "%o %s %s\t%s\n",
+			mode, typename(type), sha1_to_hex(sha1), path);
+	cat_blob_write(line.buf, line.len);
+	strbuf_release(&line);
+}
+
+static void parse_ls(struct branch *b)
+{
+	const char *p;
+	struct strbuf uq = STRBUF_INIT;
+	struct tree_entry *root = NULL;
+	struct tree_entry leaf = {0};
+
+	/* ls SP <treeish> SP <path> */
+	p = command_buf.buf + strlen("ls ");
+	if(!prefixcmp(p, "index")) {
+		p += strlen("index");
+		if (!b)
+			die("Not in a commit: %s", command_buf.buf);
+		root = &b->branch_tree;
+	} else {
+		struct object_entry *e = parse_treeish_dataref(&p);
+		root = new_tree_entry();
+		hashcpy(root->versions[1].sha1, e->idx.sha1);
+		load_tree(root);
+	}
+	if (*p++ != ' ')
+		die("Missing space after SHA1: %s", command_buf.buf);
+	if (unquote_c_style(&uq, p, &p))
+		die("Invalid path: %s", command_buf.buf);
+	if (*p)
+		die("Garbage after path: %s", command_buf.buf);
+	tree_content_get(root, uq.buf, &leaf);
+	if (!leaf.versions[1].mode)
+		die("Path %s not in branch", uq.buf);
+	/* Allow new trees to be listed. */
+	if (S_ISDIR(leaf.versions[1].mode))
+		store_tree(&leaf);
+	print_ls(leaf.versions[1].mode, leaf.versions[1].sha1, uq.buf);
+	strbuf_release(&uq);
+	if (!b || root != &b->branch_tree)
+		release_tree_entry(root);
+}
+
 static void checkpoint(void)
 {
 	checkpoint_requested = 0;
@@ -3128,6 +3249,8 @@ int main(int argc, const char **argv)
 	while (read_next_command() != EOF) {
 		if (!strcmp("blob", command_buf.buf))
 			parse_new_blob();
+		else if (!prefixcmp(command_buf.buf, "ls "))
+			parse_ls(NULL);
 		else if (!prefixcmp(command_buf.buf, "commit "))
 			parse_new_commit();
 		else if (!prefixcmp(command_buf.buf, "tag "))
-- 
1.7.3
