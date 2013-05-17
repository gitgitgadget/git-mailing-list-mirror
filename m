From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v11 12/15] git-clean: add select by numbers interactive action
Date: Fri, 17 May 2013 17:20:16 +0800
Message-ID: <d27b6034ca6f3277e0b003925a6b2f6351d02d9b.1368782129.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 17 11:21:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdGqh-0006aN-LC
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 11:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599Ab3EQJVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 05:21:03 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:47224 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab3EQJVA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 05:21:00 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so3156681pdj.10
        for <git@vger.kernel.org>; Fri, 17 May 2013 02:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=SMeqRU4AmKBvwYBIzdo79cRzF/yqDvoDeRhAVJ6/Gqc=;
        b=OuYGTWagOKsCxzb+rk9D7B++l+AkAVgSu4YNEPhdaj3zWYq3B/t6+zQRycNA6QDZ1t
         f8MjwbwglGY7AcHXNRs7n0cuYgvsh4+wTqZ5+R39vbJP5ICgZDRnNCWJcM6ML5KSnnXo
         0dQ798m7W8mKaXvX1GEFpJ6D+F4RhAVs/Qm84iURK8FTGNm6CdvJnTrgOdx6rRDZ4Xi3
         Nnm5H+2nYd/cbC4QVyQlWh+/CuA6FOYuQHPceXCNWafKKbLWii1APrruuAG5PXs2ZeRH
         In2qOr+1nxiUQ6PXyFIZ2/hrm44NaNtfa3CYoviRBowiTQte7XHizVxQTAftU9R2r8OU
         4Asg==
X-Received: by 10.68.189.231 with SMTP id gl7mr31390987pbc.123.1368782460420;
        Fri, 17 May 2013 02:21:00 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id 10sm10531002pbm.0.2013.05.17.02.20.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 02:20:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.380.g956c2b2
In-Reply-To: <cover.1368782129.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368782129.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224675>

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
index d761ae..037cc 100644
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
1.8.3.rc2.380.g956c2b2
