From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] trailer: add a trailer.trimEmpty config option
Date: Sat, 07 Feb 2015 14:11:09 +0100
Message-ID: <20150207131112.394.30858.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 14:26:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YK5PC-0004Dv-Tz
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 14:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958AbbBGN0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 08:26:30 -0500
Received: from delay-2y.bbox.fr ([194.158.98.17]:40449 "EHLO delay-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbbBGN03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 08:26:29 -0500
X-Greylist: delayed 860 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Feb 2015 08:26:29 EST
Received: from mail-2y.bbox.fr (bt8sssoo.cs.dolmen.bouyguestelecom.fr [172.24.208.129])
	by delay-2y.bbox.fr (Postfix) with ESMTP id 598854449F
	for <git@vger.kernel.org>; Sat,  7 Feb 2015 14:12:10 +0100 (CET)
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 28BD873;
	Sat,  7 Feb 2015 14:12:05 +0100 (CET)
X-git-sha1: 2e15760bfd639b6e23893f8859aa3cc0117105ba 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263439>

This way people who always want trimed trailers
don't need to specify it on the command line.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/interpret-trailers.c |  2 +-
 trailer.c                    | 13 ++++++++++---
 trailer.h                    |  2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 46838d2..1adf814 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -18,7 +18,7 @@ static const char * const git_interpret_trailers_usage[] = {
 
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
-	int trim_empty = 0;
+	int trim_empty = -1;
 	struct string_list trailers = STRING_LIST_INIT_DUP;
 
 	struct option options[] = {
diff --git a/trailer.c b/trailer.c
index 623adeb..7614182 100644
--- a/trailer.c
+++ b/trailer.c
@@ -36,6 +36,8 @@ static struct trailer_item *first_conf_item;
 
 static char *separators = ":";
 
+static int trim_empty;
+
 #define TRAILER_ARG_STRING "$ARG"
 
 static int after_or_end(enum action_where where)
@@ -120,7 +122,7 @@ static void print_tok_val(const char *tok, const char *val)
 		printf("%s%c %s\n", tok, separators[0], val);
 }
 
-static void print_all(struct trailer_item *first, int trim_empty)
+static void print_all(struct trailer_item *first)
 {
 	struct trailer_item *item;
 	for (item = first; item; item = item->next) {
@@ -509,6 +511,8 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "separators")) {
 			separators = xstrdup(value);
+		} else if (!strcmp(trailer_item, "trimempty")) {
+			trim_empty = git_config_bool(conf_key, value);
 		}
 	}
 	return 0;
@@ -842,7 +846,7 @@ static void free_all(struct trailer_item **first)
 	}
 }
 
-void process_trailers(const char *file, int trim_empty, struct string_list *trailers)
+void process_trailers(const char *file, int trim, struct string_list *trailers)
 {
 	struct trailer_item *in_tok_first = NULL;
 	struct trailer_item *in_tok_last = NULL;
@@ -854,6 +858,9 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
 	git_config(git_trailer_default_config, NULL);
 	git_config(git_trailer_config, NULL);
 
+	if (trim > -1)
+		trim_empty = trim;
+
 	lines = read_input_file(file);
 
 	/* Print the lines before the trailers */
@@ -863,7 +870,7 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
 
 	process_trailers_lists(&in_tok_first, &in_tok_last, &arg_tok_first);
 
-	print_all(in_tok_first, trim_empty);
+	print_all(in_tok_first);
 
 	free_all(&in_tok_first);
 
diff --git a/trailer.h b/trailer.h
index 8eb25d5..4f481d0 100644
--- a/trailer.h
+++ b/trailer.h
@@ -1,6 +1,6 @@
 #ifndef TRAILER_H
 #define TRAILER_H
 
-void process_trailers(const char *file, int trim_empty, struct string_list *trailers);
+void process_trailers(const char *file, int trim, struct string_list *trailers);
 
 #endif /* TRAILER_H */
-- 
2.2.1.313.gcc831f2
