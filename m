From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v10 11/14] git-clean: add select by numbers interactive action
Date: Thu, 16 May 2013 17:53:42 +0800
Message-ID: <1523388ce72cf58a275fc44b9a80a90136bba150.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 11:54:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcutY-0001AN-KK
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab3EPJyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:54:37 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:40485 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab3EPJyf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:54:35 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so2173525pbc.18
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=bPVKywwcxoYvI3mnopAnNk5QKw31TQsWcoYMI74PiEY=;
        b=ZiNb1NlMlvkArM9CW4OPKv19mxWGF1PHes+PxaPMvNiI0JZuLNKUkyJEQZh6ABDyJN
         AQvoxZH3cy7kn8m1rfynXALp4fFV4FDLhWwwwad8/FEHos/hSa0/jxBS3RTleC699PZZ
         hsfptCepn7GMlyLfHqugJIJf2Po0WAxY5T1DpzDhgUrBtnIcr/MPgmcy/zz66Va8Tq6W
         P6lBBp2jMvfQtB8U07sDVDWYRWlMgWoW12znQivKTUgVgzErDX/vwXhJ65Js6qF4P6HG
         6y1PPQdvvaTg6Th2EQKNibHyd81gJ3uNJkkpmt4AJi1eB33H5E8uCMLNBQpawLRJ58ke
         qz0w==
X-Received: by 10.68.194.135 with SMTP id hw7mr42190181pbc.192.1368698075446;
        Thu, 16 May 2013 02:54:35 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id cd2sm6183092pbd.35.2013.05.16.02.54.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 02:54:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.407.g762149a
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224538>

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
index 35b9f3..96a5bb 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -673,6 +673,43 @@ static int filter_by_patterns_cmd(void)
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
@@ -686,6 +723,7 @@ static int help_cmd(void)
 	printf_ln(_(
 		    "clean               - start cleaning\n"
 		    "filter by pattern   - exclude items from deletion\n"
+		    "select by numbers   - select items to be deleted by numbers\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -702,6 +740,7 @@ static void interactive_main_loop(void)
 		struct menu_item menus[] = {
 			{'c', "clean",			0, clean_cmd},
 			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
+			{'s', "select by numbers",	0, select_by_numbers_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.rc1.407.g762149a
