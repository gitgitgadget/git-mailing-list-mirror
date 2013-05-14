From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v9 5/9] git-clean: use a git-add-interactive compatible UI
Date: Tue, 14 May 2013 16:45:19 +0800
Message-ID: <06429848f012b2fd1e9dc6aff5ca3004b5a63a47.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 14 10:47:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcAsv-0003OM-MF
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 10:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020Ab3ENIqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 04:46:52 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:45254 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731Ab3ENIqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 04:46:05 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so237682pdj.26
        for <git@vger.kernel.org>; Tue, 14 May 2013 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=CajDGRAVb1yO+npFv2oEDxuFactF9WcTVVw6eyAf4Mg=;
        b=F5SYlP0rILvDpiNEwRZ2f8TDIVfnDxS+D35m31wgpouCy58ik73JEMojiUgx1Yha9R
         XahB2nGLluWhRTNxCCX+mFSsdYWc8hAkv7iIOcXtedvHCOvPg0can3kaErnU1mHVmpnp
         9x5dZ4LzynpzfQmDKTy/M+LXoCWXtrF/PjR8lM1KO3pLZ40PPMnE7KMyY4DIDv5ZBNNQ
         uxbh+rcKERhl8hPSfOx19KSahlB0nCQcTHXW9QmLAbC1oiY1Qo3xnyOCQEsqe30ilt5M
         NR2jGs8f8OobzfPEA7dlJtStPiJzf2N3mkzlLqF5MDKPwkfYCHtIjIIuuPgptfrFBYU4
         26YA==
X-Received: by 10.68.253.230 with SMTP id ad6mr32167575pbd.182.1368521165000;
        Tue, 14 May 2013 01:46:05 -0700 (PDT)
Received: from localhost.localdomain ([114.248.141.128])
        by mx.google.com with ESMTPSA id wt5sm17356069pbc.38.2013.05.14.01.46.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 01:46:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.401.gfc9adf8
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224293>

Rewrite menu using a new method `list_and_choose`, which is borrowed
from `git-add--interactive.perl`. We will use this framework to add
new actions for interactive git-clean later.

Please NOTE:

 * Method `list_and_choose` return an array of integers, and
 * it is up to you to free the allocated memory of the array.
 * The array ends with EOF.
 * If user pressed CTRL-D (i.e. EOF), no selection returned.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 449 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 420 insertions(+), 29 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 5c781..7930f 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -50,6 +50,36 @@ enum color_clean {
 	CLEAN_COLOR_ERROR = 5,
 };
 
