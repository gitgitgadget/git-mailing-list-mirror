From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 3/7] Add colors to interactive git-clean
Date: Tue,  7 May 2013 03:18:52 +0800
Message-ID: <c77c33fe295bb8577336d5bb4fe0d8da32f69df3.1367867498.git.worldhello.net@gmail.com>
References: <cover.1367867498.git.worldhello.net@gmail.com>
 <4a32eb7cc4e277fcbf4b46c13524874334bea2a3.1367867498.git.worldhello.net@gmail.com>
 <6276dc8861b40e8377586f30b85c33e92c4e68fe.1367867498.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 06 21:19:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQwg-00027K-QM
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771Ab3EFTT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:19:28 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:46359 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711Ab3EFTT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:19:27 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so1471374pad.22
        for <git@vger.kernel.org>; Mon, 06 May 2013 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=ZDGl/OaEgAc6KS+In+blWOTf53hyeexnOA5UsNvDwtk=;
        b=h83a17b+9pcrQn990XVhfwvLRS1tENAIxbUXSU3tiK/sJS9ePLB39Maswnj/848d1O
         PzUVx9ubgmhmIe02wD1Pi8PqGiyxi4kddLw/RYJo+aZ8v38ZY/CvzyFVKEinrKKBiIHb
         xkkOaB8TFOi+kDC/FEQaECmWKajw2eaPSJN8h9G7TjjTfj1fWt6gA9Ez7A/sMAqEaJwr
         xpq01ah9JI+bdv4h35Vvln7Gx7oNUY2/qUDIer/l0Fz2bjDOAbu9KobnCqp8P7yeJVas
         aYXpoBG7+TOo1BHqeUeu57nGNIzHJjFk7vMfYn1dHL2iJjOLrQGq5CqeIfnIS7mwpFbm
         zMZA==
X-Received: by 10.66.248.68 with SMTP id yk4mr28519151pac.137.1367867967244;
        Mon, 06 May 2013 12:19:27 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id z8sm24951256pbt.23.2013.05.06.12.19.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 May 2013 12:19:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.338.gb35aa5d
In-Reply-To: <6276dc8861b40e8377586f30b85c33e92c4e68fe.1367867498.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1367867498.git.worldhello.net@gmail.com>
References: <CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com> <cover.1367867498.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223494>

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
index 43383..6bda3 100644
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
@@ -192,7 +258,9 @@ void edit_by_patterns_cmd()
 	while (1) {
 		/* dels list may become empty when we run string_list_remove_empty_items later */
 		if (!del_list.nr) {
+			clean_print_color(CLEAN_COLOR_ERROR);
 			printf_ln(_("No more files to clean, exiting."));
+			clean_print_color(CLEAN_COLOR_RESET);
 			break;
 		}
 
@@ -203,7 +271,9 @@ void edit_by_patterns_cmd()
 			pretty_print_dels();
 		}
 
+		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Input ignore patterns>> "));
+		clean_print_color(CLEAN_COLOR_RESET);
 		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
 			strbuf_trim(&confirm);
 		} else {
@@ -243,7 +313,9 @@ void edit_by_patterns_cmd()
 		if (changed) {
 			string_list_remove_empty_items(&del_list, 0);
 		} else {
+			clean_print_color(CLEAN_COLOR_ERROR);
 			printf_ln(_("WARNING: Cannot find items matched by: %s"), confirm.buf);
+			clean_print_color(CLEAN_COLOR_RESET);
 		}
 
 		strbuf_list_free(ignore_list);
@@ -261,16 +333,20 @@ void interactive_main_loop()
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
1.8.3.rc1.338.gb35aa5d
