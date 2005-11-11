From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: [PATCH] Make git-pack-redundant consider alt-odbs
Date: Fri, 11 Nov 2005 01:25:04 +0100
Organization: Chalmers
Message-ID: <4373E4E0.10903@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net,
	=?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Fri Nov 11 01:25:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaMil-0000WV-Ko
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 01:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVKKAYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 Nov 2005 19:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVKKAYp
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 19:24:45 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:5318 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932288AbVKKAYo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 19:24:44 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.060.1)
        id 436FB1AD00114BB1; Fri, 11 Nov 2005 01:24:40 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11544>

[PATCH] Make git-pack-redundant consider alt-odbs

This patch changes git-pack-redundant so that packfiles
in alternate object directories also are considered when
deciding which objects are redundant.

This functionality is controlled by the flag '--alt-odb'.

Also convert the other flags to the long form, and update
docs and git-repack accordingly.

Signed-off-by: Lukas Sandstr=F6m <lukass@etek.chalmers.se>

---

On a related note; if you have unreachable objects in your
packfiles, those objects might make otherwise redundant
packfiles non-redundant.=20

Would it be a useful feature to be able to give git-pack-redundant
a list of bad objects on stdin, which then will be ignored?

(eg. git-fsck-objects --full --unreachable | cut -s -d ' ' -f 3 | git-p=
ack-redundant)

 Documentation/git-pack-redundant.txt |   19 +++-
 git-repack.sh                        |    4 -
 pack-redundant.c                     |  147 ++++++++++++++++++++++----=
--------
 3 files changed, 107 insertions(+), 63 deletions(-)

applies-to: 8f520c14677a07c01eb64f64bcd68cb174392ec9
ad7d016fcecacdfaf9cf0cc4b65fadf32e86899b
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-p=
ack-redundant.txt
index 3829616..2e23cbc 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -8,7 +8,7 @@ git-pack-redundant - Program used to fin
=20
 SYNOPSIS
 --------
-'git-pack-redundant [ -v ] < -a | .pack filename ... >'
+'git-pack-redundant [ --verbose ] [ --alt-odb ] < --all | .pack filena=
me ... >'
=20
 DESCRIPTION
 -----------
@@ -19,13 +19,16 @@ are redundant. The output is suitable fo
 OPTIONS
 -------
=20
--v::
-	Verbose. Outputs some statistics to stderr.
-	Has a small performance penalty.
-
--a::
-	All. Processes all the local packs. Any filenames on
-	the commandline are ignored.
+
+--all::
+	Processes all packs. Any filenames on the commandline are ignored.
+
+--alt-odb::
+	Don't require objects present in packs from alternate object
+	directories to be present in local packs.
+
+--verbose::
+	Outputs some statistics to stderr. Has a small performance penalty.
=20
 Author
 ------
diff --git a/git-repack.sh b/git-repack.sh
index 4ce0022..f347207 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -45,7 +45,7 @@ if [ -z "$name" ]; then
 	if test "$remove_redandant" =3D t ; then
 		echo "Removing redundant packs."
 		sync
-		redundant=3D$(git-pack-redundant -a)
+		redundant=3D$(git-pack-redundant --all)
 		if test "$redundant" !=3D "" ; then
 			echo $redundant | xargs rm
 		fi
@@ -63,7 +63,7 @@ exit
 if test "$remove_redandant" =3D t
 then
 	sync
-	redundant=3D$(git-pack-redundant -a)
+	redundant=3D$(git-pack-redundant --all)
 	if test "$redundant" !=3D "" ; then
 		echo $redundant | xargs rm
 	fi
diff --git a/pack-redundant.c b/pack-redundant.c
index db3dcde..1f8c577 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -9,9 +9,9 @@
 #include "cache.h"
=20
 static const char pack_redundant_usage[] =3D
-"git-pack-redundant [ -v ]  < -a | <.pack filename> ...>";
+"git-pack-redundant [ --verbose ] [ --alt-odb ] < --all | <.pack filen=
ame> ...>";
=20
-int all =3D 0, verbose =3D 0;
+int load_all_packs =3D 0, verbose =3D 0, alt_odb =3D 0;
=20
 struct llist_item {
 	struct llist_item *next;
@@ -21,14 +21,14 @@ struct llist {
 	struct llist_item *front;
 	struct llist_item *back;
 	size_t size;
-} *all_objects;
+} *all_objects; /* all objects which must be present in local packfile=
s */
=20
 struct pack_list {
 	struct pack_list *next;
 	struct packed_git *pack;
 	struct llist *unique_objects;
 	struct llist *all_objects;
-} *pack_list;
+} *local_packs =3D NULL, *altodb_packs =3D NULL;
=20
 struct pll {
 	struct pll *next;
@@ -128,32 +128,35 @@ inline struct llist_item * llist_insert_
 }
