From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Fix sparse warnings
Date: Mon, 21 Nov 2005 02:52:52 +0200
Message-ID: <20051121025252.6c2249c3.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Nov 21 01:53:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edzvf-0007LM-P7
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 01:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVKUAxD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 19:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVKUAxB
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 19:53:01 -0500
Received: from marski.suomi.net ([212.50.131.142]:38045 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S932153AbVKUAxA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 19:53:00 -0500
Received: from spartak.suomi.net (spartak.suomi.net [212.50.140.227])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IQA00ACZ546W6A0@marski.suomi.net> for git@vger.kernel.org;
 Mon, 21 Nov 2005 02:52:54 +0200 (EET)
Received: from spam1.suomi.net (spam1.suomi.net [212.50.131.165])
 by mailstore.suomi.net
 (Sun Java System Messaging Server 6.2-3.04 (built Jul 15 2005))
 with ESMTP id <0IQA00APV598KR50@mailstore.suomi.net>; Mon,
 21 Nov 2005 02:55:57 +0200 (EET)
Received: from garlic.home.net (addr-82-128-203-211.suomi.net [82.128.203.211])
	by spam1.suomi.net (Postfix) with SMTP id 77BB41ABB82; Mon,
 21 Nov 2005 02:52:50 +0200 (EET)
To: git@vger.kernel.org, junkio@cox.net
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.7; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.112,	required 5,
 autolearn=not spam, AWL 0.49, BAYES_00 -2.60)
X-OPOY-MailScanner-From: tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12415>


Make some functions static and convert func() function prototypes to to
func(void).  Fix declaration after statement, missing declaration and
redundant declaration warnings.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>

---

 cache.h          |    1 +
 name-rev.c       |    2 --
 pack-redundant.c |   58 +++++++++++++++++++++++++++---------------------------
 path.c           |    2 +-
 4 files changed, 31 insertions(+), 32 deletions(-)

