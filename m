From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 06/17] trailer: parse trailers from input file
Date: Thu, 30 Jan 2014 07:49:09 +0100
Message-ID: <20140130064921.7504.62053.chriscool@tuxfamily.org>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 08:38:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8mDA-0005Zm-Fj
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 08:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbaA3Hiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 02:38:52 -0500
Received: from [194.158.98.15] ([194.158.98.15]:39154 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752569AbaA3HiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 02:38:07 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 5421466;
	Thu, 30 Jan 2014 08:37:46 +0100 (CET)
X-git-sha1: e2f62d0d6a62ee9e8eb76a6a9b2492814c9448db 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140130064217.7504.473.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241257>

This patch reads trailers from an input file, parses
them and puts the result into a doubly linked list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/trailer.c b/trailer.c
index f48fd94..084b3e1 100644
--- a/trailer.c
+++ b/trailer.c
@@ -439,3 +439,65 @@ static struct trailer_item *process_command_line_args(int argc, const char **arg
 
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
1.8.5.2.201.gacc5987
