From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 06/11] trailer: put all the processing together and print
Date: Thu, 06 Mar 2014 23:14:03 +0100
Message-ID: <20140306221409.29648.98583.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 07:20:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLo9P-0008Pl-Rf
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 07:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbaCGGUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 01:20:43 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:62782 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138AbaCGGUY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 01:20:24 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id BD9DC50;
	Fri,  7 Mar 2014 07:20:23 +0100 (CET)
X-git-sha1: bcfd65f1022a587f26f27678700b741d4763787a 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243598>

This patch adds the process_trailers() function that
calls all the previously added processing functions
and then prints the results on the standard output.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 trailer.h |  6 ++++++
 2 files changed, 55 insertions(+)
 create mode 100644 trailer.h

diff --git a/trailer.c b/trailer.c
index 910eddb..cc87918 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "trailer.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -68,6 +69,26 @@ static void free_trailer_item(struct trailer_item *item)
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
@@ -552,3 +573,31 @@ static void process_stdin(struct trailer_item **in_tok_first,
 
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
diff --git a/trailer.h b/trailer.h
new file mode 100644
index 0000000..9323b1e
--- /dev/null
+++ b/trailer.h
@@ -0,0 +1,6 @@
+#ifndef TRAILER_H
+#define TRAILER_H
+
+void process_trailers(int trim_empty, int argc, const char **argv);
+
+#endif /* TRAILER_H */
-- 
1.8.5.2.204.gcfe299d.dirty
