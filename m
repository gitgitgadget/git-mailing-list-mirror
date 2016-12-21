Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBC21FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 09:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbcLUJhN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 04:37:13 -0500
Received: from mout.web.de ([212.227.17.12]:64848 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752736AbcLUJhI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 04:37:08 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZedc-1d0gqD3K1s-00lUGF; Wed, 21
 Dec 2016 10:36:50 +0100
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] string-list: make compare function compatible with qsort(3)
Message-ID: <c7bac0b7-c555-162f-7880-0355831cee48@web.de>
Date:   Wed, 21 Dec 2016 10:36:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:nBrqSKXxUM0fSwdAZ+UBCkyds2QfqnYLVa7F2cKuTTGzKG4ZXW6
 g0viaVlQTaJvgC/p4qoveR8PArGt3/IZDz9vwkjhJJ+Ne6ua2ZY1GpWyQw/9oxeUdN2eSQE
 AsguA7aZe5bByXlQoEQJ1s2YNJfoMiVbXanxy2ohf4BHRILhFEBdmk9YQlXerFFmCoYAAlO
 SNmcW4lJ57Sk4Ko3S2DxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RtojdFvOxUs=:VLdibPq9KnOTqjPvlEeExT
 q7yj3zYVoFH8qyMnXfcLjeu8tze/ig6dDznEOwDAT5lV+7w8nrv2Kn7t3hajdQWVHQWa9BLzE
 SvfrWE0QIOM9ugB7y5G6MLpvMMDqYAdipBL0o6ipZMwVKDsejtvkPOAIwNYLIwkiMCoZ0dt1P
 8N7jxp3+J5egJh3sIyjNvpZ6b+88tbDuo7k1Z+AMjJp5rWLF5m+pv1n0Wx9XARIEw748PiXWF
 DxMqIvjghFRJl3dBFSHClFqGItUCkg7Q79udjBR662pdKesi/VP5pQcEOMlAhhgVmOvRx1P73
 eXrn2eE/zueEpoSVAm7Rd3hOfatx/DdNSkQAVak/RGAAO1m5Et2kQkRgfD0q8a1gU2JWVesUk
 4VTGBsiJ9mQG0cd9u4atHuYhPwefV1S3ifLJV9ZAhBSAI5pCAohCQmTwFiCp4psShAeMfd+K8
 3m1jV/wt4NWGTupLQsm1MSPiEwtrAsm/bb4LISytrar5XzSKAjqj5wJHfGYSIyTa//JK0UgE5
 EMgXqPg/Q99En2kpE5NUMq160j+i9QZkwWy4w/qF8Cwd3PNqlPLKH0LrLRIR2sUN17STXuBqC
 b+t/yhixFJhZhHA14EH+pYUEir2BgJk3BVIBgC+6sC8AbOV51/DGuvXyxwVsh5z0bz7LzlHpt
 B27yLtSbq9lVD4vXGbNRYzMDPEmD/LB6VJDH+sdrIpKxH84j2guyqCNfiI2E1F4z69UGnIU17
 T33BjKAMv0XvsTZwHUdq6ZqDoOvcKC3iHDXBLnnpla5jIhbuGLLMkfVEb7PtEaxn8HupVqLX3
 3DMc5Cx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cmp member of struct string_list points to a comparison function
that is used for sorting and searching of list items.  It takes two
string pointers -- like strcmp(3), which is in fact the default;
cmp_items() provides a qsort(3) compatible interface by passing the
string members of two struct string_list_item pointers to cmp.

One shortcoming is that the comparison function is restricted to working
with the string members of items; util is inaccessible to it.  Another
one is that the value of cmp is passed in a global variable to
cmp_items(), making string_list_sort() non-reentrant.

Remove the intermediate layer, i.e. cmp_items(), make the comparison
functions compatible with qsort(3) and pass them pointers to full items.
This allows comparisons to also take the util member into account, and
avoids the need to pass the real comparison function to an intermediate
function, removing the need for a global function.

A downside is that comparison functions take void pointers now and each
of them needs to cast its arguments to struct string_list_item pointers,
weakening type safety and adding some repetitive code.  Programmers are
used to that, however, as that's par for the course with qsort(3).

Also two unsightly casts are added that remove the const qualifiers of
strings while building the structs to pass to the comparison function as
search keys.  It should be safe, though, as we only ever use them for
reading.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Alternative approach to the qsort_s()-based series "string-list: make
string_list_sort() reentrant".

 Documentation/technical/api-string-list.txt |  6 +++--
 builtin/mailsplit.c                         |  5 +++-
 mailmap.c                                   |  5 ++--
 merge-recursive.c                           |  4 ++-
 string-list.c                               | 39 +++++++++++++++--------------
 string-list.h                               |  4 +--
 tmp-objdir.c                                |  4 ++-
 7 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index c08402b12..39eac59c7 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -205,5 +205,7 @@ Represents the list itself.
   You should not tamper with it.
 . Setting the `strdup_strings` member to 1 will strdup() the strings
   before adding them, see above.
-. The `compare_strings_fn` member is used to specify a custom compare
-  function, otherwise `strcmp()` is used as the default function.
+. The `cmp` member is used to specify a custom compare function. It has
+  the same signature as the one for qsort(1) and is passed two pointers
+  to `struct string_list_item`. If it's NULL then the `string` members
+  are compared with `strcmp(1)`; this is the default.
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 30681681c..4e72e3128 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -147,8 +147,11 @@ static int populate_maildir_list(struct string_list *list, const char *path)
 	return ret;
 }
 
