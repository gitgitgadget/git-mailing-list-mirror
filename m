From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 06/11] trailer: put all the processing together and print
Date: Sat, 16 Aug 2014 18:06:16 +0200
Message-ID: <20140816160622.18221.98107.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sat Aug 16 18:31:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIgsh-0005Tz-1M
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 18:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbaHPQap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 12:30:45 -0400
Received: from gleek.ethostream.com ([66.195.129.15]:57342 "EHLO
	barracuda.ethostream.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbaHPQab (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 12:30:31 -0400
X-ASG-Debug-ID: 1408205480-016a7707b5114cf30001-QuoKaX
Received: from relay.ethostream.com (www1.ethostream.com [66.195.129.11]) by barracuda.ethostream.com with ESMTP id rCtVIIZohrKTbX7d; Sat, 16 Aug 2014 11:11:20 -0500 (CDT)
X-Barracuda-Envelope-From: chriscool@tuxfamily.org
X-Barracuda-Apparent-Source-IP: 66.195.129.11
Received: from ethoserver.ezone.net (unknown [10.230.15.218])
	by relay.ethostream.com (Postfix) with ESMTPA id 9DB0E89177D;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
Received: from [127.0.1.1] (unknown [10.0.7.4])
	by ethoserver.ezone.net (Postfix) with ESMTP id 6B2D0C54978;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
X-ASG-Orig-Subj: [PATCH v13 06/11] trailer: put all the processing together and print
X-git-sha1: 2d9a9c9f7ee50b3ce07d4c0b25cee3c507aecc80 
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255330>

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
2.0.1.674.ga7f57b7