+#define MENU_OPTS_SINGLETON		01
+#define MENU_OPTS_IMMEDIATE		02
+#define MENU_OPTS_LIST_ONLY		04
+
+struct menu_opts {
+	const char *header;
+	const char *prompt;
+	int flags;
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
 static int parse_clean_color_slot(const char *var)
 {
 	if (!strcasecmp(var, "reset"))
@@ -282,54 +312,415 @@ static void pretty_print_dels(void)
 	copts.indent = "  ";
 	copts.padding = 2;
 	print_columns(&list, colopts, &copts);
-	putchar('\n');
 	strbuf_release(&buf);
 	string_list_clear(&list, 0);
 }
 
-static void interactive_main_loop(void)
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
+	struct string_list menu_list = STRING_LIST_INIT_DUP;
+	struct strbuf menu = STRBUF_INIT;
+	int i;
+
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
+			if ((*chosen)[i] < 0)
+				(*chosen)[i] = 0;
+			strbuf_addf(&menu, "%s%2d: %s", (*chosen)[i] ? "*" : " ", ++i, item->string);
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
+	struct strbuf **choice_list, **ptr;
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
+	for (ptr = choice_list; *ptr; ptr++) {
+		char *p;
+		int choose = 1;
+		int bottom = 0, top = 0;
+		int is_range, is_number;
+
+		strbuf_trim(*ptr);
+		if (!(*ptr)->len)
+			continue;
+
+		/* Input that begins with '-'; unchoose */
+		if (*(*ptr)->buf == '-') {
+			choose = 0;
+			strbuf_remove((*ptr), 0, 1);
+		}
+
+		is_range = 0;
+		is_number = 1;
+		for(p = (*ptr)->buf; *p; p++) {
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
+			bottom = atoi((*ptr)->buf);
+			top = bottom;
+		} else if (is_range) {
+			bottom = atoi((*ptr)->buf);
+			/* a range can be specified like 5-7 or 5- */
+			if (!*(strchr((*ptr)->buf, '-') + 1)) {
+				top = menu_stuff->nr - 1;
+			} else {
+				top = atoi(strchr((*ptr)->buf, '-') + 1);
+			}
+		} else if (!strcmp((*ptr)->buf, "*")) {
+			bottom = 1;
+			top = menu_stuff->nr;
+		} else {
+			if (MENU_STUFF_TYPE_MENU_ITEM == menu_stuff->type) {
+				struct menu_item *item;
+
+				item = (struct menu_item *)menu_stuff->stuff;
+				for (i = 0; i < menu_stuff->nr; i++, item++) {
+					if (((*ptr)->len == 1 &&
+					     *(*ptr)->buf == item->hotkey) ||
+					    !strcasecmp((*ptr)->buf, item->title)) {
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
+					if (!strcasecmp((*ptr)->buf, item->string)) {
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
+			printf_ln(_("Huh (%s)?"), (*ptr)->buf);
+			clean_print_color(CLEAN_COLOR_RESET);
+			continue;
+		}
+
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
+	for (;;) {
+		if (opts->header) {
+			printf_ln("%s%s%s",
+				  clean_get_color(CLEAN_COLOR_HEADER),
+				  _(opts->header),
+				  clean_get_color(CLEAN_COLOR_RESET));
+		}
+
+		/* chosen will be initialized by print_highlight_menu_stuff */
+		print_highlight_menu_stuff(stuff, &chosen);
+
+		if (opts->flags & MENU_OPTS_LIST_ONLY)
+			break;
+
+		if (opts->prompt) {
+			printf("%s%s%s%s",
+			       clean_get_color(CLEAN_COLOR_PROMPT),
+			       _(opts->prompt),
+			       opts->flags & MENU_OPTS_SINGLETON ? "> " : ">> ",
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
+			prompt_help_cmd(opts->flags & MENU_OPTS_SINGLETON);
+			continue;
+		}
+
+		/* for a multiple-choice menu, press ENTER (empty) will return back */
+		if (!(opts->flags & MENU_OPTS_SINGLETON) && !choice.len)
+			break;
+
+		nr = parse_choice(stuff,
+				  opts->flags & MENU_OPTS_SINGLETON,
+				  choice,
+				  &chosen);
+
+		if (opts->flags & MENU_OPTS_SINGLETON) {
+			if (nr)
+				break;
+		} else if (opts->flags & MENU_OPTS_IMMEDIATE) {
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
+		/*
+		 * recalculate nr, if return back from menu directly with
+		 * default selections.
+		 */
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
+static int clean_cmd(void)
+{
+	return MENU_RETURN_NO_LOOP;
+}
+
+static int quit_cmd(void)
+{
+	string_list_clear(&del_list, 0);
+	printf_ln(_("Bye."));
+	return MENU_RETURN_NO_LOOP;
+}
+
+static int help_cmd(void)
 {
-	struct strbuf confirm = STRBUF_INIT;
+	clean_print_color(CLEAN_COLOR_HELP);
+	printf_ln(_(
+		    "clean               - start cleaning\n"
+		    "quit                - stop cleaning\n"
+		    "help                - this screen\n"
+		    "?                   - help for prompt selection"
+		   ));
+	clean_print_color(CLEAN_COLOR_RESET);
+	return 0;
+}
 
+static void interactive_main_loop(void)
+{
 	while (del_list.nr) {
-		putchar('\n');
+		struct menu_opts menu_opts;
+		struct menu_stuff menu_stuff;
+		struct menu_item menus[] = {
+			{'c', "clean",			0, clean_cmd},
+			{'q', "quit",			0, quit_cmd},
+			{'h', "help",			0, help_cmd},
+		};
+		int *chosen;
+
+		menu_opts.header = N_("*** Commands ***");
+		menu_opts.prompt = N_("What now");
+		menu_opts.flags = MENU_OPTS_SINGLETON;
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
 
 		pretty_print_dels();
 
-		clean_print_color(CLEAN_COLOR_PROMPT);
-		printf(_("Remove [y/n]? "));
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
-			} else {
+		chosen = list_and_choose(&menu_opts, &menu_stuff);
+
+		if (*chosen != EOF) {
+			int ret;
+			ret = menus[*chosen].fn();
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
1.8.3.rc1.404.gb9fcf3e