-static int maildir_filename_cmp(const char *a, const char *b)
+static int maildir_filename_cmp(const void *one, const void *two)
 {
+	const struct string_list_item *item_one = one, *item_two = two;
+	const char *a = item_one->string, *b = item_two->string;
+
 	while (*a && *b) {
 		if (isdigit(*a) && isdigit(*b)) {
 			long int na, nb;
diff --git a/mailmap.c b/mailmap.c
index c1a79c100..5290b5153 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -61,9 +61,10 @@ static void free_mailmap_entry(void *p, const char *s)
  * namemap.cmp until we know no systems that matter have such an
  * "unusual" string.h.
  */
-static int namemap_cmp(const char *a, const char *b)
+static int namemap_cmp(const void *one, const void *two)
 {
-	return strcasecmp(a, b);
+	const struct string_list_item *item_one = one, *item_two = two;
+	return strcasecmp(item_one->string, item_two->string);
 }
 
 static void add_mapping(struct string_list *map,
diff --git a/merge-recursive.c b/merge-recursive.c
index d32720944..4683ba43f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -390,8 +390,10 @@ static struct string_list *get_unmerged(void)
 	return unmerged;
 }
 
-static int string_list_df_name_compare(const char *one, const char *two)
+static int string_list_df_name_compare(const void *a, const void *b)
 {
+	const struct string_list_item *item_a = a, *item_b = b;
+	const char *one = item_a->string, *two = item_b->string;
 	int onelen = strlen(one);
 	int twolen = strlen(two);
 	/*
diff --git a/string-list.c b/string-list.c
index 8c83cac18..c583a04ee 100644
--- a/string-list.c
+++ b/string-list.c
@@ -7,17 +7,26 @@ void string_list_init(struct string_list *list, int strdup_strings)
 	list->strdup_strings = strdup_strings;
 }
 
+static int string_list_item_strcmp(const void *one, const void *two)
+{
+	const struct string_list_item *item_one = one, *item_two = two;
+	return strcmp(item_one->string, item_two->string);
+}
+
 /* if there is no exact match, point to the index where the entry could be
  * inserted */
 static int get_entry_index(const struct string_list *list, const char *string,
 		int *exact_match)
 {
 	int left = -1, right = list->nr;
-	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
+	compare_fn_t cmp = list->cmp ? list->cmp : string_list_item_strcmp;
+	struct string_list_item key = { NULL };
+
+	key.string = (char *)string;
 
 	while (left + 1 < right) {
 		int middle = (left + right) / 2;
-		int compare = cmp(string, list->items[middle].string);
+		int compare = cmp(&key, &list->items[middle]);
 		if (compare < 0)
 			right = middle;
 		else if (compare > 0)
@@ -94,11 +103,11 @@ struct string_list_item *string_list_lookup(struct string_list *list, const char
 
 void string_list_remove_duplicates(struct string_list *list, int free_util)
 {
+	compare_fn_t cmp = list->cmp ? list->cmp : string_list_item_strcmp;
 	if (list->nr > 1) {
 		int src, dst;
-		compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
 		for (src = dst = 1; src < list->nr; src++) {
-			if (!cmp(list->items[dst - 1].string, list->items[src].string)) {
+			if (!cmp(&list->items[dst - 1], &list->items[src])) {
 				if (list->strdup_strings)
 					free(list->items[src].string);
 				if (free_util)
@@ -211,31 +220,23 @@ struct string_list_item *string_list_append(struct string_list *list,
 			list->strdup_strings ? xstrdup(string) : (char *)string);
 }
 
-/* Yuck */
-static compare_strings_fn compare_for_qsort;
-
-/* Only call this from inside string_list_sort! */
-static int cmp_items(const void *a, const void *b)
-{
-	const struct string_list_item *one = a;
-	const struct string_list_item *two = b;
-	return compare_for_qsort(one->string, two->string);
-}
-
 void string_list_sort(struct string_list *list)
 {
-	compare_for_qsort = list->cmp ? list->cmp : strcmp;
-	QSORT(list->items, list->nr, cmp_items);
+	compare_fn_t cmp = list->cmp ? list->cmp : string_list_item_strcmp;
+	QSORT(list->items, list->nr, cmp);
 }
 
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string)
 {
 	struct string_list_item *item;
-	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
+	compare_fn_t cmp = list->cmp ? list->cmp : string_list_item_strcmp;
+	struct string_list_item key = { NULL };
+
+	key.string = (char *)string;
 
 	for_each_string_list_item(item, list)
-		if (!cmp(string, item->string))
+		if (!cmp(&key, item))
 			return item;
 	return NULL;
 }
diff --git a/string-list.h b/string-list.h
index d3809a141..073025ddc 100644
--- a/string-list.h
+++ b/string-list.h
@@ -6,13 +6,13 @@ struct string_list_item {
 	void *util;
 };
 
-typedef int (*compare_strings_fn)(const char *, const char *);
+typedef int (*compare_fn_t)(const void *, const void *);
 
 struct string_list {
 	struct string_list_item *items;
 	unsigned int nr, alloc;
 	unsigned int strdup_strings:1;
-	compare_strings_fn cmp; /* NULL uses strcmp() */
+	compare_fn_t cmp; /* NULL uses strcmp() on ->string */
 };
 
 #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 64435f23a..b6209b199 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -173,8 +173,10 @@ static int pack_copy_priority(const char *name)
 	return 4;
 }
 
-static int pack_copy_cmp(const char *a, const char *b)
+static int pack_copy_cmp(const void *one, const void *two)
 {
+	const struct string_list_item *item_one = one, *item_two = two;
+	const char *a = item_one->string, *b = item_two->string;
 	return pack_copy_priority(a) - pack_copy_priority(b);
 }
 
-- 
2.11.0

