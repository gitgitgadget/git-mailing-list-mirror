From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 05/14] trailer: parse trailers from input file
Date: Thu, 06 Feb 2014 21:19:54 +0100
Message-ID: <20140206202004.325.52337.chriscool@tuxfamily.org>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 21:22:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBVSx-0004d4-O0
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 21:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756843AbaBFUWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 15:22:10 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:64753 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755055AbaBFUVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 15:21:22 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 30F7139;
	Thu,  6 Feb 2014 21:21:21 +0100 (CET)
X-git-sha1: 7916eccf14997fb88e7fd892952bb29e16ade782 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140206194123.325.99451.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241737>

This patch reads trailers from an input file, parses
them and puts the result into a doubly linked list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/trailer.c b/trailer.c
index 3fde21d..f59efd1 100644
--- a/trailer.c
+++ b/trailer.c
@@ -49,6 +49,13 @@ static inline size_t alnum_len(const char *buf, int len)
 	return (size_t) len + 1;
 }
 
+static inline int contains_only_spaces(const char *str)
+{
+	const char *s;
+	for (s = str; *s && isspace(*s); s++);
+	return !*s;
+}
+
 static void add_arg_to_infile(struct trailer_item *infile_tok,
 			      struct trailer_item *arg_tok)
 {
@@ -451,3 +458,67 @@ static struct trailer_item *process_command_line_args(int argc, const char **arg
 
 	return arg_tok_first;
 }
+
+static struct strbuf **read_input_file(const char *infile)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (strbuf_read_file(&sb, infile, 0) < 0)
+		die_errno(_("could not read input file '%s'"), infile);
+
+	return strbuf_split(&sb, '\n');
+}
+
+/*
+ * Return the the (0 based) index of the first trailer line
+ * or the line count if there are no trailers.
+ */
+static int find_trailer_start(struct strbuf **lines)
+{
+	int count, start, empty = 1;
+
+	/* Get the line count */
+	for (count = 0; lines[count]; count++);
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
+static void process_input_file(const char *infile,
+			       struct trailer_item **infile_tok_first,
+			       struct trailer_item **infile_tok_last)
+{
+	struct strbuf **lines = read_input_file(infile);
+	int start = find_trailer_start(lines);
+	int i;
+
+	/* Print non trailer lines as is */
+	for (i = 0; lines[i] && i < start; i++) {
+		printf("%s", lines[i]->buf);
+	}
+
+	/* Parse trailer lines */
+	for (i = start; lines[i]; i++) {
+		struct trailer_item *new = create_trailer_item(lines[i]->buf);
+		add_trailer_item(infile_tok_first, infile_tok_last, new);
+	}
+
+	strbuf_list_free(lines);
+}
-- 
1.8.5.2.206.g98f5689.dirty