applies-to: e12ceef6841365e64bb765294235a67e9263d7de
b29cab489ba0dbd6daf69b491978615a1a96f781
diff --git a/cache.h b/cache.h
index a7c1bbd..c7c6637 100644
--- a/cache.h
+++ b/cache.h
@@ -203,6 +203,7 @@ int git_mkstemp(char *path, size_t n, co
 
 int safe_create_leading_directories(char *path);
 char *safe_strncpy(char *, const char *, size_t);
+char *enter_repo(char *path, int strict);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size);
diff --git a/name-rev.c b/name-rev.c
index 59194f1..817e36b 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -230,8 +230,6 @@ int main(int argc, char **argv)
 				fwrite(p_start, p - p_start, 1, stdout);
 		}
 	} else if (all) {
-		extern struct object **objs;
-		extern int nr_objs;
 		int i;
 
 		for (i = 0; i < nr_objs; i++)
diff --git a/pack-redundant.c b/pack-redundant.c
index fb6cb48..1519385 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -11,19 +11,19 @@
 static const char pack_redundant_usage[] =
 "git-pack-redundant [ --verbose ] [ --alt-odb ] < --all | <.pack filename> ...>";
 
-int load_all_packs = 0, verbose = 0, alt_odb = 0;
+static int load_all_packs = 0, verbose = 0, alt_odb = 0;
 
 struct llist_item {
 	struct llist_item *next;
 	char *sha1;
 };
-struct llist {
+static struct llist {
 	struct llist_item *front;
 	struct llist_item *back;
 	size_t size;
 } *all_objects; /* all objects which must be present in local packfiles */
 
-struct pack_list {
+static struct pack_list {
 	struct pack_list *next;
 	struct packed_git *pack;
 	struct llist *unique_objects;
@@ -36,7 +36,7 @@ struct pll {
 	size_t pl_size;
 };
 
-inline void llist_free(struct llist *list)
+static inline void llist_free(struct llist *list)
 {
 	while((list->back = list->front)) {
 		list->front = list->front->next;
@@ -45,14 +45,14 @@ inline void llist_free(struct llist *lis
 	free(list);
 }
 
-inline void llist_init(struct llist **list)
+static inline void llist_init(struct llist **list)
 {
 	*list = xmalloc(sizeof(struct llist));
 	(*list)->front = (*list)->back = NULL;
 	(*list)->size = 0;
 }
 
-struct llist * llist_copy(struct llist *list)
+static struct llist * llist_copy(struct llist *list)
 {
 	struct llist *ret;
 	struct llist_item *new, *old, *prev;
@@ -79,7 +79,7 @@ struct llist * llist_copy(struct llist *
 	return ret;
 }
 
-inline struct llist_item * llist_insert(struct llist *list,
+static inline struct llist_item * llist_insert(struct llist *list,
 					struct llist_item *after, char *sha1)
 {
 	struct llist_item *new = xmalloc(sizeof(struct llist_item));
@@ -102,12 +102,12 @@ inline struct llist_item * llist_insert(
 	return new;
 }
 
-inline struct llist_item * llist_insert_back(struct llist *list, char *sha1)
+static inline struct llist_item * llist_insert_back(struct llist *list, char *sha1)
 {
 	return llist_insert(list, list->back, sha1);
 }
 
-inline struct llist_item * llist_insert_sorted_unique(struct llist *list,
+static inline struct llist_item * llist_insert_sorted_unique(struct llist *list,
 					char *sha1, struct llist_item *hint)
 {
 	struct llist_item *prev = NULL, *l;
@@ -129,7 +129,7 @@ inline struct llist_item * llist_insert_
 }
 
 /* returns a pointer to an item in front of sha1 */
-inline struct llist_item * llist_sorted_remove(struct llist *list, char *sha1,
+static inline struct llist_item * llist_sorted_remove(struct llist *list, char *sha1,
 					       struct llist_item *hint)
 {
 	struct llist_item *prev, *l;
@@ -164,7 +164,7 @@ redo_from_start:
 }
 
 /* computes A\B */
-void llist_sorted_difference_inplace(struct llist *A,
+static void llist_sorted_difference_inplace(struct llist *A,
 				     struct llist *B)
 {
 	struct llist_item *hint, *b;
@@ -178,7 +178,7 @@ void llist_sorted_difference_inplace(str
 	}
 }
 
-inline struct pack_list * pack_list_insert(struct pack_list **pl,
+static inline struct pack_list * pack_list_insert(struct pack_list **pl,
 					   struct pack_list *entry)
 {
 	struct pack_list *p = xmalloc(sizeof(struct pack_list));
@@ -188,7 +188,7 @@ inline struct pack_list * pack_list_inse
 	return p;
 }
 
-inline size_t pack_list_size(struct pack_list *pl)
+static inline size_t pack_list_size(struct pack_list *pl)
 {
 	size_t ret = 0;
 	while(pl) {
@@ -198,7 +198,7 @@ inline size_t pack_list_size(struct pack
 	return ret;
 }
 
-struct pack_list * pack_list_difference(struct pack_list *A,
+static struct pack_list * pack_list_difference(struct pack_list *A,
 					struct pack_list *B)
 {
 	struct pack_list *ret, *pl;
@@ -218,7 +218,7 @@ struct pack_list * pack_list_difference(
 	return ret;
 }
 
-void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
+static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 {
 	int p1_off, p2_off;
 	void *p1_base, *p2_base;
@@ -250,7 +250,7 @@ void cmp_two_packs(struct pack_list *p1,
 	}
 }
 
-void pll_insert(struct pll **pll, struct pll **hint_table)
+static void pll_insert(struct pll **pll, struct pll **hint_table)
 {
 	struct pll *prev;
 	int i = (*pll)->pl_size - 1;
@@ -276,7 +276,7 @@ void pll_insert(struct pll **pll, struct
 /* all the permutations have to be free()d at the same time,
  * since they refer to each other
  */
-struct pll * get_all_permutations(struct pack_list *list)
+static struct pll * get_all_permutations(struct pack_list *list)
 {
 	struct pll *subset, *pll, *new_pll = NULL; /*silence warning*/
 	static struct pll **hint = NULL;
@@ -323,7 +323,7 @@ struct pll * get_all_permutations(struct
 	return hint[0];
 }
 
-int is_superset(struct pack_list *pl, struct llist *list)
+static int is_superset(struct pack_list *pl, struct llist *list)
 {
 	struct llist *diff;
 
@@ -342,7 +342,7 @@ int is_superset(struct pack_list *pl, st
 	return 0;
 }
 
-size_t sizeof_union(struct packed_git *p1, struct packed_git *p2)
+static size_t sizeof_union(struct packed_git *p1, struct packed_git *p2)
 {
 	size_t ret = 0;
 	int p1_off, p2_off;
@@ -373,14 +373,14 @@ size_t sizeof_union(struct packed_git *p
 }
 
 /* another O(n^2) function ... */
-size_t get_pack_redundancy(struct pack_list *pl)
+static size_t get_pack_redundancy(struct pack_list *pl)
 {
 	struct pack_list *subset;
+	size_t ret = 0;
 
 	if (pl == NULL)
 		return 0;
 
-	size_t ret = 0;
 	while ((subset = pl->next)) {
 		while(subset) {
 			ret += sizeof_union(pl->pack, subset->pack);
@@ -391,7 +391,7 @@ size_t get_pack_redundancy(struct pack_l
 	return ret;
 }
 
-inline size_t pack_set_bytecount(struct pack_list *pl)
+static inline size_t pack_set_bytecount(struct pack_list *pl)
 {
 	size_t ret = 0;
 	while (pl) {
@@ -402,7 +402,7 @@ inline size_t pack_set_bytecount(struct 
 	return ret;
 }
 
-void minimize(struct pack_list **min)
+static void minimize(struct pack_list **min)
 {
 	struct pack_list *pl, *unique = NULL,
 		*non_unique = NULL, *min_perm = NULL;
@@ -469,7 +469,7 @@ void minimize(struct pack_list **min)
 	}
 }
 
-void load_all_objects()
+static void load_all_objects(void)
 {
 	struct pack_list *pl = local_packs;
 	struct llist_item *hint, *l;
@@ -497,7 +497,7 @@ void load_all_objects()
 }
 
 /* this scales like O(n^2) */
-void cmp_local_packs()
+static void cmp_local_packs(void)
 {
 	struct pack_list *subset, *pl = local_packs;
 
@@ -508,7 +508,7 @@ void cmp_local_packs()
 	}
 }
 
-void scan_alt_odb_packs()
+static void scan_alt_odb_packs(void)
 {
 	struct pack_list *local, *alt;
 
@@ -524,7 +524,7 @@ void scan_alt_odb_packs()
 	}
 }
 
-struct pack_list * add_pack(struct packed_git *p)
+static struct pack_list * add_pack(struct packed_git *p)
 {
 	struct pack_list l;
 	size_t off;
@@ -550,7 +550,7 @@ struct pack_list * add_pack(struct packe
 		return pack_list_insert(&altodb_packs, &l);
 }
 
-struct pack_list * add_pack_file(char *filename)
+static struct pack_list * add_pack_file(char *filename)
 {
 	struct packed_git *p = packed_git;
 
@@ -565,7 +565,7 @@ struct pack_list * add_pack_file(char *f
 	die("Filename %s not found in packed_git\n", filename);
 }
 
-void load_all()
+static void load_all(void)
 {
 	struct packed_git *p = packed_git;
 
diff --git a/path.c b/path.c
index d635470..84b3272 100644
--- a/path.c
+++ b/path.c
@@ -131,7 +131,7 @@ int validate_symref(const char *path)
 	return -1;
 }
 
-static char *current_dir()
+static char *current_dir(void)
 {
 	return getcwd(pathname, sizeof(pathname));
 }
---
0.99.9.GIT
