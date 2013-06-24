From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v14 11/16] git-clean: add filter by pattern interactive action
Date: Mon, 24 Jun 2013 23:21:35 +0800
Message-ID: <36d2d6db4e65145bab6c85d7952f2cc068de65c5.1372087065.git.worldhello.net@gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:22:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8bR-0006nN-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976Ab3FXPWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:22:43 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:55503 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab3FXPWm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:22:42 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so10984276pbb.8
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=jkps94QZzHwzKqNgDzeP6enstQfRfNvM8pJknehIhXc=;
        b=scGWwlkXd2aDxCUdT3EtERRXtnXMDC6hpx0XBvyU7XQ2FFymXQSBhuVskuLzLdBlwV
         1ekq6xYRfZ+6ugF/X6uGXWXR5+QlHzHRuKgWsMO8frWRDYhKdIPhwDFNYZkdrCtGnjpf
         PEJ2/857tsGW3dFXp54We5zqMOAoavw0F/EgHloYgQRJgdFBp4bOgYiPvJ0waEXxXp5v
         yeO835ZH+OQXFe3SWQB1OLzdwUtq640NC1TAJgL0+C9eCoaXDkZXUOAXWYjGvLQCUzHV
         2bjkMKjUsJDMff7+xFlFdzywVXg5BaZlx1ruPe62uhBPMxxCb1apAJwuG6sepMqlP0GG
         uebA==
X-Received: by 10.68.1.226 with SMTP id 2mr24486189pbp.150.1372087361542;
        Mon, 24 Jun 2013 08:22:41 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id ix3sm18576807pbc.37.2013.06.24.08.22.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 08:22:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g41beab0
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
References: <CANYiYbHQ307TroSd6Lk=5zg68jdKxGeA4N=hWGfaz1W29NhNVw@mail.gmail.com> <cover.1372087065.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228834>

Add a new action for interactive git-clean: filter by pattern. When the
user chooses this action, user can input space-separated patterns (the
same syntax as gitignore), and each clean candidate that matches with
one of the patterns will be excluded from cleaning. When the user feels
it's OK, presses ENTER and backs to the confirmation dialog.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index df887..36369 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -614,6 +614,72 @@ static int clean_cmd(void)
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
@@ -626,6 +692,7 @@ static int help_cmd(void)
 	clean_print_color(CLEAN_COLOR_HELP);
 	printf_ln(_(
 		    "clean               - start cleaning\n"
+		    "filter by pattern   - exclude items from deletion\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -641,6 +708,7 @@ static void interactive_main_loop(void)
 		struct menu_stuff menu_stuff;
 		struct menu_item menus[] = {
 			{'c', "clean",			0, clean_cmd},
+			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.1.756.g41beab0
