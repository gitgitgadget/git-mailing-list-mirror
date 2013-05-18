From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 11/15] git-clean: add filter by pattern interactive action
Date: Sat, 18 May 2013 11:19:03 +0800
Message-ID: <b6fc7ce33f911a89b7dfe88ac190107db0488301.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368846844.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:21:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXhj-0005De-0z
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576Ab3ERDUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:20:05 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:41926 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932568Ab3ERDT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:19:59 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so1854838dad.9
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=JDppStaQRr3b+kVzlflcOZTj2+PZ4A/ViMGHdehKw5g=;
        b=ErDY6qaPSITmK859+kx89PE/vvkncFHRgyCkdXw25KDSfocE3gD5KI6zupOwts1NYO
         HHwEXg/+9tICNNH1mPbS/eB8Kl0mRB3FzDWv+ry3ShYa2Su7d5vS1p6M+VPwU0QJ1fVK
         Ln5zkQhZWjz1lbjpfdAE6CrYqa/xDqhbnYo2OvNn0IAxTj6hLw4qNfuDoVOIvlhZ56Rx
         kZp7DOS9aDsqnr1gvTiE+M/D/jhZt7ZcKrJ39IacF1qZC3EoIhNKZHJ2oBrQ15Vg+smv
         JKaVZnjeA0JWXy3UE6X5c5P1ageicbuRLtwCneoA/oUjboqjXjmdm9UVU9oLw48cpSXT
         Ty4A==
X-Received: by 10.66.217.226 with SMTP id pb2mr51515818pac.109.1368847198413;
        Fri, 17 May 2013 20:19:58 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.19.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:19:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com> <cover.1368846844.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224764>

Add a new action for interactive git-clean: filter by pattern. When the
user chooses this action, user can input space-separated patterns (the
same syntax as gitignore), and each clean candidate that matches with
one of the patterns will be excluded from cleaning. When the user feels
it's OK, presses ENTER and backs to the confirmation dialog.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 19cc..e5b1d 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -615,6 +615,72 @@ static int clean_cmd(void)
 	return MENU_RETURN_NO_LOOP;
 }
 
+static int filter_by_patterns_cmd(void)
+{
+	struct dir_struct dir;
+	struct strbuf confirm = STRBUF_INIT;
+	struct strbuf **ignore_list;
+	struct string_list_item *item;
+	struct exclude_list *el;
+	int changed = -1, i;
+
+	for (;;) {
+		if (!del_list.nr)
+			break;
+
+		if (changed)
+			pretty_print_dels();
+
+		clean_print_color(CLEAN_COLOR_PROMPT);
+		printf(_("Input ignore patterns>> "));
+		clean_print_color(CLEAN_COLOR_RESET);
+		if (strbuf_getline(&confirm, stdin, '\n') != EOF)
+			strbuf_trim(&confirm);
+		else
+			putchar('\n');
+
+		/* quit filter_by_pattern mode if press ENTER or Ctrl-D */
+		if (!confirm.len)
+			break;
+
+		memset(&dir, 0, sizeof(dir));
+		el = add_exclude_list(&dir, EXC_CMDL, "manual exclude");
+		ignore_list = strbuf_split_max(&confirm, ' ', 0);
+
+		for (i = 0; ignore_list[i]; i++) {
+			strbuf_trim(ignore_list[i]);
+			if (!ignore_list[i]->len)
+				continue;
+
+			add_exclude(ignore_list[i]->buf, "", 0, el, -(i+1));
+		}
+
+		changed = 0;
+		for_each_string_list_item(item, &del_list) {
+			int dtype = DT_UNKNOWN;
+
+			if (is_excluded(&dir, item->string, &dtype)) {
+				*item->string = '\0';
+				changed++;
+			}
+		}
+
+		if (changed) {
+			string_list_remove_empty_items(&del_list, 0);
+		} else {
+			clean_print_color(CLEAN_COLOR_ERROR);
+			printf_ln(_("WARNING: Cannot find items matched by: %s"), confirm.buf);
+			clean_print_color(CLEAN_COLOR_RESET);
+		}
+
+		strbuf_list_free(ignore_list);
+		clear_directory(&dir);
+	}
+
+	strbuf_release(&confirm);
+	return 0;
+}
+
 static int quit_cmd(void)
 {
 	string_list_clear(&del_list, 0);
@@ -627,6 +693,7 @@ static int help_cmd(void)
 	clean_print_color(CLEAN_COLOR_HELP);
 	printf_ln(_(
 		    "clean               - start cleaning\n"
+		    "filter by pattern   - exclude items from deletion\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -642,6 +709,7 @@ static void interactive_main_loop(void)
 		struct menu_stuff menu_stuff;
 		struct menu_item menus[] = {
 			{'c', "clean",			0, clean_cmd},
+			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.rc2.26.g7472058
