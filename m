From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Make git-pack-redundant non-horribly slow on large sets of
 packs
Date: Thu, 17 Nov 2005 14:11:56 +0100
Message-ID: <437C819C.4040507@etek.chalmers.se>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se> <20051115223340.GA3951@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, junkio@cox.net,
	=?UTF-8?B?THVrYXMg?= =?UTF-8?B?U2FuZHN0csO2bQ==?= 
	<lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Thu Nov 17 14:14:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcjY5-0006KD-Hh
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 14:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVKQNLa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 17 Nov 2005 08:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVKQNLa
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 08:11:30 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:43146 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750796AbVKQNL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 08:11:29 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 4378EBDA000FB6D6; Thu, 17 Nov 2005 14:11:26 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051115223340.GA3951@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12109>

Change the smallest-set detection algortithm so that when
we have found a good set, we don't check any larger sets.

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>

---
This change might make git-pack-redundant return non-optimal
pack-sets in some cases. OTOH, the case which Alex reported
completes in 0.6 sec instead of several minutes.

 pack-redundant.c |   62 +++++++++++++++++++++++++++++++++++++++++++---=
--------
 1 files changed, 49 insertions(+), 13 deletions(-)

applies-to: 1e3fcf60526c196a46433e6947c9104ca236f230
498cc056d758b9e1cd21e984be281d55e24f1117
diff --git a/pack-redundant.c b/pack-redundant.c
index fcb36ff..51d7341 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -33,6 +33,7 @@ struct pack_list {
 struct pll {
 	struct pll *next;
 	struct pack_list *pl;
+	size_t pl_size;
 };
=20
 inline void llist_free(struct llist *list)
@@ -249,18 +250,45 @@ void cmp_two_packs(struct pack_list *p1,
 	}
 }
=20
+void pll_insert(struct pll **pll, struct pll **hint_table)
+{
+	struct pll *prev;
+	int i =3D (*pll)->pl_size - 1;
+
+	if (hint_table[i] =3D=3D NULL) {
+		hint_table[i--] =3D *pll;
+		for (; i >=3D 0; --i) {
+			if (hint_table[i] !=3D NULL)
+				break;
+		}
+		if (hint_table[i] =3D=3D NULL) /* no elements in list */
+			die("Why did this happen?");
+	}
+
+	prev =3D hint_table[i];
+	while (prev->next && prev->next->pl_size < (*pll)->pl_size)
+		prev =3D prev->next;
+
+	(*pll)->next =3D prev->next;
+	prev->next =3D *pll;
+}
+
 /* all the permutations have to be free()d at the same time,
  * since they refer to each other
  */
 struct pll * get_all_permutations(struct pack_list *list)
 {
 	struct pll *subset, *pll, *new_pll =3D NULL; /*silence warning*/
-
+	static struct pll **hint =3D NULL;
+	if (hint =3D=3D NULL)
+		hint =3D xcalloc(pack_list_size(list), sizeof(struct pll *));
+	=09
 	if (list =3D=3D NULL)
 		return NULL;
=20
 	if (list->next =3D=3D NULL) {
 		new_pll =3D xmalloc(sizeof(struct pll));
+		hint[0] =3D new_pll;
 		new_pll->next =3D NULL;
 		new_pll->pl =3D list;
 		return new_pll;
@@ -268,24 +296,30 @@ struct pll * get_all_permutations(struct
=20
 	pll =3D subset =3D get_all_permutations(list->next);
 	while (pll) {
+		if (pll->pl->pack =3D=3D list->pack) {
+			pll =3D pll->next;
+			continue;
+		}
 		new_pll =3D xmalloc(sizeof(struct pll));
-		new_pll->next =3D pll->next;
-		pll->next =3D new_pll;
=20
 		new_pll->pl =3D xmalloc(sizeof(struct pack_list));
 		memcpy(new_pll->pl, list, sizeof(struct pack_list));
 		new_pll->pl->next =3D pll->pl;
+		new_pll->pl_size =3D pll->pl_size + 1;
+	=09
+		pll_insert(&new_pll, hint);
+
+		pll =3D pll->next;
+	}
+	/* add ourself */
+	new_pll =3D xmalloc(sizeof(struct pll));
+	new_pll->pl =3D xmalloc(sizeof(struct pack_list));
+	memcpy(new_pll->pl, list, sizeof(struct pack_list));
+	new_pll->pl->next =3D NULL;
+	new_pll->pl_size =3D 1;
+	pll_insert(&new_pll, hint);
=20
-		pll =3D new_pll->next;
-	}
-	/* add ourself to the end */
-	new_pll->next =3D xmalloc(sizeof(struct pll));
-	new_pll->next->pl =3D xmalloc(sizeof(struct pack_list));
-	new_pll->next->next =3D NULL;
-	memcpy(new_pll->next->pl, list, sizeof(struct pack_list));
-	new_pll->next->pl->next =3D NULL;
-
-	return subset;
+	return hint[0];
 }
=20
 int is_superset(struct pack_list *pl, struct llist *list)
@@ -401,6 +435,8 @@ void minimize(struct pack_list **min)
 	/* find the permutations which contain all missing objects */
 	perm_all =3D perm =3D get_all_permutations(non_unique);
 	while (perm) {
+		if (perm_ok && perm->pl_size > perm_ok->pl_size)
+			break; /* ignore all larger permutations */
 		if (is_superset(perm->pl, missing)) {
 			new_perm =3D xmalloc(sizeof(struct pll));
 			new_perm->pl =3D perm->pl;
---
0.99.9.GIT
