From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v13 11/15] git-clean: add filter by pattern interactive action
Date: Wed, 22 May 2013 09:40:32 +0800
Message-ID: <84ce3ae6d2f7669491180c9bc9dd63870c1147da.1369186574.git.worldhello.net@gmail.com>
References: <cover.1369186574.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 03:41:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uey3b-0001cT-Q6
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 03:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab3EVBlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 21:41:25 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:62282 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab3EVBlT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 21:41:19 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so1200219pdi.36
        for <git@vger.kernel.org>; Tue, 21 May 2013 18:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=XwQUQlLM/QdOny9WTFQpEcMR4WJskjootvEF8a3lZpg=;
        b=QPZdmFGIWjOxnZHmkHx1sMiOUcUNqX2DqmW9MWs8UDjvC+DkIFTt1rNoaIPiNK+vTd
         os2DDnQkz/4ws5WXWWBKXKuolFcwjxZqQyCPUnzTeCeZjXVAr77TWYPwbMDbuKO8w+Lp
         o9R1X4man7cxo8pFD6kGYkn3QrJf/TxxuFfM8Pq/Wn2Zco3AMUg5OGHXMEEuBTS/4u4f
         HPtYZZKQY6wNEDGFUSGeOz+TNST/P1JCVj4Z+qYwpM5ew3hwcQwKCJbUB0aEERtNx1Cm
         XQT1DbjutsuJMFErbuuaPk7kgexA/jz7Q/7Yo497vdsf4NB3W3DdndBDHkTkGmpkZ3wJ
         S48w==
X-Received: by 10.68.27.9 with SMTP id p9mr5265964pbg.139.1369186879355;
        Tue, 21 May 2013 18:41:19 -0700 (PDT)
Received: from localhost.localdomain ([114.248.150.82])
        by mx.google.com with ESMTPSA id at1sm4939345pbc.10.2013.05.21.18.41.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 18:41:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.368.g7c798dd
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
References: <7vhahwm5n6.fsf@alter.siamese.dyndns.org> <cover.1369186574.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225114>

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
1.8.3.rc3.368.g7c798dd
