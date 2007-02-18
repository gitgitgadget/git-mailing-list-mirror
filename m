From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Add `struct object_hash`
Date: Sun, 18 Feb 2007 00:34:04 -0800
Message-ID: <7vtzxjj24j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702171838150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 09:34:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIhUy-0006W3-Ag
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 09:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbXBRIeH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 03:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbXBRIeG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 03:34:06 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50733 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161146AbXBRIeF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 03:34:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218083406.UMTX1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Feb 2007 03:34:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Qwa41W0071kojtg0000000; Sun, 18 Feb 2007 03:34:04 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40062>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Using object_hash, you can store interesting information about
> objects in a private hash map. This makes up for the lack of a
> `util` member of `struct object`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	We should have done that earlier. Now, git.git already
> 	contains two specialised versions of an object hash map:
> 	obj_hash and refs_hash.
>
> 	obj_hash is not really a hash map, but rather a hash set,
> 	but there is no excuse for refs_hash having its own little
> 	private implementation nobody else can reuse.

Ok, having now looked at it more, I can say:

 - I hate it.

I dislike it intensely, because it's so _close_ to being usable.
For one thing, I do not like that the patch was not accompanied
with rewrite of object-refs.c using this new facility.

And I kind of know why.  You would end up making obj_refs quite
more expensive by doing so if you use two-pointer hash_entry
that points at a separate structure (and you would want the hash
table not too full, which means you would waste at least twice
as much memory for growing room for the hashtable, plus malloc
overhead for the separate flexible array of refs), and obj_refs
is something we would really want to keep its memory footprint
to the bare minimum, because nowhere else in git we keep
information on potentially thousands of objects.  I suspect that
it would have been bit more palatable if object_hash_entry were
a flex structure type like object_refs.

> +static void grow_object_hash(struct object_hash *hash)
> +{
> +	struct object_hash_entry *old_hash = hash->hash;
> +	int new_size = (hash->size + 1000) * 3 / 2, i;
> +
> +	hash->hash = xcalloc(sizeof(struct object_hash_entry), new_size);
> +	for (i = 0; i < hash->size; i++) {
> +		struct object_hash_entry *entry = old_hash + i;
> +		if (!entry->object)
> +			continue;
> +		insert_object_into_hash(entry->object, entry->util, hash);
> +	}
> +	hash->size = new_size;
> +	free(old_hash);
> +}

Isn't this broken?  You still have old hash size in hash->size
inside loop, which is given to insert_object_info_hash(), so the
rehashing will use the old (smaller) hash size to compute the
new location for the entry.  You want to keep old_size in a
variable to control the loop termination, update hash->size with
new_size at the same time you update hash->hash with the new
empty array, and walk the old array by hand, rehashing the
existing entries into new hashtable.

Here is a suggested replacement; patch is applicable on top of
v1.5.0 (or master).

-- >8 --
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Add `struct object_hash`

Using object_hash, you can store interesting information about
objects in a private hash map.  The earlier object-refs API is
now built on top of this generalized facility

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 Makefile      |    3 +-
 object-hash.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 object-refs.c |   71 ++++-----------------------------------------------------
 object.h      |   19 ++++++++++++++-
 4 files changed, 89 insertions(+), 68 deletions(-)
 create mode 100644 object-hash.c

diff --git a/Makefile b/Makefile
index 40bdcff..0b0a926 100644
--- a/Makefile
+++ b/Makefile
@@ -262,7 +262,8 @@ LIB_OBJS = \
 	revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o list-objects.o grep.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
-	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o
+	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
+	object-hash.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/object-hash.c b/object-hash.c
new file mode 100644
index 0000000..8e16e0e
--- /dev/null
+++ b/object-hash.c
@@ -0,0 +1,64 @@
+#include "cache.h"
+#include "object.h"
+
+static unsigned int hash_obj(struct object *obj, unsigned int n)
+{
+	unsigned int hash = *(unsigned int *)obj->sha1;
+	return hash % n;
+}
+
+static void insert_object_into_hash(struct object_hash_entry *ent, struct object_hash *hash)
+{
+	int j = hash_obj(ent->object, hash->size);
+
+	while (hash->hash[j]) {
+		j++;
+		if (j >= hash->size)
+			j = 0;
+	}
+	hash->hash[j] = ent;
+}
+
+static void grow_object_hash(struct object_hash *hash)
+{
+	struct object_hash_entry **old_hash = hash->hash;
+	int i;
+	int old_size = hash->size;
+	int new_size = (old_size + 1000) * 3 / 2;
+
+	hash->hash = xcalloc(new_size, sizeof(struct object_hash_entry *));
+	hash->size = new_size;
+	for (i = 0; i < old_size; i++) {
+		struct object_hash_entry *entry = old_hash[i];
+		if (!entry)
+			continue;
+		insert_object_into_hash(entry, hash);
+	}
+	free(old_hash);
+}
+
+void add_object_to_hash(struct object_hash_entry *ent, struct object_hash *hash)
+{
+	if (++hash->nr > hash->size * 2 / 3)
+		grow_object_hash(hash);
+	insert_object_into_hash(ent, hash);
+}
+
+struct object_hash_entry *lookup_object_in_hash(struct object *obj, struct object_hash *hash)
+{
+	struct object_hash_entry *ent;
+	int j;
+
+	/* nothing to lookup */
+	if (!hash->size)
+		return NULL;
+	j = hash_obj(obj, hash->size);
+	while ((ent = hash->hash[j]) != NULL) {
+		if (ent->object == obj)
+			break;
+		j++;
+		if (j >= hash->size)
+			j = 0;
+	}
+	return ent;
+}
diff --git a/object-refs.c b/object-refs.c
index 98ea100..022b5ca 100644
--- a/object-refs.c
+++ b/object-refs.c
@@ -3,73 +3,11 @@
 
 int track_object_refs = 0;
 
