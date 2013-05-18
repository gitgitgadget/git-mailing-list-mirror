From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 12/15] git-clean: add select by numbers interactive action
Date: Sat, 18 May 2013 11:19:04 +0800
Message-ID: <793f76704c0266135bb0bb8624222adf9c8f9059.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368846844.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:21:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXhk-0005De-KR
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759362Ab3ERDUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:20:14 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:48479 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932571Ab3ERDUC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:20:02 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so3894410pdj.36
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=diIwT7ACtSW1sykmWI77wl68aBebJy1zxcG8mwiH3vE=;
        b=uGyq0UvXnhns3CsSdEsK1P0t0vISubBUk0nfPJX7Rx6J0WzpkvBzPCEcLYR/tyfCYR
         DGIi3yfAKGAI2iUvw/UeJa/SM4idrpV5NlSBcjGbJBZxQgDJGFHgsWt2TZIa8OVWHG7j
         aCqdgYA2rIKxPTaYkuKyKUBo6Q94/wEbQjNnbsgfpTLUk5UEJyKXt/tw+EicShJK9igP
         I6pQzUhIWN3IlgOAFHjdaMdU0XenNkI22jM0tdqlvXcpHrg4zTQjOG5ViSopvIfZ2auj
         98nlcZ1iwgCPmcIq+tmmbEKeuSokJ5bodlxXKuzA9fTBAnFwKFpom6Z4+oDXbeNLOUpB
         UJmw==
X-Received: by 10.66.147.129 with SMTP id tk1mr4152527pab.191.1368847201152;
        Fri, 17 May 2013 20:20:01 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.19.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:20:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com> <cover.1368846844.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224769>

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
index e5b1d..fd6e6 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -681,6 +681,43 @@ static int filter_by_patterns_cmd(void)
 	return 0;
 }
 
+static int select_by_numbers_cmd(void)
+{
+	struct menu_opts menu_opts;
+	struct menu_stuff menu_stuff;
+	struct string_list_item *items;
+	int *chosen;
+	int i, j;
+
+	menu_opts.header = NULL;
+	menu_opts.prompt = N_("Select items to delete");
+	menu_opts.flags = 0;
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
+			/* end of chosen (chosen[j] == EOF), won't delete */
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
 static int quit_cmd(void)
 {
 	string_list_clear(&del_list, 0);
@@ -694,6 +731,7 @@ static int help_cmd(void)
 	printf_ln(_(
 		    "clean               - start cleaning\n"
 		    "filter by pattern   - exclude items from deletion\n"
+		    "select by numbers   - select items to be deleted by numbers\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -710,6 +748,7 @@ static void interactive_main_loop(void)
 		struct menu_item menus[] = {
 			{'c', "clean",			0, clean_cmd},
 			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
+			{'s', "select by numbers",	0, select_by_numbers_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.rc2.26.g7472058
