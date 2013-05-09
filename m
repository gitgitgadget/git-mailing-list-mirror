From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 07/12] git-clean: add select by numbers interactive action
Date: Fri, 10 May 2013 01:14:11 +0800
Message-ID: <890352e6b239cfb997a2864fa129c346f6c0c3b3.1368118918.git.worldhello.net@gmail.com>
References: <cover.1368118918.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 09 19:15:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUQy-00039M-HT
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab3EIRPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:15:01 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:49436 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab3EIRPA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:15:00 -0400
Received: by mail-da0-f49.google.com with SMTP id p5so1698204dak.22
        for <git@vger.kernel.org>; Thu, 09 May 2013 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=SsZFM/BgRby5gLRfQ14G5TRfOEwxvwp4Yvz2K79zY1I=;
        b=MnINuY3Zx1Xw1KyTMwjxj8iasKhuiQQS0GLnVEnfbQ74O4dAR0P9fvCVG0gpXUx9BE
         LgGIShacRmj2Wolwxhf2j3ONPEZGbn0eZ1rUyzUbkwFLVptJXu+nhqX3wDudew23iZBi
         kVK5AS1P4UZxIWFct2DcwkFIVm7CjJvEAKu5Fv/T98FQv9a4YmY//Mjv2xrqC5W/L3NF
         skooZMshZEWazOQtiU5qegsqfyR78WGNkq8ZBoJEpsppPBrPizhfjTTCNgMlFzrQTRJl
         59qGSJgdZ04bkQS4t4wfSbHSf5407XYDXj7MKTQ2rkjrx1d1F/BMf536PHOhfySUH/8q
         GJhA==
X-Received: by 10.66.144.5 with SMTP id si5mr14154475pab.6.1368119699645;
        Thu, 09 May 2013 10:14:59 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id pa2sm4407182pac.9.2013.05.09.10.14.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 10:14:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g24a8a0f
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
References: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com> <cover.1368118918.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223758>

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
index 48731..17b65 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -712,6 +712,43 @@ static int filter_by_patterns_cmd(void)
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
 static int quit_cmd(void)
 {
 	string_list_clear(&del_list, 0);
@@ -725,6 +762,7 @@ static int help_cmd(void)
 	printf_ln(_(
 		    "clean               - start cleaning\n"
 		    "filter by pattern   - exclude items from deletion\n"
+		    "select by numbers   - select items to be deleted by numbers\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -741,6 +779,7 @@ static void interactive_main_loop(void)
 		struct menu_item menus[] = {
 			{'c', "clean",			0, clean_cmd},
 			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
+			{'s', "select by numbers",	0, select_by_numbers_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.rc1.341.g24a8a0f
