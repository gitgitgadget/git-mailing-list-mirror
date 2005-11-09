From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: [PATCH 1/4] Add git-pack-intersect
Date: Wed, 09 Nov 2005 02:22:40 +0100
Organization: Chalmers
Message-ID: <43714F60.6030508@etek.chalmers.se>
References: <43714EFB.5070705@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 09 02:22:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZefO-0007mA-Ua
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 02:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbVKIBWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 Nov 2005 20:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbVKIBWU
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 20:22:20 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:53687 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030360AbVKIBWT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 20:22:19 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 4368D4B9001B0D29; Wed, 9 Nov 2005 02:22:18 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <43714EFB.5070705@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11378>

Add git-pack-intersect

This patch adds the program git-pack-intersect. It is
used to find redundant packs in git repositories.

Signed-off-by: Lukas Sandstr=F6m <lukass@etek.chalmers.se>

---

 Makefile         |    2=20
 pack-intersect.c |  577 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 sha1_file.c      |    3=20
 3 files changed, 581 insertions(+), 1 deletions(-)
 create mode 100644 pack-intersect.c

applies-to: bb7dd65e1d945edbe0137a761ebc388c7394067a
cb2f9b435d8101fd29454b77fb5047b7edf847dc
diff --git a/Makefile b/Makefile
index b202be1..4c646c9 100644
--- a/Makefile
+++ b/Makefile
@@ -122,7 +122,7 @@ PROGRAMS =3D \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
-	git-name-rev$X $(SIMPLE_PROGRAMS)
+	git-name-rev$X git-pack-intersect$X $(SIMPLE_PROGRAMS)
=20
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS +=3D git-ssh-pull$X git-ssh-push$X
diff --git a/pack-intersect.c b/pack-intersect.c
new file mode 100644
index 0000000..2267478
--- /dev/null
+++ b/pack-intersect.c
@@ -0,0 +1,577 @@
+/*
+*
+* Copyright 2005, Lukas Sandstrom <lukass@etek.chalmers.se>
+*
+* This file is licensed under the GPL v2.
+*
+*/
+
+#include "cache.h"
+
+static const char pack_intersect_usage[] =3D
+"git-pack-intersect [ -v ]  < -a | <.pack filename> ...>";
+
+int all =3D 0, verbose =3D 0;
+
+struct llist_item {
+	struct llist_item *next;
+	char *sha1;
+};
+struct llist {
+	struct llist_item *front;
+	struct llist_item *back;
+	size_t size;
+} *all_objects;
+
+struct pack_list {
+	struct pack_list *next;
+	struct packed_git *pack;
+	struct llist *unique_objects;
+	struct llist *all_objects;
+} *pack_list;
+
+struct pll {
+	struct pll *next;
+	struct pack_list *pl;
+};
+
+inline void llist_free(struct llist *list)
+{
+	while((list->back =3D list->front)) {
+		list->front =3D list->front->next;
+		free(list->back);
+	}
+	free(list);
+}
+
+inline void llist_init(struct llist **list)
+{
+	*list =3D xmalloc(sizeof(struct llist));
+	(*list)->front =3D (*list)->back =3D NULL;
+	(*list)->size =3D 0;
+}
+
+struct llist * llist_copy(struct llist *list)
+{
+	struct llist *ret;
+	struct llist_item *new, *old, *prev;
+=09
+	llist_init(&ret);
+
+	if ((ret->size =3D list->size) =3D=3D 0)
+		return ret;
+
+	new =3D ret->front =3D xmalloc(sizeof(struct llist_item));
+	new->sha1 =3D list->front->sha1;
+
+	old =3D list->front->next;
+	while (old) {
+		prev =3D new;
+		new =3D xmalloc(sizeof(struct llist_item));
+		prev->next =3D new;
+		new->sha1 =3D old->sha1;
+		old =3D old->next;
+	}
+	new->next =3D NULL;
+	ret->back =3D new;
+=09
+	return ret;
+}
+
+inline struct llist_item * llist_insert(struct llist *list,
+					struct llist_item *after, char *sha1)
+{
+	struct llist_item *new =3D xmalloc(sizeof(struct llist_item));
+	new->sha1 =3D sha1;
+	new->next =3D NULL;
+
+	if (after !=3D NULL) {
+		new->next =3D after->next;
+		after->next =3D new;
+		if (after =3D=3D list->back)
+			list->back =3D new;
+	} else {/* insert in front */
+		if (list->size =3D=3D 0)
+			list->back =3D new;
+		else
+			new->next =3D list->front;
+		list->front =3D new;
+	}
+	list->size++;
+	return new;
+}
+
+inline struct llist_item * llist_insert_back(struct llist *list, char =
*sha1)
+{
+	return llist_insert(list, list->back, sha1);
+}
+
+inline struct llist_item * llist_insert_sorted_unique(struct llist *li=
st,
+					char *sha1, struct llist_item *hint)
+{
+	struct llist_item *prev =3D NULL, *l;
+
+	l =3D (hint =3D=3D NULL) ? list->front : hint;
+	while (l) {
+		int cmp =3D memcmp(l->sha1, sha1, 20);
+		if (cmp > 0) { /* we insert before this entry */
+			return llist_insert(list, prev, sha1);
+		}
+		if(!cmp) { /* already exists */
+			return l;
+		}
+		prev =3D l;
+		l =3D l->next;
+	}
+	/* insert at the end */
+	return llist_insert_back(list, sha1);
+}
+
+/* computes A\B */
+struct llist * llist_sorted_difference(struct llist_item *A,
+				       struct llist_item *B)
+{
+	struct llist *ret;
+	llist_init(&ret);
+
+	while (A !=3D NULL && B !=3D NULL) {
+		int cmp =3D memcmp(A->sha1, B->sha1, 20);
+		if (!cmp) {
+			A =3D A->next;
+			B =3D B->next;
+			continue;
+		}
+		if(cmp > 0) { /* we'll never find this B */
+			B =3D B->next;
+			continue;
+		}
+		/* A has the object, B doesn't */
+		llist_insert_back(ret, A->sha1);
+		A =3D A->next;
+	}
+	while (A !=3D NULL) {
+		llist_insert_back(ret, A->sha1);
+		A =3D A->next;
+	}
+	return ret;
+}
+
+/* returns a pointer to an item in front of sha1 */
+inline struct llist_item * llist_sorted_remove(struct llist *list, cha=
r *sha1,
+					       struct llist_item *hint)
+{
+	struct llist_item *prev, *l;
+
+redo_from_start:
+	l =3D (hint =3D=3D NULL) ? list->front : hint;
+	prev =3D NULL;
+	while (l) {
+		int cmp =3D memcmp(l->sha1, sha1, 20);
+		if (cmp > 0) /* not in list, since sorted */
+			return prev;
+		if(!cmp) { /* found */
+			if (prev =3D=3D NULL) {
+				if (hint !=3D NULL && hint !=3D list->front) {
+					/* we don't know the previous element */
+					hint =3D NULL;
+					goto redo_from_start;
+				}
+				list->front =3D l->next;
+			} else
+				prev->next =3D l->next;
+			if (l =3D=3D list->back)
+				list->back =3D prev;
+			free(l);
+			list->size--;
+			return prev;
+		}
+		prev =3D l;
+		l =3D l->next;
+	}
+	return prev;
+}
+
+inline struct pack_list * pack_list_insert(struct pack_list **pl,
+					   struct pack_list *entry)
+{
+	struct pack_list *p =3D xmalloc(sizeof(struct pack_list));
+	memcpy(p, entry, sizeof(struct pack_list));
+	p->next =3D *pl;
+	*pl =3D p;
+	return p;
+}
+
+struct pack_list * pack_list_difference(struct pack_list *A,
+					struct pack_list *B)
+{
+	struct pack_list *ret, *pl;
+
+	if (A =3D=3D NULL)
+		return NULL;
+
+	pl =3D B;
+	while (pl !=3D NULL) {
+		if (A->pack =3D=3D pl->pack)
+			return pack_list_difference(A->next, B);
+		pl =3D pl->next;
+	}
+	ret =3D xmalloc(sizeof(struct pack_list));
+	memcpy(ret, A, sizeof(struct pack_list));
+	ret->next =3D pack_list_difference(A->next, B);
+	return ret;
+}
+
+void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
+{
+	int p1_off, p2_off;
+	void *p1_base, *p2_base;
+	struct llist_item *p1_hint =3D NULL, *p2_hint =3D NULL;
+=09
+	p1_off =3D p2_off =3D 256 * 4 + 4;
+	p1_base =3D (void *)p1->pack->index_base;
+	p2_base =3D (void *)p2->pack->index_base;
+
+	while (p1_off <=3D p1->pack->index_size - 3 * 20 &&
+	       p2_off <=3D p2->pack->index_size - 3 * 20)
+	{
+		int cmp =3D memcmp(p1_base + p1_off, p2_base + p2_off, 20);
+		/* cmp ~ p1 - p2 */
+		if (cmp =3D=3D 0) {
+			p1_hint =3D llist_sorted_remove(p1->unique_objects,
+					p1_base + p1_off, p1_hint);
+			p2_hint =3D llist_sorted_remove(p2->unique_objects,
+					p1_base + p1_off, p2_hint);
+			p1_off+=3D24;
+			p2_off+=3D24;
+			continue;
+		}
+		if (cmp < 0) { /* p1 has the object, p2 doesn't */
+			p1_off+=3D24;
+		} else { /* p2 has the object, p1 doesn't */
+			p2_off+=3D24;
+		}
+	}
+}
+
+/* all the permutations have to be free()d at the same time,
+ * since they refer to each other
+ */
+struct pll * get_all_permutations(struct pack_list *list)
+{
+	struct pll *subset, *pll, *new_pll =3D NULL; /*silence warning*/
+
+	if (list =3D=3D NULL)
+		return NULL;
+
+	if (list->next =3D=3D NULL) {
+		new_pll =3D xmalloc(sizeof(struct pll));
+		new_pll->next =3D NULL;
+		new_pll->pl =3D list;
+		return new_pll;
+	}
+
+	pll =3D subset =3D get_all_permutations(list->next);
+	while (pll) {
+		new_pll =3D xmalloc(sizeof(struct pll));
+		new_pll->next =3D pll->next;
+		pll->next =3D new_pll;
+
+		new_pll->pl =3D xmalloc(sizeof(struct pack_list));
+		memcpy(new_pll->pl, list, sizeof(struct pack_list));
+		new_pll->pl->next =3D pll->pl;
+
+		pll =3D new_pll->next;
+	}
+	/* add ourself to the end */
+	new_pll->next =3D xmalloc(sizeof(struct pll));
+	new_pll->next->pl =3D xmalloc(sizeof(struct pack_list));
+	new_pll->next->next =3D NULL;
+	memcpy(new_pll->next->pl, list, sizeof(struct pack_list));
+	new_pll->next->pl->next =3D NULL;
+
+	return subset;
+}
+
+int is_superset(struct pack_list *pl, struct llist *list)
+{
+	struct llist *diff, *old;
+
+	diff =3D llist_copy(list);
+
+	while (pl) {
+		old =3D diff;
+		diff =3D llist_sorted_difference(diff->front,
+					       pl->all_objects->front);
+		llist_free(old);
+		if (diff->size =3D=3D 0) { /* we're done */
+			llist_free(diff);
+			return 1;
+		}
+		pl =3D pl->next;
+	}
+	llist_free(diff);
+	return 0;
+}
+
+size_t sizeof_union(struct packed_git *p1, struct packed_git *p2)
+{
+	size_t ret =3D 0;
+	int p1_off, p2_off;
+	void *p1_base, *p2_base;
+
+	p1_off =3D p2_off =3D 256 * 4 + 4;
+	p1_base =3D (void *)p1->index_base;
+	p2_base =3D (void *)p2->index_base;
+
+	while (p1_off <=3D p1->index_size - 3 * 20 &&
+	       p2_off <=3D p2->index_size - 3 * 20)
+	{
+		int cmp =3D memcmp(p1_base + p1_off, p2_base + p2_off, 20);
+		/* cmp ~ p1 - p2 */
+		if (cmp =3D=3D 0) {
+			ret++;
+			p1_off+=3D24;
+			p2_off+=3D24;
+			continue;
+		}
+		if (cmp < 0) { /* p1 has the object, p2 doesn't */
+			p1_off+=3D24;
+		} else { /* p2 has the object, p1 doesn't */
+			p2_off+=3D24;
+		}
+	}
+	return ret;
+}
+
+/* another O(n^2) function ... */
+size_t get_pack_redundancy(struct pack_list *pl)
+{
+	struct pack_list *subset;
+	size_t ret =3D 0;
+	while ((subset =3D pl->next)) {
+		while(subset) {
+			ret +=3D sizeof_union(pl->pack, subset->pack);
+			subset =3D subset->next;
+		}
+		pl =3D pl->next;
+	}
+	return ret;
+}
+
+inline size_t pack_set_bytecount(struct pack_list *pl)
+{
+	size_t ret =3D 0;
+	while (pl) {
+		ret +=3D pl->pack->pack_size;
+		ret +=3D pl->pack->index_size;
+		pl =3D pl->next;
+	}
+	return ret;
+}
+
+void minimize(struct pack_list **min)
+{
+	struct pack_list *pl, *unique =3D NULL,
+		*non_unique =3D NULL, *min_perm =3D NULL;
+	struct pll *perm, *perm_all, *perm_ok =3D NULL, *new_perm;
+	struct llist *missing, *old;
+	size_t min_perm_size =3D (size_t)-1, perm_size;
+
+	pl =3D pack_list;
+	while (pl) {
+		if(pl->unique_objects->size)
+			pack_list_insert(&unique, pl);
+		else
+			pack_list_insert(&non_unique, pl);
+		pl =3D pl->next;
+	}
+	/* find out which objects are missing from the set of unique packs */
+	missing =3D llist_copy(all_objects);
+	pl =3D unique;
+	while (pl) {
+		old =3D missing;
+		missing =3D llist_sorted_difference(missing->front,
+						  pl->all_objects->front);
+		llist_free(old);
+		pl =3D pl->next;
+	}
+
+	if (missing->size =3D=3D 0) {
+		*min =3D unique;
+		return;
+	}
+
+	/* find the permutations which contain all missing objects */
+	perm_all =3D perm =3D get_all_permutations(non_unique);
+	while (perm) {
+		if (is_superset(perm->pl, missing)) {
+			new_perm =3D xmalloc(sizeof(struct pll));
+			new_perm->pl =3D perm->pl;
+			new_perm->next =3D perm_ok;
+			perm_ok =3D new_perm;
+		}
+		perm =3D perm->next;
+	}
+=09
+	if (perm_ok =3D=3D NULL)
+		die("Internal error: No complete sets found!\n");
+
+	/* find the permutation with the smallest size */
+	perm =3D perm_ok;
+	while (perm) {
+		perm_size =3D pack_set_bytecount(perm->pl);
+		if (min_perm_size > perm_size) {
+			min_perm_size =3D perm_size;
+			min_perm =3D perm->pl;
+		}
+		perm =3D perm->next;
+	}
+	*min =3D min_perm;
+	/* add the unique packs to the list */
+	pl =3D unique;
+	while(pl) {
+		pack_list_insert(min, pl);
+		pl =3D pl->next;
+	}
+}
+
+void load_all_objects()
+{
+	struct pack_list *pl =3D pack_list;
+	struct llist_item *hint, *l;
+	int i;
+
+	llist_init(&all_objects);
+
+	while (pl) {
+		i =3D 0;
+		hint =3D NULL;
+		l =3D pl->all_objects->front;
+		while (l) {
+			hint =3D llist_insert_sorted_unique(all_objects,
+							  l->sha1, hint);
+			l =3D l->next;
+		}
+		pl =3D pl->next;
+	}
+}
+
+/* this scales like O(n^2) */
+void cmp_packs()
+{
+	struct pack_list *subset, *curr =3D pack_list;
+
+	while ((subset =3D curr)) {
+		while((subset =3D subset->next))
+			cmp_two_packs(curr, subset);
+		curr =3D curr->next;
+	}
+}
+
+struct pack_list * add_pack(struct packed_git *p)
+{
+	struct pack_list l;
+	size_t off;
+	void *base;
+
+	l.pack =3D p;
+	llist_init(&l.all_objects);
+
+	off =3D 256 * 4 + 4;
+	base =3D (void *)p->index_base;
+	while (off <=3D p->index_size - 3 * 20) {
+		llist_insert_back(l.all_objects, base + off);
+		off+=3D24;
+	}
+	/* this list will be pruned in cmp_two_packs later */
+	l.unique_objects =3D llist_copy(l.all_objects);
+	return pack_list_insert(&pack_list, &l);
+}
+
+struct pack_list * add_pack_file(char *filename)
+{
+	struct packed_git *p =3D packed_git;
+
+	if (strlen(filename) < 40)
+		die("Bad pack filename: %s\n", filename);
+
+	while (p) {
+		if (strstr(p->pack_name, filename))
+			/* this will silently ignore packs in alt-odb */
+			return add_pack(p);
+		p =3D p->next;
+	}
+	die("Filename %s not found in packed_git\n", filename);
+}
+
+void load_all()
+{
+	struct packed_git *p =3D packed_git;
+
+	while (p) {
+		if (p->pack_local) /* ignore alt-odb for now */
+			add_pack(p);
+		p =3D p->next;
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int i;
+	struct pack_list *min, *red, *pl;
+
+	for (i =3D 1; i < argc; i++) {
+		const char *arg =3D argv[i];
+		if(!strcmp(arg, "--"))
+			break;
+		if(!strcmp(arg, "-a")) {
+			all =3D 1;
+			continue;
+		}
+		if(!strcmp(arg, "-v")) {
+			verbose =3D 1;
+			continue;
+		}
+		if(*arg =3D=3D '-')
+			usage(pack_intersect_usage);
+		else
+			break;
+	}
+
+	prepare_packed_git();
+
+	if(all)
+		load_all();
+	else
+		while (*(argv + i) !=3D NULL)
+			add_pack_file(*(argv + i++));
+
+	if (pack_list =3D=3D NULL)
+		die("Zero packs found!\n");
+
+	cmp_packs();
+
+	load_all_objects();
+
+	minimize(&min);
+	if (verbose) {
+		fprintf(stderr, "The smallest (bytewise) set of packs is:\n");
+		pl =3D min;
+		while (pl) {
+			fprintf(stderr, "\t%s\n", pl->pack->pack_name);
+			pl =3D pl->next;
+		}
+		fprintf(stderr, "containing %ld duplicate objects "
+				"with a total size of %ldkb.\n",
+			get_pack_redundancy(min), pack_set_bytecount(min)/1024);
+		fprintf(stderr, "Redundant packs (with indexes):\n");
+	}
+	pl =3D red =3D pack_list_difference(pack_list, min);
+	while (pl) {
+		printf("%s\n%s\n",
+		       sha1_pack_index_name(pl->pack->sha1), pl->pack->pack_name);
+		pl =3D pl->next;
+	}
+
+	return 0;
+}
diff --git a/sha1_file.c b/sha1_file.c
index 946a353..cd814d7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -424,6 +424,7 @@ struct packed_git *add_packed_git(char *
 	struct packed_git *p;
 	unsigned long idx_size;
 	void *idx_map;
+	char sha1[20];
=20
 	if (check_packed_git_idx(path, &idx_size, &idx_map))
 		return NULL;
@@ -447,6 +448,8 @@ struct packed_git *add_packed_git(char *
 	p->pack_last_used =3D 0;
 	p->pack_use_cnt =3D 0;
 	p->pack_local =3D local;
+	if (!get_sha1_hex(path + path_len - 40 - 4, sha1))
+		memcpy(p->sha1, sha1, 20);
 	return p;
 }
=20
---
0.99.9.GIT
