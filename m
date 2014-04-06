From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v10 05/12] trailer: parse trailers from stdin
Date: Sun, 06 Apr 2014 19:01:56 +0200
Message-ID: <20140406170204.15116.49476.chriscool@tuxfamily.org>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Apr 07 20:44:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEWy-0003cA-Ch
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015AbaDGSoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 14:44:05 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:46714 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755998AbaDGSoB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 14:44:01 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 8469F74;
	Mon,  7 Apr 2014 20:44:00 +0200 (CEST)
X-git-sha1: 8a4dc1b1d4b8ab29740813b9f760aba5d95410d3 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140406163214.15116.91484.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245878>

Read trailers from stdin, parse them and put the result into a doubly linked
list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/trailer.c b/trailer.c
index 89ebff1..6d2da32 100644
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
@@ -508,3 +516,71 @@ static struct trailer_item *process_command_line_args(int argc, const char **arg
 
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
1.9.0.163.g8ca203c
