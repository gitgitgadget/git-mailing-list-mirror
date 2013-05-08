From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 03/10] Add colors to interactive git-clean
Date: Wed,  8 May 2013 19:38:48 +0800
Message-ID: <d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
 <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
 <6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 08 13:39:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua2iS-00014J-Sb
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab3EHLjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:39:20 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:41343 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278Ab3EHLjT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 07:39:19 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so1258143pad.23
        for <git@vger.kernel.org>; Wed, 08 May 2013 04:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=MjTNZIjgaBOxZVaeV0D2B4BOyfgx0f2hlU56phLAwXE=;
        b=ma91YX1gn92O8T7M72Vi2CJbZlx6NPiTKM16CjeNTYwDIUqPLiAtTDZ8of8QW7CWXp
         Xn23uo15Rg6luUe86ii17Y44em0mZhPzx+/Jyq6JfR8vn4XsklZU6Ij5BEDz9uPq0OPg
         3570fHi4/Og2fsj9KS5nYw0EA6EYh6bvR4hYFOUpl1rVk4dV4DGKvbMJRiqzsdZOiecN
         wWt0tvCKj6X5l6dLcqsalIlR5vYKomzyZVjhaX8Ktnv2xp073nHXi/VeUVHaxXc0UrDU
         qc3FQq46nLURH1qQOmLDLkYWZ2ZgDScLTZTQm98E+ZQlcjhF356Z4OJ1PNgQvB2CuW2r
         bBSw==
X-Received: by 10.68.35.3 with SMTP id d3mr7041450pbj.155.1368013158452;
        Wed, 08 May 2013 04:39:18 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id gc5sm32287860pbb.19.2013.05.08.04.39.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 04:39:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g1c24ab7
In-Reply-To: <6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223659>

Show header, help, error messages, and prompt in colors for interactive
git-clean. Re-use config variables for other git commands, such as
git-add--interactive and git-stash:

 * color.interactive: When set to always, always use colors for
   interactive prompts and displays. When false (or never),
   never. When set to true or auto, use colors only when the
   output is to the terminal.

 * color.interactive.<slot>: Use customized color for interactive
   git-clean output (like git add --interactive). <slot> may be
   prompt, header, help or error.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Comments-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/clean.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 38ed0..9b029 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -14,6 +14,7 @@
 #include "string-list.h"
 #include "quote.h"
 #include "column.h"
+#include "color.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -32,16 +33,81 @@ static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
 
+static int clean_use_color = -1;
+static char clean_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RESET,
+	GIT_COLOR_NORMAL,	/* PLAIN */
+	GIT_COLOR_BOLD_BLUE,	/* PROMPT */
+	GIT_COLOR_BOLD,		/* HEADER */
+	GIT_COLOR_BOLD_RED,	/* HELP */
+	GIT_COLOR_BOLD_RED,	/* ERROR */
+};
+enum color_clean {
+	CLEAN_COLOR_RESET = 0,
+	CLEAN_COLOR_PLAIN = 1,
+	CLEAN_COLOR_PROMPT = 2,
+	CLEAN_COLOR_HEADER = 3,
+	CLEAN_COLOR_HELP = 4,
+	CLEAN_COLOR_ERROR = 5,
+};
+
+static int parse_clean_color_slot(const char *var, int ofs)
+{
+	if (!strcasecmp(var+ofs, "reset"))
+		return CLEAN_COLOR_RESET;
+	if (!strcasecmp(var+ofs, "plain"))
+		return CLEAN_COLOR_PLAIN;
+	if (!strcasecmp(var+ofs, "prompt"))
+		return CLEAN_COLOR_PROMPT;
+	if (!strcasecmp(var+ofs, "header"))
+		return CLEAN_COLOR_HEADER;
+	if (!strcasecmp(var+ofs, "help"))
+		return CLEAN_COLOR_HELP;
+	if (!strcasecmp(var+ofs, "error"))
+		return CLEAN_COLOR_ERROR;
+	return -1;
+}
+
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
 	if (!prefixcmp(var, "column."))
 		return git_column_config(var, value, "clean", &colopts);
 
+	/* honors the color.interactive* config variables which also
+	   applied in git-add--interactive and git-stash */
+	if (!strcmp(var, "color.interactive")) {
+		clean_use_color = git_config_colorbool(var, value);
+		return 0;
+	}
+	if (!prefixcmp(var, "color.interactive.")) {
+		int slot = parse_clean_color_slot(var, 18);
+		if (slot < 0)
+			return 0;
+		if (!value)
+			return config_error_nonbool(var);
+		color_parse(value, var, clean_colors[slot]);
+		return 0;
+	}
+
 	if (!strcmp(var, "clean.requireforce")) {
 		force = !git_config_bool(var, value);
 		return 0;
 	}
-	return git_default_config(var, value, cb);
+
+	/* inspect the color.ui config variable and others */
+	return git_color_default_config(var, value, cb);
+}
+
+static const char *clean_get_color(enum color_clean ix)
+{
+	if (want_color(clean_use_color))
+		return clean_colors[ix];
+	return "";
+}
+
+static void clean_print_color(enum color_clean ix)
+{
+	printf("%s", clean_get_color(ix));
 }
 
 static int exclude_cb(const struct option *opt, const char *arg, int unset)
@@ -192,7 +258,9 @@ static void edit_by_patterns_cmd()
 	while (1) {
 		/* dels list may become empty when we run string_list_remove_empty_items later */
 		if (!del_list.nr) {
+			clean_print_color(CLEAN_COLOR_ERROR);
 			printf_ln(_("No more files to clean, exiting."));
+			clean_print_color(CLEAN_COLOR_RESET);
 			break;
 		}
 
@@ -203,7 +271,9 @@ static void edit_by_patterns_cmd()
 			pretty_print_dels();
 		}
 
+		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Input ignore patterns>> "));
+		clean_print_color(CLEAN_COLOR_RESET);
 		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
 			strbuf_trim(&confirm);
 		} else {
@@ -243,7 +313,9 @@ static void edit_by_patterns_cmd()
 		if (changed) {
 			string_list_remove_empty_items(&del_list, 0);
 		} else {
+			clean_print_color(CLEAN_COLOR_ERROR);
 			printf_ln(_("WARNING: Cannot find items matched by: %s"), confirm.buf);
+			clean_print_color(CLEAN_COLOR_RESET);
 		}
 
 		strbuf_list_free(ignore_list);
@@ -261,16 +333,20 @@ static void interactive_main_loop()
 	/* dels list may become empty after return back from edit mode */
 	while (del_list.nr) {
 		putchar('\n');
+		clean_print_color(CLEAN_COLOR_HEADER);
 		printf_ln(Q_("Would remove the following item:",
 			     "Would remove the following items:",
 			     del_list.nr));
+		clean_print_color(CLEAN_COLOR_RESET);
 		putchar('\n');
 
 		/* Display dels in columns */
 		pretty_print_dels();
 
 		/* Confirmation dialog */
+		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Remove ([y]es/[n]o/[e]dit) ? "));
+		clean_print_color(CLEAN_COLOR_RESET);
 		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
 			strbuf_trim(&confirm);
 		} else {
-- 
1.8.3.rc1.341.g1c24ab7
