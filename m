From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 04/10] git-clean: use a git-add-interactive compatible UI
Date: Wed,  8 May 2013 19:38:49 +0800
Message-ID: <e7cf5d7ffd83e238078b4585ac4bef4ec9a48e21.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
 <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
 <6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
 <d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 08 13:39:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua2ij-0001Lx-Jd
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab3EHLjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:39:24 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:53734 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab3EHLjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 07:39:22 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so1280858pad.37
        for <git@vger.kernel.org>; Wed, 08 May 2013 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=l84tXQx2wFL9WicHB4vUCKGTIAlJri3u59+jN5V5/B4=;
        b=bWTH3SyLRnTaQksVmNER3q+OfDRT2kPDIWQYMa/h3CMnbumBCA+iDSWPQFBYvAbrzd
         Y8hPnvk//Cw0eBtB7P+aZpOl0Adld6lPYKc0lQyCSNBpPMUMOYqgnop57lqTKw32LL8S
         Q6M6CH69l/63EJfGNnGvi7drM3ZAcGGIXtRZyoB4X9/eaKAn7dmcX+693AYVgwfQ6OKo
         RQ9IPtiKCLacjwUoTS0V06kJnuEUL9qK9IaLYOSbIY5gz8Q467LGOsqfiZ4fmEJF9FhK
         ymUHkGc9M+l0SEXuxDBAXbDhtWnOuxbnnYdC5JNNVjmeKqYVXICMcFaYucbgYKBoRuG4
         TJ/Q==
X-Received: by 10.66.164.195 with SMTP id ys3mr7673224pab.89.1368013162217;
        Wed, 08 May 2013 04:39:22 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id gc5sm32287860pbb.19.2013.05.08.04.39.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 04:39:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g1c24ab7
In-Reply-To: <d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223661>

Rewrite menu using a new method `list_and_choose`, which is borrowed
from `git-add--interactive.perl`. We can reused this method later for
more actions.

Please NOTE:

 * Method `list_and_choose` return an array of integers, and
 * it is up to you to free the allocated memory of the array.
 * The array ends with EOF.
 * If user pressed CTRL-D (i.e. EOF), no selection returned.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 469 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 428 insertions(+), 41 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 9b029..10f3 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -51,6 +51,36 @@ enum color_clean {
 	CLEAN_COLOR_ERROR = 5,
 };
 
+#define MENU_OPTS_SINGLETON		01
+#define MENU_OPTS_IMMEDIATE		02
+#define MENU_OPTS_LIST_ONLY		04
+
+struct menu_opts {
+	const char *header;
+	const char *prompt;
+	int flag;
+};
+
+#define MENU_RETURN_NO_LOOP		10
+
+struct menu_item {
+	char hotkey;
+	char *title;
+	int selected;
+	int (*fn)();
+};
+
+enum menu_stuff_type {
+	MENU_STUFF_TYPE_STRING_LIST = 1,
+	MENU_STUFF_TYPE_MENU_ITEM
+};
+
+struct menu_stuff {
+	enum menu_stuff_type type;
+	int nr;
+	void *stuff;
+};
+
 static int parse_clean_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "reset"))
@@ -240,12 +270,345 @@ static void pretty_print_dels()
 	copts.indent = "  ";
 	copts.padding = 2;
 	print_columns(&list, colopts, &copts);
-	putchar('\n');
 	strbuf_release(&buf);
 	string_list_clear(&list, 0);
 }
 
