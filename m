From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 3/3] Add colors to interactive git-clean
Date: Thu,  2 May 2013 21:15:04 +0800
Message-ID: <bb5463fa4ef09df08ad3bf5abf4660a5df414e64.1367500374.git.worldhello.net@gmail.com>
References: <6e795640952cad0eb25cb0db4243b2712f11e957.1367500374.git.worldhello.net@gmail.com>
 <3b80db3d2e8f31b1d9373406cce3cbdee2094a29.1367500374.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:15:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXtMH-0007dW-39
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759196Ab3EBNP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:15:27 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:48868 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918Ab3EBNP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:15:26 -0400
Received: by mail-pb0-f42.google.com with SMTP id up7so343484pbc.29
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=367JBZQhsvhaPunLwbzXPXoJ98AJbo0lbjDuoytdxX0=;
        b=Q2i9JOInXPrNL/MAQ9YTpyGLyN9pgEgdDmYWR7Kp/ugE9IE7jfybHoDyhJg5/UGod/
         LE8HKZeN2dCIMo7bl2JW0vp/oe7HLZnfS+3aML4OjQ3YCZNrdiRcZIlZ8M7H0jEq00U9
         z+FKHzObZ31i2y7llyJCRmdl8WjysN2yjW9xDgYUQTTvSVXSfdWRtiLaERKtjgGp87Y+
         1Ixfqk+ctVAb6E01uYWzpeGnpiL0GeIGkf0KFwWaGd0iX7M8CkOdGKL2o/UWYoLLgWr3
         TiFu3z080zsCs2J+0iW3tFraWt84ktQVFvKGkSxoscGEtg/0khk9ZkBTrQhWRuM1Bs07
         NP+A==
X-Received: by 10.66.88.105 with SMTP id bf9mr9639251pab.175.1367500526133;
        Thu, 02 May 2013 06:15:26 -0700 (PDT)
Received: from localhost.localdomain ([114.246.126.106])
        by mx.google.com with ESMTPSA id ux10sm8293841pab.1.2013.05.02.06.15.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:15:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.364.gbb5463f
In-Reply-To: <3b80db3d2e8f31b1d9373406cce3cbdee2094a29.1367500374.git.worldhello.net@gmail.com>
In-Reply-To: <vpq38u6n397.fsf@grenoble-inp.fr>
References: <vpq38u6n397.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223196>

Show help, error messages, and prompt in colors for interactive
git-clean. Re-use config variables from git-add--interactive:

 * color.interactive: When set to always, always use colors for
   interactive prompts and displays. When false (or never),
   never. When set to true or auto, use colors only when the
   output is to the terminal.

 * color.interactive.<slot>: Use customized color for interactive
   git-clean output (like git add --interactive). <slot> may be
   prompt, header, help or error.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index ac48e..c85b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -14,6 +14,7 @@
 #include "string-list.h"
 #include "quote.h"
 #include "column.h"
+#include "color.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -30,15 +31,71 @@ static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
 
+static int clean_use_color = -1;
+static char clean_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RESET,
+	GIT_COLOR_NORMAL,	/* PLAIN */
+	GIT_COLOR_BOLD_BLUE,	/* PROMPT */
+	GIT_COLOR_BOLD_RED,	/* HELP */
+	GIT_COLOR_BOLD_RED,	/* ERROR */
+};
+enum color_clean {
+	CLEAN_COLOR_RESET = 0,
+	CLEAN_COLOR_PLAIN = 1,
+	CLEAN_COLOR_PROMPT = 2,
+	CLEAN_COLOR_HELP = 3,
+	CLEAN_COLOR_ERROR = 4
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
 	if (!strcmp(var, "clean.requireforce")) {
 		force = !git_config_bool(var, value);
 		return 0;
 	}
-	return git_default_config(var, value, cb);
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
@@ -190,16 +247,20 @@ void interactive_clean_edit(struct string_list *dels, const char *prefix)
 	while (1) {
 		/* dels list may become empty when we run string_list_remove_empty_items later */
 		if (!dels->nr) {
+			clean_print_color(CLEAN_COLOR_ERROR);
 			printf_ln(_("No more files to clean, exiting."));
+			clean_print_color(CLEAN_COLOR_RESET);
 			break;
 		}
 
 		if (changed) {
+			clean_print_color(CLEAN_COLOR_HELP);
 			printf(_(
 				 "NOTE: Will remove the following items. You can input space-seperated\n"
 				 "NOTE: patterns (just like .gitignore) to exclude items from deletion,\n"
 				 "NOTE: or press ENTER to continue."
 				));
+			clean_print_color(CLEAN_COLOR_RESET);
 			putchar('\n');
 			putchar('\n');
 
@@ -207,7 +268,9 @@ void interactive_clean_edit(struct string_list *dels, const char *prefix)
 			pretty_print_dels(dels, prefix);
 		}
 
+		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Input ignore patterns> "));
+		clean_print_color(CLEAN_COLOR_RESET);
 		strbuf_getline(&confirm, stdin, '\n');
 		strbuf_trim(&confirm);
 		putchar('\n');
@@ -244,7 +307,9 @@ void interactive_clean_edit(struct string_list *dels, const char *prefix)
 		if (changed) {
 			string_list_remove_empty_items(dels, 0);
 		} else {
+			clean_print_color(CLEAN_COLOR_ERROR);
 			printf(_("WARNING: Cannot find items matched by: %s"), confirm.buf);
+			clean_print_color(CLEAN_COLOR_RESET);
 			putchar('\n');
 		}
 
@@ -263,6 +328,7 @@ void interactive_clean(struct string_list *dels, const char *prefix)
 
 	/* dels list may become empty after return back from edit mode */
 	while (dels->nr) {
+		clean_print_color(CLEAN_COLOR_HELP);
 		printf_ln(_(
 			    "WARNING: The following items will be removed permanently. Press \"y\"\n"
 			    "WARNING: to start cleaning, and press \"n\" to abort the cleaning.\n"
@@ -270,12 +336,15 @@ void interactive_clean(struct string_list *dels, const char *prefix)
 			    "WARNING: to be excluded from the cleaning."
 			   ));
 		putchar('\n');
+		clean_print_color(CLEAN_COLOR_RESET);
 
 		/* Display dels in columns */
 		pretty_print_dels(dels, prefix);
 
 		/* Confirmation dialog */
+		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(count > 0 ? _("Remove (Yes/no/edit) ? ") : _("Remove (yes/no/Edit) ? "));
+		clean_print_color(CLEAN_COLOR_RESET);
 		strbuf_getline(&confirm, stdin, '\n');
 		strbuf_trim(&confirm);
 		putchar('\n');
-- 
1.8.3.rc0.364.gbb5463f
