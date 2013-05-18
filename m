From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 00/15] Interactive git-clean
Date: Sat, 18 May 2013 11:18:52 +0800
Message-ID: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:19:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXgS-0004GC-0I
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759357Ab3ERDT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:19:26 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34273 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758596Ab3ERDTW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:19:22 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so4138978pad.2
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=R6kKDUCVQBM5wL2bT5zi309+tq/F5wC7+uOJhxJ9+9Y=;
        b=t3bVmXEZR5xYkIWvxvKX7KVaHsErT2OL9op2vDDK3PQPBV+ijE9wFlU9rXMihbPPGr
         EF8q98rjSEr4QtUU30d4djyvzDvbhshikLsfbYpuAedOVsdVJ7OwOtEPBMYzh2OYrYjo
         FYXs8o4qsSIuM7GDRLAmoBAWEnO8g+6pWFX483hTdVJbtOt+4I919GrvB/oEvFSE9fTM
         qNumHhbNF2LWwV7lv6hs/YR9mMFm/yxCw9oldFPuC6dxg0+gmrWFY29OhTO3KcrAc96U
         xrSxMrVq5JYdOFJrtcW04N5pDIr403Ks5EmBHAAaSE6DF8SR9ga64B+DufNhoyYbAQy1
         5WEw==
X-Received: by 10.68.139.33 with SMTP id qv1mr44960283pbb.93.1368847161893;
        Fri, 17 May 2013 20:19:21 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.19.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:19:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368782129.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224758>

I feel change the order of patch 01/15 and patch 02/15 is better.
I.E. Add test cases for relative_path first, then refactor
relative_path and fix the test cases.

Also fix wrong indent in t/7301.

Differences with gitster/jx/clean-interactive:

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 75fb54..5bf76 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -82,8 +82,8 @@ and type return, like this:
 
 ------------
     *** Commands ***
-	1: clean                2: filter by pattern    3: select by numbers
-	4: ask each             5: quit                 6: help
+        1: clean                2: filter by pattern    3: select by numbers
+        4: ask each             5: quit                 6: help
     What now> 1
 ------------
 