=20
 /* computes A\B */
-struct llist * llist_sorted_difference(struct llist_item *A,
-				       struct llist_item *B)
+void llist_sorted_difference_inplace(struct llist *A,
+				     struct llist *B)
 {
-	struct llist *ret;
-	llist_init(&ret);
+	struct llist_item *prev, *a, *b, *x;
=20
-	while (A !=3D NULL && B !=3D NULL) {
-		int cmp =3D memcmp(A->sha1, B->sha1, 20);
+	prev =3D a =3D A->front;
+	b =3D B->front;
+
+	while (a !=3D NULL && b !=3D NULL) {
+		int cmp =3D memcmp(a->sha1, b->sha1, 20);
 		if (!cmp) {
-			A =3D A->next;
-			B =3D B->next;
-			continue;
-		}
-		if(cmp > 0) { /* we'll never find this B */
-			B =3D B->next;
-			continue;
-		}
-		/* A has the object, B doesn't */
-		llist_insert_back(ret, A->sha1);
-		A =3D A->next;
-	}
-	while (A !=3D NULL) {
-		llist_insert_back(ret, A->sha1);
-		A =3D A->next;
+			x =3D a;
+			if (a =3D=3D A->front)
+				A->front =3D a->next;
+			a =3D prev->next =3D a->next;
+
+			if (a =3D=3D NULL) /* end of list */
+				A->back =3D prev;
+			A->size--;
+			free(x);
+			b =3D b->next;
+		} else
+			if (cmp > 0)
+				b =3D b->next;
+			else {
+				prev =3D a;
+				a =3D a->next;
+			}
 	}
-	return ret;
 }
=20
 /* returns a pointer to an item in front of sha1 */
@@ -201,6 +204,16 @@ inline struct pack_list * pack_list_inse
 	return p;
 }
