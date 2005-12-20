From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] git-pack-redundant: speed and memory usage improvements
Date: Tue, 20 Dec 2005 21:05:54 +0100
Message-ID: <43A86422.3090909@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	=?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Dec 20 21:08:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EonjJ-0002G3-W5
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 21:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVLTUE6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Dec 2005 15:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVLTUE6
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 15:04:58 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:51085 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932068AbVLTUE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 15:04:57 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.069.1)
        id 43A8126C000206CF; Tue, 20 Dec 2005 21:04:53 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13853>

Slab allocation of llist entries gives some speed improvements.

Not computing the pack_list permutaions all at once reduces memory
usage greatly on repositories with many packs.

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>

---
This might be post-1.0 material, but I have tested it on a couple of
different repositories and it appears to work as before, only faster
and using less memory.

 pack-redundant.c |  147 +++++++++++++++++++++++++---------------------=
--------
 1 files changed, 68 insertions(+), 79 deletions(-)

e21c29b79531a98d52dcaf647968cde8e9a462d9
diff --git a/pack-redundant.c b/pack-redundant.c
index 0a43278..1869b38 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -8,6 +8,8 @@
=20
 #include "cache.h"
=20
+#define BLKSIZE 512
+
 static const char pack_redundant_usage[] =3D
 "git-pack-redundant [ --verbose ] [ --alt-odb ] < --all | <.pack filen=
ame> ...>";
=20
@@ -33,29 +35,32 @@ static struct pack_list {
 struct pll {
 	struct pll *next;
 	struct pack_list *pl;
-	size_t pl_size;
 };
=20
 static struct llist_item *free_nodes =3D NULL;
=20
+static inline void llist_item_put(struct llist_item *item)
+{
+	item->next =3D free_nodes;
+	free_nodes =3D item;
+}
+
 static inline struct llist_item *llist_item_get()
 {
 	struct llist_item *new;
 	if ( free_nodes ) {
 		new =3D free_nodes;
 		free_nodes =3D free_nodes->next;
-	} else
-		new =3D xmalloc(sizeof(struct llist_item));
-
+	} else {
+		int i =3D 1;
+		new =3D xmalloc(sizeof(struct llist_item) * BLKSIZE);
+		for(;i < BLKSIZE; i++) {
+			llist_item_put(&new[i]);
+		}
+	}
 	return new;
 }
