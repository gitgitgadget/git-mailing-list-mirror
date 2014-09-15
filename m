From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 06/11] trailer: put all the processing together and print
Date: Mon, 15 Sep 2014 07:31:36 +0200
Message-ID: <20140915053142.26573.98062.chriscool@tuxfamily.org>
References: <20140915052330.26573.34823.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Sep 15 07:50:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTPB3-0003Ti-SU
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 07:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbaIOFuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 01:50:12 -0400
Received: from delay-4y.bbox.fr ([194.158.98.75]:63748 "EHLO delay-5y.bbox.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751890AbaIOFuK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 01:50:10 -0400
Received: from mail-3y.bbox.fr (bt8sssoh.cs.dolmen.bouyguestelecom.fr [172.24.208.141])
	by delay-5y.bbox.fr (Postfix) with ESMTP id F3C305496D
	for <git@vger.kernel.org>; Mon, 15 Sep 2014 07:36:28 +0200 (CEST)
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 8D59280;
	Mon, 15 Sep 2014 07:34:07 +0200 (CEST)
X-git-sha1: 2d9a9c9f7ee50b3ce07d4c0b25cee3c507aecc80 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140915052330.26573.34823.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257042>

This patch adds the process_trailers() function that
calls all the previously added processing functions
and then prints the results on the standard output.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 trailer.h |  6 +++++
 2 files changed, 75 insertions(+), 12 deletions(-)
 create mode 100644 trailer.h

diff --git a/trailer.c b/trailer.c
index 46e2fcb..8e41b8f 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "string-list.h"
+#include "trailer.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -82,6 +83,35 @@ static void free_trailer_item(struct trailer_item *item)
 	free(item);
 }
 
+static char last_non_space_char(const char *s)
+{
+	int i;
+	for (i = strlen(s) - 1; i >= 0; i--)
+		if (!isspace(s[i]))
+			return s[i];
+	return '\0';
+}
+
+static void print_tok_val(const char *tok, const char *val)
+{
+	char c = last_non_space_char(tok);
+	if (!c)
+		return;
+	if (strchr(separators, c))
+		printf("%s%s\n", tok, val);
+	else
+		printf("%s%c %s\n", tok, separators[0], val);
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
 static void update_last(struct trailer_item **last)
 {
 	if (*last)
@@ -489,18 +519,6 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tra
 	return 0;
 }
 
-
-static void duplicate_conf(struct conf_info *dst, struct conf_info *src)
-{
-	*dst = *src;
-	if (src->name)
-		dst->name = xstrdup(src->name);
-	if (src->key)
-		dst->key = xstrdup(src->key);
-	if (src->command)
-		dst->command = xstrdup(src->command);
-}
-
 static const char *token_from_item(struct trailer_item *item)
 {
 	if (item->conf.key)
@@ -705,3 +723,42 @@ static int process_input_file(struct strbuf **lines,
 
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
+	/* Default config must be setup first */
+	git_config(git_trailer_default_config, NULL);
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
2.0.3.960.g41c6e4c
