From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 1/6] string_list: add function string_list_append_nodup()
Date: Wed, 12 Sep 2012 16:04:42 +0200
Message-ID: <1347458687-31092-2-git-send-email-mhagger@alum.mit.edu>
References: <1347458687-31092-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 16:05:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBnZJ-0004hC-8M
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 16:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758904Ab2ILOFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 10:05:16 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:46564 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605Ab2ILOFI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 10:05:08 -0400
X-AuditID: 12074413-b7f786d0000008bb-f3-505096948725
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 83.92.02235.49690505; Wed, 12 Sep 2012 10:05:08 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8CE51QT021888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Sep 2012 10:05:07 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347458687-31092-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqDtlWkCAwbUzLBZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujM1fX7EX
	PFSreDnvFEsD4xv5LkZODgkBE4n90zvYIGwxiQv31gPZXBxCApcZJSa3bGCHcM4wSTzoXssM
	UsUmoCuxqKeZCcQWEVCTmNh2iAXEZhZIkeh43s0IYgsL+Egc+d0KVs8ioCrx+NgMdhCbV8BF
	4vaTX8wQ2xQlfnxfA2ZzCrhKLJn5B+wKIaCatc0zmSYw8i5gZFjFKJeYU5qrm5uYmVOcmqxb
	nJyYl5dapGuul5tZopeaUrqJERJAwjsYd52UO8QowMGoxMPLkOAfIMSaWFZcmXuIUZKDSUmU
	9/PkgAAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwbdIFyvCmJlVWpRfkwKWkOFiVxXrUl6n5C
	AumJJanZqakFqUUwWRkODiUJ3rdTgBoFi1LTUyvSMnNKENJMHJwgggtkAw/QhnKQQt7igsTc
	4sx0iKJTjIpS4rxnJgElBEASGaV5cANgsf6KURzoH2FewalAVTzANAHX/QpoMBPQ4Alr/UEG
	lyQipKQaGNvEj89ZFHT8zcmspiwZwa02B5tNzt959OQ/5x7LJ4+2HD9amBdVXxy07fi3wr/C
	jPeLf33P5KhOCbEQuPX/xaoeZ39xez/PnYvP8AhkZOuxC656GCASZ6y6+XKiSMxG1br+gDkH
	uW29zXvuFfnGXtl8a8HO62qrk0/2z5sxf5nBmlI+f4fHe5VYijMSDbWYi4oTAcmD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205291>

Add a new function that appends a string to a string_list without
copying it.  This can be used to pass ownership of an already-copied
string to a string_list that has strdup_strings set.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt | 17 ++++++++++++++---
 string-list.c                               | 20 +++++++++++++++-----
 string-list.h                               | 18 ++++++++++++++++++
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 5a0c14f..113f841 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -20,8 +20,8 @@ If you need something advanced, you can manually malloc() the `items`
 member (you need this if you add things later) and you should set the
 `nr` and `alloc` members in that case, too.
 
-. Adds new items to the list, using `string_list_append` or
-  `string_list_insert`.
+. Adds new items to the list, using `string_list_append`,
+  `string_list_append_nodup`, or `string_list_insert`.
 
 . Can check if a string is in the list using `string_list_has_string` or
   `unsorted_string_list_has_string` and get it from the list using
@@ -100,7 +100,18 @@ write `string_list_insert(...)->util = ...;`.
 
 `string_list_append`::
 
-	Append a new string to the end of the string_list.
+	Append a new string to the end of the string_list.  If
+	`strdup_string` is set, then the string argument is copied;
+	otherwise the new `string_list_entry` refers to the input
+	string.
+
+`string_list_append_nodup`::
+
+	Append a new string to the end of the string_list.  The new
+	`string_list_entry` always refers to the input string, even if
+	`strdup_string` is set.  This function can be used to hand
+	ownership of a malloc()ed string to a `string_list` that has
+	`strdup_string` set.
 
 `sort_string_list`::
 
diff --git a/string-list.c b/string-list.c
index d9810ab..ad2aa5a 100644
--- a/string-list.c
+++ b/string-list.c
@@ -148,13 +148,23 @@ void print_string_list(const struct string_list *p, const char *text)
 		printf("%s:%p\n", p->items[i].string, p->items[i].util);
 }
 
-struct string_list_item *string_list_append(struct string_list *list, const char *string)
+struct string_list_item *string_list_append_nodup(struct string_list *list,
+						  char *string)
 {
+	struct string_list_item *retval;
 	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
-	list->items[list->nr].string =
-		list->strdup_strings ? xstrdup(string) : (char *)string;
-	list->items[list->nr].util = NULL;
-	return list->items + list->nr++;
+	retval = &list->items[list->nr++];
+	retval->string = string;
+	retval->util = NULL;
+	return retval;
+}
+
+struct string_list_item *string_list_append(struct string_list *list,
+					    const char *string)
+{
+	return string_list_append_nodup(
+			list,
+			list->strdup_strings ? xstrdup(string) : (char *)string);
 }
 
 static int cmp_items(const void *a, const void *b)
diff --git a/string-list.h b/string-list.h
index 0684cb7..1b3915b 100644
--- a/string-list.h
+++ b/string-list.h
@@ -29,6 +29,7 @@ int for_each_string_list(struct string_list *list,
 #define for_each_string_list_item(item,list) \
 	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
 
+
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
@@ -38,11 +39,28 @@ struct string_list_item *string_list_insert_at_index(struct string_list *list,
 						     int insert_at, const char *string);
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
 
+
 /* Use these functions only on unsorted lists: */
+
+/*
+ * Add string to the end of list.  If list->strdup_string is set, then
+ * string is copied; otherwise the new string_list_entry refers to the
+ * input string.
+ */
 struct string_list_item *string_list_append(struct string_list *list, const char *string);
+
+/*
+ * Like string_list_append(), except string is never copied.  When
+ * list->strdup_strings is set, this function can be used to hand
+ * ownership of a malloc()ed string to list without making an extra
+ * copy.
+ */
+struct string_list_item *string_list_append_nodup(struct string_list *list, char *string);
+
 void sort_string_list(struct string_list *list);
 int unsorted_string_list_has_string(struct string_list *list, const char *string);
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string);
+
 void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
 #endif /* STRING_LIST_H */
-- 
1.7.11.3
