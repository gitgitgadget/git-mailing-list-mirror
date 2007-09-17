From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/3] Drop strbuf's 'eof' marker, and make read_line a first class citizen.
Date: Mon, 17 Sep 2007 11:19:04 +0200
Message-ID: <20070917125257.1BF16344A4A@madism.org>
References: <20070917125211.GA18176@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:53:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXG65-0004d1-0R
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 14:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbXIQMxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 08:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbXIQMw7
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 08:52:59 -0400
Received: from pan.madism.org ([88.191.52.104]:43267 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbXIQMw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 08:52:58 -0400
Received: from madism.org (beacon-free2.intersec.com [82.236.12.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8105A6AB;
	Mon, 17 Sep 2007 14:52:57 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1BF16344A4A; Mon, 17 Sep 2007 14:52:57 +0200 (CEST)
In-Reply-To: <20070917125211.GA18176@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58434>

read_line is now strbuf_getline, and is a first class citizen, it returns 0
when reading a line worked, EOF else.

The ->eof marker was used non-locally by fast-import.c, mimic the same
behaviour using a static int in "read_next_command", that now returns -1 on
EOF, and avoids to call strbuf_getline when it's in EOF state.

Also no longer automagically strbuf_release the buffer, it's counter
intuitive and breaks fast-import in a very subtle way.

Note: being at EOF implies that command_buf.len == 0.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-checkout-index.c |    5 ++---
 builtin-update-index.c   |    8 ++++----
 fast-import.c            |   34 +++++++++++++++++++---------------
 fetch.c                  |    4 ++--
 mktree.c                 |    4 ++--
 strbuf.c                 |   20 ++++++++------------
 strbuf.h                 |    5 ++---
 7 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 85e8efe..a18ecc4 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -277,9 +277,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		while (1) {
 			char *path_name;
 			const char *p;
-
-			read_line(&buf, stdin, line_termination);
-			if (buf.eof)
+			if (strbuf_getline(&buf, stdin, line_termination) == EOF)
 				break;
 			if (line_termination && buf.buf[0] == '"')
 				path_name = unquote_c_style(buf.buf, NULL);
@@ -292,6 +290,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			if (path_name != buf.buf)
 				free(path_name);
 		}
+		strbuf_release(&buf);
 	}
 
 	if (all)
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 0b60513..acd5ab5 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -320,8 +320,7 @@ static void read_index_info(int line_termination)
 		 * This format is to put higher order stages into the
 		 * index file and matches git-ls-files --stage output.
 		 */
-		read_line(&buf, stdin, line_termination);
-		if (buf.eof)
+		if (strbuf_getline(&buf, stdin, line_termination) == EOF)
 			break;
 
 		errno = 0;
@@ -383,6 +382,7 @@ static void read_index_info(int line_termination)
 	bad_line:
 		die("malformed index info %s", buf.buf);
 	}
+	strbuf_release(&buf);
 }
 
 static const char update_index_usage[] =
@@ -710,8 +710,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		while (1) {
 			char *path_name;
 			const char *p;
-			read_line(&buf, stdin, line_termination);
-			if (buf.eof)
+			if (strbuf_getline(&buf, stdin, line_termination) == EOF)
 				break;
 			if (line_termination && buf.buf[0] == '"')
 				path_name = unquote_c_style(buf.buf, NULL);
@@ -726,6 +725,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			if (path_name != buf.buf)
 				free(path_name);
 		}
+		strbuf_release(&buf);
 	}
 
  finish:
diff --git a/fast-import.c b/fast-import.c
index 1866d34..da04566 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1584,20 +1584,25 @@ static void dump_marks(void)
 			mark_file, strerror(errno));
 }
 
-static void read_next_command(void)
+static int read_next_command(void)
 {
+	static int stdin_eof = 0;
+
+	if (stdin_eof) {
+		unread_command_buf = 0;
+		return EOF;
+	}
+
 	do {
 		if (unread_command_buf) {
 			unread_command_buf = 0;
-			if (command_buf.eof)
-				return;
 		} else {
 			struct recent_command *rc;
 
 			strbuf_detach(&command_buf);
-			read_line(&command_buf, stdin, '\n');
-			if (command_buf.eof)
-				return;
+			stdin_eof = strbuf_getline(&command_buf, stdin, '\n');
+			if (stdin_eof)
+				return EOF;
 
 			rc = rc_free;
 			if (rc)
@@ -1616,6 +1621,8 @@ static void read_next_command(void)
 			cmd_tail = rc;
 		}
 	} while (command_buf.buf[0] == '#');
+
+	return 0;
 }
 
 static void skip_optional_lf(void)
@@ -1648,8 +1655,7 @@ static void *cmd_data (size_t *size)
 		size_t term_len = command_buf.len - 5 - 2;
 
 		for (;;) {
-			read_line(&command_buf, stdin, '\n');
-			if (command_buf.eof)
+			if (strbuf_getline(&command_buf, stdin, '\n') == EOF)
 				die("EOF in data (terminator '%s' not found)", term);
 			if (term_len == command_buf.len
 				&& !strcmp(term, command_buf.buf))
@@ -2095,7 +2101,7 @@ static void cmd_new_commit(void)
 	}
 
 	/* file_change* */
