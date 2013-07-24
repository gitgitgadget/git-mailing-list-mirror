From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] git-clean: implement partial matching for selection
Date: Wed, 24 Jul 2013 10:04:33 +0800
Message-ID: <d099b22989d6e7c023e160a6a9b232bc58e6349c.1374631307.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 04:06:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1oTH-00032D-TT
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 04:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843Ab3GXCG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 22:06:26 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39883 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3GXCGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 22:06:25 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so8830994pdj.14
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 19:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wtYmzCNSqOv6cdScyDPwAIwpJ7NDceB5SEaeIaHTBp8=;
        b=FElG11YO7qoAqAtOk+Vvbn1r7zILIGg8+d33LJ3W4YM6PBSLt3JxnaxdNY16NRiDKU
         QvNH0Z2Vnsm1Pk1p3+f8SYWgZbe0JQh67I8WKf+4OOD+cewfYMbe/9muhf9QcgcguEpP
         zlMAHOiaZdYr2fo14NiBkGjMnrXFirCFX1+siOn96wG8mFYNyNGQIGBsBUjGsjU70z7N
         z84acLFjxdj1OiJ7YmrNcu7wUBa1Zi/5zog2i6I6O43No1t+J0L9+Wb07yKmtWzZ3ynC
         AcW0IJMqFxHPAT9Krej9LbF8YISajWv0YwaREupJCSOpf6tGYtezgLxFpsrRNdCQx8qq
         izIw==
X-Received: by 10.66.25.232 with SMTP id f8mr30731163pag.25.1374631585058;
        Tue, 23 Jul 2013 19:06:25 -0700 (PDT)
Received: from localhost.localdomain ([114.246.130.173])
        by mx.google.com with ESMTPSA id 7sm40760362paf.22.2013.07.23.19.06.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 19:06:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.842.g8e6673c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231074>

Document for interactive git-clean says: "You also could say `c` or
`clean` above as long as the choice is unique". But it's not true,
because only hotkey `c` and full match (`clean`) could work.

Implement partial matching via find_unique function to make the
document right.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c              | 80 ++++++++++++++++++++++++++++----------------
 t/t7301-clean-interactive.sh | 41 +++++++++++++++++++++--
 2 files changed, 91 insertions(+), 30 deletions(-)

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
index 4e6055d..71c5c6b 100755
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
@@ -256,6 +277,22 @@ test_expect_success 'git clean -id (select - number 3)' '
 
 '
 
+test_expect_success 'git clean -id (select - filenames)' '
+
+	mkdir -p build docs &&
+	touch a.out foo.txt bar.txt baz.txt &&
+	(echo s; echo a.out fo ba bar; echo; echo c) | \
+	git clean -id &&
+	find . > /tmp/x &&
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