=20
-static inline void llist_item_put(struct llist_item *item)
-{
-	item->next =3D free_nodes;
-	free_nodes =3D item;
-}
-
 static void llist_free(struct llist *list)
 {
 	while((list->back =3D list->front)) {
@@ -270,77 +275,58 @@ static void cmp_two_packs(struct pack_li
 	}
 }
=20
-static void pll_insert(struct pll **pll, struct pll **hint_table)
+void pll_free(struct pll *l)
 {
-	struct pll *prev;
-	int i =3D (*pll)->pl_size - 1;
+	struct pll *old;
+	struct pack_list *opl;
=20
-	if (hint_table[i] =3D=3D NULL) {
-		hint_table[i--] =3D *pll;
-		for (; i >=3D 0; --i) {
-			if (hint_table[i] !=3D NULL)
-				break;
+	while (l) {
+		old =3D l;
+		while (l->pl) {
+			opl =3D l->pl;
+			l->pl =3D opl->next;
+			free(opl);
 		}
-		if (hint_table[i] =3D=3D NULL) /* no elements in list */
-			die("Why did this happen?");
+		l =3D l->next;
+		free(old);
 	}
-
-	prev =3D hint_table[i];
-	while (prev->next && prev->next->pl_size < (*pll)->pl_size)
-		prev =3D prev->next;
-
-	(*pll)->next =3D prev->next;
-	prev->next =3D *pll;
 }
=20
 /* all the permutations have to be free()d at the same time,
  * since they refer to each other
  */
-static struct pll * get_all_permutations(struct pack_list *list)
+static struct pll * get_permutations(struct pack_list *list, int n)
 {
-	struct pll *subset, *pll, *new_pll =3D NULL; /*silence warning*/
-	static struct pll **hint =3D NULL;
-	if (hint =3D=3D NULL)
-		hint =3D xcalloc(pack_list_size(list), sizeof(struct pll *));
-	=09
-	if (list =3D=3D NULL)
+	struct pll *subset, *ret =3D NULL, *new_pll =3D NULL, *pll;
+
+	if (list =3D=3D NULL || pack_list_size(list) < n || n =3D=3D 0)
 		return NULL;
=20
-	if (list->next =3D=3D NULL) {
-		new_pll =3D xmalloc(sizeof(struct pll));
-		hint[0] =3D new_pll;
-		new_pll->next =3D NULL;
-		new_pll->pl =3D list;
-		new_pll->pl_size =3D 1;
-		return new_pll;
+	if (n =3D=3D 1) {
+		while (list) {
+			new_pll =3D xmalloc(sizeof(pll));
+			new_pll->pl =3D NULL;
+			pack_list_insert(&new_pll->pl, list);
+			new_pll->next =3D ret;
+			ret =3D new_pll;
+			list =3D list->next;
+		}
+		return ret;
 	}
=20
-	pll =3D subset =3D get_all_permutations(list->next);
-	while (pll) {
-		if (pll->pl->pack =3D=3D list->pack) {
-			pll =3D pll->next;
-			continue;
+	while (list->next) {
+		subset =3D get_permutations(list->next, n - 1);
+		while (subset) {
+			new_pll =3D xmalloc(sizeof(pll));
+			new_pll->pl =3D subset->pl;
+			pack_list_insert(&new_pll->pl, list);
+			new_pll->next =3D ret;
+			ret =3D new_pll;
+			subset =3D subset->next;
 		}
-		new_pll =3D xmalloc(sizeof(struct pll));
-
-		new_pll->pl =3D xmalloc(sizeof(struct pack_list));
-		memcpy(new_pll->pl, list, sizeof(struct pack_list));
-		new_pll->pl->next =3D pll->pl;
-		new_pll->pl_size =3D pll->pl_size + 1;
-	=09
-		pll_insert(&new_pll, hint);
-
-		pll =3D pll->next;
-	}
-	/* add ourself */
-	new_pll =3D xmalloc(sizeof(struct pll));
-	new_pll->pl =3D xmalloc(sizeof(struct pack_list));
-	memcpy(new_pll->pl, list, sizeof(struct pack_list));
-	new_pll->pl->next =3D NULL;
-	new_pll->pl_size =3D 1;
-	pll_insert(&new_pll, hint);
-
-	return hint[0];
+		list =3D list->next;
+	}
+	return ret;
 }
=20
 static int is_superset(struct pack_list *pl, struct llist *list)
@@ -428,6 +414,7 @@ static void minimize(struct pack_list **
 	struct pll *perm, *perm_all, *perm_ok =3D NULL, *new_perm;
 	struct llist *missing;
 	size_t min_perm_size =3D (size_t)-1, perm_size;
+	int n;
=20
 	pl =3D local_packs;
 	while (pl) {
@@ -441,8 +428,7 @@ static void minimize(struct pack_list **
 	missing =3D llist_copy(all_objects);
 	pl =3D unique;
 	while (pl) {
-		llist_sorted_difference_inplace(missing,
-						pl->all_objects);
+		llist_sorted_difference_inplace(missing, pl->all_objects);
 		pl =3D pl->next;
 	}
=20
@@ -453,19 +439,21 @@ static void minimize(struct pack_list **
 	}
=20
 	/* find the permutations which contain all missing objects */
-	perm_all =3D perm =3D get_all_permutations(non_unique);
-	while (perm) {
-		if (perm_ok && perm->pl_size > perm_ok->pl_size)
-			break; /* ignore all larger permutations */
-		if (is_superset(perm->pl, missing)) {
-			new_perm =3D xmalloc(sizeof(struct pll));
-			memcpy(new_perm, perm, sizeof(struct pll));
-			new_perm->next =3D perm_ok;
-			perm_ok =3D new_perm;
+	for (n =3D 1; n <=3D pack_list_size(non_unique) && !perm_ok; n++) {
+		perm_all =3D perm =3D get_permutations(non_unique, n);
+		while (perm) {
+			if (is_superset(perm->pl, missing)) {
+				new_perm =3D xmalloc(sizeof(struct pll));
+				memcpy(new_perm, perm, sizeof(struct pll));
+				new_perm->next =3D perm_ok;
+				perm_ok =3D new_perm;
+			}
+			perm =3D perm->next;
 		}
-		perm =3D perm->next;
+		if (perm_ok)
+			break;
+		pll_free(perm_all);
 	}
-=09
 	if (perm_ok =3D=3D NULL)
 		die("Internal error: No complete sets found!\n");
=20
@@ -537,6 +525,7 @@ static void scan_alt_odb_packs(void)
 							alt->all_objects);
 			local =3D local->next;
 		}
+		llist_sorted_difference_inplace(all_objects, alt->all_objects);
 		alt =3D alt->next;
 	}
 }
--=20
0.99.9.GIT
