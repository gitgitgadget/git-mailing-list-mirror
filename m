From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/5] trailer: reuse ignore_non_trailer() to ignore conflict
 lines
Date: Sun, 09 Nov 2014 10:23:42 +0100
Message-ID: <20141109092344.4864.88180.chriscool@tuxfamily.org>
References: <20141109092313.4864.54933.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 10:27:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnOml-0006Of-03
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 10:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbaKIJ1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 04:27:42 -0500
Received: from [194.158.98.14] ([194.158.98.14]:55749 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751560AbaKIJ1j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 04:27:39 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id CBD898F;
	Sun,  9 Nov 2014 10:27:17 +0100 (CET)
X-git-sha1: 88e4a675e1110779bc40d0fd57a8afcae3433fc3 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20141109092313.4864.54933.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make sure we look for trailers before any conflict line
by reusing the ignore_non_trailer() function.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7513-interpret-trailers.sh |  2 ++
 trailer.c                     | 32 +++++++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 1efb880..fed053a 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -232,6 +232,8 @@ test_expect_success 'with message that has comments' '
 
 		Reviewed-by: Johan
 		Cc: Peff
+		# last comment
+
 	EOF
 	cat basic_patch >>expected &&
 	git interpret-trailers --trim-empty --trailer "Cc: Peff" message_with_comments >actual &&
diff --git a/trailer.c b/trailer.c
index 219a5a2..30636d2 100644
--- a/trailer.c
+++ b/trailer.c
@@ -2,6 +2,7 @@
 #include "string-list.h"
 #include "run-command.h"
 #include "string-list.h"
+#include "commit.h"
 #include "trailer.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
@@ -769,6 +770,22 @@ static int find_trailer_start(struct strbuf **lines, int count)
 	return only_spaces ? count : 0;
 }
 
+/* Get the index of the end of the trailers */
+static int find_trailer_end(struct strbuf **lines, int patch_start)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int i, ignore_bytes;
+
+	for (i = 0; i < patch_start; i++)
+		strbuf_addbuf(&sb, lines[i]);
+	ignore_bytes = ignore_non_trailer(&sb);
+	strbuf_release(&sb);
+	for (i = patch_start - 1; i >= 0 && ignore_bytes > 0; i--)
+		ignore_bytes -= lines[i]->len;
+
+	return i + 1;
+}
+
 static int has_blank_line_before(struct strbuf **lines, int start)
 {
 	for (;start >= 0; start--) {
@@ -791,14 +808,15 @@ static int process_input_file(struct strbuf **lines,
 			      struct trailer_item **in_tok_last)
 {
 	int count = 0;
-	int patch_start, trailer_start, i;
+	int patch_start, trailer_start, trailer_end, i;
 
 	/* Get the line count */
 	while (lines[count])
 		count++;
 
 	patch_start = find_patch_start(lines, count);
-	trailer_start = find_trailer_start(lines, patch_start);
+	trailer_end = find_trailer_end(lines, patch_start);
+	trailer_start = find_trailer_start(lines, trailer_end);
 
 	/* Print lines before the trailers as is */
 	print_lines(lines, 0, trailer_start);
@@ -807,14 +825,14 @@ static int process_input_file(struct strbuf **lines,
 		printf("\n");
 
 	/* Parse trailer lines */
-	for (i = trailer_start; i < patch_start; i++) {
+	for (i = trailer_start; i < trailer_end; i++) {
 		if (lines[i]->buf[0] != comment_line_char) {
 			struct trailer_item *new = create_trailer_item(lines[i]->buf);
 			add_trailer_item(in_tok_first, in_tok_last, new);
 		}
 	}
 
-	return patch_start;
+	return trailer_end;
 }
 
 static void free_all(struct trailer_item **first)
@@ -831,7 +849,7 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
 	struct trailer_item *in_tok_last = NULL;
 	struct trailer_item *arg_tok_first;
 	struct strbuf **lines;
-	int patch_start;
+	int trailer_end;
 
 	/* Default config must be setup first */
 	git_config(git_trailer_default_config, NULL);
@@ -840,7 +858,7 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
 	lines = read_input_file(file);
 
 	/* Print the lines before the trailers */
-	patch_start = process_input_file(lines, &in_tok_first, &in_tok_last);
+	trailer_end = process_input_file(lines, &in_tok_first, &in_tok_last);
 
 	arg_tok_first = process_command_line_args(trailers);
 
@@ -851,7 +869,7 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
 	free_all(&in_tok_first);
 
 	/* Print the lines after the trailers as is */
-	print_lines(lines, patch_start, INT_MAX);
+	print_lines(lines, trailer_end, INT_MAX);
 
 	strbuf_list_free(lines);
 }
-- 
2.1.2.555.gfbecd99
