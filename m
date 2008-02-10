From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Sun, 10 Feb 2008 18:58:12 +0100
Message-ID: <20080210175812.GB12162@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 18:59:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOGS7-0003Ah-4n
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 18:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbYBJR6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 12:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYBJR6S
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 12:58:18 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58666 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbYBJR6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 12:58:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 70A43680BF6C
	for <git@vger.kernel.org>; Sun, 10 Feb 2008 18:58:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id otmuZFz5MDSe for <git@vger.kernel.org>;
	Sun, 10 Feb 2008 18:58:12 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 2F877680BF6B; Sun, 10 Feb 2008 18:58:12 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73384>

Some weeks ago, I ask myself, what unexpected things could be
done by user via git-shell/git-daemon. I created logical corrupt=20
objects (such can be uploaded via receive pack without any problem)
and got git to segfaults very quickly.

In most cases they are cause by one of the two things:

* lookup/parse_XXX returns a NULL pointer, which is not handled=20
  in many cases.
* The return values of functions are not checked.

=46ixing all these things would be a lot of work and maybe even slow
down git. Even if all this things would be fixed, a corrupt=20
object in the history would mean, that git-upload-pack will die=20
with an error message and that a admin must fix the repository.

So I tried to fix the problem in another way: Instead of coping with=20
corrupt objects, stop them from entering the repository.

These patch series does the following things:
* add a type aware object chain walker for all child objects (patch 2)

  I have not found a similar function in the git core, so I wrote
  one. I'm open for better alternatives.

* move fsck to object chain walker (and get rid of track objects) (patc=
h 3,4,5,12)

  I'm not sure, if this is advocated by others. At least it fixes=20
  some crashes in the case of NULL pointers.

* Factor out reuseable code from builtin-fsck.c to fsck.c (patch 6+7)
* add --strict option to unpack-objects (patch 1,8,9)

  The --strict option changes writing order slightly. All non blob obje=
cts
  are not written out immediatly. After the last object of the packfile
  is read, unpack-objects starts looking for non written objects. If th=
e object
  is not corrupt and all its links are available, the object is written=
=2E

  This way only dangling objects can be created.=20

  On shallow repositories, this check can fail, if the list of shallow =
commits
  is changed. For the intended use in receive-pack, this is not a probl=
em, as
  it does not work on such repositories.

* add --strict option to index-pack (patch 8,10)

  Same as for unpack-objects, but without writting objects.

* add config option for receive pack to enable checking (patch 11)

These patch serie is a first prototype to get some feedback.

mfg Martin K=F6gler

Patch 1: unpack-object: cache for non written objects
Patch 2: add generic, type aware object chain walker
Patch 3: fsck: move mark-reachable to fsck_walk
Patch 4: fsck: move reachable object check to fsck_walk
Patch 5: fsck: disable track objects
Patch 6: create a common object checker code out of fsck
Patch 7: fsck: use common object checker
Patch 8: add common fsck error printing function
Patch 9: unpack-objects: prevent writing of inconsistent objects
Patch 10: index-pack: introduce checking mode
Patch 11: receive-pack: use strict mode for unpacking objects
Patch 12: Remove unused object-ref code


 Documentation/config.txt             |    6 +
 Documentation/git-index-pack.txt     |    3 +
 Documentation/git-unpack-objects.txt |    3 +
 Makefile                             |    6 +-
 builtin-fetch-pack.c                 |    1 -
 builtin-fsck.c                       |  329 +++++++++-----------------=
--------
 builtin-pack-objects.c               |    1 -
 builtin-rev-list.c                   |    1 -
 builtin-unpack-objects.c             |  131 +++++++++++++-
 commit.c                             |   11 --
 fsck.c                               |  314 ++++++++++++++++++++++++++=
++++++
 fsck.h                               |   16 ++
 index-pack.c                         |   78 ++++++++-
 object-refs.c                        |   87 ---------
 object.h                             |    8 -
 receive-pack.c                       |   36 +++--
 tag.c                                |    6 -
 tree.c                               |   48 -----
 upload-pack.c                        |    1 -
 walker.c                             |    1 -
 20 files changed, 653 insertions(+), 434 deletions(-)

-----------------------------------------------------------------------=
-------

=46rom 76e86fe55345e633c910d6b8fe166e27c23c5aaf Mon Sep 17 00:00:00 200=
1
=46rom: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Fri, 8 Feb 2008 08:51:38 +0100
Subject: [PATCH 01/12] unpack-object: cache for non written objects

Preventing objects with broken links entering the repository
means, that write of some objects must be delayed.

This patch adds a cache to keep the object data in memory. The delta
resolving code must also search in the cache.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-unpack-objects.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 1e51865..f18c7e8 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -8,6 +8,7 @@
 #include "tag.h"
 #include "tree.h"
 #include "progress.h"
+#include "decorate.h"
=20
 static int dry_run, quiet, recover, has_errors;
 static const char unpack_usage[] =3D "git-unpack-objects [-n] [-q] [-r=
] < pack-file";
@@ -18,6 +19,28 @@ static unsigned int offset, len;
 static off_t consumed_bytes;
 static SHA_CTX ctx;
