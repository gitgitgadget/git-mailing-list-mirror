From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 01/10] string-list: allow case-insensitive string list
Date: Thu, 10 Jan 2013 22:35:05 +0100
Message-ID: <50EF3409.6050805@lsrfire.ath.cx>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com> <1357603821-8647-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:35:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtPmc-0002RH-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 22:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398Ab3AJVfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 16:35:09 -0500
Received: from india601.server4you.de ([85.25.151.105]:37367 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab3AJVfI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 16:35:08 -0500
Received: from [192.168.2.105] (p4FFD8614.dip.t-dialin.net [79.253.134.20])
	by india601.server4you.de (Postfix) with ESMTPSA id A1E18105;
	Thu, 10 Jan 2013 22:35:06 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <1357603821-8647-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213154>

Am 08.01.2013 01:10, schrieb Junio C Hamano:
> Some string list needs to be searched case insensitively, and for
> that to work correctly, the string needs to be sorted case
> insensitively from the beginning.
>=20
> Allow a custom comparison function to be defined on a string list
> instance and use it throughout in place of strcmp().
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

We can avoid using a static variable to pass the comparison function fr=
om
sort_string_list() to cmp_items() by dialling back the flexibility a bi=
t
and only have a flag to switch between strcmp() and strcasecmp().  I be=
t
this suffices for quite a while yet.  Slightly more code, less yuck,
squashable.

Ren=E9


---
 mailmap.c     |  2 +-
 string-list.c | 23 ++++++++++++++---------
 string-list.h |  4 +---
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 276c54f..08126b1 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -235,7 +235,7 @@ int read_mailmap(struct string_list *map, char **re=
po_abbrev)
 	int err =3D 0;
=20
 	map->strdup_strings =3D 1;
-	map->cmp =3D strcasecmp;
+	map->ignore_case =3D 1;
=20
 	if (!git_mailmap_blob && is_bare_repository())
 		git_mailmap_blob =3D "HEAD:.mailmap";
diff --git a/string-list.c b/string-list.c
index aabb25e..ddecc23 100644
--- a/string-list.c
+++ b/string-list.c
@@ -1,13 +1,15 @@
 #include "cache.h"
 #include "string-list.h"
=20
+typedef int (*compare_strings_fn)(const char *, const char *);
+
 /* if there is no exact match, point to the index where the entry coul=
d be
  * inserted */
 static int get_entry_index(const struct string_list *list, const char =
*string,
 		int *exact_match)
 {
 	int left =3D -1, right =3D list->nr;
-	compare_strings_fn cmp =3D list->cmp ? list->cmp : strcmp;
+	compare_strings_fn cmp =3D list->ignore_case ? strcasecmp : strcmp;
=20
 	while (left + 1 < right) {
 		int middle =3D (left + right) / 2;
@@ -97,7 +99,7 @@ void string_list_remove_duplicates(struct string_list=
 *list, int free_util)
 {
 	if (list->nr > 1) {
 		int src, dst;
-		compare_strings_fn cmp =3D list->cmp ? list->cmp : strcmp;
+		compare_strings_fn cmp =3D list->ignore_case ? strcasecmp : strcmp;
 		for (src =3D dst =3D 1; src < list->nr; src++) {
 			if (!cmp(list->items[dst - 1].string, list->items[src].string)) {
 				if (list->strdup_strings)
@@ -212,28 +214,31 @@ struct string_list_item *string_list_append(struc=
t string_list *list,
 			list->strdup_strings ? xstrdup(string) : (char *)string);
 }
=20
-/* Yuck */
-static compare_strings_fn compare_for_qsort;
+static int cmp_items_ignore_case(const void *a, const void *b)
+{
+	const struct string_list_item *one =3D a;
+	const struct string_list_item *two =3D b;
+	return strcasecmp(one->string, two->string);
+}
=20
-/* Only call this from inside sort_string_list! */
 static int cmp_items(const void *a, const void *b)
 {
 	const struct string_list_item *one =3D a;
 	const struct string_list_item *two =3D b;
-	return compare_for_qsort(one->string, two->string);
+	return strcmp(one->string, two->string);
 }
=20
 void sort_string_list(struct string_list *list)
 {
-	compare_for_qsort =3D list->cmp ? list->cmp : strcmp;
-	qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
+	qsort(list->items, list->nr, sizeof(*list->items),
+	      list->ignore_case ? cmp_items_ignore_case : cmp_items);
 }
=20
 struct string_list_item *unsorted_string_list_lookup(struct string_lis=
t *list,
 						     const char *string)
 {
 	int i;
-	compare_strings_fn cmp =3D list->cmp ? list->cmp : strcmp;
+	compare_strings_fn cmp =3D list->ignore_case ? strcasecmp : strcmp;
=20
 	for (i =3D 0; i < list->nr; i++)
 		if (!cmp(string, list->items[i].string))
diff --git a/string-list.h b/string-list.h
index de6769c..33f2e9c 100644
--- a/string-list.h
+++ b/string-list.h
@@ -6,13 +6,11 @@ struct string_list_item {
 	void *util;
 };
=20
-typedef int (*compare_strings_fn)(const char *, const char *);
-
 struct string_list {
 	struct string_list_item *items;
 	unsigned int nr, alloc;
 	unsigned int strdup_strings:1;
-	compare_strings_fn cmp; /* NULL uses strcmp() */
+	unsigned int ignore_case:1;
 };
=20
 #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0 }
--=20
1.8.0
