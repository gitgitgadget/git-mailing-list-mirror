From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 06/12] git-clean: add filter by pattern interactive action
Date: Fri, 10 May 2013 01:14:10 +0800
Message-ID: <1a78a5e0f03d320bbac165342e0cedd2726d44d3.1368118918.git.worldhello.net@gmail.com>
References: <cover.1368118918.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 09 19:15:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUQs-0002zq-43
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab3EIRO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:14:57 -0400
Received: from mail-da0-f51.google.com ([209.85.210.51]:43180 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab3EIRO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:14:56 -0400
Received: by mail-da0-f51.google.com with SMTP id h15so1703900dan.38
        for <git@vger.kernel.org>; Thu, 09 May 2013 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=Omp3Q5z9Oe6E7YVVXbbP46Wyp99zAcMEkDqKKUcLksU=;
        b=ybP7GgUATaouSsLy0WHwH9e8sJNWsLuOZjHfGAMsDzK4WX7qqfAycXcjYcQieVaCuu
         vcMp7oNsKFm5mSuVzQTx9pVrrBJaJvdIZLaeE0HK47yVT1Bti1MqMcim1BYmKNQRm2X4
         Vinr6ZyjAQkSmvH/I7lQ94fu8p8BlKg35HDGrJrZFSUUM8c1WI+XflV1nhPbdhncVabY
         XB3BZEuBIM2oalGnBG0sfPna9U0LaOENOJQ3ykEDEdy/iuYLCwlPlxst/2otp1V+syey
         uY7ypZDjl51JLHouKSxO3ik9e0o8uCLNOD9hKgsEneqhlqipf9/0GHu/BnWU/y2E3wQ2
         YUrg==
X-Received: by 10.66.154.195 with SMTP id vq3mr13184196pab.105.1368119695597;
        Thu, 09 May 2013 10:14:55 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id pa2sm4407182pac.9.2013.05.09.10.14.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 10:14:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g24a8a0f
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
References: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com> <cover.1368118918.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223755>

Add a new action for interactive git-clean: filter by pattern. When
the user chooses this action, user can input space-separated
patterns (the same syntax as gitignore), and each clean candidate
that matches with one of the patterns will be excluded from cleaning.
When the user feels it's OK, presses ENTER and back to the confirmation
dialog.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index a9a1ee..48731 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -646,6 +646,72 @@ static int clean_cmd(void)
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
+		/* Quit filter_by_pattern mode if press ENTER or Ctrl-D */
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
@@ -658,6 +724,7 @@ static int help_cmd(void)
 	clean_print_color(CLEAN_COLOR_HELP);
 	printf_ln(_(
 		    "clean               - start cleaning\n"
+		    "filter by pattern   - exclude items from deletion\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -673,6 +740,7 @@ static void interactive_main_loop(void)
 		struct menu_stuff menu_stuff;
 		struct menu_item menus[] = {
 			{'c', "clean",			0, clean_cmd},
+			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.rc1.341.g24a8a0f
