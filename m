From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 3/3] Add colors to interactive git-clean
Date: Fri,  3 May 2013 11:49:55 +0800
Message-ID: <6e5487033b0f2cef49bd19e35825e3b0ddd1f58e.1367551846.git.worldhello.net@gmail.com>
References: <cover.1367551846.git.worldhello.net@gmail.com>
 <63984814a9679ca8eedecda308bd1131658e95d6.1367551846.git.worldhello.net@gmail.com>
 <4f3bc9f30c0f544d16bef5b2a5ea4f5412ca3b36.1367551846.git.worldhello.net@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 03 05:50:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY710-0000lZ-Ny
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 05:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761426Ab3ECDuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 23:50:22 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:38846 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762388Ab3ECDuU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 23:50:20 -0400
Received: by mail-da0-f49.google.com with SMTP id p5so614660dak.36
        for <git@vger.kernel.org>; Thu, 02 May 2013 20:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=B36fOcZWoHscrciMPf2nwVjTQ9VpnnRUFURtUJdnoe4=;
        b=jdMdCN27Sk8XFmsDAXFnTw4cLxV/yXFY7l8gvYIL7JjvzOhZR57dRDiFbs0cuPap2F
         iXyBvrB6m5Hk6/Gn49jrzo6rsNjRz6pA+4U3u4QC2WvRm+hqRseWaprYGvVoUUVI0a5j
         Y5VsIlSvmnNCy8lVj+tgJLeUZGApoh3OeltEimU5YiiKdNbb7KU5umT0HSwiy+4mp+9b
         T2moBxGi+I0vyXaXaeoIb7d8ihD1yZTTE2ALYl/3gKabh8QR5OzcP4iYVyoPIrntdqlq
         SSbBEeuemvHahEswSKdoXl/pJ1QTtZDwu/zPI/57QEGAVxZzbmFu0glCwQDhRpAEaexz
         0E8A==
X-Received: by 10.66.251.161 with SMTP id zl1mr12764232pac.54.1367553019559;
        Thu, 02 May 2013 20:50:19 -0700 (PDT)
Received: from localhost.localdomain ([114.246.126.106])
        by mx.google.com with ESMTPSA id qb1sm9819651pbb.33.2013.05.02.20.50.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 20:50:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.364.g6e54870
In-Reply-To: <4f3bc9f30c0f544d16bef5b2a5ea4f5412ca3b36.1367551846.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1367551846.git.worldhello.net@gmail.com>
References: <cover.1367551846.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223273>

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
 builtin/clean.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 6ee7..1692b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -14,6 +14,7 @@
 #include "string-list.h"
 #include "quote.h"
 #include "column.h"
+#include "color.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -30,17 +31,82 @@ static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
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
 	/* honors the column.ui config variable only */
 	if (!prefixcmp(var, "column."))
 		return git_column_config(var, value, NULL, &colopts);
 
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
@@ -189,16 +255,20 @@ void interactive_clean_edit(struct string_list *dels, const char *prefix)
 	int changed = -1, i;
 
 	putchar('\n');
+	clean_print_color(CLEAN_COLOR_HELP);
 	printf_ln(_(
 		    "NOTE: Will remove the following items. You can input space-seperated\n"
 		    "NOTE: patterns (just like .gitignore) to exclude items from deletion,\n"
 		    "NOTE: or press ENTER to continue."
 		   ));
+	clean_print_color(CLEAN_COLOR_RESET);
 
 	while (1) {
 		/* dels list may become empty when we run string_list_remove_empty_items later */
 		if (!dels->nr) {
+			clean_print_color(CLEAN_COLOR_ERROR);
 			printf_ln(_("No more files to clean, exiting."));
+			clean_print_color(CLEAN_COLOR_RESET);
 			break;
 		}
 
@@ -209,7 +279,9 @@ void interactive_clean_edit(struct string_list *dels, const char *prefix)
 			pretty_print_dels(dels, prefix);
 		}
 
+		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Input ignore patterns> "));
+		clean_print_color(CLEAN_COLOR_RESET);
 		strbuf_getline(&confirm, stdin, '\n');
 		strbuf_trim(&confirm);
 
@@ -245,7 +317,9 @@ void interactive_clean_edit(struct string_list *dels, const char *prefix)
 		if (changed) {
 			string_list_remove_empty_items(dels, 0);
 		} else {
+			clean_print_color(CLEAN_COLOR_ERROR);
 			printf_ln(_("WARNING: Cannot find items matched by: %s"), confirm.buf);
+			clean_print_color(CLEAN_COLOR_RESET);
 		}
 
 		strbuf_list_free(ignore_list);
@@ -264,19 +338,23 @@ void interactive_clean(struct string_list *dels, const char *prefix)
 	/* dels list may become empty after return back from edit mode */
 	while (dels->nr) {
 		putchar('\n');
+		clean_print_color(CLEAN_COLOR_HEADER);
 		printf_ln(_(
 			    "WARNING: The following items will be removed permanently. Press \"y\"\n"
 			    "WARNING: to start cleaning, and press \"n\" to abort the cleaning.\n"
 			    "WARNING: You can also enter the \"edit\" mode, and select items\n"
 			    "WARNING: to be excluded from the cleaning."
 			   ));
+		clean_print_color(CLEAN_COLOR_RESET);
 		putchar('\n');
 
 		/* Display dels in columns */
 		pretty_print_dels(dels, prefix);
 
 		/* Confirmation dialog */
+		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(count > 0 ? _("Remove (Yes/no/edit) ? ") : _("Remove (yes/no/Edit) ? "));
+		clean_print_color(CLEAN_COLOR_RESET);
 		strbuf_getline(&confirm, stdin, '\n');
 		strbuf_trim(&confirm);
 
-- 
1.8.3.rc0.364.gc6aefbf
