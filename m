From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 06/11] trailer: put all the processing together and print
Date: Tue, 04 Mar 2014 20:48:04 +0100
Message-ID: <20140304194810.14249.40429.chriscool@tuxfamily.org>
References: <20140304193250.14249.56949.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 20:50:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKvLh-0000BT-N0
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 20:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278AbaCDTtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 14:49:47 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:63953 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754846AbaCDTtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 14:49:31 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 9D12F61;
	Tue,  4 Mar 2014 20:49:30 +0100 (CET)
X-git-sha1: 6f0b1a834c3eb538ac893b4728c867fbd486743a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140304193250.14249.56949.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243383>

This patch adds the process_trailers() function that
calls all the previously added processing functions
and then prints the results on the standard output.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/trailer.c b/trailer.c
index e0e066f..ab93c16 100644
--- a/trailer.c
+++ b/trailer.c
@@ -67,6 +67,26 @@ static void free_trailer_item(struct trailer_item *item)
 	free(item);
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
 static void add_arg_to_input_list(struct trailer_item *in_tok,
 				  struct trailer_item *arg_tok)
 {
@@ -547,3 +567,31 @@ static void process_stdin(struct trailer_item **in_tok_first,
 
 	strbuf_list_free(lines);
 }
+
+static void free_all(struct trailer_item **first)
+{
+	while (*first) {
+		struct trailer_item *item = remove_first(first);
+		free_trailer_item(item);
+	}
+}
+
+void process_trailers(int trim_empty, int argc, const char **argv)
+{
+	struct trailer_item *in_tok_first = NULL;
+	struct trailer_item *in_tok_last = NULL;
+	struct trailer_item *arg_tok_first;
+
+	git_config(git_trailer_config, NULL);
+
+	/* Print the non trailer part of stdin */
+	process_stdin(&in_tok_first, &in_tok_last);
+
+	arg_tok_first = process_command_line_args(argc, argv);
+
+	process_trailers_lists(&in_tok_first, &in_tok_last, &arg_tok_first);
+
+	print_all(in_tok_first, trim_empty);
+
+	free_all(&in_tok_first);
+}
-- 
1.8.5.2.204.gcfe299d.dirty
