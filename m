From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 11/12] git-clean: add toggle flags interactive action
Date: Fri, 10 May 2013 01:14:15 +0800
Message-ID: <3de32e2d73ae6e88ae968814b45bb421281e371b.1368118918.git.worldhello.net@gmail.com>
References: <cover.1368118918.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 09 19:15:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaURD-0003Tw-6G
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284Ab3EIRPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:15:19 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:43654 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab3EIRPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:15:16 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so2274065pad.39
        for <git@vger.kernel.org>; Thu, 09 May 2013 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=kh3zYF+vEJAWxEvx+NbdvPYFCV+/FL1Zy63GiiLnprE=;
        b=wovYH/R3UI5kL91ZZtDstRL8++LZwoKhgRvXqcUq/jQqidG/VDM4XyEwInlVMJOuHI
         rpxC5LbFt/Rjqg/MlJJ/wxMJWkrjvytFeJ2ZoV21zvNHSKgaE1BwO9gsb5UjBv/Zc7ex
         QdiPx8wlj2GU9qab5Y1cA7D2tO1km6l7aMw8q10doDPwMcA6HirK+AFItWqSIaxFYUlJ
         pOyW85kYvexO57qOxZD/sGvqWNDp25MCPA187YgHLA47obhTPR/JMr0Z9WEIMMWfIvMh
         xE6H6Bjco3hyAiUdpbSiuR56IbXAUivVa+GyHrbyqld83nvfoEbLaDGT6mN1p/GwUu5K
         aV6A==
X-Received: by 10.68.254.225 with SMTP id al1mr13776621pbd.69.1368119716352;
        Thu, 09 May 2013 10:15:16 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id pa2sm4407182pac.9.2013.05.09.10.15.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 10:15:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g24a8a0f
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
References: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com> <cover.1368118918.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223760>

Add new action in the interactive mode, so that the user can change
git-clean flags, such as -x/-X/-d/-ff, and refresh the cleaning
candidates list.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 101 insertions(+), 16 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 232d48..b4472 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -879,6 +879,66 @@ static int rm_i_cmd(void)
 	return MENU_RETURN_NO_LOOP;
 }
 
