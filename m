From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: RFC: [PATCH] Support incremental pack files
Date: Fri, 23 Feb 2007 08:13:44 +0100
Message-ID: <20070223071344.GA21107@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 23 08:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKUcy-0007Vn-GG
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 08:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbXBWHNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Feb 2007 02:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbXBWHNs
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 02:13:48 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:57296 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbXBWHNr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 02:13:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 592006800672
	for <git@vger.kernel.org>; Fri, 23 Feb 2007 08:13:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YQMxDJqIzA2K for <git@vger.kernel.org>;
	Fri, 23 Feb 2007 08:13:44 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 95D6B6800654; Fri, 23 Feb 2007 08:13:44 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40420>

With CVS (or RCS), commiting a version, increases the required storage
only by the size of the diff.

Commiting a new version in GIT increases the storage by the compressed
size of each changed blob. Packing all unpacked objects decreases the
required storage, but does not generate deltas against objects in
packs. You need to repack all objects to get around this.

=46or normal source code, this is not a problem.  But if you want to us=
e
git for big files, you waste storage (or CPU time for everything
repacking).

The follwing patch (again git-1.5.0-rc3) is a prototyp for supporting
incremental pack files in git. The file structures are not changed.
It only permits, that the base commit of a delta is located in a
different pack or as unpacked object.

Changes:=20

* in sha1_file get_delta_base returns offset 0, if the delta base
object is not the same pack. Additionally it stores the sha1 of it in
a parameter. unpack_delta_entry and packed_delta_info are changed, so
that they search such a blob in other packs or as sha1
file. packed_object_info_detail stops searching, if the delta base
object is not in the same pack.

* to builtin-pack-objects.c a loop detector is added (flag
loop_check).  When adding a excluded object (=3D preferred base), its
position in the pack file is added, if it is in pack.

If a preferred base object is in a pack, it checks, if it is a delta.
If so, it locates the base object and stores it in ->delta. If it was
not in the object list, the base object gets added with a exclude
value of 2 and it is recusivly check the base object in the same way
(check_preferred_object).

try_delta refuses to produce a delta, if a loop would be created or if
the base object was added by check_preferred_object.

* mark_edges_unparsed travers all commit list for not parsed parent
commit objects. They are used as heuristic to create a list of
suiteable base object for building the delta.

With the patch, you can eg. pack all unpacked object with a command lin=
k like
git-pack-objects --non-empty --all --reflog --unpacked --incremental --=
base-parent

I see the following problems:
* fetching an incremental pack file over HTTP
* reusing a incremental pack file via reuse_cached_pack in builtin-pack=
-objects.c

mfg Martin K=F6gler

--- builtin-pack-objects.c.orig	2007-02-22 22:11:11.287809817 +0100
+++ builtin-pack-objects.c	2007-02-22 22:11:22.694525976 +0100
@@ -16,7 +16,7 @@
 static const char pack_usage[] =3D "\
 git-pack-objects [{ -q | --progress | --all-progress }] \n\
 	[--local] [--incremental] [--window=3DN] [--depth=3DN] \n\
-	[--no-reuse-delta] [--delta-base-offset] [--non-empty] \n\
+	[--no-reuse-delta] [--delta-base-offset] [--non-empty] [--base-parent=
] \n\
 	[--revs [--unpacked | --all]*] [--reflog] [--stdout | base-name] \n\
 	[<ref-list | <object-list]";
=20
@@ -65,6 +65,8 @@
 static int local;
 static int incremental;
 static int allow_ofs_delta;
+static int base_parent;
+static int loop_check;
=20
 static struct object_entry **sorted_by_sha, **sorted_by_type;
 static struct object_entry *objects;
@@ -692,6 +694,19 @@
 			}
 		}
 	}
+
+	if (loop_check && exclude) {
+		for (p =3D packed_git; p; p =3D p->next) {
+			unsigned long offset =3D find_pack_entry_one(sha1, p);
+			if (offset) {
+				if (!found_pack) {
+					found_offset =3D offset;
+					found_pack =3D p;
+				}
+			}
+		}
+	}
+
 	if ((entry =3D locate_object_entry(sha1)) !=3D NULL)
 		goto already_added;
=20
@@ -722,13 +737,13 @@
 		progress_update =3D 0;
 	}
 	if (exclude)
-		entry->preferred_base =3D 1;
-	else {
-		if (found_pack) {
-			entry->in_pack =3D found_pack;
-			entry->in_pack_offset =3D found_offset;
-		}
+	    entry->preferred_base =3D exclude;
+
+	if (found_pack) {
+	    entry->in_pack =3D found_pack;
+	    entry->in_pack_offset =3D found_offset;
 	}
+
 	return status;
 }
=20
@@ -976,6 +991,78 @@
 	it->pcache.tree_size =3D size;
 }
