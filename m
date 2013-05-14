From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v9 6/9] git-clean: add filter by pattern interactive action
Date: Tue, 14 May 2013 16:45:20 +0800
Message-ID: <b1c1164ef7bba3299b3f4333492ea07bc3afd0cd.1368518327.git.worldhello.net@gmail.com>
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
	id 1UcAst-0003OM-If
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 10:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956Ab3ENIqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 04:46:13 -0400
Received: from mail-da0-f44.google.com ([209.85.210.44]:52416 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756948Ab3ENIqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 04:46:09 -0400
Received: by mail-da0-f44.google.com with SMTP id z8so178741daj.17
        for <git@vger.kernel.org>; Tue, 14 May 2013 01:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=GEgTwc7QO1Gl2L+Bd2qLMz5pIGTbFUfhIOFZvf9d+N0=;
        b=WfPGV/vz1lhwuXvOfCLVrzLvz80MQfyY34Km029/zFNSrPUDMVtpMRSTIc0afoRJfW
         iLp+pe2hnWeBZKXvZNwTVpVuw+XL/NdWSIVEDQijv2qMFa683tyHjFHri7zljhhPHRyS
         fS5X8ZYNEwD4p/t5Wg5LX5MKRqPm2ULoKshklli/9I8NB8cSLe2iZpkmlDC5v1N/+Bz5
         GbgbSbhXZRuP135hZpaVhMoYexs7hf0tTXvV+QuC8KZtB3+9Y45i9aOvL7qcmsnU6vrk
         cJFtqxkIkgXxQqRbM9KAfT58XTxm3wq26esuV7aEbyPY7H4wCFcI2y4fc9gvKr1Nh30m
         HIwg==
X-Received: by 10.68.35.3 with SMTP id d3mr33060254pbj.155.1368521168644;
        Tue, 14 May 2013 01:46:08 -0700 (PDT)
Received: from localhost.localdomain ([114.248.141.128])
        by mx.google.com with ESMTPSA id wt5sm17356069pbc.38.2013.05.14.01.46.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 01:46:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.401.gfc9adf8
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224294>

Add a new action for interactive git-clean: filter by pattern. When the
user chooses this action, user can input space-separated patterns (the
same syntax as gitignore), and each clean candidate that matches with
one of the patterns will be excluded from cleaning. When the user feels
it's OK, presses ENTER and back to the confirmation dialog.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 7930f..80cf1 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -649,6 +649,72 @@ static int clean_cmd(void)
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
@@ -661,6 +727,7 @@ static int help_cmd(void)
 	clean_print_color(CLEAN_COLOR_HELP);
 	printf_ln(_(
 		    "clean               - start cleaning\n"
+		    "filter by pattern   - exclude items from deletion\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -676,6 +743,7 @@ static void interactive_main_loop(void)
 		struct menu_stuff menu_stuff;
 		struct menu_item menus[] = {
 			{'c', "clean",			0, clean_cmd},
+			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.rc1.404.gb9fcf3e