-	while (!command_buf.eof && command_buf.len > 0) {
+	while (command_buf.len > 0) {
 		if (!prefixcmp(command_buf.buf, "M "))
 			file_change_m(b);
 		else if (!prefixcmp(command_buf.buf, "D "))
@@ -2110,7 +2116,8 @@ static void cmd_new_commit(void)
 			unread_command_buf = 1;
 			break;
 		}
-		read_next_command();
+		if (read_next_command() == EOF)
+			break;
 	}
 
 	/* build the tree and the commit */
@@ -2375,11 +2382,8 @@ int main(int argc, const char **argv)
 	prepare_packed_git();
 	start_packfile();
 	set_die_routine(die_nicely);
-	for (;;) {
-		read_next_command();
-		if (command_buf.eof)
-			break;
-		else if (!strcmp("blob", command_buf.buf))
+	while (read_next_command() != EOF) {
+		if (!strcmp("blob", command_buf.buf))
 			cmd_new_blob();
 		else if (!prefixcmp(command_buf.buf, "commit "))
 			cmd_new_commit();
diff --git a/fetch.c b/fetch.c
index c256e6f..b1c1f07 100644
--- a/fetch.c
+++ b/fetch.c
@@ -222,8 +222,7 @@ int pull_targets_stdin(char ***target, const char ***write_ref)
 		char *rf_one = NULL;
 		char *tg_one;
 
-		read_line(&buf, stdin, '\n');
-		if (buf.eof)
+		if (strbuf_getline(&buf, stdin, '\n') == EOF)
 			break;
 		tg_one = buf.buf;
 		rf_one = strchr(tg_one, '\t');
@@ -239,6 +238,7 @@ int pull_targets_stdin(char ***target, const char ***write_ref)
 		(*write_ref)[targets] = rf_one ? xstrdup(rf_one) : NULL;
 		targets++;
 	}
+	strbuf_release(&buf);
 	return targets;
 }
 
diff --git a/mktree.c b/mktree.c
index 5dab4bd..9c137de 100644
--- a/mktree.c
+++ b/mktree.c
@@ -88,8 +88,7 @@ int main(int ac, char **av)
 		enum object_type type;
 		char *path;
 
-		read_line(&sb, stdin, line_termination);
-		if (sb.eof)
+		if (strbuf_getline(&sb, stdin, line_termination) == EOF)
 			break;
 		ptr = sb.buf;
 		/* Input is non-recursive ls-tree output format
@@ -121,6 +120,7 @@ int main(int ac, char **av)
 		if (path != ntr)
 			free(path);
 	}
+	strbuf_release(&sb);
 	write_tree(sha1);
 	puts(sha1_to_hex(sha1));
 	exit(0);
diff --git a/strbuf.c b/strbuf.c
index c5f9e2a..59383ac 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -17,7 +17,6 @@ void strbuf_reset(struct strbuf *sb)
 {
 	if (sb->len)
 		strbuf_setlen(sb, 0);
-	sb->eof = 0;
 }
 
 char *strbuf_detach(struct strbuf *sb)
@@ -145,14 +144,13 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 	return sb->len - oldlen;
 }
 
-void read_line(struct strbuf *sb, FILE *fp, int term)
+int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 {
 	int ch;
-	if (feof(fp)) {
-		strbuf_release(sb);
-		sb->eof = 1;
-		return;
-	}
+
+	strbuf_grow(sb, 0);
+	if (feof(fp))
+		return EOF;
 
 	strbuf_reset(sb);
 	while ((ch = fgetc(fp)) != EOF) {
@@ -161,11 +159,9 @@ void read_line(struct strbuf *sb, FILE *fp, int term)
 		strbuf_grow(sb, 1);
 		sb->buf[sb->len++] = ch;
 	}
-	if (ch == EOF && sb->len == 0) {
-		strbuf_release(sb);
-		sb->eof = 1;
-	}
+	if (ch == EOF && sb->len == 0)
+		return EOF;
 
-	strbuf_grow(sb, 1);
 	sb->buf[sb->len] = '\0';
+	return 0;
 }
diff --git a/strbuf.h b/strbuf.h
index f163c63..b2cbd97 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -44,11 +44,10 @@
 struct strbuf {
 	size_t alloc;
 	size_t len;
-	int eof;
 	char *buf;
 };
 
-#define STRBUF_INIT  { 0, 0, 0, NULL }
+#define STRBUF_INIT  { 0, 0, NULL }
 
 /*----- strbuf life cycle -----*/
 extern void strbuf_init(struct strbuf *, size_t);
@@ -101,6 +100,6 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 
-extern void read_line(struct strbuf *, FILE *, int);
+extern int strbuf_getline(struct strbuf *, FILE *, int);
 
 #endif /* STRBUF_H */
-- 
1.5.3.1