=20
+struct obj_buffer {
+	char *buffer;
+	unsigned long size;
+};
+
+static struct decoration obj_decorate;
+
+static struct obj_buffer *lookup_object_buffer(struct object *base)
+{
+	return lookup_decoration(&obj_decorate, base);
+}
+
+static void add_object_buffer(struct object *object, char *buffer, uns=
igned long size)
+{
+	struct obj_buffer *obj;
+	obj =3D xcalloc(1, sizeof(struct obj_buffer));
+	obj->buffer =3D buffer;
+	obj->size =3D size;
+	if (add_decoration(&obj_decorate, object, obj))
+		die("object %s tried to add buffer twice!", sha1_to_hex(object->sha1=
));
+}
+
 /*
  * Make sure at least "min" bytes are available in the buffer, and
  * return the pointer to the buffer.
@@ -252,6 +275,15 @@ static void unpack_delta_entry(enum object_type ty=
pe, unsigned long delta_size,
 		}
 	}
=20
+	struct object* obj =3D lookup_object(base_sha1);
+	if (obj) {
+		struct obj_buffer *obj_buf =3D lookup_object_buffer (obj);
+		if (obj_buf) {
+			resolve_delta(nr, obj->type, obj_buf->buffer, obj_buf->size, delta_=
data, delta_size);
+			return;
+		}
+	}
+
 	base =3D read_sha1_file(base_sha1, &type, &base_size);
 	if (!base) {
 		error("failed to read delta-pack base object %s",
--=20
1.5.4.g074be


=46rom 9fb732d8939ea2108440a0ab468aab15c648dde5 Mon Sep 17 00:00:00 200=
1
=46rom: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Fri, 8 Feb 2008 09:01:01 +0100
Subject: [PATCH 02/12] add generic, type aware object chain walker

The requirements are:
* it may not crash on NULL pointers
* a callback function is needed, as index-pack/unpack-objects
  need to do different things
* the type information is needed to check the expected <-> real type
  and print better error messages

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 Makefile |    4 +-
 fsck.c   |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 fsck.h   |   10 +++++++
 3 files changed, 96 insertions(+), 2 deletions(-)
 create mode 100644 fsck.c
 create mode 100644 fsck.h

diff --git a/Makefile b/Makefile
index 728cfc2..0921484 100644
--- a/Makefile
+++ b/Makefile
@@ -301,7 +301,7 @@ LIB_H =3D \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h
+	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h fsck=
=2Eh
=20
 DIFF_OBJS =3D \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -324,7 +324,7 @@ LIB_OBJS =3D \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o =
\
-	transport.o bundle.o walker.o parse-options.o ws.o archive.o
+	transport.o bundle.o walker.o parse-options.o ws.o archive.o fsck.o
=20
 BUILTIN_OBJS =3D \
 	builtin-add.o \
diff --git a/fsck.c b/fsck.c
new file mode 100644
index 0000000..089f775
--- /dev/null
+++ b/fsck.c
@@ -0,0 +1,84 @@
+#include "cache.h"
+#include "object.h"
+#include "blob.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "commit.h"
+#include "tag.h"
+#include "fsck.h"
+
+static int fsck_walk_tree(struct tree* tree, fsck_walk_func walk, void=
* data)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+
+	if(parse_tree(tree))
+		return -1;
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	while(tree_entry(&desc, &entry)) {
+		int result;
+	=09
+		if (S_ISGITLINK(entry.mode))
+			continue;
+		if (S_ISDIR(entry.mode))
+			result =3D walk(&lookup_tree(entry.sha1)->object, OBJ_TREE, data);
+		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode))
+			result =3D walk(&lookup_blob(entry.sha1)->object, OBJ_BLOB, data);
+		else {
+			error("in tree %s: entry %s has bad mode %.6o\n",
+			      sha1_to_hex(tree->object.sha1), entry.path, entry.mode);
+			result =3D -1;
+		}
+		if (result)
+			return result;
+	}
+	return 0;
+}
+
+static int fsck_walk_commit(struct commit* commit, fsck_walk_func walk=
, void* data)
+{
+	struct commit_list *parents =3D commit->parents;
+	int result;
+
+	if(parse_commit(commit))
+		return -1;
+
+	result =3D walk((struct object*)commit->tree, OBJ_TREE, data);
+	if (result)
+		return result;
+
+	while (parents) {
+		result =3D walk((struct object*)parents->item, OBJ_COMMIT, data);
+		if (result)
+			return result;
+		parents =3D parents->next;
+	}
+	return 0;
+}
+
+static int fsck_walk_tag(struct tag* tag, fsck_walk_func walk, void* d=
ata)
+{
+	if(parse_tag(tag))
+		return -1;
+	return walk(tag->tagged, OBJ_ANY, data);
+}
+
+int fsck_walk(struct object* obj, fsck_walk_func walk, void* data)
+{
+	if (!obj)
+		return -1;
+	switch(obj->type) {
+	case OBJ_BLOB:
+		return 0;
+	case OBJ_TREE:
+		return fsck_walk_tree((struct tree*)obj, walk, data);
+	case OBJ_COMMIT:
+		return fsck_walk_commit((struct commit*)obj, walk, data);
+	case OBJ_TAG:
+		return fsck_walk_tag((struct tag*)obj, walk, data);
+	default:
+		error("Unknown object type for %s", sha1_to_hex(obj->sha1));
+		return -1;
+	}
+}
diff --git a/fsck.h b/fsck.h
new file mode 100644
index 0000000..caeb2c9
--- /dev/null
+++ b/fsck.h
@@ -0,0 +1,10 @@
+#ifndef GIT_FSCK_H
+#define GIT_FSCK_H
+
+#define OBJ_ANY OBJ_BAD
+
+typedef int (*fsck_walk_func)(struct object* obj, int type, void* data=
);
+
+int fsck_walk(struct object* obj, fsck_walk_func walk, void* data);
+
+#endif
--=20
1.5.4.g074be


=46rom 80b22c3f2c3e13c207790a49646020c55b34bba7 Mon Sep 17 00:00:00 200=
1
=46rom: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Fri, 8 Feb 2008 09:01:50 +0100
Subject: [PATCH 03/12] fsck: move mark-reachable to fsck_walk

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index cc7524b..49e96ff 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -8,6 +8,7 @@
 #include "pack.h"
 #include "cache-tree.h"
 #include "tree-walk.h"
+#include "fsck.h"
 #include "parse-options.h"
=20
 #define REACHABLE 0x0001
@@ -35,6 +36,23 @@ static int verbose;
 #define DIRENT_SORT_HINT(de) ((de)->d_ino)
 #endif
=20
+static int mark_object(struct object* obj, int type, void* data)
+{
+	if (!obj)
+		return 0;
+	if (obj->flags & REACHABLE)
+		return 0;
+	obj->flags |=3D REACHABLE;
+	if (!obj->parsed)
+		return 0;
+	return fsck_walk(obj, mark_object, data);
+}
+
+static void mark_object_reachable(struct object* obj)
+{
+	mark_object(obj, 0, 0);
+}
+
 static void objreport(struct object *obj, const char *severity,
                       const char *err, va_list params)
 {
@@ -326,8 +344,6 @@ static int fsck_tree(struct tree *item)
 		o_name =3D name;
 		o_sha1 =3D sha1;
 	}
-	free(item->buffer);
-	item->buffer =3D NULL;
=20
 	retval =3D 0;
 	if (has_full_path) {
@@ -375,8 +391,6 @@ static int fsck_commit(struct commit *commit)
 	}
 	if (memcmp(buffer, "author ", 7))
 		return objerror(&commit->object, "invalid format - expected 'author'=
 line");
-	free(commit->buffer);
-	commit->buffer =3D NULL;
 	if (!commit->tree)
 		return objerror(&commit->object, "could not load commit's tree %s", =
tree_sha1);
 	if (!commit->parents && show_root)
@@ -538,13 +552,13 @@ static int fsck_handle_reflog_ent(unsigned char *=
osha1, unsigned char *nsha1,
 		obj =3D lookup_object(osha1);
 		if (obj) {
 			obj->used =3D 1;
-			mark_reachable(obj, REACHABLE);
+			mark_object_reachable(obj);
 		}
 	}
 	obj =3D lookup_object(nsha1);
 	if (obj) {
 		obj->used =3D 1;
-		mark_reachable(obj, REACHABLE);
+		mark_object_reachable(obj);
 	}
 	return 0;
 }
@@ -574,7 +588,7 @@ static int fsck_handle_ref(const char *refname, con=
st unsigned char *sha1, int f
 		error("%s: not a commit", refname);
 	default_refs++;
 	obj->used =3D 1;
-	mark_reachable(obj, REACHABLE);
+	mark_object_reachable(obj);
=20
 	return 0;
 }
@@ -660,7 +674,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 			      sha1_to_hex(it->sha1));
 			return 1;
 		}
-		mark_reachable(obj, REACHABLE);
+		mark_object_reachable(obj);
 		obj->used =3D 1;
 		if (obj->type !=3D OBJ_TREE)
 			err |=3D objerror(obj, "non-tree in cache-tree");
@@ -741,7 +755,7 @@ int cmd_fsck(int argc, const char **argv, const cha=
r *prefix)
 				continue;
=20
 			obj->used =3D 1;
-			mark_reachable(obj, REACHABLE);
+			mark_object_reachable(obj);
 			heads++;
 			continue;
 		}
@@ -773,7 +787,7 @@ int cmd_fsck(int argc, const char **argv, const cha=
r *prefix)
 				continue;
 			obj =3D &blob->object;
 			obj->used =3D 1;
-			mark_reachable(obj, REACHABLE);
+			mark_object_reachable(obj);
 		}
 		if (active_cache_tree)
 			fsck_cache_tree(active_cache_tree);
--=20
1.5.4.g074be


=46rom ce43251ef71962ff64fe138f1295c405ef6aaf65 Mon Sep 17 00:00:00 200=
1
=46rom: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Fri, 8 Feb 2008 09:04:08 +0100
Subject: [PATCH 04/12] fsck: move reachable object check to fsck_walk

It handles NULL pointers in object references without crashing.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |   49 +++++++++++++++++++++++++++++-------------------=
-
 1 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 49e96ff..2c1e10f 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -81,13 +81,39 @@ static int objwarning(struct object *obj, const cha=
r *err, ...)
 	return -1;
 }
=20
+static int check_reachable_object_childs(struct object *obj, int type,=
 void *data)
+{
+	struct object *parent =3D data;
+	if (!obj) {
+		printf("broken link from %7s %s\n",
+			   typename(parent->type), sha1_to_hex(parent->sha1));
+		printf("broken link from %7s %s\n",
+			   (type=3D=3DOBJ_ANY?"unknown":typename(type)), "unknown");
+		errors_found |=3D ERROR_REACHABLE;
+		return 0;
+	}
+
+	if (type !=3D OBJ_ANY && obj->type !=3D type) {
+		objerror(parent, "wrong object type in link");
+		return 0;
+	}
+
+	if (obj->parsed || (has_sha1_file(obj->sha1)))
+		return 0;
+			=09
+	printf("broken link from %7s %s\n",
+	       typename(parent->type), sha1_to_hex(parent->sha1));
+	printf("              to %7s %s\n",
+	       typename(obj->type), sha1_to_hex(obj->sha1));
+	errors_found |=3D ERROR_REACHABLE;
+	return 0;
+}
+
 /*
  * Check a single reachable object
  */
 static void check_reachable_object(struct object *obj)
 {
-	const struct object_refs *refs;
-
 	/*
 	 * We obviously want the object to be parsed,
 	 * except if it was in a pack-file and we didn't
@@ -101,24 +127,7 @@ static void check_reachable_object(struct object *=
obj)
 		return;
 	}
=20
-	/*
-	 * Check that everything that we try to reference is also good.
-	 */
-	refs =3D lookup_object_refs(obj);
-	if (refs) {
-		unsigned j;
-		for (j =3D 0; j < refs->count; j++) {
-			struct object *ref =3D refs->ref[j];
-			if (ref->parsed ||
-			    (has_sha1_file(ref->sha1)))
-				continue;
-			printf("broken link from %7s %s\n",
-			       typename(obj->type), sha1_to_hex(obj->sha1));
-			printf("              to %7s %s\n",
-			       typename(ref->type), sha1_to_hex(ref->sha1));
-			errors_found |=3D ERROR_REACHABLE;
-		}
-	}
+	fsck_walk(obj, check_reachable_object_childs, obj);
 }