=20
+inline size_t pack_list_size(struct pack_list *pl)
+{
+	size_t ret =3D 0;
+	while(pl) {
+		ret++;
+		pl =3D pl->next;
+	}
+	return ret;
+}
+
 struct pack_list * pack_list_difference(struct pack_list *A,
 					struct pack_list *B)
 {
@@ -294,15 +307,13 @@ struct pll * get_all_permutations(struct
=20
 int is_superset(struct pack_list *pl, struct llist *list)
 {
-	struct llist *diff, *old;
+	struct llist *diff;
=20
 	diff =3D llist_copy(list);
=20
 	while (pl) {
-		old =3D diff;
-		diff =3D llist_sorted_difference(diff->front,
-					       pl->all_objects->front);
-		llist_free(old);
+		llist_sorted_difference_inplace(diff,
+						pl->all_objects);
 		if (diff->size =3D=3D 0) { /* we're done */
 			llist_free(diff);
 			return 1;
@@ -347,6 +358,10 @@ size_t sizeof_union(struct packed_git *p
 size_t get_pack_redundancy(struct pack_list *pl)
 {
 	struct pack_list *subset;
+
+	if (pl =3D=3D NULL)
+		return 0;
+
 	size_t ret =3D 0;
 	while ((subset =3D pl->next)) {
 		while(subset) {
@@ -374,10 +389,10 @@ void minimize(struct pack_list **min)
 	struct pack_list *pl, *unique =3D NULL,
 		*non_unique =3D NULL, *min_perm =3D NULL;
 	struct pll *perm, *perm_all, *perm_ok =3D NULL, *new_perm;
-	struct llist *missing, *old;
+	struct llist *missing;
 	size_t min_perm_size =3D (size_t)-1, perm_size;
=20
-	pl =3D pack_list;
+	pl =3D local_packs;
 	while (pl) {
 		if(pl->unique_objects->size)
 			pack_list_insert(&unique, pl);
@@ -389,13 +404,12 @@ void minimize(struct pack_list **min)
 	missing =3D llist_copy(all_objects);
 	pl =3D unique;
 	while (pl) {
-		old =3D missing;
-		missing =3D llist_sorted_difference(missing->front,
-						  pl->all_objects->front);
-		llist_free(old);
+		llist_sorted_difference_inplace(missing,
+						pl->all_objects);
 		pl =3D pl->next;
 	}
=20
+	/* return if there are no objects missing from the unique set */
 	if (missing->size =3D=3D 0) {
 		*min =3D unique;
 		return;
@@ -437,7 +451,7 @@ void minimize(struct pack_list **min)
=20
 void load_all_objects()
 {
-	struct pack_list *pl =3D pack_list;
+	struct pack_list *pl =3D local_packs;
 	struct llist_item *hint, *l;
 	int i;
=20
@@ -454,17 +468,34 @@ void load_all_objects()
 		}
 		pl =3D pl->next;
 	}
+	/* remove objects present in remote packs */
+	pl =3D altodb_packs;
+	while (pl) {
+		llist_sorted_difference_inplace(all_objects, pl->all_objects);
+		pl =3D pl->next;
+	}
 }
=20
 /* this scales like O(n^2) */
 void cmp_packs()
 {
-	struct pack_list *subset, *curr =3D pack_list;
+	struct pack_list *subset, *pl =3D local_packs;
=20
-	while ((subset =3D curr)) {
+	while ((subset =3D pl)) {
 		while((subset =3D subset->next))
-			cmp_two_packs(curr, subset);
-		curr =3D curr->next;
+			cmp_two_packs(pl, subset);
+		pl =3D pl->next;
+	}
+
+	pl =3D altodb_packs;
+	while (pl) {
+		subset =3D local_packs;
+		while (subset) {
+			llist_sorted_difference_inplace(subset->unique_objects,
+							pl->all_objects);
+			subset =3D subset->next;
+		}
+		pl =3D pl->next;
 	}
 }
=20
@@ -485,7 +516,10 @@ struct pack_list * add_pack(struct packe
 	}
 	/* this list will be pruned in cmp_two_packs later */
 	l.unique_objects =3D llist_copy(l.all_objects);
-	return pack_list_insert(&pack_list, &l);
+	if (p->pack_local)
+		return pack_list_insert(&local_packs, &l);
+	else
+		return alt_odb ? pack_list_insert(&altodb_packs, &l) : NULL;
 }
=20
 struct pack_list * add_pack_file(char *filename)
@@ -497,7 +531,6 @@ struct pack_list * add_pack_file(char *f
=20
 	while (p) {
 		if (strstr(p->pack_name, filename))
-			/* this will silently ignore packs in alt-odb */
 			return add_pack(p);
 		p =3D p->next;
 	}
@@ -509,8 +542,7 @@ void load_all()
 	struct packed_git *p =3D packed_git;
=20
 	while (p) {
-		if (p->pack_local) /* ignore alt-odb for now */
-			add_pack(p);
+		add_pack(p);
 		p =3D p->next;
 	}
 }
@@ -526,14 +558,18 @@ int main(int argc, char **argv)
 			i++;
 			break;
 		}
-		if(!strcmp(arg, "-a")) {
-			all =3D 1;
+		if(!strcmp(arg, "--all")) {
+			load_all_packs =3D 1;
 			continue;
 		}
-		if(!strcmp(arg, "-v")) {
+		if(!strcmp(arg, "--verbose")) {
 			verbose =3D 1;
 			continue;
 		}
+		if(!strcmp(arg, "--alt-odb")) {
+			alt_odb =3D 1;
+			continue;
+		}
 		if(*arg =3D=3D '-')
 			usage(pack_redundant_usage);
 		else
@@ -542,13 +578,13 @@ int main(int argc, char **argv)
=20
 	prepare_packed_git();
=20
-	if(all)
+	if (load_all_packs)
 		load_all();
 	else
 		while (*(argv + i) !=3D NULL)
 			add_pack_file(*(argv + i++));
=20
-	if (pack_list =3D=3D NULL)
+	if (local_packs =3D=3D NULL)
 		die("Zero packs found!\n");
=20
 	cmp_packs();
@@ -557,6 +593,8 @@ int main(int argc, char **argv)
=20
 	minimize(&min);
 	if (verbose) {
+		fprintf(stderr, "There are %ld packs available in alt-odbs.\n",
+			pack_list_size(altodb_packs));
 		fprintf(stderr, "The smallest (bytewise) set of packs is:\n");
 		pl =3D min;
 		while (pl) {
@@ -566,12 +604,15 @@ int main(int argc, char **argv)
 		fprintf(stderr, "containing %ld duplicate objects "
 				"with a total size of %ldkb.\n",
 			get_pack_redundancy(min), pack_set_bytecount(min)/1024);
+		fprintf(stderr, "A total of %ld unique objects were considered.\n",
+			all_objects->size);
 		fprintf(stderr, "Redundant packs (with indexes):\n");
 	}
-	pl =3D red =3D pack_list_difference(pack_list, min);
+	pl =3D red =3D pack_list_difference(local_packs, min);
 	while (pl) {
 		printf("%s\n%s\n",
-		       sha1_pack_index_name(pl->pack->sha1), pl->pack->pack_name);
+		       sha1_pack_index_name(pl->pack->sha1),
+		       pl->pack->pack_name);
 		pl =3D pl->next;
 	}
=20
---
0.99.9.GIT