=20
+static void check_preferred_object(struct object_entry *entry)
+{
+    struct packed_git *p =3D entry->in_pack;
+    struct pack_window *w_curs =3D NULL;
+    unsigned long size, used;
+    unsigned char *buf;
+    unsigned long left =3D p->pack_size - entry->in_pack_offset;
+    struct object_entry *base_entry =3D NULL;
+    unsigned hash;
+
+    if (!p || !entry->preferred_base)
+	return;
+
+    buf =3D use_pack(p, &w_curs, entry->in_pack_offset, NULL);
+   =20
+    used =3D unpack_object_header_gently(buf, left,
+				       &entry->in_pack_type, &size);
+
+    unsigned char c, *base_name;
+    unsigned long ofs;
+    unsigned long used_0;
+    /* there is at least 20 bytes left in the pack */
+    switch (entry->in_pack_type) {
+	case OBJ_REF_DELTA:
+	    base_name =3D use_pack(p, &w_curs,
+				 entry->in_pack_offset + used, NULL);
+	    used +=3D 20;
+	    break;
+	case OBJ_OFS_DELTA:
+	    buf =3D use_pack(p, &w_curs,
+			   entry->in_pack_offset + used, NULL);
+	    used_0 =3D 0;
+	    c =3D buf[used_0++];
+	    ofs =3D c & 127;
+	    while (c & 128) {
+		ofs +=3D 1;
+		if (!ofs || ofs & ~(~0UL >> 7))
+		    die("delta base offset overflow in pack for %s",
+			sha1_to_hex(entry->sha1));
+		c =3D buf[used_0++];
+		ofs =3D (ofs << 7) + (c & 127);
+	    }
+	    if (ofs >=3D entry->in_pack_offset)
+		die("delta base offset out of bound for %s",
+		    sha1_to_hex(entry->sha1));
+	    ofs =3D entry->in_pack_offset - ofs;
+	    base_name =3D find_packed_object_name(p, ofs);
+	    used +=3D used_0;
+	    break;
+	default:
+	    base_name =3D NULL;
+    }
+
+    unuse_pack(&w_curs);
+
+    if (!base_name)
+	return;
+
+    base_entry =3D locate_object_entry(base_name);
+    if (!base_entry) {
+	hash =3D name_hash("");
+	add_object_entry(base_name, hash, 2);
+
+	base_entry =3D locate_object_entry(base_name);
+	check_preferred_object(base_entry);
+    }
+
+    entry->delta =3D base_entry;
+    entry->delta_sibling =3D base_entry->delta_child;
+    base_entry->delta_child =3D entry;
+}
+
 static void check_object(struct object_entry *entry)
 {
 	char type[20];
@@ -1062,6 +1149,9 @@
 		/* Otherwise we would do the usual */
 	}
=20
+	if (entry->in_pack && entry->preferred_base)=20
+	    check_preferred_object (entry);
+
 	if (sha1_object_info(entry->sha1, type, &entry->size))
 		die("unable to get type of object %s",
 		    sha1_to_hex(entry->sha1));
@@ -1218,6 +1308,8 @@
 	 */
 	if (trg_entry->preferred_base)
 		return -1;
+	if (src_entry->preferred_base =3D=3D 2)
+		return -1;
=20
 	/*
 	 * We do not bother to try a delta that we discarded
@@ -1242,6 +1334,15 @@
 	if (src_entry->depth >=3D max_depth)
 		return 0;
=20
+	if (loop_check) {
+	    struct object_entry *i =3D src_entry->delta;
+	    while (i) {
+		if (i =3D=3D trg_entry)
+		    return 0;
+		i =3D i->delta;
+	    }
+	}
+
 	/* Now some size filtering heuristics. */
 	trg_size =3D trg_entry->size;
 	max_size =3D trg_size/2 - 20;
@@ -1540,6 +1641,8 @@
=20
 	prepare_revision_walk(&revs);
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
+	if (base_parent)
+	    mark_edges_unparsed(revs.commits, &revs, show_edge);
 	traverse_commit_list(&revs, show_commit, show_object);
 }
=20
@@ -1609,6 +1712,11 @@
 			no_reuse_delta =3D 1;
 			continue;
 		}
+		if (!strcmp("--base-parent", arg)) {
+			base_parent =3D 1;
+			loop_check =3D 1;
+			continue;
+		}
 		if (!strcmp("--delta-base-offset", arg)) {
 			allow_ofs_delta =3D 1;
 			continue;
--- list-objects.c.orig	2007-02-22 22:05:13.972754239 +0100
+++ list-objects.c	2007-02-22 22:11:11.254461051 +0100
@@ -66,6 +66,27 @@
 	tree->buffer =3D NULL;
 }
