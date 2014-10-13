From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v16 05/11] trailer: parse trailers from file or stdin
Date: Mon, 13 Oct 2014 20:16:27 +0200
Message-ID: <20141013181634.27329.98098.chriscool@tuxfamily.org>
References: <20141013181428.27329.86081.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael S Tsirkin <mst@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 20:20:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdkEE-0007iK-22
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 20:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbaJMSUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 14:20:13 -0400
Received: from [194.158.98.14] ([194.158.98.14]:45346 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754769AbaJMSTc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 14:19:32 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id DC8276D;
	Mon, 13 Oct 2014 20:19:10 +0200 (CEST)
X-git-sha1: ea0b7cfad443745995746264a8a756c8f23aaae2 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20141013181428.27329.86081.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Read trailers from a file or from stdin, parse the trailers and then
put the result into a doubly linked list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/trailer.c b/trailer.c
index b5666b3..4f0de3b 100644
--- a/trailer.c
+++ b/trailer.c
@@ -69,6 +69,14 @@ static int same_trailer(struct trailer_item *a, struct trailer_item *b)
 	return same_token(a, b) && same_value(a, b);
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
@@ -574,3 +582,118 @@ static struct trailer_item *process_command_line_args(struct string_list *traile
 
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
+ * index (count - 1) down to index 0.
+ */
+static int find_trailer_start(struct strbuf **lines, int count)
+{
+	int start, only_spaces = 1;
+
+	/*
+	 * Get the start of the trailers by looking starting from the end
+	 * for a line with only spaces before lines with one separator.
+	 */
+	for (start = count - 1; start >= 0; start--) {
+		if (lines[start]->buf[0] == comment_line_char)
+			continue;
+		if (contains_only_spaces(lines[start]->buf)) {
+			if (only_spaces)
+				continue;
+			return start + 1;
+		}
+		if (strcspn(lines[start]->buf, separators) < lines[start]->len) {
+			if (only_spaces)
+				only_spaces = 0;
+			continue;
+		}
+		return count;
+	}
+
+	return only_spaces ? count : 0;
+}
+
+static int has_blank_line_before(struct strbuf **lines, int start)
+{
+	for (;start >= 0; start--) {
+		if (lines[start]->buf[0] == comment_line_char)
+			continue;
+		return contains_only_spaces(lines[start]->buf);
+	}
+	return 0;
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
+	int patch_start, trailer_start, i;
+
+	/* Get the line count */
+	while (lines[count])
+		count++;
+
+	patch_start = find_patch_start(lines, count);
+	trailer_start = find_trailer_start(lines, patch_start);
+
+	/* Print lines before the trailers as is */
+	print_lines(lines, 0, trailer_start);
+
+	if (!has_blank_line_before(lines, trailer_start - 1))
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
2.1.0.rc0.248.gb91fdbc