-static unsigned int refs_hash_size, nr_object_refs;
-static struct object_refs **refs_hash;
-
-static unsigned int hash_obj(struct object *obj, unsigned int n)
-{
-	unsigned int hash = *(unsigned int *)obj->sha1;
-	return hash % n;
-}
-
-static void insert_ref_hash(struct object_refs *ref, struct object_refs **hash, unsigned int size)
-{
-	int j = hash_obj(ref->base, size);
-
-	while (hash[j]) {
-		j++;
-		if (j >= size)
-			j = 0;
-	}
-	hash[j] = ref;
-}
-
-static void grow_refs_hash(void)
-{
-	int i;
-	int new_hash_size = (refs_hash_size + 1000) * 3 / 2;
-	struct object_refs **new_hash;
-
-	new_hash = xcalloc(new_hash_size, sizeof(struct object_refs *));
-	for (i = 0; i < refs_hash_size; i++) {
-		struct object_refs *ref = refs_hash[i];
-		if (!ref)
-			continue;
-		insert_ref_hash(ref, new_hash, new_hash_size);
-	}
-	free(refs_hash);
-	refs_hash = new_hash;
-	refs_hash_size = new_hash_size;
-}
-
-static void add_object_refs(struct object *obj, struct object_refs *ref)
-{
-	int nr = nr_object_refs + 1;
-
-	if (nr > refs_hash_size * 2 / 3)
-		grow_refs_hash();
-	ref->base = obj;
-	insert_ref_hash(ref, refs_hash, refs_hash_size);
-	nr_object_refs = nr;
-}
+static struct object_hash refs_hash;
 
 struct object_refs *lookup_object_refs(struct object *obj)
 {
-	struct object_refs *ref;
-	int j;
-
-	/* nothing to lookup */
-	if (!refs_hash_size)
-		return NULL;
-	j = hash_obj(obj, refs_hash_size);
-	while ((ref = refs_hash[j]) != NULL) {
-		if (ref->base == obj)
-			break;
-		j++;
-		if (j >= refs_hash_size)
-			j = 0;
-	}
-	return ref;
+	return (struct object_refs *)lookup_object_in_hash(obj, &refs_hash);
 }
 
 struct object_refs *alloc_object_refs(unsigned count)
@@ -120,7 +58,8 @@ void set_object_refs(struct object *obj, struct object_refs *refs)
 
 	for (i = 0; i < refs->count; i++)
 		refs->ref[i]->used = 1;
-	add_object_refs(obj, refs);
+	refs->base = obj;
+	add_object_to_hash((struct object_hash_entry *)refs, &refs_hash);
 }
 
 void mark_reachable(struct object *obj, unsigned int mask)
@@ -133,7 +72,7 @@ void mark_reachable(struct object *obj, unsigned int mask)
 	if (obj->flags & mask)
 		return;
 	obj->flags |= mask;
-	refs = lookup_object_refs(obj);
+	refs = (struct object_refs *)lookup_object_in_hash(obj, &refs_hash);
 	if (refs) {
 		unsigned i;
 		for (i = 0; i < refs->count; i++)
diff --git a/object.h b/object.h
index caee733..c417cf2 100644
--- a/object.h
+++ b/object.h
@@ -7,11 +7,28 @@ struct object_list {
 };
 
 struct object_refs {
-	unsigned count;
 	struct object *base;
+	unsigned count;
 	struct object *ref[FLEX_ARRAY]; /* more */
 };
 
+/*
+ * This is a "shell" type that represents the actual structure you
+ * would place in object_hash.  The user would cast up the pointer to
+ * object_hash_entry to a more concrete type, such as object_refs.
+ */
+struct object_hash_entry {
+	struct object *object;
+};
+
+struct object_hash {
+	unsigned int size, nr;
+	struct object_hash_entry **hash;
+};
+
+void add_object_to_hash(struct object_hash_entry *, struct object_hash *);
+struct object_hash_entry *lookup_object_in_hash(struct object *, struct object_hash *);
+
 struct object_array {
 	unsigned int nr;
 	unsigned int alloc;
