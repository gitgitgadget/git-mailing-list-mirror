From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 01/10] list_lookup: create case and length search
Date: Sat,  5 Jan 2013 22:26:37 +0100
Message-ID: <1357421206-5014-2-git-send-email-apelisse@gmail.com>
References: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:27:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbHB-0000L4-4D
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893Ab3AEV1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:27:15 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:49737 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886Ab3AEV1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:27:14 -0500
Received: by mail-wg0-f42.google.com with SMTP id dr1so1094013wgb.3
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 13:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dxdSSdPevQz0a4Sga1VjddmqsPgxKOol8yOf3WuySmU=;
        b=UpxocG51ef805zmlqDbMeVJerVsjg+kGyjQb7/JYd/7d0c1uL+QY73oIaorkjFTY+Y
         Q1p+w6ACTUVsvx1w22Wg5ks3tQs74nEbYxVPWuV/89AZt2Nil5I+26dZM7FH++cj61gD
         QZ6uxhhBzRInb0D2sVg5GASErQjLTR9XnXz04VlhHF+WVQjGDEgCVG441ObRZvyj0PSt
         EBkm6L3VMqpOpyeeAiifGcKhDkjN7QT8gCbSuMjfDRXEZXWVVT1bgqF3pHoiAnsuvkdb
         u2iWy0eyK62jyExg9ZQlL0j/lwG9ZRE+KUJPA3FyqkWtFusvPk8DUgc11YCl5vPWYLb4
         qmBg==
X-Received: by 10.180.106.34 with SMTP id gr2mr3172347wib.18.1357421232672;
        Sat, 05 Jan 2013 13:27:12 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id t17sm5623711wiv.6.2013.01.05.13.27.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 13:27:12 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.15.g5ddde70
In-Reply-To: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212718>

Create a new function to look-up a string in a string_list, but:
 - add a new parameter to ignore case differences
 - add a length parameter to search for a substring

The idea is to avoid several copies (lowering a string before searching
it when we just want to ignore case), or copying a substring of a bigger
string to search it in the string_list

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 string-list.c | 30 ++++++++++++++++++++++++------
 string-list.h |  2 ++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/string-list.c b/string-list.c
index 397e6cf..f06e110 100644
--- a/string-list.c
+++ b/string-list.c
@@ -4,13 +4,21 @@
 /* if there is no exact match, point to the index where the entry could be
  * inserted */
 static int get_entry_index(const struct string_list *list, const char *string,
-		int *exact_match)
+		int *exact_match, int case_sensitive, size_t n)
 {
 	int left = -1, right = list->nr;
 
 	while (left + 1 < right) {
+		int compare;
 		int middle = (left + right) / 2;
-		int compare = strcmp(string, list->items[middle].string);
+		if (case_sensitive)
+			compare = strncmp(string, list->items[middle].string, n);
+		else
+			compare = strncasecmp(string, list->items[middle].string, n);
+		/* Make sure our string is not a substring of item string */
+		if (!compare && n != -1)
+			if (list->items[middle].string[n] != '\0')
+				compare = -1;
 		if (compare < 0)
 			right = middle;
 		else if (compare > 0)
@@ -29,7 +37,7 @@ static int get_entry_index(const struct string_list *list, const char *string,
 static int add_entry(int insert_at, struct string_list *list, const char *string)
 {
 	int exact_match = 0;
-	int index = insert_at != -1 ? insert_at : get_entry_index(list, string, &exact_match);
+	int index = insert_at != -1 ? insert_at : get_entry_index(list, string, &exact_match, 1, -1);
 
 	if (exact_match)
 		return -1 - index;
@@ -70,7 +78,7 @@ struct string_list_item *string_list_insert_at_index(struct string_list *list,
 int string_list_has_string(const struct string_list *list, const char *string)
 {
 	int exact_match;
-	get_entry_index(list, string, &exact_match);
+	get_entry_index(list, string, &exact_match, 1, -1);
 	return exact_match;
 }
 
@@ -78,7 +86,7 @@ int string_list_find_insert_index(const struct string_list *list, const char *st
 				  int negative_existing_index)
 {
 	int exact_match;
-	int index = get_entry_index(list, string, &exact_match);
+	int index = get_entry_index(list, string, &exact_match, 1, -1);
 	if (exact_match)
 		index = -1 - (negative_existing_index ? index : 0);
 	return index;
@@ -86,7 +94,17 @@ int string_list_find_insert_index(const struct string_list *list, const char *st
 
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string)
 {
-	int exact_match, i = get_entry_index(list, string, &exact_match);
+	int exact_match, i = get_entry_index(list, string, &exact_match, 1, -1);
+	if (!exact_match)
+		return NULL;
+	return list->items + i;
+}
+
+struct string_list_item *string_list_lookup_extended(struct string_list *list,
+    const char *string, int case_sensitive, size_t n)
+{
+	int exact_match, i = get_entry_index(list, string, &exact_match,
+					     case_sensitive, n);
 	if (!exact_match)
 		return NULL;
 	return list->items + i;
diff --git a/string-list.h b/string-list.h
index c50b0d0..4f5ae19 100644
--- a/string-list.h
+++ b/string-list.h
@@ -62,6 +62,8 @@ struct string_list_item *string_list_insert(struct string_list *list, const char
 struct string_list_item *string_list_insert_at_index(struct string_list *list,
 						     int insert_at, const char *string);
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
+struct string_list_item *string_list_lookup_extended(struct string_list *list,
+    const char *string, int case_sensitive, size_t n);
 
 /*
  * Remove all but the first of consecutive entries with the same
-- 
1.7.12.4.3.g2036a08.dirty
