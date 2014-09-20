From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v15 06/11] trailer: put all the processing together and print
Date: Sat, 20 Sep 2014 15:45:09 +0200
Message-ID: <20140920134515.18999.8387.chriscool@tuxfamily.org>
References: <20140920134048.18999.79434.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sat Sep 20 15:49:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVL2B-0006ro-Gr
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 15:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067AbaITNsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2014 09:48:53 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:63973 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbaITNsi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 09:48:38 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 1DCC483;
	Sat, 20 Sep 2014 15:48:37 +0200 (CEST)
X-git-sha1: 5abb4b2cd736eeb8e191342bcb50eff4e238a450 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140920134048.18999.79434.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257320>

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
index c3e096f..094c6e8 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "string-list.h"
+#include "trailer.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -87,6 +88,35 @@ static void free_trailer_item(struct trailer_item *item)
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
@@ -494,18 +524,6 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tra
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
@@ -710,3 +728,42 @@ static int process_input_file(struct strbuf **lines,
 
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
