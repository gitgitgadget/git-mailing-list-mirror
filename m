From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/10] string-list: allow case-insensitive string list
Date: Mon,  7 Jan 2013 16:10:12 -0800
Message-ID: <1357603821-8647-2-git-send-email-gitster@pobox.com>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 01:10:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsMmH-00061G-Ol
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 01:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab3AHAK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 19:10:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50204 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756103Ab3AHAK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 19:10:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B3B9B7A1;
	Mon,  7 Jan 2013 19:10:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JmGr
	4kdkwae7NPDbNsgrioDn1Co=; b=thAfUS2U1Uc/pIxjGyngVlzQBuf5o9onlj9t
	PARH8YGQW8IodsTQrEX/4wLxztKsEhWOdWprF//DrqVT7oWZLpMHyADbuk9dMIvk
	NLCvo0IsQjW9w943L5jUnRuogYnB5dKktgH8mNqAeb+FQXGIhe1Q2Og3SxIbBoIJ
	invuOKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	gD5UB3DKWwpwYhuZoFN650FINyY3Ifuv1d9BxGL8IRj51/tJvGLEiS19CVxvLsGF
	wqBSZcw573DuLH4AgGVQdyeA/hqlOAlyxIqk7i/ncU7f3hx2a2F2Gk2HcWZBxidl
	ZlKEoNg8vcCmO496bL0RF2ZMbuGUEIvqEMVSsPEAj3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CCE1B79F;
	Mon,  7 Jan 2013 19:10:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AF05B79D; Mon,  7 Jan 2013
 19:10:25 -0500 (EST)
X-Mailer: git-send-email 1.8.1.304.gf036638
In-Reply-To: <1357603821-8647-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CD0A5BE0-5927-11E2-B602-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212921>

Some string list needs to be searched case insensitively, and for
that to work correctly, the string needs to be sorted case
insensitively from the beginning.

Allow a custom comparison function to be defined on a string list
instance and use it throughout in place of strcmp().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 string-list.c | 17 +++++++++++++----
 string-list.h |  4 ++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/string-list.c b/string-list.c
index 397e6cf..6f3d8cf 100644
--- a/string-list.c
+++ b/string-list.c
@@ -7,10 +7,11 @@ static int get_entry_index(const struct string_list *list, const char *string,
 		int *exact_match)
 {
 	int left = -1, right = list->nr;
+	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
 
 	while (left + 1 < right) {
 		int middle = (left + right) / 2;
-		int compare = strcmp(string, list->items[middle].string);
+		int compare = cmp(string, list->items[middle].string);
 		if (compare < 0)
 			right = middle;
 		else if (compare > 0)
@@ -96,8 +97,9 @@ void string_list_remove_duplicates(struct string_list *list, int free_util)
 {
 	if (list->nr > 1) {
 		int src, dst;
+		compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
 		for (src = dst = 1; src < list->nr; src++) {
-			if (!strcmp(list->items[dst - 1].string, list->items[src].string)) {
+			if (!cmp(list->items[dst - 1].string, list->items[src].string)) {
 				if (list->strdup_strings)
 					free(list->items[src].string);
 				if (free_util)
@@ -230,15 +232,20 @@ struct string_list_item *string_list_append(struct string_list *list,
 			list->strdup_strings ? xstrdup(string) : (char *)string);
 }
 
+/* Yuck */
+static compare_strings_fn compare_for_qsort;
+
+/* Only call this from inside sort_string_list! */
 static int cmp_items(const void *a, const void *b)
 {
 	const struct string_list_item *one = a;
 	const struct string_list_item *two = b;
-	return strcmp(one->string, two->string);
+	return compare_for_qsort(one->string, two->string);
 }
 
 void sort_string_list(struct string_list *list)
 {
+	compare_for_qsort = list->cmp ? list->cmp : strcmp;
 	qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
 }
 
@@ -246,8 +253,10 @@ struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string)
 {
 	int i;
+	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
+
 	for (i = 0; i < list->nr; i++)
-		if (!strcmp(string, list->items[i].string))
+		if (!cmp(string, list->items[i].string))
 			return list->items + i;
 	return NULL;
 }
diff --git a/string-list.h b/string-list.h
index c50b0d0..446e79e 100644
--- a/string-list.h
+++ b/string-list.h
@@ -5,10 +5,14 @@ struct string_list_item {
 	char *string;
 	void *util;
 };
+
+typedef int (*compare_strings_fn)(const char *, const char *);
+
 struct string_list {
 	struct string_list_item *items;
 	unsigned int nr, alloc;
 	unsigned int strdup_strings:1;
+	compare_strings_fn cmp; /* NULL uses strcmp() */
 };
 
 #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0 }
-- 
1.8.1.304.gf036638
