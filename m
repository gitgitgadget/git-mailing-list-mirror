From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v14 12/16] git-clean: add select by numbers interactive action
Date: Mon, 24 Jun 2013 23:21:36 +0800
Message-ID: <b0da2c8e4aa3767335c4d3a95402f43644c2a691.1372087065.git.worldhello.net@gmail.com>
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
	id 1Ur8bS-0006nN-Cw
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab3FXPWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:22:47 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:44096 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab3FXPWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:22:46 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so11202771pad.14
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=supIMT8v4KEN1uMOaUoFl8nPBV2ubh78WQXbGIngLDY=;
        b=wtbfiYWOEXK9wtVs6LTBi1HAZLPK4ol63//RW4RtMZm28oeQP7SDwAGZRrSLzdOCJL
         vF0mYsbIUNpGRqJWP8yHJazni4YFdKlLo4ivF6jGrJv2rUgTthjUq/Kat2No0dsFD0fc
         b66yncmV6n/WAXyil4sKF5JzAFnl0ZCTs8sAMwECN/T2PLYIr02IRwn06xsxtU/+b4Jy
         6K5biUPxPLc9vAqlBKKvyQAsUpHzyOR91NMTjnicBJUoI3wDOR3zDG6S7Isn2EA+wV62
         KpppGy8Uj+ze3RJmwGWwo54zeLcSYAV7KPi/BiFJrhVdaa95Zxf46ffnZIgd/iwI+1I0
         Zrig==
X-Received: by 10.66.191.40 with SMTP id gv8mr28668120pac.19.1372087365238;
        Mon, 24 Jun 2013 08:22:45 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id ix3sm18576807pbc.37.2013.06.24.08.22.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 08:22:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g41beab0
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
References: <CANYiYbHQ307TroSd6Lk=5zg68jdKxGeA4N=hWGfaz1W29NhNVw@mail.gmail.com> <cover.1372087065.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228833>

Draw a multiple choice menu using `list_and_choose` to select items
to be deleted by numbers.

User can input:

 *  1,5-7 : select 1,5,6,7 items to be deleted
 *  *     : select all items to be deleted
 *  -*    : unselect all, nothing will be deleted
 *        : (empty) finish selecting, and return back to main menu

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 36369..643a5e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -680,6 +680,43 @@ static int filter_by_patterns_cmd(void)
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
+	for (i = 0, j = 0; i < del_list.nr; i++) {
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
@@ -693,6 +730,7 @@ static int help_cmd(void)
 	printf_ln(_(
 		    "clean               - start cleaning\n"
 		    "filter by pattern   - exclude items from deletion\n"
+		    "select by numbers   - select items to be deleted by numbers\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -709,6 +747,7 @@ static void interactive_main_loop(void)
 		struct menu_item menus[] = {
 			{'c', "clean",			0, clean_cmd},
 			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
+			{'s', "select by numbers",	0, select_by_numbers_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.1.756.g41beab0