-static void edit_by_patterns_cmd()
+static void pretty_print_menus(struct string_list *menu_list)
+{
+	unsigned int local_colopts = 0;
+	struct column_options copts;
+
+	local_colopts = COL_ENABLED | COL_ROW;
+	memset(&copts, 0, sizeof(copts));
+	copts.indent = "  ";
+	copts.padding = 2;
+	print_columns(menu_list, local_colopts, &copts);
+}
+
+static void prompt_help_cmd(int singleton)
+{
+	clean_print_color(CLEAN_COLOR_HELP);
+	printf_ln(singleton ?
+		  _("Prompt help:\n"
+		    "1          - select a numbered item\n"
+		    "foo        - select item based on unique prefix\n"
+		    "           - (empty) select nothing") :
+		  _("Prompt help:\n"
+		    "1          - select a single item\n"
+		    "3-5        - select a range of items\n"
+		    "2-3,6-9    - select multiple ranges\n"
+		    "foo        - select item based on unique prefix\n"
+		    "-...       - unselect specified items\n"
+		    "*          - choose all items\n"
+		    "           - (empty) finish selecting"));
+	clean_print_color(CLEAN_COLOR_RESET);
+}
+
+/*
+ * display menu stuff with number prefix and hotkey highlight
+ */
+static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
+{
+	static struct string_list menu_list = STRING_LIST_INIT_DUP;
+	struct strbuf menu = STRBUF_INIT;
+	int i;
+
+	/* highlight hotkey in menu */
+	if (MENU_STUFF_TYPE_MENU_ITEM == stuff->type) {
+		struct menu_item *item;
+
+		item = (struct menu_item *)stuff->stuff;
+		for (i = 0; i < stuff->nr; i++, item++) {
+			char *p;
+			int highlighted = 0;
+
+			p = item->title;
+			if ((*chosen)[i] < 0)
+				(*chosen)[i] = item->selected ? 1 : 0;
+			strbuf_addf(&menu, "%s%2d: ", (*chosen)[i] ? "*" : " ", i+1);
+			for (; *p; p++) {
+				if (!highlighted && *p == item->hotkey) {
+					strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_PROMPT));
+					strbuf_addch(&menu, *p);
+					strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_RESET));
+					highlighted = 1;
+				} else {
+					strbuf_addch(&menu, *p);
+				}
+			}
+			string_list_append(&menu_list, menu.buf);
+			strbuf_reset(&menu);
+		}
+	} else if (MENU_STUFF_TYPE_STRING_LIST == stuff->type) {
+		struct string_list_item *item;
+		struct strbuf buf = STRBUF_INIT;
+		i = 0;
+
+		for_each_string_list_item(item, (struct string_list *)stuff->stuff) {
+			const char *qname;
+
+			if ((*chosen)[i] < 0)
+				(*chosen)[i] = 0;
+			qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
+			strbuf_addf(&menu, "%s%2d: %s", (*chosen)[i] ? "*" : " ", ++i, qname);
+			string_list_append(&menu_list, menu.buf);
+			strbuf_reset(&menu);
+		}
+		strbuf_release(&buf);
+	}
+
+	pretty_print_menus(&menu_list);
+
+	strbuf_release(&menu);
+	string_list_clear(&menu_list, 0);
+}
+
+/*
+ * Parse user input, and return choice(s) for menu (menu_stuff).
+ *
+ * Input
+ *     (for single choice)
+ *         1          - select a numbered item
+ *         foo        - select item based on menu title
+ *                    - (empty) select nothing
+ *
+ *     (for multiple choice)
+ *         1          - select a single item
+ *         3-5        - select a range of items
+ *         2-3,6-9    - select multiple ranges
+ *         foo        - select item based on menu title
+ *         -...       - unselect specified items
+ *         *          - choose all items
+ *                    - (empty) finish selecting
+ *
+ * The parse result will be saved in array **chosen, and
+ * return number of total selections.
+ */
+static int parse_choice(struct menu_stuff *menu_stuff,
+			int is_single,
+			struct strbuf input,
+			int **chosen)
+{
+	struct strbuf **choice_list, **choice_p;
+	int nr = 0;
+	int i;
+
+	if (is_single) {
+		choice_list = strbuf_split_max(&input, '\n', 0);
+	} else {
+		char *p = input.buf;
+		do {
+			if (*p == ',')
+				*p = ' ';
+		} while (*p++);
+		choice_list = strbuf_split_max(&input, ' ', 0);
+	}
+
+	for (choice_p = choice_list; *choice_p; choice_p++) {
+		char *p;
+		int choose = 1;
+		int bottom = 0, top = 0;
+		int is_range, is_number;
+
+		strbuf_trim(*choice_p);
+		if (!(*choice_p)->len)
+			continue;
+
+		/* Input that begins with '-'; unchoose */
+		if (*(*choice_p)->buf == '-') {
+			choose = 0;
+			strbuf_remove((*choice_p), 0, 1);
+		}
+
+		is_range = 0;
+		is_number = 1;
+		for(p = (*choice_p)->buf; *p; p++) {
+			if ('-' == *p) {
+				if (!is_range) {
+					is_range = 1;
+					is_number = 0;
+				} else {
+					is_number = 0;
+					is_range = 0;
+					break;
+				}
+			} else if (!isdigit(*p)) {
+				is_number = 0;
+				is_range = 0;
+				break;
+			}
+		}
+
+		if (is_number) {
+			bottom = atoi((*choice_p)->buf);
+			top = bottom;
+		} else if (is_range) {
+			bottom = atoi((*choice_p)->buf);
+			if (!*(strchr((*choice_p)->buf, '-') + 1)) {
+				top = menu_stuff->nr - 1;
+			} else {
+				top = atoi(strchr((*choice_p)->buf, '-') + 1);
+			}
+		} else if (!strcmp((*choice_p)->buf, "*")) {
+			bottom = 1;
+			top = menu_stuff->nr;
+		} else {
+			if (MENU_STUFF_TYPE_MENU_ITEM == menu_stuff->type) {
+				struct menu_item *item;
+
+				item = (struct menu_item *)menu_stuff->stuff;
+				for (i = 0; i < menu_stuff->nr; i++, item++) {
+					if (((*choice_p)->len == 1 &&
+					     *(*choice_p)->buf == item->hotkey) ||
+					    !strcasecmp((*choice_p)->buf, item->title)) {
+						bottom = i + 1;
+						top = bottom;
+						break;
+					}
+				}
+			} else if (MENU_STUFF_TYPE_STRING_LIST == menu_stuff->type) {
+				struct string_list_item *item;
+
+				item = ((struct string_list *)menu_stuff->stuff)->items;
+				for (i = 0; i < menu_stuff->nr; i++, item++) {
+					if (!strcasecmp((*choice_p)->buf, item->string)) {
+						bottom = i + 1;
+						top = bottom;
+						break;
+					}
+				}
+			}
+		}
+
+		if (top <= 0 || bottom <= 0 || top > menu_stuff->nr || bottom > top ||
+		    (is_single && bottom != top)) {
+			clean_print_color(CLEAN_COLOR_ERROR);
+			printf_ln(_("Huh (%s)?"), (*choice_p)->buf);
+			clean_print_color(CLEAN_COLOR_RESET);
+			continue;
+		}
+
+		/* A range can be specified like 5-7 or 5-. */
+		for (i = bottom; i <= top; i++)
+			(*chosen)[i-1] = choose;
+	}
+
+	strbuf_list_free(choice_list);
+
+	for (i = 0; i < menu_stuff->nr; i++)
+		nr += (*chosen)[i];
+	return nr;
+}
+
+/*
+ * Implement a git-add-interactive compatible UI, which is borrowed
+ * from git-add--interactive.perl.
+ *
+ * Return value:
+ *
+ *   - Return an array of integers
+ *   - , and it is up to you to free the allocated memory.
+ *   - The array ends with EOF.
+ *   - If user pressed CTRL-D (i.e. EOF), no selection returned.
+ */
+static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
+{
+	struct strbuf choice = STRBUF_INIT;
+	int *chosen, *result;
+	int nr = 0;
+	int eof = 0;
+	int i;
+
+	chosen = xmalloc(sizeof(int) * stuff->nr);
+	/* set chosen as uninitialized */
+	for (i = 0; i < stuff->nr; i++)
+		chosen[i] = -1;
+
+	while (1) {
+		if (opts->header) {
+			printf_ln("%s%s%s",
+				  clean_get_color(CLEAN_COLOR_HEADER),
+				  opts->header,
+				  clean_get_color(CLEAN_COLOR_RESET));
+		}
+
+		/* the chosen array can be initialized by menu_item.selected  */
+		print_highlight_menu_stuff(stuff, &chosen);
+
+		if (opts->flag & MENU_OPTS_LIST_ONLY)
+			break;
+
+		if (opts->prompt) {
+			printf("%s%s%s%s",
+			       clean_get_color(CLEAN_COLOR_PROMPT),
+			       opts->prompt,
+			       opts->flag & MENU_OPTS_SINGLETON ? "> " : ">> ",
+			       clean_get_color(CLEAN_COLOR_RESET));
+		}
+
+		if (strbuf_getline(&choice, stdin, '\n') != EOF) {
+			strbuf_trim(&choice);
+		} else {
+			eof = 1;
+			break;
+		}
+
+		/* help for prompt */
+		if (!strcmp(choice.buf, "?")) {
+			prompt_help_cmd(opts->flag & MENU_OPTS_SINGLETON);
+			continue;
+		}
+
+		/* for a multiple-choice menu, press ENTER (empty) will return back */
+		if (!(opts->flag & MENU_OPTS_SINGLETON) && !choice.len)
+			break;
+
+		nr = parse_choice(stuff,
+				  opts->flag & MENU_OPTS_SINGLETON,
+				  choice,
+				  &chosen);
+
+		if (opts->flag & MENU_OPTS_SINGLETON) {
+			if (nr)
+				break;
+		} else if (opts->flag & MENU_OPTS_IMMEDIATE) {
+			break;
+		}
+	}
+
+	if (eof) {
+		result = xmalloc(sizeof(int));
+		*result = EOF;
+	} else {
+		int j = 0;
+
+		/* recalculate nr, for a multiple-choice menu with initial selections */
+		if (!nr) {
+			for (i = 0; i < stuff->nr; i++)
+				nr += chosen[i];
+		}
+
+		result = xmalloc(sizeof(int) * (nr + 1));
+		memset(result, 0, sizeof(int) * (nr + 1));
+		for (i = 0; i < stuff->nr && j < nr; i++) {
+			if (chosen[i])
+				result[j++] = i;
+		}
+		result[j] = EOF;
+	}
+
+	free(chosen);
+	strbuf_release(&choice);
+	return result;
+}
+
+static int clean_cmd()
+{
+	return MENU_RETURN_NO_LOOP;
+}
+
+static int edit_by_patterns_cmd()
 {
 	struct dir_struct dir;
 	struct strbuf confirm = STRBUF_INIT;
@@ -257,16 +620,10 @@ static void edit_by_patterns_cmd()
 
 	while (1) {
 		/* dels list may become empty when we run string_list_remove_empty_items later */
-		if (!del_list.nr) {
-			clean_print_color(CLEAN_COLOR_ERROR);
-			printf_ln(_("No more files to clean, exiting."));
-			clean_print_color(CLEAN_COLOR_RESET);
+		if (!del_list.nr)
 			break;
-		}
 
 		if (changed) {
-			putchar('\n');
-
 			/* Display dels in columns */
 			pretty_print_dels();
 		}
@@ -324,56 +681,86 @@ static void edit_by_patterns_cmd()
 
 	strbuf_release(&buf);
 	strbuf_release(&confirm);
+	return 0;
 }
 
-static void interactive_main_loop()
+static int quit_cmd()
 {
-	struct strbuf confirm = STRBUF_INIT;
+	string_list_clear(&del_list, 0);
+	printf_ln(_("Bye."));
+	return MENU_RETURN_NO_LOOP;
+}
 
+static int help_cmd(int x)
+{
+	clean_print_color(CLEAN_COLOR_HELP);
+	printf_ln(_(
+		    "clean            - start cleaning\n"
+		    "edit by patterns - exclude items from deletion\n"
+		    "quit             - stop cleaning\n"
+		    "help             - this screen\n"
+		    "?                - help for prompt selection"
+		   ));
+	clean_print_color(CLEAN_COLOR_RESET);
+	return 0;
+}
+
+static void interactive_main_loop()
+{
 	/* dels list may become empty after return back from edit mode */
 	while (del_list.nr) {
-		putchar('\n');
+		struct menu_opts menu_opts;
+		struct menu_stuff menu_stuff;
+		struct menu_item menus[] = {
+			{'c', "clean",			0, clean_cmd},
+			{'p', "edit by patterns",	0, edit_by_patterns_cmd},
+			{'q', "quit",			0, quit_cmd},
+			{'h', "help",			0, help_cmd},
+		};
+		int *chosen;
+
+		menu_opts.header = _("*** Commands ***");
+		menu_opts.prompt = "What now";
+		menu_opts.flag = MENU_OPTS_SINGLETON;
+
+		menu_stuff.type = MENU_STUFF_TYPE_MENU_ITEM;
+		menu_stuff.stuff = menus;
+		menu_stuff.nr = sizeof(menus) / sizeof(struct menu_item);
+
 		clean_print_color(CLEAN_COLOR_HEADER);
 		printf_ln(Q_("Would remove the following item:",
 			     "Would remove the following items:",
 			     del_list.nr));
 		clean_print_color(CLEAN_COLOR_RESET);
-		putchar('\n');
 
-		/* Display dels in columns */
+		/* display dels in columns */
 		pretty_print_dels();
 
-		/* Confirmation dialog */
-		clean_print_color(CLEAN_COLOR_PROMPT);
-		printf(_("Remove ([y]es/[n]o/[e]dit) ? "));
-		clean_print_color(CLEAN_COLOR_RESET);
-		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
-			strbuf_trim(&confirm);
-		} else {
-			/* Ctrl-D is the same as "quit" */
-			string_list_clear(&del_list, 0);
-			putchar('\n');
-			printf_ln("Bye.");
-			break;
-		}
-
-		if (confirm.len) {
-			if (!strncasecmp(confirm.buf, "yes", confirm.len)) {
-				break;
-			} else if (!strncasecmp(confirm.buf, "no", confirm.len) ||
-				   !strncasecmp(confirm.buf, "quit", confirm.len)) {
-				string_list_clear(&del_list, 0);
-				printf_ln("Bye.");
-				break;
-			} else if (!strncasecmp(confirm.buf, "edit", confirm.len)) {
-				edit_by_patterns_cmd();
-			} else {
+		/* main menu */
+		chosen = list_and_choose(&menu_opts, &menu_stuff);
+
+		if (*chosen != EOF) {
+			int ret;
+			ret = menus[*chosen].fn(1);
+			if (ret != MENU_RETURN_NO_LOOP) {
+				free(chosen);
+				chosen = NULL;
+				if (!del_list.nr) {
+					clean_print_color(CLEAN_COLOR_ERROR);
+					printf_ln(_("No more files to clean, exiting."));
+					clean_print_color(CLEAN_COLOR_RESET);
+					break;
+				}
 				continue;
 			}
+		} else {
+			quit_cmd();
 		}
-	}
 
-	strbuf_release(&confirm);
+		free(chosen);
+		chosen = NULL;
+		break;
+	}
 }
 
 int cmd_clean(int argc, const char **argv, const char *prefix)
-- 
1.8.3.rc1.341.g1c24ab7
