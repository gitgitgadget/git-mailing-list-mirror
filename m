From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 05/11] trailer: parse trailers from stdin
Date: Thu, 06 Mar 2014 23:14:02 +0100
Message-ID: <20140306221409.29648.94530.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 07:20:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLo97-00089r-LN
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 07:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbaCGGUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 01:20:25 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:57812 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbaCGGUY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 01:20:24 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 3549839;
	Fri,  7 Mar 2014 07:20:23 +0100 (CET)
X-git-sha1: a578008e2d6e2c297af8d34b8c0b2c16249e2222 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243592>

Read trailers from stdin, parse them and put the result into a doubly linked
list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/trailer.c b/trailer.c
index 43cbf10..910eddb 100644
--- a/trailer.c
+++ b/trailer.c
@@ -50,6 +50,14 @@ static size_t alnum_len(const char *buf, size_t len)
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
@@ -476,3 +484,71 @@ static struct trailer_item *process_command_line_args(int argc, const char **arg
 
 	return arg_tok_first;
 }
+
+static struct strbuf **read_stdin(void)
+{
+	struct strbuf **lines;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (strbuf_read(&sb, fileno(stdin), 0) < 0)
+		die_errno(_("could not read from stdin"));
+
+	lines = strbuf_split(&sb, '\n');
+
+	strbuf_release(&sb);
+
+	return lines;
+}
+
+/*
+ * Return the the (0 based) index of the first trailer line
+ * or the line count if there are no trailers.
+ */
+static int find_trailer_start(struct strbuf **lines)
+{
+	int start, empty = 1, count = 0;
+
+	/* Get the line count */
+	while (lines[count])
+		count++;
+
+	/*
+	 * Get the start of the trailers by looking starting from the end
+	 * for a line with only spaces before lines with one ':'.
+	 */
+	for (start = count - 1; start >= 0; start--) {
+		if (contains_only_spaces(lines[start]->buf)) {
+			if (empty)
+				continue;
+			return start + 1;
+		}
+		if (strchr(lines[start]->buf, ':')) {
+			if (empty)
+				empty = 0;
+			continue;
+		}
+		return count;
+	}
+
+	return empty ? count : start + 1;
+}
+
+static void process_stdin(struct trailer_item **in_tok_first,
+			  struct trailer_item **in_tok_last)
+{
+	struct strbuf **lines = read_stdin();
+	int start = find_trailer_start(lines);
+	int i;
+
+	/* Print non trailer lines as is */
+	for (i = 0; lines[i] && i < start; i++)
+		printf("%s", lines[i]->buf);
+
+	/* Parse trailer lines */
+	for (i = start; lines[i]; i++) {
+		struct trailer_item *new = create_trailer_item(lines[i]->buf);
+		add_trailer_item(in_tok_first, in_tok_last, new);
+	}
+
+	strbuf_list_free(lines);
+}
-- 
1.8.5.2.204.gcfe299d.dirty
