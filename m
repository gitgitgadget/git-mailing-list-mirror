From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 1/2] trailer: use fprintf instead of printf
Date: Mon, 11 Jan 2016 14:33:32 +0100
Message-ID: <1452519213-1819-2-git-send-email-tklauser@distanz.ch>
References: <1452519213-1819-1-git-send-email-tklauser@distanz.ch>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 14:33:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIcbZ-0000rA-Q4
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 14:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759626AbcAKNdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 08:33:45 -0500
Received: from mail.zhinst.com ([212.126.164.98]:52496 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759568AbcAKNdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 08:33:39 -0500
Received: from ziws06.zhinst.com ([10.42.0.7])
	by mail.zhinst.com (Kerio Connect 9.0.1) with ESMTP;
	Mon, 11 Jan 2016 14:33:33 +0100
X-Mailer: git-send-email 2.7.0.1.g5e091f5
In-Reply-To: <1452519213-1819-1-git-send-email-tklauser@distanz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283648>

Use fprintf instead of printf in trailer.c in order to allow printing
to a file other than stdout. This will be needed to support in-place
editing in git interpret-trailers.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 trailer.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/trailer.c b/trailer.c
index 6f3416febaba..176fac213450 100644
--- a/trailer.c
+++ b/trailer.c
@@ -108,23 +108,23 @@ static char last_non_space_char(const char *s)
 	return '\0';
 }
 
-static void print_tok_val(const char *tok, const char *val)
+static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 {
 	char c = last_non_space_char(tok);
 	if (!c)
 		return;
 	if (strchr(separators, c))
-		printf("%s%s\n", tok, val);
+		fprintf(outfile, "%s%s\n", tok, val);
 	else
-		printf("%s%c %s\n", tok, separators[0], val);
+		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void print_all(struct trailer_item *first, int trim_empty)
+static void print_all(FILE *outfile, struct trailer_item *first, int trim_empty)
 {
 	struct trailer_item *item;
 	for (item = first; item; item = item->next) {
 		if (!trim_empty || strlen(item->value) > 0)
-			print_tok_val(item->token, item->value);
+			print_tok_val(outfile, item->token, item->value);
 	}
 }
 
@@ -795,14 +795,15 @@ static int has_blank_line_before(struct strbuf **lines, int start)
 	return 0;
 }
 
-static void print_lines(struct strbuf **lines, int start, int end)
+static void print_lines(FILE *outfile, struct strbuf **lines, int start, int end)
 {
 	int i;
 	for (i = start; lines[i] && i < end; i++)
-		printf("%s", lines[i]->buf);
+		fprintf(outfile, "%s", lines[i]->buf);
 }
 
-static int process_input_file(struct strbuf **lines,
+static int process_input_file(FILE *outfile,
+			      struct strbuf **lines,
 			      struct trailer_item **in_tok_first,
 			      struct trailer_item **in_tok_last)
 {
@@ -818,10 +819,10 @@ static int process_input_file(struct strbuf **lines,
 	trailer_start = find_trailer_start(lines, trailer_end);
 
 	/* Print lines before the trailers as is */
-	print_lines(lines, 0, trailer_start);
+	print_lines(outfile, lines, 0, trailer_start);
 
 	if (!has_blank_line_before(lines, trailer_start - 1))
-		printf("\n");
+		fprintf(outfile, "\n");
 
 	/* Parse trailer lines */
 	for (i = trailer_start; i < trailer_end; i++) {
@@ -849,6 +850,7 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
 	struct trailer_item *arg_tok_first;
 	struct strbuf **lines;
 	int trailer_end;
+	FILE *outfile = stdout;
 
 	/* Default config must be setup first */
 	git_config(git_trailer_default_config, NULL);
@@ -857,18 +859,18 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
 	lines = read_input_file(file);
 
 	/* Print the lines before the trailers */
-	trailer_end = process_input_file(lines, &in_tok_first, &in_tok_last);
+	trailer_end = process_input_file(outfile, lines, &in_tok_first, &in_tok_last);
 
 	arg_tok_first = process_command_line_args(trailers);
 
 	process_trailers_lists(&in_tok_first, &in_tok_last, &arg_tok_first);
 
-	print_all(in_tok_first, trim_empty);
+	print_all(outfile, in_tok_first, trim_empty);
 
 	free_all(&in_tok_first);
 
 	/* Print the lines after the trailers as is */
-	print_lines(lines, trailer_end, INT_MAX);
+	print_lines(outfile, lines, trailer_end, INT_MAX);
 
 	strbuf_list_free(lines);
 }
-- 
2.7.0.1.g5e091f5
