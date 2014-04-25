From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v11 05/11] trailer: parse trailers from file or stdin
Date: Fri, 25 Apr 2014 21:06:56 +0200
Message-ID: <20140425190703.28550.84971.chriscool@tuxfamily.org>
References: <20140425185719.28550.27059.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 21:11:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdlWl-0000Bs-64
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 21:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbaDYTHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 15:07:53 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:56447 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591AbaDYTHq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 15:07:46 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 70BF740;
	Fri, 25 Apr 2014 21:07:45 +0200 (CEST)
X-git-sha1: 67fab5f7be6cb2b5903a26b83581687c1570e6c7 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140425185719.28550.27059.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247099>

Read trailers from a file or from stdin, parse the trailers and then
put the result into a doubly linked list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/trailer.c b/trailer.c
index f79a369..4ca9157 100644
--- a/trailer.c
+++ b/trailer.c
@@ -51,6 +51,14 @@ static size_t alnum_len(const char *buf, size_t len)
 	return len;
 }
 
+static inline int contains_only_spaces(const char *str)
+{
+	const char *s = str;
+	while (*s && isspace(*s))
+		s++;
+	return !*s;
+}
+
 static void free_trailer_item(struct trailer_item *item)
 {
 	free(item->conf.name);
@@ -509,3 +517,111 @@ static struct trailer_item *process_command_line_args(struct string_list *traile
 
 	return arg_tok_first;
 }
+
+static struct strbuf **read_input_file(const char *file)
+{
+	struct strbuf **lines;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (file) {
+		if (strbuf_read_file(&sb, file, 0) < 0)
+			die_errno(_("could not read input file '%s'"), file);
+	} else {
+		if (strbuf_read(&sb, fileno(stdin), 0) < 0)
+			die_errno(_("could not read from stdin"));
+	}
+
+	lines = strbuf_split(&sb, '\n');
+
+	strbuf_release(&sb);
+
+	return lines;
+}
+
+/*
+ * Return the (0 based) index of the start of the patch or the line
+ * count if there is no patch in the message.
+ */
+static int find_patch_start(struct strbuf **lines, int count)
+{
+	int i;
+
+	/* Get the start of the patch part if any */
+	for (i = 0; i < count; i++) {
+		if (starts_with(lines[i]->buf, "---"))
+			return i;
+	}
+
+	return count;
+}
+
+/*
+ * Return the (0 based) index of the first trailer line or count if
+ * there are no trailers. Trailers are searched only in the lines from
+ * index (count - 1) down to index 0. The has_blank_line parameter
+ * tells if there is a blank line before the trailers.
+ */
+static int find_trailer_start(struct strbuf **lines, int count, int *has_blank_line)
+{
+	int start, only_spaces = 1;
+
+	/*
+	 * Get the start of the trailers by looking starting from the end
+	 * for a line with only spaces before lines with one ':'.
+	 */
+	for (start = count - 1; start >= 0; start--) {
+		if (contains_only_spaces(lines[start]->buf)) {
+			if (only_spaces)
+				continue;
+			*has_blank_line = 1;
+			return start + 1;
+		}
+		if (strchr(lines[start]->buf, ':')) {
+			if (only_spaces)
+				only_spaces = 0;
+			continue;
+		}
+		*has_blank_line = start == count - 1 ?
+		  0 : contains_only_spaces(lines[start + 1]->buf);
+		return count;
+	}
+
+	*has_blank_line = only_spaces ? count > 0 : 0;
+	return only_spaces ? count : start + 1;
+}
+
+static void print_lines(struct strbuf **lines, int start, int end)
+{
+	int i;
+	for (i = start; lines[i] && i < end; i++)
+		printf("%s", lines[i]->buf);
+}
+
+static int process_input_file(struct strbuf **lines,
+			      struct trailer_item **in_tok_first,
+			      struct trailer_item **in_tok_last)
+{
+	int count = 0;
+	int patch_start, trailer_start, has_blank_line, i;
+
+	/* Get the line count */
+	while (lines[count])
+		count++;
+
+	patch_start = find_patch_start(lines, count);
+	trailer_start = find_trailer_start(lines, patch_start, &has_blank_line);
+
+	/* Print lines before the trailers as is */
+	print_lines(lines, 0, trailer_start);
+
+	if (!has_blank_line)
+		printf("\n");
+
+	/* Parse trailer lines */
+	for (i = trailer_start; i < patch_start; i++) {
+		struct trailer_item *new = create_trailer_item(lines[i]->buf);
+		add_trailer_item(in_tok_first, in_tok_last, new);
+	}
+
+	return patch_start;
+}
-- 
1.9.1.636.g20d5f34
