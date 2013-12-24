From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/9] trailer: parse trailers from input file
Date: Tue, 24 Dec 2013 07:37:22 +0100
Message-ID: <20131224063726.19560.28407.chriscool@tuxfamily.org>
References: <20131224061541.19560.17773.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 24 07:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvLeH-0001vx-1e
	for gcvg-git-2@plane.gmane.org; Tue, 24 Dec 2013 07:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab3LXGjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Dec 2013 01:39:22 -0500
Received: from [194.158.98.14] ([194.158.98.14]:50299 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750985Ab3LXGil (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Dec 2013 01:38:41 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 08F5A58;
	Tue, 24 Dec 2013 07:38:20 +0100 (CET)
X-git-sha1: 43fc6f37394a1c021c852dd3243b6d77b94bb8ff 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131224061541.19560.17773.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239664>

This patch reads trailers from an input file, parses
them and puts the result into a doubly linked list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/trailer.c b/trailer.c
index b572c44..22d3ea3 100644
--- a/trailer.c
+++ b/trailer.c
@@ -440,3 +440,65 @@ static struct trailer_item *process_command_line_args(int argc, const char **arg
 
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
+		if (strbuf_isspace(lines[start])) {
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
+}
-- 
1.8.4.1.616.g07f5c81
