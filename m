From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 07/16] trailer: put all the processing together and print
Date: Sun, 19 Jan 2014 09:53:45 +0100
Message-ID: <20140119085355.2734.29264.chriscool@tuxfamily.org>
References: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 09:55:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4oAS-0008R0-JA
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 09:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbaASIzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 03:55:41 -0500
Received: from [194.158.98.15] ([194.158.98.15]:50033 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752024AbaASIzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 03:55:07 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 801505B;
	Sun, 19 Jan 2014 09:54:29 +0100 (CET)
X-git-sha1: b1b69d65f7f06137a21206681265ebd2b68ffb7a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240686>

This patch adds the process_trailers() function that
calls all the previously added processing functions
and then prints the results on the standard output.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/trailer.c b/trailer.c
index 36eb1f8..d2a4427 100644
--- a/trailer.c
+++ b/trailer.c
@@ -48,6 +48,26 @@ static size_t alnum_len(const char *buf, size_t len) {
 	return len + 1;
 }
 
+static void print_tok_val(const char *tok, const char *val)
+{
+	char c = tok[strlen(tok) - 1];
+	if (isalnum(c))
+		printf("%s: %s\n", tok, val);
+	else if (isspace(c) || c == '#')
+		printf("%s%s\n", tok, val);
+	else
+		printf("%s %s\n", tok, val);
+}
+
+static void print_all(struct trailer_item *first, int trim_empty)
+{
+	struct trailer_item *item;
+	for (item = first; item; item = item->next) {
+		if (!trim_empty || strlen(item->value) > 0)
+			print_tok_val(item->token, item->value);
+	}
+}
+
 static void add_arg_to_infile(struct trailer_item *infile_tok,
 			      struct trailer_item *arg_tok)
 {
@@ -502,3 +522,23 @@ static void process_input_file(const char *infile,
 		add_trailer_item(infile_tok_first, infile_tok_last, new);
 	}
 }
+
+void process_trailers(const char *infile, int trim_empty, int argc, const char **argv)
+{
+	struct trailer_item *infile_tok_first = NULL;
+	struct trailer_item *infile_tok_last = NULL;
+	struct trailer_item *arg_tok_first;
+
+	git_config(git_trailer_config, NULL);
+
+	/* Print the non trailer part of infile */
+	if (infile) {
+		process_input_file(infile, &infile_tok_first, &infile_tok_last);
+	}
+
+	arg_tok_first = process_command_line_args(argc, argv);
+
+	process_trailers_lists(&infile_tok_first, &infile_tok_last, &arg_tok_first);
+
+	print_all(infile_tok_first, trim_empty);
+}
-- 
1.8.5.2.201.gacc5987
