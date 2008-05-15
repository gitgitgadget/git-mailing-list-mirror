From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-fast-import: rename cmd_*() functions to parse_*()
Date: Fri, 16 May 2008 00:35:56 +0200
Message-ID: <1210890956-24068-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:36:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwm47-0005V6-AQ
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 00:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902AbYEOWf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 18:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756207AbYEOWf5
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 18:35:57 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:51707 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759759AbYEOWf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 18:35:56 -0400
Received: from vmobile.example.net (dsl5401C014.pool.t-online.hu [84.1.192.20])
	by yugo.frugalware.org (Postfix) with ESMTP id 4852B1DDC5B;
	Fri, 16 May 2008 00:35:54 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D7AB7185E19; Fri, 16 May 2008 00:35:56 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82236>

There is a cmd_merge() function in fast-import that will conflict with
builtin-merge's cmd_merge() function. To keep it consistent, rename all
cmd_*() function to parse_*()

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I originally just wanted to rename cmd_merge() but Shawn suggested that
then renaming all functions and keeping consistency is a better
approach, so here it is.

 fast-import.c |   62 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 73e5439..caea684 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1690,7 +1690,7 @@ static void skip_optional_lf(void)
 		ungetc(term_char, stdin);
 }
 
-static void cmd_mark(void)
+static void parse_mark(void)
 {
 	if (!prefixcmp(command_buf.buf, "mark :")) {
 		next_mark = strtoumax(command_buf.buf + 6, NULL, 10);
@@ -1700,7 +1700,7 @@ static void cmd_mark(void)
 		next_mark = 0;
 }
 
-static void cmd_data(struct strbuf *sb)
+static void parse_data(struct strbuf *sb)
 {
 	strbuf_reset(sb);
 
@@ -1798,13 +1798,13 @@ static char *parse_ident(const char *buf)
 	return ident;
 }
 
-static void cmd_new_blob(void)
+static void parse_new_blob(void)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
 	read_next_command();
-	cmd_mark();
-	cmd_data(&buf);
+	parse_mark();
+	parse_data(&buf);
 	store_object(OBJ_BLOB, &buf, &last_blob, NULL, next_mark);
 }
 
@@ -1908,7 +1908,7 @@ static void file_change_m(struct branch *b)
 			p = uq.buf;
 		}
 		read_next_command();
-		cmd_data(&buf);
+		parse_data(&buf);
 		store_object(OBJ_BLOB, &buf, &last_blob, sha1, 0);
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
@@ -1995,7 +1995,7 @@ static void file_change_deleteall(struct branch *b)
 	load_tree(&b->branch_tree);
 }
 
-static void cmd_from_commit(struct branch *b, char *buf, unsigned long size)
+static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
 {
 	if (!buf || size < 46)
 		die("Not a valid commit: %s", sha1_to_hex(b->sha1));
@@ -2006,7 +2006,7 @@ static void cmd_from_commit(struct branch *b, char *buf, unsigned long size)
 		b->branch_tree.versions[1].sha1);
 }
 
-static void cmd_from_existing(struct branch *b)
+static void parse_from_existing(struct branch *b)
 {
 	if (is_null_sha1(b->sha1)) {
 		hashclr(b->branch_tree.versions[0].sha1);
@@ -2017,12 +2017,12 @@ static void cmd_from_existing(struct branch *b)
 
 		buf = read_object_with_reference(b->sha1,
 			commit_type, &size, b->sha1);
-		cmd_from_commit(b, buf, size);
+		parse_from_commit(b, buf, size);
 		free(buf);
 	}
 }
 
-static int cmd_from(struct branch *b)
+static int parse_from(struct branch *b)
 {
 	const char *from;
 	struct branch *s;
@@ -2053,12 +2053,12 @@ static int cmd_from(struct branch *b)
 		if (oe->pack_id != MAX_PACK_ID) {
 			unsigned long size;
 			char *buf = gfi_unpack_entry(oe, &size);
-			cmd_from_commit(b, buf, size);
+			parse_from_commit(b, buf, size);
 			free(buf);
 		} else
-			cmd_from_existing(b);
+			parse_from_existing(b);
 	} else if (!get_sha1(from, b->sha1))