diff --git a/builtin/clean.c b/builtin/clean.c
index 73ba2..7d34b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -64,7 +64,7 @@ struct menu_opts {
 
 struct menu_item {
 	char hotkey;
-	char *title;
+	const char *title;
 	int selected;
 	int (*fn)();
 };
@@ -312,22 +312,26 @@ static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
 {
 	struct string_list menu_list = STRING_LIST_INIT_DUP;
 	struct strbuf menu = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct menu_item *menu_item;
+	struct string_list_item *string_list_item;
 	int i;
 
-	if (stuff->type == MENU_STUFF_TYPE_MENU_ITEM) {
-		struct menu_item *item;
-
-		item = (struct menu_item *)stuff->stuff;
-		for (i = 0; i < stuff->nr; i++, item++) {
-			char *p;
+	switch (stuff->type) {
+	default:
+		die("Bad type of menu_staff when print menu");
+	case MENU_STUFF_TYPE_MENU_ITEM:
+		menu_item = (struct menu_item *)stuff->stuff;
+		for (i = 0; i < stuff->nr; i++, menu_item++) {
+			const char *p;
 			int highlighted = 0;
 
-			p = item->title;
+			p = menu_item->title;
 			if ((*chosen)[i] < 0)
-				(*chosen)[i] = item->selected ? 1 : 0;
+				(*chosen)[i] = menu_item->selected ? 1 : 0;
 			strbuf_addf(&menu, "%s%2d: ", (*chosen)[i] ? "*" : " ", i+1);
 			for (; *p; p++) {
-				if (!highlighted && *p == item->hotkey) {
+				if (!highlighted && *p == menu_item->hotkey) {
 					strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_PROMPT));
 					strbuf_addch(&menu, *p);
 					strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_RESET));
@@ -339,27 +343,25 @@ static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
 			string_list_append(&menu_list, menu.buf);
 			strbuf_reset(&menu);
 		}
-
-	} else if (stuff->type == MENU_STUFF_TYPE_STRING_LIST) {
-		struct string_list_item *item;
-		struct strbuf buf = STRBUF_INIT;
+		break;
+	case MENU_STUFF_TYPE_STRING_LIST:
 		i = 0;
-
-		for_each_string_list_item(item, (struct string_list *)stuff->stuff) {
+		for_each_string_list_item(string_list_item, (struct string_list *)stuff->stuff) {
 			if ((*chosen)[i] < 0)
 				(*chosen)[i] = 0;
 			strbuf_addf(&menu, "%s%2d: %s",
-				    (*chosen)[i] ? "*" : " ", i + 1, item->string);
+				    (*chosen)[i] ? "*" : " ", i+1, string_list_item->string);
 			string_list_append(&menu_list, menu.buf);
 			strbuf_reset(&menu);
 			i++;
 		}
-		strbuf_release(&buf);
+		break;
 	}
 
 	pretty_print_menus(&menu_list);
 
 	strbuf_release(&menu);
+	strbuf_release(&buf);
 	string_list_clear(&menu_list, 0);
 }
 
@@ -390,6 +392,8 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 			int **chosen)
 {
 	struct strbuf **choice_list, **ptr;
+	struct menu_item *menu_item;
+	struct string_list_item *string_list_item;
 	int nr = 0;
 	int i;
 
@@ -454,30 +458,31 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 			bottom = 1;
 			top = menu_stuff->nr;
 		} else {
-			if (MENU_STUFF_TYPE_MENU_ITEM == menu_stuff->type) {
-				struct menu_item *item;
-
-				item = (struct menu_item *)menu_stuff->stuff;
-				for (i = 0; i < menu_stuff->nr; i++, item++) {
+			switch (menu_stuff->type) {
+			default:
+				die("Bad type of menu_stuff when parse choice");
+			case MENU_STUFF_TYPE_MENU_ITEM:
+				menu_item = (struct menu_item *)menu_stuff->stuff;
+				for (i = 0; i < menu_stuff->nr; i++, menu_item++) {
 					if (((*ptr)->len == 1 &&
-					     *(*ptr)->buf == item->hotkey) ||
-					    !strcasecmp((*ptr)->buf, item->title)) {
+					     *(*ptr)->buf == menu_item->hotkey) ||
+					    !strcasecmp((*ptr)->buf, menu_item->title)) {
 						bottom = i + 1;
 						top = bottom;
 						break;
 					}
 				}
-			} else if (MENU_STUFF_TYPE_STRING_LIST == menu_stuff->type) {
-				struct string_list_item *item;
-
-				item = ((struct string_list *)menu_stuff->stuff)->items;
-				for (i = 0; i < menu_stuff->nr; i++, item++) {
-					if (!strcasecmp((*ptr)->buf, item->string)) {
+				break;
+			case MENU_STUFF_TYPE_STRING_LIST:
+				string_list_item = ((struct string_list *)menu_stuff->stuff)->items;
+				for (i = 0; i < menu_stuff->nr; i++, string_list_item++) {
+					if (!strcasecmp((*ptr)->buf, string_list_item->string)) {
 						bottom = i + 1;
 						top = bottom;
 						break;
 					}
 				}
+				break;
 			}
 		}
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d3b33..6acff4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -46,11 +46,11 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
-static void write_name(const char* name)
+static void write_name(const char *name)
 {
 
 	/* turn off prefix, if run with "--full-name" */
-	write_name_quoted_relative(name, prefix_len > 0 ? prefix : NULL,
+	write_name_quoted_relative(name, prefix_len ? prefix : NULL,
 				   stdout, line_terminator);
 }
 
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 09a42..dfe47 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -12,6 +12,11 @@ norm_path() {
 	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$2'"
 }
 
+relative_path() {
+	test_expect_success $4 "relative path: $1 $2 => $3" \
+	"test \"\$(test-path-utils relative_path '$1' '$2')\" = '$3'"
+}
+
 # On Windows, we are using MSYS's bash, which mangles the paths.
 # Absolute paths are anchored at the MSYS installation directory,
 # which means that the path / accounts for this many characters:
@@ -183,4 +188,22 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
 '
 
+relative_path /a/b/c/	/a/b/		c/
+relative_path /a/b/c/	/a/b		c/
+relative_path /a//b//c/	//a/b//		c/
+relative_path /a/b	/a/b		./
+relative_path /a/b/	/a/b		./
+relative_path /a	/a/b		../
+relative_path /		/a/b/		../../
+relative_path /a/c	/a/b/		../c
+relative_path /a/c	/a/b		../c
+relative_path /a/b	"<empty>"	/a/b
+relative_path /a/b 	"<null>"	/a/b
+relative_path "<empty>"	/a/b		./
+relative_path "<empty>"	"<empty>"	./
+relative_path "<empty>"	"<null>"	./
+relative_path "<null>"	"<empty>"	./
+relative_path "<null>"	"<null>"	./
+relative_path "<null>"	/a/b		./
+
 test_done
diff --git a/test-path-utils.c b/test-path-utils.c
index 0092cb..bc4ad 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -1,6 +1,19 @@
 #include "cache.h"
 #include "string-list.h"
 
+#define PARSE_ARGV_STRING(var, input) do { \
+	if (!strcmp(input, "<null>")) { \
+		var = NULL; \
+	} else if (!strcmp(input, "<empty>")) { \
+		var = ""; \
+	} else if (*input == '<' || *input == '(') { \
+		fprintf(stderr, "Bad value: %s\n", input); \
+		return 1; \
+	} else { \
+		var = input; \
+	} \
+} while (0)
+
 /*
  * A "string_list_each_func_t" function that normalizes an entry from
  * GIT_CEILING_DIRECTORIES.  If the path is unusable for some reason,
@@ -103,6 +116,20 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc == 4 && !strcmp(argv[1], "relative_path")) {
+		struct strbuf sb = STRBUF_INIT;
+		const char *abs, *base, *rel;
+		PARSE_ARGV_STRING(abs, argv[2]);
+		PARSE_ARGV_STRING(base, argv[3]);
+		rel = relative_path(abs, base, &sb);
+		if (!rel)
+			puts("(null)");
+		else
+			puts(strlen(rel) > 0 ? rel : "(empty)");
+		strbuf_release(&sb);
+		return 0;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;

Jiang Xin (15):
  test: add test cases for relative_path
  path.c: refactor relative_path(), not only strip prefix
  quote.c: remove path_relative, use relative_path instead
  Refactor quote_path_relative, remove unused params
  Refactor write_name_quoted_relative, remove unused params
  git-clean: refactor git-clean into two phases
  git-clean: add support for -i/--interactive
  git-clean: show items of del_list in columns
  git-clean: add colors to interactive git-clean
  git-clean: use a git-add-interactive compatible UI
  git-clean: add filter by pattern interactive action
  git-clean: add select by numbers interactive action
  git-clean: add ask each interactive action
  git-clean: add documentation for interactive git-clean
  test: add t7301 for git-clean--interactive

 Documentation/config.txt     |  21 +-
 Documentation/git-clean.txt  |  71 +++-
 builtin/clean.c              | 779 +++++++++++++++++++++++++++++++++++++++++--
 builtin/grep.c               |   5 +-
 builtin/ls-files.c           |  16 +-
 cache.h                      |   2 +-
 path.c                       | 112 +++++--
 quote.c                      |  65 +---
 quote.h                      |   7 +-
 setup.c                      |   5 +-
 t/t0060-path-utils.sh        |  23 ++
 t/t7301-clean-interactive.sh | 439 ++++++++++++++++++++++++
 test-path-utils.c            |  27 ++
 wt-status.c                  |  17 +-
 14 files changed, 1438 insertions(+), 151 deletions(-)
 create mode 100755 t/t7301-clean-interactive.sh

-- 
1.8.3.rc2.26.g7472058
