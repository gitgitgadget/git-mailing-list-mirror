From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 5/7] git-clean: interactive cleaning by select numbers
Date: Tue,  7 May 2013 03:18:54 +0800
Message-ID: <c81cef0983760c76c2a6b92c1fcc2c49a80a8747.1367867498.git.worldhello.net@gmail.com>
References: <cover.1367867498.git.worldhello.net@gmail.com>
 <4a32eb7cc4e277fcbf4b46c13524874334bea2a3.1367867498.git.worldhello.net@gmail.com>
 <6276dc8861b40e8377586f30b85c33e92c4e68fe.1367867498.git.worldhello.net@gmail.com>
 <c77c33fe295bb8577336d5bb4fe0d8da32f69df3.1367867498.git.worldhello.net@gmail.com>
 <217e7618e9b9d50a50461959b38984ac8be88651.1367867498.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 06 21:19:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQwq-0002FN-3e
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab3EFTTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:19:37 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:37320 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab3EFTTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:19:35 -0400
Received: by mail-pd0-f176.google.com with SMTP id x10so2157118pdj.21
        for <git@vger.kernel.org>; Mon, 06 May 2013 12:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=ct700uaRuWbBUmHUqIl3UoIgqhRDCQWeK0/VDQjTAU4=;
        b=CLFRTJ1SNpgA/iiBAPUtP3MSI4K/SSPXiDgEop5PcyZ0vme+R7sT3ss09Jfibv+asL
         034eU82U/Q317KrVRaR9TNUe1yG3mauKhCgGQawOONy0M6PVtndxqIJvQMDLPDKre8OR
         6SldiM38vJXRX33mI19o4XLCelJCyLgK7BpBbJyxuUm76KHo9UPFJGgeabjuRCbHmk7Y
         3u9b6rsHnWvHxDmc8NHIIhPIw550U+5awu0JqgNYVxsnIrhdUou8Q1ipzHzgJbR6i/bu
         p0055uhQPi9trqQ4VMH8QSWwbnc6BbMZNqK03g225B+e0beVwCzce0WN238VBhqQZhRw
         A8gQ==
X-Received: by 10.68.112.1 with SMTP id im1mr21944127pbb.116.1367867974999;
        Mon, 06 May 2013 12:19:34 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id z8sm24951256pbt.23.2013.05.06.12.19.31
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 May 2013 12:19:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.338.gb35aa5d
In-Reply-To: <217e7618e9b9d50a50461959b38984ac8be88651.1367867498.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1367867498.git.worldhello.net@gmail.com>
References: <CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com> <cover.1367867498.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223496>

Draw a multiple choice menu using `list_and_choose` to select items
to be deleted by numbers.

User can input:

 *  1,5-7 : select 1,5,6,7 items to be deleted
 *  *     : select all items to be deleted
 *  -*    : unselect all, nothing will be deleted
 *        : (empty) finish selecting, and return back to main menu

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 3b9f3..3b07f 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -622,6 +622,43 @@ int edit_by_patterns_cmd()
 	return 0;
 }
 
+int edit_by_numbers_cmd()
+{
+	struct menu_opts menu_opts;
+	struct menu_stuff menu_stuff;
+	struct string_list_item *items;
+	int *chosen;
+	int i, j;
+
+	menu_opts.header = NULL;
+	menu_opts.prompt = "Select items to delete";
+	menu_opts.flag = 0;
+
+	menu_stuff.type = MENU_STUFF_TYPE_STRING_LIST;
+	menu_stuff.stuff = &del_list;
+	menu_stuff.nr = del_list.nr;
+
+	chosen = list_and_choose(&menu_opts, &menu_stuff);
+	items = del_list.items;
+	for(i = 0, j = 0; i < del_list.nr; i++) {
+		if (i < chosen[j]) {
+			*(items[i].string) = '\0';
+		} else if (i == chosen[j]) {
+			/* delete selected item */
+			j++;
+			continue;
+		} else {
+			/* end of chosen (EOF), won't delete */
+			*(items[i].string) = '\0';
+		}
+	}
+
+	string_list_remove_empty_items(&del_list, 0);
+
+	free(chosen);
+	return 0;
+}
+
 int quit_cmd()
 {
 	string_list_clear(&del_list, 0);
@@ -635,6 +672,7 @@ int help_cmd(int x)
 	printf_ln(_(
 		    "clean            - start cleaning\n"
 		    "edit by patterns - exclude items from deletion\n"
+		    "edit by numbers  - select items to be deleted by numbers\n"
 		    "quit             - stop cleaning\n"
 		    "help             - this screen\n"
 		    "?                - help for prompt selection"
@@ -652,6 +690,7 @@ void interactive_main_loop()
 		struct menu_item menus[] = {
 			{'c', "clean",			clean_cmd},
 			{'p', "edit by patterns",	edit_by_patterns_cmd},
+			{'n', "edit by numbers",	edit_by_numbers_cmd},
 			{'q', "quit",			quit_cmd},
 			{'h', "help",			help_cmd},
 		};
-- 
1.8.3.rc1.338.gb35aa5d
