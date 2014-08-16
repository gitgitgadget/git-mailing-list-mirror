From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 05/11] trailer: parse trailers from file or stdin
Date: Sat, 16 Aug 2014 18:06:15 +0200
Message-ID: <20140816160622.18221.80639.chriscool@tuxfamily.org>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 18:31:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIgsf-0005Tz-Cj
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 18:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbaHPQaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 12:30:39 -0400
Received: from gleek.ethostream.com ([66.195.129.15]:57359 "EHLO
	barracuda.ethostream.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbaHPQac (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 12:30:32 -0400
X-ASG-Debug-ID: 1408205480-016a7707b5114cf20001-QuoKaX
Received: from relay.ethostream.com (www1.ethostream.com [66.195.129.11]) by barracuda.ethostream.com with ESMTP id pVHgu9Y1NRF3tBgv; Sat, 16 Aug 2014 11:11:20 -0500 (CDT)
X-Barracuda-Envelope-From: chriscool@tuxfamily.org
X-Barracuda-Apparent-Source-IP: 66.195.129.11
Received: from ethoserver.ezone.net (unknown [10.230.15.218])
	by relay.ethostream.com (Postfix) with ESMTPA id 94E7889177C;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
Received: from [127.0.1.1] (unknown [10.0.7.4])
	by ethoserver.ezone.net (Postfix) with ESMTP id 5EBEBC5494D;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
X-ASG-Orig-Subj: [PATCH v13 05/11] trailer: parse trailers from file or stdin
X-git-sha1: 012a2939526402776a6df74030217632c360b6de 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140816153440.18221.29179.chriscool@tuxfamily.org>
X-Barracuda-Connect: www1.ethostream.com[66.195.129.11]
X-Barracuda-Start-Time: 1408205480
X-Barracuda-URL: http://66.195.129.15:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ethostream.com
X-Barracuda-Spam-Score: 3.38
X-Barracuda-Spam-Status: No, SCORE=3.38 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=FH_DATE_PAST_20XX
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.138343
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	3.38 FH_DATE_PAST_20XX      The date is grossly in the future.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255328>

Read trailers from a file or from stdin, parse the trailers and then
put the result into a doubly linked list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/trailer.c b/trailer.c
index b9d3ed4..46e2fcb 100644
--- a/trailer.c
+++ b/trailer.c
@@ -64,6 +64,14 @@ static int same_trailer(struct trailer_item *a, struct trailer_item *b)
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
@@ -582,3 +590,118 @@ static struct trailer_item *process_command_line_args(struct string_list *traile
 
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
2.0.1.674.ga7f57b7
