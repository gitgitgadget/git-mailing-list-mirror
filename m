From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 16/18] revert: implement parsing TODO and DONE files
Date: Thu, 25 Nov 2010 22:20:47 +0100
Message-ID: <20101125212050.5188.64875.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:56:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrIh-0007NM-MS
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab0KZFzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:55:41 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48042 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509Ab0KZFzk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:55:40 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DD2C3A61B0;
	Fri, 26 Nov 2010 06:55:32 +0100 (CET)
X-git-sha1: 5db28724d964ba7a60ee929ed7f754c023c48dd3 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162198>

From: Stephan Beyer <s-beyer@gmx.net>

The code from this patch comes from the git sequencer Google
Summer of Code 2008 project available here:

http://repo.or.cz/w/git/sbeyer.git

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |  228 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 228 insertions(+), 0 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index fee2e38..ca65b92 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -70,6 +70,234 @@ static const char * const *revert_or_cherry_pick_usage(struct args_info *info)
 	return info->action == REVERT ? revert_usage : cherry_pick_usage;
 }
 
+/*
+ * A structure for a parsed instruction line plus a next pointer
+ * to allow linked list behavior
+ */
+struct parsed_insn {
+	int argc;
+	const char **argv;
+	int line;
+	struct strbuf orig;
+	struct parsed_insn *next;
+};
+
+struct parsed_file {
+	size_t count;
+	size_t total;
+	struct parsed_insn *first;
+	struct parsed_insn *last;
+	struct parsed_insn *cur; /* a versatile helper */
+};
+
+static int parse_line(char *buf, size_t len, int lineno,
+		      struct parsed_insn **line)
+{
+	static int alloc = 0;
+	static struct strbuf arg_sb = STRBUF_INIT;
+	static enum {
+		ST_START,
+		ST_DELIMITER,
+		ST_ARGUMENT,
+		ST_ESCAPE,
+		ST_DOUBLE_QUOTES,
+		ST_DOUBLE_QUOTES_ESCAPE,
+		ST_SINGLE_QUOTES,
+	} state = ST_START;
+	/* The current rules are as follows:
+	 *  1. whitespace at the beginning is ignored
+	 *  2. insn is everything up to next whitespace or EOL
+	 *  3. now whitespace acts as delimiter for arguments,
+	 *     except if written in single or double quotes
+	 *  4. \ acts as escape inside and outside double quotes.
+	 *     Inside double quotes, this is only useful for \".
+	 *     Outside, it is useful for \', \", \\ and \ .
+	 *  5. single quotes do not have an escape character
+	 *  6. abort on "#" (comments)
+	 */
+
+	size_t i, j = 0;
+	struct parsed_insn *ret = *line;
+
+	for (i = 0; i <= len; ++i) {
+		switch (state) {
+		case ST_START:
+			switch (buf[i]) {
+			case ' ':
+			case '\t':
+				continue;
+			case 0:
+			case '#':
+				break;
+			case '\'':
+				j = i+1;
+				state = ST_SINGLE_QUOTES;
+				break;
+			case '"':
+				j = i+1;
+				state = ST_DOUBLE_QUOTES;
+				break;
+			default:
+				j = i;
+				state = ST_ARGUMENT;
+				break;
+			}
+			/* prepare everything */
+			ret = xcalloc(1, sizeof(*ret));
+			ret->line = lineno;
+			strbuf_init(&ret->orig, len+2);
+			if (!buf[i] || buf[i] == '#') /* empty/comment */
+				goto finish;
+			break;
+		case ST_DELIMITER:
+			switch (buf[i]) {
+			case ' ':
+			case '\t':
+				continue;
+			case 0:
+				break;
+			case '\'':
+				j = i+1;
+				state = ST_SINGLE_QUOTES;
+				break;
+			case '"':
+				j = i+1;
+				state = ST_DOUBLE_QUOTES;
+				break;
+			default:
+				j = i;
+				state = ST_ARGUMENT;
+				if (buf[i] == '#') /* a comment */
+					goto finish;
+				break;
+			}
+			/* prepare next argument */
+			ALLOC_GROW(ret->argv, ret->argc + 1, alloc);
+			ret->argv[ret->argc++] = strbuf_detach(&arg_sb, NULL);
+			break;
+		case ST_ARGUMENT:
+			switch (buf[i]) {
+			case ' ':
+			case '\t':
+				strbuf_add(&arg_sb, buf+j, i-j);
+				state = ST_DELIMITER;
+				break;
+			case '"':
+				strbuf_add(&arg_sb, buf+j, i-j);
+				j = i + 1;
+				state = ST_DOUBLE_QUOTES;
+				break;
+			case '\'':
+				strbuf_add(&arg_sb, buf+j, i-j);
+				j = i + 1;
+				state = ST_SINGLE_QUOTES;
+				break;
+			case '\\':
+				strbuf_add(&arg_sb, buf+j, i-j);
+				j = i + 1;
+				state = ST_ESCAPE;
+			default:
+				break;
+			}
+			break;
+		case ST_ESCAPE:
+				state = ST_ARGUMENT;
+			break;
+		case ST_DOUBLE_QUOTES:
+			switch (buf[i]) {
+			case '"':
+				strbuf_add(&arg_sb, buf+j, i-j);
+				j = i + 1;
+				state = ST_ARGUMENT;
+				break;
+			case '\\':
+				strbuf_add(&arg_sb, buf+j, i-j);
+				j = i + 1;
+				state = ST_DOUBLE_QUOTES_ESCAPE;
+				break;
+			default:
+				break;
+			}
+			break;
+		case ST_DOUBLE_QUOTES_ESCAPE:
+			state = ST_DOUBLE_QUOTES;
+			break;
+		case ST_SINGLE_QUOTES:
+			switch (buf[i]) {
+			case '\'':
+				strbuf_add(&arg_sb, buf+j, i-j);
+				j = i + 1;
+				state = ST_ARGUMENT;
+				break;
+			default:
+				break;
+			}
+			break;
+		}
+	}
+finish:
+	*line = ret;
+	switch(state) {
+	case ST_DOUBLE_QUOTES:
+	case ST_DOUBLE_QUOTES_ESCAPE:
+	case ST_SINGLE_QUOTES:
+		strbuf_add(&arg_sb, buf+j, i-j-1);
+		strbuf_add(&arg_sb, "\n", 1);
+		return 1;
+	case ST_ARGUMENT:
+		if (i-j > 1)
+			strbuf_add(&arg_sb, buf+j, i-j-1);
+		ALLOC_GROW(ret->argv, ret->argc + 1, alloc);
+		ret->argv[ret->argc++] = strbuf_detach(&arg_sb, NULL);
+	case ST_DELIMITER:
+		state = ST_START;
+		alloc = 0;
+	default:
+		strbuf_addstr(&ret->orig, buf);
+		strbuf_addch(&ret->orig, '\n');
+		return 0;
+	}
+}
+
+static void add_parsed_line_to_parsed_file(struct parsed_insn *parsed_line,
+					   struct parsed_file *contents)
+{
+	if (!contents->first) {
+		contents->first = parsed_line;
+		contents->last = parsed_line;
+	} else {
+		contents->last->next = parsed_line;
+		contents->last = parsed_line;
+	}
+	if (parsed_line->argv)
+		contents->total++;
+}
+
+/* Parse a file fp; write result into contents */
+static void parse_file(const char *filename, struct parsed_file *contents)
+{
+	struct strbuf str = STRBUF_INIT;
+	struct parsed_insn *parsed_line = NULL;
+	int r = 0;
+	int lineno = 0;
+	FILE *fp = fp = fopen(filename, "r");
+	if (!fp)
+		die_errno("Could not open file '%s'", filename);
+
+	memset(contents, 0, sizeof(*contents));
+
+	while (strbuf_getline(&str, fp, '\n') != EOF) {
+		lineno++;
+		r = parse_line(str.buf, str.len, lineno, &parsed_line);
+		if (!r)
+			add_parsed_line_to_parsed_file(parsed_line, contents);
+	}
+	strbuf_release(&str);
+	fclose(fp);
+	if (r)
+		die("Unexpected end of file.");
+}
+
 static void parse_args(int argc, const char **argv, struct args_info *info)
 {
 	int noop;
-- 
1.7.3.2.504.g59d466
