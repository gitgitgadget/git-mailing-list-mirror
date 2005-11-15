From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] Rework object refs tracking to reduce memory usage
Date: Tue, 15 Nov 2005 19:08:08 +0300
Message-ID: <20051115160808.GG24496@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 17:13:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec3Lz-0007V0-LW
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 17:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVKOQIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 11:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVKOQIM
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 11:08:12 -0500
Received: from mivlgu.ru ([81.18.140.87]:48026 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S964808AbVKOQIK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 11:08:10 -0500
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id F0B4C18011E; Tue, 15 Nov 2005 19:08:08 +0300 (MSK)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11912>

Store pointers to referenced objects in a variable sized array instead
of linked list.  This cuts down memory usage of utilities which use
object references; e.g., git-fsck-objects --full on the git.git
repository consumes about 2 MB of memory tracked by Massif instead of
7 MB before the change.  Object refs are still the biggest consumer of
memory (57%), but the malloc overhead for a single block instead of a
linked list is substantially smaller.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 commit.c       |   19 ++++++++++++++---
 fsck-objects.c |   22 +++++++++++--------
 object.c       |   64 +++++++++++++++++++++++++++++++++++++++-----------------
 object.h       |   10 +++++++--
 server-info.c  |   25 ++++++++++++++++------
 tag.c          |    7 ++++--
 tree.c         |   13 +++++++++++
 7 files changed, 117 insertions(+), 43 deletions(-)

applies-to: 4d3146cd52c79f88fcc08b542630cfe7394f5047
1ab535abd04f9150a9a7904d1459109211369f6c
diff --git a/commit.c b/commit.c
index ebf4db6..e867b86 100644
--- a/commit.c
+++ b/commit.c
@@ -204,6 +204,7 @@ int parse_commit_buffer(struct commit *i
 	unsigned char parent[20];
 	struct commit_list **pptr;
 	struct commit_graft *graft;
+	unsigned n_refs = 0;
 
 	if (item->object.parsed)
 		return 0;
@@ -214,7 +215,7 @@ int parse_commit_buffer(struct commit *i
 		return error("bad tree pointer in commit %s\n", sha1_to_hex(item->object.sha1));
 	item->tree = lookup_tree(parent);
 	if (item->tree)
-		add_ref(&item->object, &item->tree->object);
+		n_refs++;
 	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
@@ -230,7 +231,7 @@ int parse_commit_buffer(struct commit *i
 		new_parent = lookup_commit(parent);
 		if (new_parent) {
 			pptr = &commit_list_insert(new_parent, pptr)->next;
-			add_ref(&item->object, &new_parent->object);
+			n_refs++;
 		}
 	}
 	if (graft) {
@@ -241,10 +242,22 @@ int parse_commit_buffer(struct commit *i
 			if (!new_parent)
 				continue;
 			pptr = &commit_list_insert(new_parent, pptr)->next;
-			add_ref(&item->object, &new_parent->object);
+			n_refs++;
 		}
 	}
 	item->date = parse_commit_date(bufptr);
+
+	if (track_object_refs) {
+		unsigned i = 0;
+		struct commit_list *p;
+		struct object_refs *refs = alloc_object_refs(n_refs);
+		if (item->tree)
+			refs->ref[i++] = &item->tree->object;
+		for (p = item->parents; p; p = p->next)
+			refs->ref[i++] = &p->item->object;
+		set_object_refs(&item->object, refs);
+	}
+
 	return 0;
 }
 
diff --git a/fsck-objects.c b/fsck-objects.c
index c1b279e..0433a1d 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -56,7 +56,6 @@ static void check_connectivity(void)
 	/* Look up all the requirements, warn about missing objects.. */
 	for (i = 0; i < nr_objs; i++) {
 		struct object *obj = objs[i];
-		struct object_list *refs;
 
 		if (!obj->parsed) {
 			if (!standalone && has_sha1_file(obj->sha1))
@@ -67,14 +66,19 @@ static void check_connectivity(void)
 			continue;
 		}
 
-		for (refs = obj->refs; refs; refs = refs->next) {
-			if (refs->item->parsed ||
-			    (!standalone && has_sha1_file(refs->item->sha1)))
-				continue;
-			printf("broken link from %7s %s\n",
-			       obj->type, sha1_to_hex(obj->sha1));
-			printf("              to %7s %s\n",
-			       refs->item->type, sha1_to_hex(refs->item->sha1));
+		if (obj->refs) {
+			const struct object_refs *refs = obj->refs;
+			unsigned j;
+			for (j = 0; j < refs->count; j++) {
+				struct object *ref = refs->ref[j];
+				if (ref->parsed ||
+				    (!standalone && has_sha1_file(ref->sha1)))
+					continue;
+				printf("broken link from %7s %s\n",
+				       obj->type, sha1_to_hex(obj->sha1));
+				printf("              to %7s %s\n",
+				       ref->type, sha1_to_hex(ref->sha1));
+			}
 		}
 
 		if (show_unreachable && !(obj->flags & REACHABLE)) {
diff --git a/object.c b/object.c
index 1fdebe0..427e14c 100644
--- a/object.c
+++ b/object.c
@@ -67,40 +67,66 @@ void created_object(const unsigned char 
 	nr_objs++;
 }
 
-void add_ref(struct object *refer, struct object *target)
+struct object_refs *alloc_object_refs(unsigned count)
 {
-	struct object_list **pp, *p;
+	struct object_refs *refs;
+	size_t size = sizeof(*refs) + count*sizeof(struct object *);
 
-	if (!track_object_refs)
-		return;
+	refs = xmalloc(size);
+	memset(refs, 0, size);
+	refs->count = count;
+	return refs;
+}
+
+static int compare_object_pointers(const void *a, const void *b)
+{
+	const struct object * const *pa = a;
+	const struct object * const *pb = b;
+	return *pa - *pb;
+}
+
+void set_object_refs(struct object *obj, struct object_refs *refs)
+{
+	unsigned int i, j;
 
-	pp = &refer->refs;
-	while ((p = *pp) != NULL) {
-		if (p->item == target)
-			return;
-		pp = &p->next;
+	/* Do not install empty list of references */
+	if (refs->count < 1) {
+		free(refs);
+		return;
 	}
 
-	target->used = 1;
-	p = xmalloc(sizeof(*p));
-	p->item = target;
-	p->next = NULL;
-	*pp = p;
+	/* Sort the list and filter out duplicates */
+	qsort(refs->ref, refs->count, sizeof(refs->ref[0]),
+	      compare_object_pointers);
+	for (i = j = 1; i < refs->count; i++) {
+		if (refs->ref[i] != refs->ref[i - 1])
+			refs->ref[j++] = refs->ref[i];
+	}
+	if (j < refs->count) {
+		/* Duplicates were found - reallocate list */
+		size_t size = sizeof(*refs) + j*sizeof(struct object *);
+		refs->count = j;
+		refs = xrealloc(refs, size);
+	}
+
+	for (i = 0; i < refs->count; i++)
+		refs->ref[i]->used = 1;
+	obj->refs = refs;
 }
 
 void mark_reachable(struct object *obj, unsigned int mask)
 {
-	struct object_list *p = obj->refs;
-
 	if (!track_object_refs)
 		die("cannot do reachability with object refs turned off");
 	/* If we've been here already, don't bother */
 	if (obj->flags & mask)
 		return;
 	obj->flags |= mask;
-	while (p) {
-		mark_reachable(p->item, mask);
-		p = p->next;
+	if (obj->refs) {
+		const struct object_refs *refs = obj->refs;
+		unsigned i;
+		for (i = 0; i < refs->count; i++)
+			mark_reachable(refs->ref[i], mask);
 	}
 }
 
diff --git a/object.h b/object.h
index 6accda3..336d986 100644
--- a/object.h
+++ b/object.h
@@ -7,13 +7,18 @@ struct object_list {
 	const char *name;
 };
 
+struct object_refs {
+	unsigned count;
+	struct object *ref[0];
+};
+
 struct object {
 	unsigned parsed : 1;
 	unsigned used : 1;
 	unsigned int flags;
 	unsigned char sha1[20];
 	const char *type;
-	struct object_list *refs;
+	struct object_refs *refs;
 	void *util;
 };
 
@@ -35,7 +40,8 @@ struct object *parse_object(const unsign
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
 
-void add_ref(struct object *refer, struct object *target);
+struct object_refs *alloc_object_refs(unsigned count);
+void set_object_refs(struct object *obj, struct object_refs *refs);
 
 void mark_reachable(struct object *obj, unsigned int mask);
 
diff --git a/server-info.c b/server-info.c
index 0cba8e1..e4006f0 100644
--- a/server-info.c
+++ b/server-info.c
@@ -424,7 +424,6 @@ static void find_pack_info_one(int pack_
 {
 	unsigned char sha1[20];
 	struct object *o;
-	struct object_list *ref;
 	int i;
 	struct packed_git *p = info[pack_ix]->p;
 	int num = num_packed_objects(p);
@@ -437,8 +436,12 @@ static void find_pack_info_one(int pack_
 			die("corrupt pack file %s?", p->pack_name);
 		if ((o = lookup_object(sha1)) == NULL)
 			die("cannot parse %s", sha1_to_hex(sha1));
-		for (ref = o->refs; ref; ref = ref->next)
-			ref->item->flags = 0;
+		if (o->refs) {
+			struct object_refs *refs = o->refs;
+			int j;
+			for (j = 0; j < refs->count; j++)
+				refs->ref[j]->flags = 0;
+		}
 		o->flags = 0;
 	}
 
@@ -448,8 +451,12 @@ static void find_pack_info_one(int pack_
 			die("corrupt pack file %s?", p->pack_name);
 		if ((o = lookup_object(sha1)) == NULL)
 			die("cannot find %s", sha1_to_hex(sha1));
-		for (ref = o->refs; ref; ref = ref->next)
-			ref->item->flags |= REFERENCED;
+		if (o->refs) {
+			struct object_refs *refs = o->refs;
+			int j;
+			for (j = 0; j < refs->count; j++)
+				refs->ref[j]->flags |= REFERENCED;
+		}
 		o->flags |= INTERNAL;
 	}
 
@@ -460,8 +467,12 @@ static void find_pack_info_one(int pack_
 			die("cannot find %s", sha1_to_hex(sha1));
 
 		show(o, pack_ix);
-		for (ref = o->refs; ref; ref = ref->next)
-			show(ref->item, pack_ix);
+		if (o->refs) {
+			struct object_refs *refs = o->refs;
+			int j;
+			for (j = 0; j < refs->count; j++)
+				show(refs->ref[j], pack_ix);
+		}
 	}
 
 }
diff --git a/tag.c b/tag.c
index e574c4b..61ac434 100644
--- a/tag.c
+++ b/tag.c
@@ -75,8 +75,11 @@ int parse_tag_buffer(struct tag *item, v
 	item->tag[taglen] = '\0';
 
 	item->tagged = lookup_object_type(object, type);
-	if (item->tagged)
-		add_ref(&item->object, item->tagged);
+	if (item->tagged && track_object_refs) {
+		struct object_refs *refs = alloc_object_refs(1);
+		refs->ref[0] = item->tagged;
+		set_object_refs(&item->object, refs);
+	}
 
 	return 0;
 }
diff --git a/tree.c b/tree.c
index 315b6a5..8b42a07 100644
--- a/tree.c
+++ b/tree.c
@@ -148,6 +148,7 @@ int parse_tree_buffer(struct tree *item,
 {
 	void *bufptr = buffer;
 	struct tree_entry_list **list_p;
+	int n_refs = 0;
 
 	if (item->object.parsed)
 		return 0;
@@ -184,11 +185,21 @@ int parse_tree_buffer(struct tree *item,
 			obj = &entry->item.blob->object;
 		}
 		if (obj)
-			add_ref(&item->object, obj);
+			n_refs++;
 		entry->parent = NULL; /* needs to be filled by the user */
 		*list_p = entry;
 		list_p = &entry->next;
 	}
+
+	if (track_object_refs) {
+		struct tree_entry_list *entry;
+		unsigned i = 0;
+		struct object_refs *refs = alloc_object_refs(n_refs);
+		for (entry = item->entries; entry; entry = entry->next)
+			refs->ref[i++] = entry->item.any;
+		set_object_refs(&item->object, refs);
+	}
+
 	return 0;
 }
 
---
0.99.9.GIT
