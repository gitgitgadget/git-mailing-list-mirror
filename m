From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 06/14] trailer: put all the processing together and print
Date: Thu, 06 Feb 2014 21:19:55 +0100
Message-ID: <20140206202004.325.31354.chriscool@tuxfamily.org>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 21:21:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBVSN-00046N-96
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 21:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465AbaBFUV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 15:21:26 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:64763 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348AbaBFUVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 15:21:22 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id C888D66;
	Thu,  6 Feb 2014 21:21:21 +0100 (CET)
X-git-sha1: 9ab402b765136361f11517456f6023e27e3e8016 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140206194123.325.99451.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241734>

This patch adds the process_trailers() function that
calls all the previously added processing functions
and then prints the results on the standard output.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/trailer.c b/trailer.c
index f59efd1..186316f 100644
--- a/trailer.c
+++ b/trailer.c
@@ -56,6 +56,26 @@ static inline int contains_only_spaces(const char *str)
 	return !*s;
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
@@ -522,3 +542,23 @@ static void process_input_file(const char *infile,
 
 	strbuf_list_free(lines);
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
1.8.5.2.206.g98f5689.dirty
