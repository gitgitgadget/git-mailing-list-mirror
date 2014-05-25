From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 06/11] trailer: put all the processing together and print
Date: Sun, 25 May 2014 07:32:17 +0200
Message-ID: <20140525053223.5329.76257.chriscool@tuxfamily.org>
References: <20140525051254.5329.66539.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 07:46:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoRGd-0005Qh-7h
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 07:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbaEYFqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 01:46:36 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:55756 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbaEYFqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 01:46:11 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 6566754;
	Sun, 25 May 2014 07:46:10 +0200 (CEST)
X-git-sha1: 774bff7c45bce0a3e433feb6bb866345a96fb5d0 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140525051254.5329.66539.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250074>

This patch adds the process_trailers() function that
calls all the previously added processing functions
and then prints the results on the standard output.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 trailer.h |  6 ++++++
 2 files changed, 62 insertions(+)
 create mode 100644 trailer.h

diff --git a/trailer.c b/trailer.c
index 40ad1a1..d648939 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "string-list.h"
+#include "trailer.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -69,6 +70,24 @@ static void free_trailer_item(struct trailer_item *item)
 	free(item);
 }
 
+static void print_tok_val(const char *tok, const char *val)
+{
+	char c = tok[strlen(tok) - 1];
+	if (isalnum(c))
+		printf("%s: %s\n", tok, val);
+	else
+		printf("%s%s\n", tok, val);
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
@@ -632,3 +651,40 @@ static int process_input_file(struct strbuf **lines,
 
 	return patch_start;
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
+void process_trailers(const char *file, int trim_empty, struct string_list *trailers)
+{
+	struct trailer_item *in_tok_first = NULL;
+	struct trailer_item *in_tok_last = NULL;
+	struct trailer_item *arg_tok_first;
+	struct strbuf **lines;
+	int patch_start;
+
+	git_config(git_trailer_config, NULL);
+
+	lines = read_input_file(file);
+
+	/* Print the lines before the trailers */
+	patch_start = process_input_file(lines, &in_tok_first, &in_tok_last);
+
+	arg_tok_first = process_command_line_args(trailers);
+
+	process_trailers_lists(&in_tok_first, &in_tok_last, &arg_tok_first);
+
+	print_all(in_tok_first, trim_empty);
+
+	free_all(&in_tok_first);
+
+	/* Print the lines after the trailers as is */
+	print_lines(lines, patch_start, INT_MAX);
+
+	strbuf_list_free(lines);
+}
diff --git a/trailer.h b/trailer.h
new file mode 100644
index 0000000..8eb25d5
--- /dev/null
+++ b/trailer.h
@@ -0,0 +1,6 @@
+#ifndef TRAILER_H
+#define TRAILER_H
+
+void process_trailers(const char *file, int trim_empty, struct string_list *trailers);
+
+#endif /* TRAILER_H */
-- 
1.9.rc0.17.g651113e