-		cmd_from_existing(b);
+		parse_from_existing(b);
 	else
 		die("Invalid ref name or SHA1 expression: %s", from);
 
@@ -2066,7 +2066,7 @@ static int cmd_from(struct branch *b)
 	return 1;
 }
 
-static struct hash_list *cmd_merge(unsigned int *count)
+static struct hash_list *parse_merge(unsigned int *count)
 {
 	struct hash_list *list = NULL, *n, *e = e;
 	const char *from;
@@ -2107,7 +2107,7 @@ static struct hash_list *cmd_merge(unsigned int *count)
 	return list;
 }
 
-static void cmd_new_commit(void)
+static void parse_new_commit(void)
 {
 	static struct strbuf msg = STRBUF_INIT;
 	struct branch *b;
@@ -2124,7 +2124,7 @@ static void cmd_new_commit(void)
 		b = new_branch(sp);
 
 	read_next_command();
-	cmd_mark();
+	parse_mark();
 	if (!prefixcmp(command_buf.buf, "author ")) {
 		author = parse_ident(command_buf.buf + 7);
 		read_next_command();
@@ -2135,10 +2135,10 @@ static void cmd_new_commit(void)
 	}
 	if (!committer)
 		die("Expected committer but didn't get one");
-	cmd_data(&msg);
+	parse_data(&msg);
 	read_next_command();
-	cmd_from(b);
-	merge_list = cmd_merge(&merge_count);
+	parse_from(b);
+	merge_list = parse_merge(&merge_count);
 
 	/* ensure the branch is active/loaded */
 	if (!b->branch_tree.tree || !max_active_branches) {
@@ -2196,7 +2196,7 @@ static void cmd_new_commit(void)
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
 
-static void cmd_new_tag(void)
+static void parse_new_tag(void)
 {
 	static struct strbuf msg = STRBUF_INIT;
 	char *sp;
@@ -2253,7 +2253,7 @@ static void cmd_new_tag(void)
 
 	/* tag payload/message */
 	read_next_command();
-	cmd_data(&msg);
+	parse_data(&msg);
 
 	/* build the tag object */
 	strbuf_reset(&new_data);
@@ -2273,7 +2273,7 @@ static void cmd_new_tag(void)
 		t->pack_id = pack_id;
 }
 
-static void cmd_reset_branch(void)
+static void parse_reset_branch(void)
 {
 	struct branch *b;
 	char *sp;
@@ -2293,12 +2293,12 @@ static void cmd_reset_branch(void)
 	else
 		b = new_branch(sp);
 	read_next_command();
-	cmd_from(b);
+	parse_from(b);
 	if (command_buf.len > 0)
 		unread_command_buf = 1;
 }
 
-static void cmd_checkpoint(void)
+static void parse_checkpoint(void)
 {
 	if (object_count) {
 		cycle_packfile();
@@ -2309,7 +2309,7 @@ static void cmd_checkpoint(void)
 	skip_optional_lf();
 }
 
-static void cmd_progress(void)
+static void parse_progress(void)
 {
 	fwrite(command_buf.buf, 1, command_buf.len, stdout);
 	fputc('\n', stdout);
@@ -2449,17 +2449,17 @@ int main(int argc, const char **argv)
 	set_die_routine(die_nicely);
 	while (read_next_command() != EOF) {
 		if (!strcmp("blob", command_buf.buf))
-			cmd_new_blob();
+			parse_new_blob();
 		else if (!prefixcmp(command_buf.buf, "commit "))
-			cmd_new_commit();
+			parse_new_commit();
 		else if (!prefixcmp(command_buf.buf, "tag "))
-			cmd_new_tag();
+			parse_new_tag();
 		else if (!prefixcmp(command_buf.buf, "reset "))
-			cmd_reset_branch();
+			parse_reset_branch();
 		else if (!strcmp("checkpoint", command_buf.buf))
-			cmd_checkpoint();
+			parse_checkpoint();
 		else if (!prefixcmp(command_buf.buf, "progress "))
-			cmd_progress();
+			parse_progress();
 		else
 			die("Unsupported command: %s", command_buf.buf);
 	}
-- 
1.5.5.1.211.g65ea3.dirty