=20
+void mark_edges_unparsed(struct commit_list *list,
+			 struct rev_info *revs,
+			 show_edge_fn show_edge)
+{
+	for ( ; list; list =3D list->next) {
+		struct commit *commit =3D list->item;
+		struct commit_list *parents;
+
+		for (parents =3D commit->parents; parents; parents =3D parents->next=
) {
+		    struct commit *parent =3D parents->item;
+		    if (parent->object.parsed)
+			continue;
+		    if (!(parent->object.flags & SHOWN)) {
+			parent->object.flags |=3D SHOWN;
+			show_edge(parent);
+		    }
+		}
+	}
+}
+
+
 static void mark_edge_parents_uninteresting(struct commit *commit,
 					    struct rev_info *revs,
 					    show_edge_fn show_edge)
--- list-objects.h.orig	2007-02-22 22:05:10.375119739 +0100
+++ list-objects.h	2007-02-22 22:05:48.095287586 +0100
@@ -8,5 +8,6 @@
 void traverse_commit_list(struct rev_info *revs, show_commit_fn, show_=
object_fn);
=20
 void mark_edges_uninteresting(struct commit_list *, struct rev_info *,=
 show_edge_fn);
+void mark_edges_unparsed(struct commit_list *, struct rev_info *, show=
_edge_fn);
=20
 #endif
--- sha1_file.c.orig	2007-02-22 22:39:46.163797786 +0100
+++ sha1_file.c	2007-02-22 22:52:36.547048788 +0100
@@ -1030,7 +1030,8 @@
 				    unsigned long offset,
 				    enum object_type kind,
 				    unsigned long delta_obj_offset,
-				    unsigned long *base_obj_offset)
+				    unsigned long *base_obj_offset,
+				    unsigned char *base_sha1)
 {
 	unsigned char *base_info =3D use_pack(p, w_curs, offset, NULL);
 	unsigned long base_offset;
@@ -1059,9 +1060,7 @@
 	} else if (kind =3D=3D OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
 		base_offset =3D find_pack_entry_one(base_info, p);
-		if (!base_offset)
-			die("failed to find delta-pack base object %s",
-				sha1_to_hex(base_info));
+		hashcpy (base_sha1, base_info);
 		offset +=3D 20;
 	} else
 		die("I am totally screwed");
@@ -1081,18 +1080,25 @@
 			     char *type,
 			     unsigned long *sizep)
 {
+        unsigned char base_sha1[20];
 	unsigned long base_offset;
=20
 	offset =3D get_delta_base(p, w_curs, offset, kind,
-		obj_offset, &base_offset);
+		obj_offset, &base_offset, base_sha1);
=20
 	/* We choose to only get the type of the base object and
 	 * ignore potentially corrupt pack file that expects the delta
 	 * based on a base with a wrong size.  This saves tons of
 	 * inflate() calls.
 	 */
-	if (packed_object_info(p, base_offset, type, NULL))
+	if (base_offset) {
+	    if (packed_object_info(p, base_offset, type, NULL))
 		die("cannot get info for delta-pack base");
+	} else {
+	    if (sha1_object_info(base_sha1, type, NULL))
+		die("cannot get info for delta-pack base %s",
+		    sha1_to_hex (base_sha1));
+	}
=20
 	if (sizep) {
 		const unsigned char *data;
@@ -1168,6 +1174,7 @@
 	struct pack_window *w_curs =3D NULL;
 	unsigned long obj_offset, val;
 	unsigned char *next_sha1;
+	unsigned char sha1[20];
 	enum object_type kind;
=20
 	*delta_chain_length =3D 0;
@@ -1189,7 +1196,7 @@
 			return;
 		case OBJ_OFS_DELTA:
 			get_delta_base(p, &w_curs, offset, kind,
-				obj_offset, &offset);
+				obj_offset, &offset, sha1);
 			if (*delta_chain_length =3D=3D 0) {
 				/* TODO: find base_sha1 as pointed by offset */
 			}
@@ -1199,6 +1206,8 @@
 			if (*delta_chain_length =3D=3D 0)
 				hashcpy(base_sha1, next_sha1);
 			offset =3D find_pack_entry_one(next_sha1, p);
+			if (!offset)
+			    return;
 			break;
 		}
 		obj_offset =3D offset;
@@ -1281,11 +1290,15 @@
 				unsigned long *sizep)
 {
 	void *delta_data, *result, *base;
+	unsigned char base_sha1[20];
 	unsigned long result_size, base_size, base_offset;
=20
 	offset =3D get_delta_base(p, w_curs, offset, kind,
-		obj_offset, &base_offset);
-	base =3D unpack_entry(p, base_offset, type, &base_size);
+		obj_offset, &base_offset, base_sha1);
+	if (base_offset)
+	    base =3D unpack_entry(p, base_offset, type, &base_size);
+	else
+	    base =3D read_sha1_file (base_sha1, type, &base_size);
 	if (!base)
 		die("failed to read delta base object at %lu from %s",
 		    base_offset, p->pack_name);