+static int toggle_flags_cmd(void)
+{
+	struct menu_opts menu_opts;
+	struct menu_stuff menu_stuff;
+	struct menu_item menus[] = {
+		{'d', "(d) remove directories",
+			clean_flags & CLEAN_OPTS_REMOVE_DIRECTORIES,	NULL},
+		{'x', "(x) show ignored",
+			clean_flags & CLEAN_OPTS_SHOW_IGNORED,		NULL},
+		{'X', "(X) ignored only",
+			clean_flags & CLEAN_OPTS_IGNORED_ONLY,		NULL},
+		{'f', "(ff) remove nested.git",
+			clean_flags & CLEAN_OPTS_REMOVE_NESTED_GIT,	NULL},
+	};
+	int new_flags = 0;
+	int *chosen;
+	int i;
+
+	menu_opts.header = NULL;
+	menu_opts.prompt = "Change flags";
+	menu_opts.flag = 0;
+
+	menu_stuff.type = MENU_STUFF_TYPE_MENU_ITEM;
+	menu_stuff.stuff = menus;
+	menu_stuff.nr = sizeof(menus) / sizeof(struct menu_item);
+
+	chosen = list_and_choose(&menu_opts, &menu_stuff);
+
+	for (i = 0; chosen[i] != EOF; i++) {
+		switch (chosen[i]) {
+		case 0:
+			new_flags |= CLEAN_OPTS_REMOVE_DIRECTORIES;
+			break;
+		case 1:
+			new_flags |= CLEAN_OPTS_SHOW_IGNORED;
+			break;
+		case 2:
+			new_flags |= CLEAN_OPTS_IGNORED_ONLY;
+			break;
+		case 3:
+			new_flags |= CLEAN_OPTS_REMOVE_NESTED_GIT;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (new_flags & CLEAN_OPTS_IGNORED_ONLY &&
+	    new_flags & CLEAN_OPTS_SHOW_IGNORED) {
+		clean_print_color(CLEAN_COLOR_ERROR);
+		printf_ln(_("-x and -X cannot be used together"));
+		clean_print_color(CLEAN_COLOR_RESET);
+	} else {
+		clean_flags = new_flags;
+	}
+
+	free(chosen);
+	return 0;
+}
+
 static int quit_cmd(void)
 {
 	string_list_clear(&del_list, 0);
@@ -894,6 +954,7 @@ static int help_cmd(void)
 		    "filter by pattern   - exclude items from deletion\n"
 		    "select by numbers   - select items to be deleted by numbers\n"
 		    "ask each            - confirm each deletion (like \"rm -i\")\n"
+		    "toggle flags        - toggle git-clean flags and update the list\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -902,9 +963,14 @@ static int help_cmd(void)
 	return 0;
 }
 
-static void interactive_main_loop(void)
+static void interactive_main_loop(const char **pathspec,
+				  struct string_list exclude_list,
+				  const char *prefix)
 {
-	while (del_list.nr) {
+	int cached_clean_flags = clean_flags;
+	char flags_title[40];
+
+	for (;;) {
 		struct menu_opts menu_opts;
 		struct menu_stuff menu_stuff;
 		struct menu_item menus[] = {
@@ -912,11 +978,24 @@ static void interactive_main_loop(void)
 			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
 			{'s', "select by numbers",	0, select_by_numbers_cmd},
 			{'a', "ask each",		0, rm_i_cmd},
+			{'t', flags_title,		0, toggle_flags_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
 		int *chosen;
 
+		if (!clean_flags) {
+			strncpy(flags_title, "toggle flags: none", sizeof(flags_title)/sizeof(char));
+		} else {
+			snprintf(flags_title, sizeof(flags_title)/sizeof(char),
+				 "toggle flags: -%s%s%s%s",
+				 clean_flags & CLEAN_OPTS_REMOVE_DIRECTORIES ? "d" : "",
+				 clean_flags & CLEAN_OPTS_SHOW_IGNORED ? "x" : "",
+				 clean_flags & CLEAN_OPTS_IGNORED_ONLY ? "X" : "",
+				 clean_flags & CLEAN_OPTS_REMOVE_NESTED_GIT ? "ff" : ""
+				);
+		}
+
 		menu_opts.header = _("*** Commands ***");
 		menu_opts.prompt = "What now";
 		menu_opts.flag = MENU_OPTS_SINGLETON;
@@ -925,13 +1004,25 @@ static void interactive_main_loop(void)
 		menu_stuff.stuff = menus;
 		menu_stuff.nr = sizeof(menus) / sizeof(struct menu_item);
 
-		clean_print_color(CLEAN_COLOR_HEADER);
-		printf_ln(Q_("Would remove the following item:",
-			     "Would remove the following items:",
-			     del_list.nr));
-		clean_print_color(CLEAN_COLOR_RESET);
+		if (cached_clean_flags != clean_flags) {
+			scan_clean_candidates(pathspec, exclude_list, prefix);
+			cached_clean_flags = clean_flags;
+		}
 
-		pretty_print_dels();
+		if (del_list.nr) {
+			clean_print_color(CLEAN_COLOR_HEADER);
+			printf_ln(Q_("Would remove the following item:",
+				     "Would remove the following items:",
+				     del_list.nr));
+			clean_print_color(CLEAN_COLOR_RESET);
+
+			pretty_print_dels();
+		} else {
+			clean_print_color(CLEAN_COLOR_HEADER);
+			printf_ln(_("NOTE: no more files to clean; press \"t\" to toggle flags of git-clean."));
+			putchar('\n');
+			clean_print_color(CLEAN_COLOR_RESET);
+		}
 
 		chosen = list_and_choose(&menu_opts, &menu_stuff);
 
@@ -941,12 +1032,6 @@ static void interactive_main_loop(void)
 			if (ret != MENU_RETURN_NO_LOOP) {
 				free(chosen);
 				chosen = NULL;
-				if (!del_list.nr) {
-					clean_print_color(CLEAN_COLOR_ERROR);
-					printf_ln(_("No more files to clean, exiting."));
-					clean_print_color(CLEAN_COLOR_RESET);
-					break;
-				}
 				continue;
 			}
 		} else {
@@ -1023,8 +1108,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	scan_clean_candidates(pathspec, exclude_list, prefix);
 
-	if (interactive && !dry_run && del_list.nr > 0)
-		interactive_main_loop();
+	if (interactive && !dry_run)
+		interactive_main_loop(pathspec, exclude_list, prefix);
 
 	for_each_string_list_item(item, &del_list) {
 		struct stat st;
-- 
1.8.3.rc1.341.g24a8a0f
