From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 05/10] git-clean: interactive cleaning by select numbers
Date: Wed,  8 May 2013 19:38:50 +0800
Message-ID: <ae69a75fa1bbad9827ef3891a33c3bfa6685d914.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
 <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
 <6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
 <d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
 <e7cf5d7ffd83e238078b4585ac4bef4ec9a48e21.1368011946.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 08 13:39:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua2ik-0001Lx-Ka
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab3EHLj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:39:27 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:60766 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab3EHLj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 07:39:26 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so1163387pdj.8
        for <git@vger.kernel.org>; Wed, 08 May 2013 04:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=ak7AtX/FcADkUNjihZqCtOiYCKjeg+5CuHRWrPG2Pdg=;
        b=CimqjZ0zaYOdsTwN17sF3LjK20wsNgfo0Yp7Q/CVZgWWZY7vZexBsHhysaWaOwjDEu
         X5Emz3Ww94Myy+G9PX7EverRhqjE/OL9TCx20rFSIdfHsvitLi1l6MJlYo0QA/Y9+VzN
         Rvy37NkwtbbGX1VS5hwKn0XLyTt30HCt/2lci12rR/LcQ4t5zRLvoXnGcHiXwHRRUvBM
         Ggav0VowZ9chMAP8kCWm87vstojOqHHtUoQv5whXTRlsfQxnKxHbuMePUYhrX2zgyoec
         3vqxPoQhmrw+2qpJiVQl4sTxrfwqtrnNybRotW5cEYSv0fUFtAPSHdIhRIu1O1Sp63kV
         36aQ==
X-Received: by 10.68.35.138 with SMTP id h10mr7119801pbj.49.1368013165846;
        Wed, 08 May 2013 04:39:25 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id gc5sm32287860pbb.19.2013.05.08.04.39.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 04:39:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g1c24ab7
In-Reply-To: <e7cf5d7ffd83e238078b4585ac4bef4ec9a48e21.1368011946.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223662>

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
index 10f3..75e37 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -684,6 +684,43 @@ static int edit_by_patterns_cmd()
 	return 0;
 }
 
+static int edit_by_numbers_cmd()
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
 static int quit_cmd()
 {
 	string_list_clear(&del_list, 0);
@@ -697,6 +734,7 @@ static int help_cmd(int x)
 	printf_ln(_(
 		    "clean            - start cleaning\n"
 		    "edit by patterns - exclude items from deletion\n"
+		    "edit by numbers  - select items to be deleted by numbers\n"
 		    "quit             - stop cleaning\n"
 		    "help             - this screen\n"
 		    "?                - help for prompt selection"
@@ -714,6 +752,7 @@ static void interactive_main_loop()
 		struct menu_item menus[] = {
 			{'c', "clean",			0, clean_cmd},
 			{'p', "edit by patterns",	0, edit_by_patterns_cmd},
+			{'n', "edit by numbers",	0, edit_by_numbers_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.rc1.341.g1c24ab7
