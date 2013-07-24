From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2] git-clean: implement partial matching for selection
Date: Wed, 24 Jul 2013 10:22:04 +0800
Message-ID: <81f7abd21d03b90bcf46237c3655e8aa6f5a13cd.1374632255.git.worldhello.net@gmail.com>
References: <cover.1374632255.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 04:24:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1ok9-0001Td-3y
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 04:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105Ab3GXCXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 22:23:51 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:33456 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab3GXCXu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 22:23:50 -0400
Received: by mail-pb0-f48.google.com with SMTP id md4so1220232pbc.21
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 19:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=jwSn5MSYegGxzSYPA0DIOxdQjNqvKv5kRfA1DibNvDs=;
        b=t0yKxAeD0NlJgbbfHXeZbcAZXsrZtQVxa1xCKMp7lVpLMK4HCwrQWvDXrGJRj0LmLm
         h6dWxpwbtWlF6BGOd6WCjjsCgw2zHJYgfIm7gmDjpTqI55p2UiHyomW7C57Q/lJis3TG
         uMqo3/6gcTyR3yPc8g5eEX7sk1jvKBNJA0okrOHrVNmwfW5cs29NiBKWDd5eL6ztWmR5
         nDwBdA8kYokgrzXc7ujzb0bWqiq5A4BQxl7l0s1uUuGul5dR3/mCxhyC1FuWTcD//rAe
         /jDiWoUtSyGVlUeZXaffJSNQw6DluYsiwXkph9bgGTlToPJxLIZDrw03Pa9cwCRXGkBf
         FeQw==
X-Received: by 10.68.176.132 with SMTP id ci4mr39838250pbc.7.1374632629287;
        Tue, 23 Jul 2013 19:23:49 -0700 (PDT)
Received: from localhost.localdomain ([114.246.130.173])
        by mx.google.com with ESMTPSA id vu5sm48294783pab.10.2013.07.23.19.23.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 19:23:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.842.g8e6673c
In-Reply-To: <cover.1374632255.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1374632255.git.worldhello.net@gmail.com>
References: <d099b22989d6e7c023e160a6a9b232bc58e6349c.1374631307.git.worldhello.net@gmail.com> <cover.1374632255.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231076>

Document for interactive git-clean says: "You also could say `c` or
`clean` above as long as the choice is unique". But it's not true,
because only hotkey `c` and full match (`clean`) could work.

Implement partial matching via find_unique function to make the
document right.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c              | 80 ++++++++++++++++++++++++++++----------------
 t/t7301-clean-interactive.sh | 40 ++++++++++++++++++++--
 2 files changed, 90 insertions(+), 30 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index dba8387..3c85e15 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -365,6 +365,56 @@ static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
 	string_list_clear(&menu_list, 0);
 }
 
+static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
+{
+	struct menu_item *menu_item;
+	struct string_list_item *string_list_item;
+	int i, len, found = 0;
+
+	len = strlen(choice);
+	switch (menu_stuff->type) {
+	default:
+		die("Bad type of menu_stuff when parse choice");
+	case MENU_STUFF_TYPE_MENU_ITEM:
+
+		menu_item = (struct menu_item *)menu_stuff->stuff;
+		for (i = 0; i < menu_stuff->nr; i++, menu_item++) {
+			if (len == 1 && *choice == menu_item->hotkey) {
+				found = i + 1;
+				break;
+			}
+			if (!strncasecmp(choice, menu_item->title, len)) {
+				if (found) {
+					if (len == 1) {
+						/* continue for hotkey matching */
+						found = -1;
+					} else {
+						found = 0;
+						break;
+					}
+				} else {
+					found = i + 1;
+				}
+			}
+		}
+		break;
+	case MENU_STUFF_TYPE_STRING_LIST:
+		string_list_item = ((struct string_list *)menu_stuff->stuff)->items;
+		for (i = 0; i < menu_stuff->nr; i++, string_list_item++) {
+			if (!strncasecmp(choice, string_list_item->string, len)) {
+				if (found) {
+					found = 0;
+					break;
+				}
+				found = i + 1;
+			}
+		}
+		break;
+	}
+	return found;
+}
+
+
 /*
  * Parse user input, and return choice(s) for menu (menu_stuff).
  *
@@ -392,8 +442,6 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 			int **chosen)
 {
 	struct strbuf **choice_list, **ptr;
-	struct menu_item *menu_item;
-	struct string_list_item *string_list_item;
 	int nr = 0;
 	int i;
 
@@ -457,32 +505,8 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 			bottom = 1;
 			top = menu_stuff->nr;
 		} else {
-			switch (menu_stuff->type) {
-			default:
-				die("Bad type of menu_stuff when parse choice");
-			case MENU_STUFF_TYPE_MENU_ITEM:
-				menu_item = (struct menu_item *)menu_stuff->stuff;
-				for (i = 0; i < menu_stuff->nr; i++, menu_item++) {
-					if (((*ptr)->len == 1 &&
-					     *(*ptr)->buf == menu_item->hotkey) ||
-					    !strcasecmp((*ptr)->buf, menu_item->title)) {
-						bottom = i + 1;
-						top = bottom;
-						break;
-					}
-				}
-				break;
-			case MENU_STUFF_TYPE_STRING_LIST:
-				string_list_item = ((struct string_list *)menu_stuff->stuff)->items;
-				for (i = 0; i < menu_stuff->nr; i++, string_list_item++) {
-					if (!strcasecmp((*ptr)->buf, string_list_item->string)) {
-						bottom = i + 1;
-						top = bottom;
-						break;
-					}
-				}
-				break;
-			}
+			bottom = find_unique((*ptr)->buf, menu_stuff);
+			top = bottom;
 		}
 
 		if (top <= 0 || bottom <= 0 || top > menu_stuff->nr || bottom > top ||
diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index 4e6055d..3ae394e 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup' '
 
 '
 
-test_expect_success 'git clean -i (clean)' '
+test_expect_success 'git clean -i (c: clean hotkey)' '
 
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
@@ -38,12 +38,33 @@ test_expect_success 'git clean -i (clean)' '
 
 '
 
+test_expect_success 'git clean -i (cl: clean prefix)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	echo cl | git clean -i &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test ! -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
 test_expect_success 'git clean -i (quit)' '
 
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	echo q | git clean -i &&
+	echo quit | git clean -i &&
 	test -f Makefile &&
 	test -f README &&
 	test -f src/part1.c &&
@@ -256,6 +277,21 @@ test_expect_success 'git clean -id (select - number 3)' '
 
 '
 
+test_expect_success 'git clean -id (select - filenames)' '
+
+	mkdir -p build docs &&
+	touch a.out foo.txt bar.txt baz.txt &&
+	(echo s; echo a.out fo ba bar; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test ! -f a.out &&
+	test ! -f foo.txt &&
+	test ! -f bar.txt &&
+	test -f baz.txt &&
+	rm baz.txt
+
+'
+
 test_expect_success 'git clean -id (select - range)' '
 
 	mkdir -p build docs &&
-- 
1.8.3.4.842.g8e6673c
