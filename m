From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH v3 2/4] Add find_insert_index, insert_at_index and clear_func functions to string_list
Date: Mon,  2 Feb 2009 15:32:08 +0100
Message-ID: <76e643ff7e99985ce46b6bf36ec967124d7fc6aa.1233584536.git.marius@trolltech.com>
References: <cover.1233584536.git.marius@trolltech.com>
 <36adb0d2cc4c20c4efb3b03a912b27e67c166855.1233584536.git.marius@trolltech.com>
Cc: gitster@pobox.com, Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 15:35:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTzt0-000779-Iv
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 15:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbZBBOdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 09:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbZBBOd2
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 09:33:28 -0500
Received: from hoat.troll.no ([62.70.27.150]:37590 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643AbZBBOd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 09:33:27 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 60AA720F51;
	Mon,  2 Feb 2009 15:33:21 +0100 (CET)
Received: from localhost.localdomain (unknown [172.24.90.96])
	by hoat.troll.no (Postfix) with ESMTP id 5144420F04;
	Mon,  2 Feb 2009 15:33:21 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.257.g84fd75
In-Reply-To: <36adb0d2cc4c20c4efb3b03a912b27e67c166855.1233584536.git.marius@trolltech.com>
In-Reply-To: <cover.1233584536.git.marius@trolltech.com>
References: <cover.1233584536.git.marius@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108092>

string_list_find_insert_index() and string_list_insert_at_index()
enables you to see if an item is in the string_list, and to
insert at the appropriate index in the list, if not there.
This is usefull if you need to manipulate an existing item,
if present, and insert a new item if not.

Future mailmap code will use this construct to enable
complex (old_name, old_email) -> (new_name, new_email)
lookups.

The string_list_clear_func() allows to call a custom
cleanup function on each item in a string_list, which is
useful is the util member points to a complex structure.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 string-list.c |   43 +++++++++++++++++++++++++++++++++++++++----
 string-list.h |    9 +++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/string-list.c b/string-list.c
index ddd83c8..15e14cf 100644
--- a/string-list.c
+++ b/string-list.c
@@ -26,10 +26,10 @@ static int get_entry_index(const struct string_list *list, const char *string,
 }
 
 /* returns -1-index if already exists */
-static int add_entry(struct string_list *list, const char *string)
+static int add_entry(int insert_at, struct string_list *list, const char *string)
 {
-	int exact_match;
-	int index = get_entry_index(list, string, &exact_match);
+	int exact_match = 0;
+	int index = insert_at != -1 ? insert_at : get_entry_index(list, string, &exact_match);
 
 	if (exact_match)
 		return -1 - index;
@@ -53,7 +53,13 @@ static int add_entry(struct string_list *list, const char *string)
 
 struct string_list_item *string_list_insert(const char *string, struct string_list *list)
 {
-	int index = add_entry(list, string);
+	return string_list_insert_at_index(-1, string, list);
+}
+
+struct string_list_item *string_list_insert_at_index(int insert_at,
+						     const char *string, struct string_list *list)
+{
+	int index = add_entry(insert_at, list, string);
 
 	if (index < 0)
 		index = -1 - index;
@@ -68,6 +74,16 @@ int string_list_has_string(const struct string_list *list, const char *string)
 	return exact_match;
 }
 
+int string_list_find_insert_index(const struct string_list *list, const char *string,
+				  int negative_existing_index)
+{
+	int exact_match;
+	int index = get_entry_index(list, string, &exact_match);
+	if (exact_match)
+		index = -1 - (negative_existing_index ? index : 0);
+	return index;
+}
+
 struct string_list_item *string_list_lookup(const char *string, struct string_list *list)
 {
 	int exact_match, i = get_entry_index(list, string, &exact_match);
@@ -94,6 +110,25 @@ void string_list_clear(struct string_list *list, int free_util)
 	list->nr = list->alloc = 0;
 }
 
+void string_list_clear_func(struct string_list *list, string_list_clear_func_t clearfunc)
+{
+	if (list->items) {
+		int i;
+		if (clearfunc) {
+			for (i = 0; i < list->nr; i++)
+				clearfunc(list->items[i].util, list->items[i].string);
+		}
+		if (list->strdup_strings) {
+			for (i = 0; i < list->nr; i++)
+				free(list->items[i].string);
+		}
+		free(list->items);
+	}
+	list->items = NULL;
+	list->nr = list->alloc = 0;
+}
+
+
 void print_string_list(const char *text, const struct string_list *p)
 {
 	int i;
diff --git a/string-list.h b/string-list.h
index 4d6a705..d32ba05 100644
--- a/string-list.h
+++ b/string-list.h
@@ -15,9 +15,18 @@ struct string_list
 void print_string_list(const char *text, const struct string_list *p);
 void string_list_clear(struct string_list *list, int free_util);
 
+/* Use this function to call a custom clear function on each util pointer */
+/* The string associated with the util pointer is passed as the second argument */
+typedef void (*string_list_clear_func_t)(void *p, const char *str);
+void string_list_clear_func(struct string_list *list, string_list_clear_func_t clearfunc);
+
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
+int string_list_find_insert_index(const struct string_list *list, const char *string,
+				  int negative_existing_index);
 struct string_list_item *string_list_insert(const char *string, struct string_list *list);
+struct string_list_item *string_list_insert_at_index(int insert_at,
+						     const char *string, struct string_list *list);
 struct string_list_item *string_list_lookup(const char *string, struct string_list *list);
 
 /* Use these functions only on unsorted lists: */
-- 
1.6.1.2.257.g84fd75