=20
 /*
--=20
1.5.4.g074be


=46rom ba836cfe0202f97bd5901e1155abfd22b698020c Mon Sep 17 00:00:00 200=
1
=46rom: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Fri, 8 Feb 2008 09:06:02 +0100
Subject: [PATCH 05/12] fsck: disable track objects

Mark the usage of object with fsck_walk. As this is the last user
of object_refs, it is disabled.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 2c1e10f..b0ca3ad 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -53,6 +53,14 @@ static void mark_object_reachable(struct object* obj=
)
 	mark_object(obj, 0, 0);
 }
=20
+static int mark_used(struct object* obj, int type, void* data)
+{
+	if (!obj)
+		return 0;
+	obj->used =3D 1;
+	return 0;
+}
+
 static void objreport(struct object *obj, const char *severity,
                       const char *err, va_list params)
 {
@@ -437,6 +445,7 @@ static int fsck_sha1(const unsigned char *sha1)
 	if (obj->flags & SEEN)
 		return 0;
 	obj->flags |=3D SEEN;
+	fsck_walk (obj, mark_used, 0);
 	if (obj->type =3D=3D OBJ_BLOB)
 		return 0;
 	if (obj->type =3D=3D OBJ_TREE)
@@ -716,7 +725,6 @@ int cmd_fsck(int argc, const char **argv, const cha=
r *prefix)
 {
 	int i, heads;
=20
-	track_object_refs =3D 1;
 	errors_found =3D 0;
=20
 	argc =3D parse_options(argc, argv, fsck_opts, fsck_usage, 0);
--=20
1.5.4.g074be


=46rom ee11f771be1ef1c29725cb56ab3eb8dfe61ca25a Mon Sep 17 00:00:00 200=
1
=46rom: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Fri, 8 Feb 2008 09:07:33 +0100
Subject: [PATCH 06/12] create a common object checker code out of fsck

The function provides a callback for reporting errors.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 fsck.c |  200 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 fsck.h |    4 +
 2 files changed, 204 insertions(+), 0 deletions(-)

diff --git a/fsck.c b/fsck.c
index 089f775..ac253ae 100644
--- a/fsck.c
+++ b/fsck.c
@@ -82,3 +82,203 @@ int fsck_walk(struct object* obj, fsck_walk_func wa=
lk, void* data)
 		return -1;
 	}
 }
+
+/*
+ * The entries in a tree are ordered in the _path_ order,
+ * which means that a directory entry is ordered by adding
+ * a slash to the end of it.
+ *
+ * So a directory called "a" is ordered _after_ a file
+ * called "a.c", because "a/" sorts after "a.c".
+ */
+#define TREE_UNORDERED (-1)
+#define TREE_HAS_DUPS  (-2)
+
+static int verify_ordered(unsigned mode1, const char *name1, unsigned =
mode2, const char *name2)
+{
+	int len1 =3D strlen(name1);
+	int len2 =3D strlen(name2);
+	int len =3D len1 < len2 ? len1 : len2;
+	unsigned char c1, c2;
+	int cmp;
+
+	cmp =3D memcmp(name1, name2, len);
+	if (cmp < 0)
+		return 0;
+	if (cmp > 0)
+		return TREE_UNORDERED;
+
+	/*
+	 * Ok, the first <len> characters are the same.
+	 * Now we need to order the next one, but turn
+	 * a '\0' into a '/' for a directory entry.
+	 */
+	c1 =3D name1[len];
+	c2 =3D name2[len];
+	if (!c1 && !c2)
+		/*
+		 * git-write-tree used to write out a nonsense tree that has
+		 * entries with the same name, one blob and one tree.  Make
+		 * sure we do not have duplicate entries.
+		 */
+		return TREE_HAS_DUPS;
+	if (!c1 && S_ISDIR(mode1))
+		c1 =3D '/';
+	if (!c2 && S_ISDIR(mode2))
+		c2 =3D '/';
+	return c1 < c2 ? 0 : TREE_UNORDERED;
+}
+
+
+static int fsck_tree(struct tree *item, int strict, fsck_error error_f=
unc)
+{
+	int retval;
+	int has_full_path =3D 0;
+	int has_empty_name =3D 0;
+	int has_zero_pad =3D 0;
+	int has_bad_modes =3D 0;
+	int has_dup_entries =3D 0;
+	int not_properly_sorted =3D 0;
+	struct tree_desc desc;
+	unsigned o_mode;
+	const char *o_name;
+	const unsigned char *o_sha1;
+
+	init_tree_desc(&desc, item->buffer, item->size);
+
+	o_mode =3D 0;
+	o_name =3D NULL;
+	o_sha1 =3D NULL;
+	if (!desc.size)
+		return error_func (&item->object, FSCK_ERROR, "empty tree");
+
+	while (desc.size) {
+		unsigned mode;
+		const char *name;
+		const unsigned char *sha1;
+
+		sha1 =3D tree_entry_extract(&desc, &name, &mode);
+
+		if (strchr(name, '/'))
+			has_full_path =3D 1;
+		if (!*name)
+			has_empty_name =3D 1;
+		has_zero_pad |=3D *(char *)desc.buffer =3D=3D '0';
+		update_tree_entry(&desc);
+
+		switch (mode) {
+		/*
+		 * Standard modes..
+		 */
+		case S_IFREG | 0755:
+		case S_IFREG | 0644:
+		case S_IFLNK:
+		case S_IFDIR:
+		case S_IFGITLINK:
+			break;
+		/*
+		 * This is nonstandard, but we had a few of these
+		 * early on when we honored the full set of mode
+		 * bits..
+		 */
+		case S_IFREG | 0664:
+			if (!strict)
+				break;
+		default:
+			has_bad_modes =3D 1;
+		}
+
+		if (o_name) {
+			switch (verify_ordered(o_mode, o_name, mode, name)) {
+			case TREE_UNORDERED:
+				not_properly_sorted =3D 1;
+				break;
+			case TREE_HAS_DUPS:
+				has_dup_entries =3D 1;
+				break;
+			default:
+				break;
+			}
+		}
+
+		o_mode =3D mode;
+		o_name =3D name;
+		o_sha1 =3D sha1;
+	}
+
+	retval =3D 0;
+	if (has_full_path) {
+		retval +=3D error_func(&item->object, FSCK_WARN, "contains full path=
names");
+	}
+	if (has_empty_name) {
+		retval +=3D error_func(&item->object, FSCK_WARN, "contains empty pat=
hname");
+	}
+	if (has_zero_pad) {
+		retval +=3D error_func(&item->object, FSCK_WARN, "contains zero-padd=
ed file modes");
+	}
+	if (has_bad_modes) {
+		retval +=3D error_func(&item->object, FSCK_WARN, "contains bad file =
modes");
+	}
+	if (has_dup_entries) {
+		retval +=3D error_func(&item->object, FSCK_ERROR, "contains duplicat=
e file entries");
+	}
+	if (not_properly_sorted) {
+		retval +=3D error_func(&item->object, FSCK_ERROR, "not properly sort=
ed");
+	}
+	return retval;
+}
+
+static int fsck_commit(struct commit *commit, fsck_error error_func)
+{
+	char *buffer =3D commit->buffer;
+	unsigned char tree_sha1[20], sha1[20];
+
+	if (!commit->date)
+		return error_func(&commit->object, FSCK_ERROR, "invalid author/commi=
tter line in %s",
+				  sha1_to_hex(commit->object.sha1));
+
+	if (memcmp(buffer, "tree ", 5))
+		return error_func(&commit->object, FSCK_ERROR, "invalid format - exp=
ected 'tree' line");
+	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] !=3D '\n')
+		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line =
format - bad sha1");
+	buffer +=3D 46;
+	while (!memcmp(buffer, "parent ", 7)) {
+		if (get_sha1_hex(buffer+7, sha1) || buffer[47] !=3D '\n')
+			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' li=
ne format - bad sha1");
+		buffer +=3D 48;
+	}
+	if (memcmp(buffer, "author ", 7))
+		return error_func(&commit->object, FSCK_ERROR, "invalid format - exp=
ected 'author' line");
+	if (!commit->tree)
+		return error_func(&commit->object, FSCK_ERROR, "could not load commi=
t's tree %s", sha1_to_hex(tree_sha1));
+
+	return 0;
+}
+
+static int fsck_tag(struct tag *tag, fsck_error error_func)
+{
+	struct object *tagged =3D tag->tagged;
+
+	if (!tagged) {
+		return error_func(&tag->object, FSCK_ERROR, "could not load tagged o=
bject");
+	}
+	return 0;
+}
+
+int fsck_object(struct object *obj, int strict, fsck_error error_func)
+{
+	if (!obj)
+		return error_func(obj, FSCK_ERROR, "no object given");
+
+	if (obj->type =3D=3D OBJ_BLOB)
+		return 0;
+	if (obj->type =3D=3D OBJ_TREE)
+		return fsck_tree((struct tree *) obj, strict, error_func);
+	if (obj->type =3D=3D OBJ_COMMIT)
+		return fsck_commit((struct commit *) obj, error_func);
+	if (obj->type =3D=3D OBJ_TAG)
+		return fsck_tag((struct tag *) obj, error_func);
+
+	return error_func(obj, FSCK_ERROR, "unknown type '%d' (internal fsck =
error)",
+			  obj->type);
+}
diff --git a/fsck.h b/fsck.h
index caeb2c9..78819d3 100644
--- a/fsck.h
+++ b/fsck.h
@@ -2,9 +2,13 @@
 #define GIT_FSCK_H
=20
 #define OBJ_ANY OBJ_BAD
+#define FSCK_ERROR 1
+#define FSCK_WARN 2
=20
 typedef int (*fsck_walk_func)(struct object* obj, int type, void* data=
);
+typedef int (*fsck_error)(struct object *obj, int type, const char *er=
r, ...);
=20
 int fsck_walk(struct object* obj, fsck_walk_func walk, void* data);
+int fsck_object(struct object *obj, int strict, fsck_error error_func)=
;
=20
 #endif
--=20
1.5.4.g074be


=46rom 22c621718c90d88c6295bd8035001451f9b7bf9d Mon Sep 17 00:00:00 200=
1
=46rom: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Fri, 8 Feb 2008 09:07:59 +0100
Subject: [PATCH 07/12] fsck: use common object checker

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |  236 ++++++------------------------------------------=
-------
 1 files changed, 26 insertions(+), 210 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index b0ca3ad..f69dc99 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -80,13 +80,13 @@ static int objerror(struct object *obj, const char =
*err, ...)
 	return -1;
 }
=20
-static int objwarning(struct object *obj, const char *err, ...)
+static int fsck_error_func(struct object *obj, int type, const char *e=
rr, ...)
 {
 	va_list params;
 	va_start(params, err);
-	objreport(obj, "warning", err, params);
+	objreport(obj, (type =3D=3D FSCK_WARN)?"warning":"error", err, params=
);
 	va_end(params);
-	return -1;
+	return (type =3D=3D FSCK_WARN)?0:1;
 }
=20
 static int check_reachable_object_childs(struct object *obj, int type,=
 void *data)
@@ -239,201 +239,6 @@ static void check_connectivity(void)
 	}
 }
=20
-/*
- * The entries in a tree are ordered in the _path_ order,
- * which means that a directory entry is ordered by adding
- * a slash to the end of it.
- *
- * So a directory called "a" is ordered _after_ a file
- * called "a.c", because "a/" sorts after "a.c".
- */
-#define TREE_UNORDERED (-1)
-#define TREE_HAS_DUPS  (-2)
-
-static int verify_ordered(unsigned mode1, const char *name1, unsigned =
mode2, const char *name2)
-{
-	int len1 =3D strlen(name1);
-	int len2 =3D strlen(name2);
-	int len =3D len1 < len2 ? len1 : len2;
-	unsigned char c1, c2;
-	int cmp;
-
-	cmp =3D memcmp(name1, name2, len);
-	if (cmp < 0)
-		return 0;
-	if (cmp > 0)
-		return TREE_UNORDERED;
-
-	/*
-	 * Ok, the first <len> characters are the same.
-	 * Now we need to order the next one, but turn
-	 * a '\0' into a '/' for a directory entry.
-	 */
-	c1 =3D name1[len];
-	c2 =3D name2[len];
-	if (!c1 && !c2)
-		/*
-		 * git-write-tree used to write out a nonsense tree that has
-		 * entries with the same name, one blob and one tree.  Make
-		 * sure we do not have duplicate entries.
-		 */
-		return TREE_HAS_DUPS;
-	if (!c1 && S_ISDIR(mode1))
-		c1 =3D '/';
-	if (!c2 && S_ISDIR(mode2))
-		c2 =3D '/';
-	return c1 < c2 ? 0 : TREE_UNORDERED;
-}
-
-static int fsck_tree(struct tree *item)
-{
-	int retval;
-	int has_full_path =3D 0;
-	int has_empty_name =3D 0;
-	int has_zero_pad =3D 0;
-	int has_bad_modes =3D 0;
-	int has_dup_entries =3D 0;
-	int not_properly_sorted =3D 0;
-	struct tree_desc desc;
-	unsigned o_mode;
-	const char *o_name;
-	const unsigned char *o_sha1;
-
-	if (verbose)
-		fprintf(stderr, "Checking tree %s\n",
-				sha1_to_hex(item->object.sha1));
-
-	init_tree_desc(&desc, item->buffer, item->size);
-
-	o_mode =3D 0;
-	o_name =3D NULL;
-	o_sha1 =3D NULL;
-	while (desc.size) {
-		unsigned mode;
-		const char *name;
-		const unsigned char *sha1;
-
-		sha1 =3D tree_entry_extract(&desc, &name, &mode);
-
-		if (strchr(name, '/'))
-			has_full_path =3D 1;
-		if (!*name)
-			has_empty_name =3D 1;
-		has_zero_pad |=3D *(char *)desc.buffer =3D=3D '0';
-		update_tree_entry(&desc);
-
-		switch (mode) {
-		/*
-		 * Standard modes..
-		 */
-		case S_IFREG | 0755:
-		case S_IFREG | 0644:
-		case S_IFLNK:
-		case S_IFDIR:
-		case S_IFGITLINK:
-			break;
-		/*
-		 * This is nonstandard, but we had a few of these
-		 * early on when we honored the full set of mode
-		 * bits..
-		 */
-		case S_IFREG | 0664:
-			if (!check_strict)
-				break;
-		default:
-			has_bad_modes =3D 1;
-		}
-
-		if (o_name) {
-			switch (verify_ordered(o_mode, o_name, mode, name)) {
-			case TREE_UNORDERED:
-				not_properly_sorted =3D 1;
-				break;
-			case TREE_HAS_DUPS:
-				has_dup_entries =3D 1;
-				break;
-			default:
-				break;
-			}
-		}
-
-		o_mode =3D mode;
-		o_name =3D name;
-		o_sha1 =3D sha1;
-	}
-
-	retval =3D 0;
-	if (has_full_path) {
-		objwarning(&item->object, "contains full pathnames");
-	}
-	if (has_empty_name) {
-		objwarning(&item->object, "contains empty pathname");
-	}
-	if (has_zero_pad) {
-		objwarning(&item->object, "contains zero-padded file modes");
-	}
-	if (has_bad_modes) {
-		objwarning(&item->object, "contains bad file modes");
-	}
-	if (has_dup_entries) {
-		retval =3D objerror(&item->object, "contains duplicate file entries"=
);
-	}
-	if (not_properly_sorted) {
-		retval =3D objerror(&item->object, "not properly sorted");
-	}
-	return retval;
-}
-
-static int fsck_commit(struct commit *commit)
-{
-	char *buffer =3D commit->buffer;
-	unsigned char tree_sha1[20], sha1[20];
-
-	if (verbose)
-		fprintf(stderr, "Checking commit %s\n",
-			sha1_to_hex(commit->object.sha1));
-
-	if (!commit->date)
-		return objerror(&commit->object, "invalid author/committer line");
-
-	if (memcmp(buffer, "tree ", 5))
-		return objerror(&commit->object, "invalid format - expected 'tree' l=
ine");
-	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] !=3D '\n')
-		return objerror(&commit->object, "invalid 'tree' line format - bad s=
ha1");
-	buffer +=3D 46;
-	while (!memcmp(buffer, "parent ", 7)) {
-		if (get_sha1_hex(buffer+7, sha1) || buffer[47] !=3D '\n')
-			return objerror(&commit->object, "invalid 'parent' line format - ba=
d sha1");
-		buffer +=3D 48;
-	}
-	if (memcmp(buffer, "author ", 7))
-		return objerror(&commit->object, "invalid format - expected 'author'=
 line");
-	if (!commit->tree)
-		return objerror(&commit->object, "could not load commit's tree %s", =
tree_sha1);
-	if (!commit->parents && show_root)
-		printf("root %s\n", sha1_to_hex(commit->object.sha1));
-	return 0;
-}
-
-static int fsck_tag(struct tag *tag)
-{
-	struct object *tagged =3D tag->tagged;
-
-	if (verbose)
-		fprintf(stderr, "Checking tag %s\n",
-			sha1_to_hex(tag->object.sha1));
-
-	if (!tagged) {
-		return objerror(&tag->object, "could not load tagged object");
-	}
-	if (!show_tags)
-		return 0;
-
-	printf("tagged %s %s", typename(tagged->type), sha1_to_hex(tagged->sh=
a1));
-	printf(" (%s) in %s\n", tag->tag, sha1_to_hex(tag->object.sha1));
-	return 0;
-}
-
 static int fsck_sha1(const unsigned char *sha1)
 {
 	struct object *obj =3D parse_object(sha1);
@@ -445,19 +250,30 @@ static int fsck_sha1(const unsigned char *sha1)
 	if (obj->flags & SEEN)
 		return 0;
 	obj->flags |=3D SEEN;
+
+	if (verbose)
+		fprintf(stderr, "Checking %s %s\n",
+			typename(obj->type), sha1_to_hex(obj->sha1));
+
 	fsck_walk (obj, mark_used, 0);
-	if (obj->type =3D=3D OBJ_BLOB)
-		return 0;
-	if (obj->type =3D=3D OBJ_TREE)
-		return fsck_tree((struct tree *) obj);
-	if (obj->type =3D=3D OBJ_COMMIT)
-		return fsck_commit((struct commit *) obj);
-	if (obj->type =3D=3D OBJ_TAG)
-		return fsck_tag((struct tag *) obj);
-
-	/* By now, parse_object() would've returned NULL instead. */
-	return objerror(obj, "unknown type '%d' (internal fsck error)",
-			obj->type);
+	if (fsck_object (obj, check_strict, fsck_error_func))
+		return -1;
+
+	if (obj->type =3D=3D OBJ_COMMIT) {
+		struct commit *commit =3D (struct commit*) obj;
+		if (!commit->parents && show_root)
+			printf("root %s\n", sha1_to_hex(commit->object.sha1));
+	}
+
+	if (obj->type =3D=3D OBJ_TAG) {
+		struct tag *tag =3D (struct tag*) obj;
+		if (show_tags  && tag->tagged) {
+			printf("tagged %s %s", typename(tag->tagged->type), sha1_to_hex(tag=
->tagged->sha1));
+			printf(" (%s) in %s\n", tag->tag, sha1_to_hex(tag->object.sha1));
+		}
+	}
+
+	return 0;
 }
=20
 /*
--=20
1.5.4.g074be


=46rom 09938f28e230a236dc48014ace6c8ed02ad33084 Mon Sep 17 00:00:00 200=
1
=46rom: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Fri, 8 Feb 2008 09:08:45 +0100
Subject: [PATCH 08/12] add common fsck error printing function

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 fsck.c |   30 ++++++++++++++++++++++++++++++
 fsck.h |    2 ++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/fsck.c b/fsck.c
index ac253ae..07e48a8 100644
--- a/fsck.c
+++ b/fsck.c
@@ -282,3 +282,33 @@ int fsck_object(struct object *obj, int strict, fs=
ck_error error_func)
 	return error_func(obj, FSCK_ERROR, "unknown type '%d' (internal fsck =
error)",
 			  obj->type);
 }
+
+int fsck_error_function(struct object *obj, int type, const char* fmt,=
 ...)
+{
+	va_list ap;
+	int len;
+	struct strbuf sb;
+=09
+	strbuf_init(&sb, 0);
+	strbuf_addf(&sb, "object %s:", sha1_to_hex(obj->sha1));
+=09
+	va_start(ap, fmt);
+	len =3D vsnprintf(sb.buf + sb.len, strbuf_avail(&sb), fmt, ap);
+	va_end(ap);
+=09
+	if (len < 0)
+		len =3D 0;
+	if (len >=3D strbuf_avail(&sb)) {
+		strbuf_grow(&sb, len + 2);
+		va_start(ap, fmt);
+		len =3D vsnprintf(sb.buf + sb.len, strbuf_avail(&sb), fmt, ap);
+		va_end(ap);
+		if (len >=3D strbuf_avail(&sb)) {
+			die("this should not happen, your snprintf is broken");
+		}
+	}
+=09
+	error(sb.buf);
+	strbuf_release(&sb);
+	return 1;
+}
diff --git a/fsck.h b/fsck.h
index 78819d3..f13631c 100644
--- a/fsck.h
+++ b/fsck.h
@@ -8,6 +8,8 @@
 typedef int (*fsck_walk_func)(struct object* obj, int type, void* data=
);
 typedef int (*fsck_error)(struct object *obj, int type, const char *er=
r, ...);
=20
+int fsck_error_function(struct object *obj, int type, const char* fmt,=
 ...);
+
 int fsck_walk(struct object* obj, fsck_walk_func walk, void* data);
 int fsck_object(struct object *obj, int strict, fsck_error error_func)=
;
=20
--=20
1.5.4.g074be


=46rom a8db4e754e717bac0b2462333d4145eac3452099 Mon Sep 17 00:00:00 200=
1
=46rom: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Fri, 8 Feb 2008 09:14:14 +0100
Subject: [PATCH 09/12] unpack-objects: prevent writing of inconsistent =
objects

This patch introduces a strict mode, which ensures that:
- no malformed object will be written
- no object with broken links will be written

The patch ensures this by delaying the write of all non blob object.
These object are written, after all objects they link to are written.

An error can only result in unreferenced objects.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 Documentation/git-unpack-objects.txt |    3 +
 builtin-unpack-objects.c             |   99 ++++++++++++++++++++++++++=
+++++---
 2 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-u=
npack-objects.txt
index b79be3f..3697896 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -40,6 +40,9 @@ OPTIONS
 	and make the best effort to recover as many objects as
 	possible.
=20
+--strict::
+	Don't write objects with broken content or links.
+
=20
 Author
 ------
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index f18c7e8..3e906e4 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -7,11 +7,13 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree.h"
+#include "tree-walk.h"
 #include "progress.h"
 #include "decorate.h"
+#include "fsck.h"
=20
-static int dry_run, quiet, recover, has_errors;
-static const char unpack_usage[] =3D "git-unpack-objects [-n] [-q] [-r=
] < pack-file";
+static int dry_run, quiet, recover, has_errors, strict;
+static const char unpack_usage[] =3D "git-unpack-objects [-n] [-q] [-r=
] [--strict] < pack-file";
=20
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
@@ -144,9 +146,58 @@ static void add_delta_to_list(unsigned nr, unsigne=
d const char *base_sha1,
 struct obj_info {
 	off_t offset;
 	unsigned char sha1[20];
+	struct object * obj;
 };
=20
+#define FLAG_OPEN (1u<<20)
+#define FLAG_WRITTEN (1u<<21)
+
 static struct obj_info *obj_list;
+unsigned nr_objects;
+
+static void write_cached_object(struct object* obj)
+{
+	unsigned char sha1[20];
+	struct obj_buffer *obj_buf =3D lookup_object_buffer(obj);
+	if (write_sha1_file(obj_buf->buffer, obj_buf->size, typename(obj->typ=
e), sha1) < 0)
+		die("failed to write object %s", sha1_to_hex(obj->sha1));
+	obj->flags |=3D FLAG_WRITTEN;
+}
+
+static int check_object(struct object* obj, int type, void *data)
+{
+	if (!obj)
+		return 0;
+=09
+	if (obj->flags & FLAG_WRITTEN)
+		return 1;
+=09
+	if (type !=3D OBJ_ANY && obj->type !=3D type)
+		die("object type mismatch");
+=09
+	if (!(obj->flags & FLAG_OPEN)) {
+		unsigned long size;
+		int type =3D sha1_object_info (obj->sha1, &size);
+		if (type !=3D obj->type || type <=3D 0)
+			die("object of unexpected type");
+		obj->flags |=3D FLAG_WRITTEN;
+		return 1;
+	}
+=09
+	if (fsck_object(obj, 1, fsck_error_function))
+	  die("Error in object");
+	if(!fsck_walk(obj, check_object, 0))
+		die("Error on reachable objects of %s", sha1_to_hex (obj->sha1));
+	write_cached_object(obj);
+	return 1;
+}
+
+static void write_rest()
+{
+	unsigned i;
+	for (i =3D 0; i < nr_objects; i++)
+		check_object(obj_list[i].obj, OBJ_ANY, 0);
+}
=20
 static void added_object(unsigned nr, enum object_type type,
 			 void *data, unsigned long size);
@@ -154,9 +205,35 @@ static void added_object(unsigned nr, enum object_=
type type,
 static void write_object(unsigned nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
-	if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0=
)
-		die("failed to write object");
 	added_object(nr, type, buf, size);
+	if (!strict) {
+		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < =
0)
+			die("failed to write object");
+		free(buf);
+		obj_list[nr].obj =3D 0;
+	} else if (type =3D=3D OBJ_BLOB) {
+		struct blob * blob;
+		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < =
0)
+			die("failed to write object");
+		free(buf);
+
+		blob =3D lookup_blob (obj_list[nr].sha1);
+		if (blob)
+			blob->object.flags |=3D FLAG_WRITTEN;
+		else
+			die("invalid blob object");
+		obj_list[nr].obj =3D 0;
+	} else {
+		struct object * obj;
+		int eaten;
+		hash_sha1_file(buf, size, typename(type), obj_list[nr].sha1);
+		obj =3D parse_object_buffer(obj_list[nr].sha1, type, size, buf, &eat=
en);
+		if (!obj)
+			die ("invalid %s", typename(type));
+		add_object_buffer (obj, buf, size);
+		obj->flags |=3D FLAG_OPEN;
+		obj_list[nr].obj =3D obj;
+	}
 }
=20
 static void resolve_delta(unsigned nr, enum object_type type,
@@ -173,7 +250,6 @@ static void resolve_delta(unsigned nr, enum object_=
type type,
 		die("failed to apply delta");
 	free(delta);
 	write_object(nr, type, result, result_size);
-	free(result);
 }
=20
 static void added_object(unsigned nr, enum object_type type,
@@ -203,7 +279,8 @@ static void unpack_non_delta_entry(enum object_type=
 type, unsigned long size,
=20
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
-	free(buf);
+	else if (buf)
+		free(buf);
 }
=20
 static void unpack_delta_entry(enum object_type type, unsigned long de=
lta_size,
@@ -345,7 +422,8 @@ static void unpack_all(void)
 	int i;
 	struct progress *progress =3D NULL;
 	struct pack_header *hdr =3D fill(sizeof(struct pack_header));
-	unsigned nr_objects =3D ntohl(hdr->hdr_entries);
+
+	nr_objects =3D ntohl(hdr->hdr_entries);
=20
 	if (ntohl(hdr->hdr_signature) !=3D PACK_SIGNATURE)
 		die("bad pack file");
@@ -356,6 +434,7 @@ static void unpack_all(void)
 	if (!quiet)
 		progress =3D start_progress("Unpacking objects", nr_objects);
 	obj_list =3D xmalloc(nr_objects * sizeof(*obj_list));
+	memset(obj_list, 0, nr_objects * sizeof(*obj_list));
 	for (i =3D 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
@@ -391,6 +470,10 @@ int cmd_unpack_objects(int argc, const char **argv=
, const char *prefix)
 				recover =3D 1;
 				continue;
 			}
+			if (!strcmp(arg, "--strict")) {
+				strict =3D 1;
+				continue;
+			}
 			if (!prefixcmp(arg, "--pack_header=3D")) {
 				struct pack_header *hdr;
 				char *c;
@@ -416,6 +499,8 @@ int cmd_unpack_objects(int argc, const char **argv,=
 const char *prefix)
 	unpack_all();
 	SHA1_Update(&ctx, buffer, offset);
 	SHA1_Final(sha1, &ctx);
+	if (strict)
+		write_rest();
 	if (hashcmp(fill(20), sha1))
 		die("final sha1 did not match");
 	use(20);
--=20
1.5.4.g074be


=46rom e2c4a69caeb7650a2655db864827879a0eea701f Mon Sep 17 00:00:00 200=
1
=46rom: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Fri, 8 Feb 2008 09:16:05 +0100
Subject: [PATCH 10/12] index-pack: introduce checking mode

Adds strict option, which bails out if the pack would
introduces broken object or links in the repository.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 Documentation/git-index-pack.txt |    3 +
 index-pack.c                     |   78 ++++++++++++++++++++++++++++++=
+++++--
 2 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index=
-pack.txt
index 72b5d00..a7825b6 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -75,6 +75,9 @@ OPTIONS
 	to force the version for the generated pack index, and to force
 	64-bit index entries on objects located above the given offset.
=20
+--strict::
+	Die, if the pack contains broken objects or links.
+
=20
 Note
 ----
diff --git a/index-pack.c b/index-pack.c
index 9fd6982..bde0249 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -7,9 +7,10 @@
 #include "tag.h"
 #include "tree.h"
 #include "progress.h"
+#include "fsck.h"
=20
 static const char index_pack_usage[] =3D
-"git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=3D<msg> }] =
{ <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
+"git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=3D<msg> }] =
[--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
=20
 struct object_entry
 {
@@ -18,6 +19,7 @@ struct object_entry
 	unsigned int hdr_size;
 	enum object_type type;
 	enum object_type real_type;
+	struct object *obj;
 };
=20
 union delta_base {
@@ -31,6 +33,9 @@ union delta_base {
  */
 #define UNION_BASE_SZ	20
=20
+#define FLAG_OPEN (1u<<20)
+#define FLAG_WRITTEN (1u<<21)
+
 struct delta_entry
 {
 	union delta_base base;
@@ -44,6 +49,7 @@ static int nr_deltas;
 static int nr_resolved_deltas;
=20
 static int from_stdin;
+static int strict;
 static int verbose;
=20
 static struct progress *progress;
@@ -56,6 +62,41 @@ static SHA_CTX input_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
=20
+static int check_object(struct object* obj, int type, void *data)
+{
+	if (!obj)
+		return 0;
+=09
+	if (obj->flags & FLAG_WRITTEN)
+		return 1;
+=09
+	if (type !=3D OBJ_ANY && obj->type !=3D type)
+		die("object type mismatch");
+=09
+	if (!(obj->flags & FLAG_OPEN)) {
+		unsigned long size;
+		int type =3D sha1_object_info (obj->sha1, &size);
+		if (type !=3D obj->type || type <=3D 0)
+			die("object of unexpected type");
+		obj->flags |=3D FLAG_WRITTEN;
+		return 1;
+	}
+=09
+	if (fsck_object(obj, 1, fsck_error_function))
+	  die("Error in object");
+	if(!fsck_walk(obj, check_object, 0))
+		die("Error on reachable objects of %s", sha1_to_hex (obj->sha1));
+	return 1;
+}
+
+static void check_objects()
+{
+	unsigned i;
+	for (i =3D 0; i < nr_objects; i++)
+		check_object(objects[i].obj, OBJ_ANY, 0);
+}
+
+
 /* Discard current buffer used content. */
 static void flush(void)
 {
@@ -325,8 +366,8 @@ static int find_delta_children(const union delta_ba=
se *base,
 	return 0;
 }
=20
-static void sha1_object(const void *data, unsigned long size,
-			enum object_type type, unsigned char *sha1)
+static struct object* sha1_object(const void *data, unsigned long size=
,
+				  enum object_type type, unsigned char *sha1)
 {
 	hash_sha1_file(data, size, typename(type), sha1);
 	if (has_sha1_file(sha1)) {
@@ -341,6 +382,29 @@ static void sha1_object(const void *data, unsigned=
 long size,
 			die("SHA1 COLLISION FOUND WITH %s !", sha1_to_hex(sha1));
 		free(has_data);
 	}
+	if (strict) {
+		if (type =3D=3D OBJ_BLOB) {
+			struct blob * blob =3D lookup_blob(sha1);
+			if (blob)
+				blob->object.flags |=3D FLAG_WRITTEN;
+			else
+				die("invalid blob object %s", sha1_to_hex(sha1));
+			return (struct object*)blob;
+		} else {
+			struct object * obj;
+			int eaten;
+			void *buf =3D xmemdupz(data, size);
+		=09
+			obj =3D parse_object_buffer(sha1, type, size, buf, &eaten);
+			if (!obj)
+				die ("invalid %s", typename(type));
+			if(!eaten)
+				free(buf);
+			obj->flags |=3D FLAG_OPEN;
+			return obj;
+		}
+	}
+	return NULL;
 }
=20
 static void resolve_delta(struct object_entry *delta_obj, void *base_d=
ata,
@@ -361,7 +425,7 @@ static void resolve_delta(struct object_entry *delt=
a_obj, void *base_data,
 	free(delta_data);
 	if (!result)
 		bad_object(delta_obj->idx.offset, "failed to apply delta");
-	sha1_object(result, result_size, type, delta_obj->idx.sha1);
+	delta_obj->obj =3D sha1_object(result, result_size, type, delta_obj->=
idx.sha1);
 	nr_resolved_deltas++;
=20
 	hashcpy(delta_base.sha1, delta_obj->idx.sha1);
@@ -420,7 +484,7 @@ static void parse_pack_objects(unsigned char *sha1)
 			delta->obj_no =3D i;
 			delta++;
 		} else
-			sha1_object(data, obj->size, obj->type, obj->idx.sha1);
+			obj->obj =3D sha1_object(data, obj->size, obj->type, obj->idx.sha1)=
;
 		free(data);
 		display_progress(progress, i+1);
 	}
@@ -714,6 +778,8 @@ int main(int argc, char **argv)
 				from_stdin =3D 1;
 			} else if (!strcmp(arg, "--fix-thin")) {
 				fix_thin_pack =3D 1;
+			} else if (!strcmp(arg, "--strict")) {
+				strict =3D 1;
 			} else if (!strcmp(arg, "--keep")) {
 				keep_msg =3D "";
 			} else if (!prefixcmp(arg, "--keep=3D")) {
@@ -812,6 +878,8 @@ int main(int argc, char **argv)
 			    nr_deltas - nr_resolved_deltas);
 	}
 	free(deltas);
+	if (strict)
+		check_objects();
=20
 	idx_objects =3D xmalloc((nr_objects) * sizeof(struct pack_idx_entry *=
));
 	for (i =3D 0; i < nr_objects; i++)
--=20
1.5.4.g074be


=46rom a992fadf4014830315d7b5053dc633c2c566ae44 Mon Sep 17 00:00:00 200=
1
=46rom: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Sat, 9 Feb 2008 18:17:56 +0100
Subject: [PATCH 11/12] receive-pack: use strict mode for unpacking obje=
cts

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 Documentation/config.txt |    6 ++++++
 receive-pack.c           |   36 +++++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 530a6a8..d5b7698 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -909,6 +909,12 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
=20
+receive.fsckObjects::
+	If it is set to true, git-receive-pack will check all received=20
+	objects. It will abort in the case of a malformed object or a=20
+	broken link. The result of an abort are only dangling objects.
+	The default value is false.
+
 receive.unpackLimit::
 	If the number of objects received in a push is below this
 	limit then the objects will be unpacked into loose object
diff --git a/receive-pack.c b/receive-pack.c
index 3267495..7136f35 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -10,6 +10,7 @@
 static const char receive_pack_usage[] =3D "git-receive-pack <git-dir>=
";
=20
 static int deny_non_fast_forwards =3D 0;
+static int receive_fsck_objects =3D 0;
 static int receive_unpack_limit =3D -1;
 static int transfer_unpack_limit =3D -1;
 static int unpack_limit =3D 100;
@@ -35,6 +36,11 @@ static int receive_pack_config(const char *var, cons=
t char *value)
 		return 0;
 	}
=20
+	if (strcmp(var, "receive.fsckobjects") =3D=3D 0) {
+		receive_fsck_objects =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value);
 }
=20
@@ -367,11 +373,13 @@ static const char *unpack(void)
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
=20
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
-		int code;
-		const char *unpacker[3];
-		unpacker[0] =3D "unpack-objects";
-		unpacker[1] =3D hdr_arg;
-		unpacker[2] =3D NULL;
+		int code, i =3D 0;
+		const char *unpacker[4];
+		unpacker[i++] =3D "unpack-objects";
+		if (receive_fsck_objects)
+			unpacker[i++] =3D "--strict";
+		unpacker[i++] =3D hdr_arg;
+		unpacker[i++] =3D NULL;
 		code =3D run_command_v_opt(unpacker, RUN_GIT_CMD);
 		switch (code) {
 		case 0:
@@ -392,8 +400,8 @@ static const char *unpack(void)
 			return "unpacker exited with error code";
 		}
 	} else {
-		const char *keeper[6];
-		int s, status;
+		const char *keeper[7];
+		int s, status, i =3D 0;
 		char keep_arg[256];
 		struct child_process ip;
=20
@@ -401,12 +409,14 @@ static const char *unpack(void)
 		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
 			strcpy(keep_arg + s, "localhost");
=20
-		keeper[0] =3D "index-pack";
-		keeper[1] =3D "--stdin";
-		keeper[2] =3D "--fix-thin";
-		keeper[3] =3D hdr_arg;
-		keeper[4] =3D keep_arg;
-		keeper[5] =3D NULL;
+		keeper[i++] =3D "index-pack";
+		keeper[i++] =3D "--stdin";
+		if (receive_fsck_objects)
+			keeper[i++] =3D "--strict";
+		keeper[i++] =3D "--fix-thin";
+		keeper[i++] =3D hdr_arg;
+		keeper[i++] =3D keep_arg;
+		keeper[i++] =3D NULL;
 		memset(&ip, 0, sizeof(ip));
 		ip.argv =3D keeper;
 		ip.out =3D -1;
--=20
1.5.4.g074be


=46rom c39a307f2f6f551d967cbc9fb502de7cad8beae6 Mon Sep 17 00:00:00 200=
1
=46rom: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Sat, 9 Feb 2008 18:18:41 +0100
Subject: [PATCH 12/12] Remove unused object-ref code

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 Makefile               |    2 +-
 builtin-fetch-pack.c   |    1 -
 builtin-pack-objects.c |    1 -
 builtin-rev-list.c     |    1 -
 commit.c               |   11 ------
 object-refs.c          |   87 ----------------------------------------=
--------
 object.h               |    8 ----
 tag.c                  |    6 ---
 tree.c                 |   48 --------------------------
 upload-pack.c          |    1 -
 walker.c               |    1 -
 11 files changed, 1 insertions(+), 166 deletions(-)
 delete mode 100644 object-refs.c

diff --git a/Makefile b/Makefile
index 0921484..268b8dd 100644
--- a/Makefile
+++ b/Makefile
@@ -316,7 +316,7 @@ LIB_OBJS =3D \
 	patch-ids.o \
 	object.o pack-check.o pack-write.o patch-delta.o path.o pkt-line.o \
 	sideband.o reachable.o reflog-walk.o \
-	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
+	quote.o read-cache.o refs.o run-command.o dir.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	revision.o pager.o tree-walk.o xdiff-interface.o \
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index f401352..25f1915 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -386,7 +386,6 @@ static int everything_local(struct ref **refs, int =
nr_match, char **match)
 	int retval;
 	unsigned long cutoff =3D 0;
=20
-	track_object_refs =3D 0;
 	save_commit_buffer =3D 0;
=20
 	for (ref =3D *refs; ref; ref =3D ref->next) {
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d3efeff..6f8f388 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2009,7 +2009,6 @@ static void get_object_list(int ac, const char **=
av)
=20
 	init_revisions(&revs, NULL);
 	save_commit_buffer =3D 0;
-	track_object_refs =3D 0;
 	setup_revisions(ac, av, &revs, NULL);
=20
 	while (fgets(line, sizeof(line), stdin) !=3D NULL) {
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index de80158..14e86ce 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -605,7 +605,6 @@ int cmd_rev_list(int argc, const char **argv, const=
 char *prefix)
 		usage(rev_list_usage);
=20
 	save_commit_buffer =3D revs.verbose_header || revs.grep_filter;
-	track_object_refs =3D 0;
 	if (bisect_list)
 		revs.limited =3D 1;
=20
diff --git a/commit.c b/commit.c
index 8b8fb04..df4d331 100644
--- a/commit.c
+++ b/commit.c
@@ -290,17 +290,6 @@ int parse_commit_buffer(struct commit *item, void =
*buffer, unsigned long size)
 	}
 	item->date =3D parse_commit_date(bufptr, tail);
=20
-	if (track_object_refs) {
-		unsigned i =3D 0;
-		struct commit_list *p;
-		struct object_refs *refs =3D alloc_object_refs(n_refs);
-		if (item->tree)
-			refs->ref[i++] =3D &item->tree->object;
-		for (p =3D item->parents; p; p =3D p->next)
-			refs->ref[i++] =3D &p->item->object;
-		set_object_refs(&item->object, refs);
-	}
-
 	return 0;
 }
=20
diff --git a/object-refs.c b/object-refs.c
deleted file mode 100644
index 5345671..0000000
--- a/object-refs.c
+++ /dev/null
@@ -1,87 +0,0 @@
-#include "cache.h"
-#include "object.h"
-#include "decorate.h"
-
-int track_object_refs =3D 0;
-
-static struct decoration ref_decorate;
-
-struct object_refs *lookup_object_refs(struct object *base)
-{
-	return lookup_decoration(&ref_decorate, base);
-}
-
-static void add_object_refs(struct object *obj, struct object_refs *re=
fs)
-{
-	if (add_decoration(&ref_decorate, obj, refs))
-		die("object %s tried to add refs twice!", sha1_to_hex(obj->sha1));
-}
-
-struct object_refs *alloc_object_refs(unsigned count)
-{
-	struct object_refs *refs;
-	size_t size =3D sizeof(*refs) + count*sizeof(struct object *);
-
-	refs =3D xcalloc(1, size);
-	refs->count =3D count;
-	return refs;
-}
-
-static int compare_object_pointers(const void *a, const void *b)
-{
-	const struct object * const *pa =3D a;
-	const struct object * const *pb =3D b;
-	if (*pa =3D=3D *pb)
-		return 0;
-	else if (*pa < *pb)
-		return -1;
-	else
-		return 1;
-}
-
-void set_object_refs(struct object *obj, struct object_refs *refs)
-{
-	unsigned int i, j;
-
-	/* Do not install empty list of references */
-	if (refs->count < 1) {
-		free(refs);
-		return;
-	}
-
-	/* Sort the list and filter out duplicates */
-	qsort(refs->ref, refs->count, sizeof(refs->ref[0]),
-	      compare_object_pointers);
-	for (i =3D j =3D 1; i < refs->count; i++) {
-		if (refs->ref[i] !=3D refs->ref[i - 1])
-			refs->ref[j++] =3D refs->ref[i];
-	}
-	if (j < refs->count) {
-		/* Duplicates were found - reallocate list */
-		size_t size =3D sizeof(*refs) + j*sizeof(struct object *);
-		refs->count =3D j;
-		refs =3D xrealloc(refs, size);
-	}
-
-	for (i =3D 0; i < refs->count; i++)
-		refs->ref[i]->used =3D 1;
-	add_object_refs(obj, refs);
-}
-
-void mark_reachable(struct object *obj, unsigned int mask)
-{
-	const struct object_refs *refs;
-
-	if (!track_object_refs)
-		die("cannot do reachability with object refs turned off");
-	/* If we've been here already, don't bother */
-	if (obj->flags & mask)
-		return;
-	obj->flags |=3D mask;
-	refs =3D lookup_object_refs(obj);
-	if (refs) {
-		unsigned i;
-		for (i =3D 0; i < refs->count; i++)
-			mark_reachable(refs->ref[i], mask);
-	}
-}
diff --git a/object.h b/object.h
index 397bbfa..036bd66 100644
--- a/object.h
+++ b/object.h
@@ -35,14 +35,11 @@ struct object {
 	unsigned char sha1[20];
 };
=20
-extern int track_object_refs;
-
 extern const char *typename(unsigned int type);
 extern int type_from_string(const char *str);
=20
 extern unsigned int get_max_object_index(void);
 extern struct object *get_indexed_object(unsigned int);
-extern struct object_refs *lookup_object_refs(struct object *);
=20
 /** Internal only **/
 struct object *lookup_object(const unsigned char *sha1);
@@ -61,11 +58,6 @@ struct object *parse_object_buffer(const unsigned ch=
ar *sha1, enum object_type t
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
=20
-struct object_refs *alloc_object_refs(unsigned count);
-void set_object_refs(struct object *obj, struct object_refs *refs);
-
-void mark_reachable(struct object *obj, unsigned int mask);
-
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
=20
diff --git a/tag.c b/tag.c
index 38bf913..d19f56d 100644
--- a/tag.c
+++ b/tag.c
@@ -84,12 +84,6 @@ int parse_tag_buffer(struct tag *item, void *data, u=
nsigned long size)
 		item->tagged =3D NULL;
 	}
=20
-	if (item->tagged && track_object_refs) {
-		struct object_refs *refs =3D alloc_object_refs(1);
-		refs->ref[0] =3D item->tagged;
-		set_object_refs(&item->object, refs);
-	}
-
 	return 0;
 }
=20
diff --git a/tree.c b/tree.c
index 87708ef..4b1825c 100644
--- a/tree.c
+++ b/tree.c
@@ -202,52 +202,6 @@ struct tree *lookup_tree(const unsigned char *sha1=
)
 	return (struct tree *) obj;
 }
=20
-/*
- * NOTE! Tree refs to external git repositories
- * (ie gitlinks) do not count as real references.
- *
- * You don't have to have those repositories
- * available at all, much less have the objects
- * accessible from the current repository.
- */
-static void track_tree_refs(struct tree *item)
-{
-	int n_refs =3D 0, i;
-	struct object_refs *refs;
-	struct tree_desc desc;
-	struct name_entry entry;
-
-	/* Count how many entries there are.. */
-	init_tree_desc(&desc, item->buffer, item->size);
-	while (tree_entry(&desc, &entry)) {
-		if (S_ISGITLINK(entry.mode))
-			continue;
-		n_refs++;
-	}
-
-	/* Allocate object refs and walk it again.. */
-	i =3D 0;
-	refs =3D alloc_object_refs(n_refs);
-	init_tree_desc(&desc, item->buffer, item->size);
-	while (tree_entry(&desc, &entry)) {
-		struct object *obj;
-
-		if (S_ISGITLINK(entry.mode))
-			continue;
-		if (S_ISDIR(entry.mode))
-			obj =3D &lookup_tree(entry.sha1)->object;
-		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode))
-			obj =3D &lookup_blob(entry.sha1)->object;
-		else {
-			warning("in tree %s: entry %s has bad mode %.6o\n",
-			     sha1_to_hex(item->object.sha1), entry.path, entry.mode);
-			obj =3D lookup_unknown_object(entry.sha1);
-		}
-		refs->ref[i++] =3D obj;
-	}
-	set_object_refs(&item->object, refs);
-}
-
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long s=
ize)
 {
 	if (item->object.parsed)
@@ -256,8 +210,6 @@ int parse_tree_buffer(struct tree *item, void *buff=
er, unsigned long size)
 	item->buffer =3D buffer;
 	item->size =3D size;
=20
-	if (track_object_refs)
-		track_tree_refs(item);
 	return 0;
 }
=20
diff --git a/upload-pack.c b/upload-pack.c
index 7e04311..b2828ab 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -392,7 +392,6 @@ static int get_common_commits(void)
 	char hex[41], last_hex[41];
 	int len;
=20
-	track_object_refs =3D 0;
 	save_commit_buffer =3D 0;
=20
 	for(;;) {
diff --git a/walker.c b/walker.c
index adc3e80..c10eca8 100644
--- a/walker.c
+++ b/walker.c
@@ -256,7 +256,6 @@ int walker_fetch(struct walker *walker, int targets=
, char **target,
 	int i;
=20
 	save_commit_buffer =3D 0;
-	track_object_refs =3D 0;
=20
 	for (i =3D 0; i < targets; i++) {
 		if (!write_ref || !write_ref[i])
--=20
1.5.4.g074be
