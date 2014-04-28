From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/32] read-cache: split-index mode
Date: Mon, 28 Apr 2014 17:55:38 +0700
Message-ID: <1398682553-11634-18-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:56:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejEX-0002mf-EJ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbaD1K4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:56:14 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:59243 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbaD1K4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:56:05 -0400
Received: by mail-pa0-f52.google.com with SMTP id kx10so5706515pab.11
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PqvYjEHqU4gqJNYsn6QgRr8GYV6HWTamabg0bOb3Vqo=;
        b=DPXxZ4ixsTF9th8adzs02ZZMo3bcekaNcPKZ0X0iBjK8RrK+88u7Qefd1VCiQVWvKY
         E3aUsnonVyVv4YHdDA4aLXoEwYBty+l4zCrCUQNjhVDscE767m8DW8bGSrWBygW19Pyu
         3tCMb/xHVjQKfm66r4fovOguW839+znKPUf9RcoboqU1GiHy4qlDbMVVjcLUOOKFDUop
         zimevMk3A8+YCWemSdpnLT8/77dsYzdK5BP907ZOiRKemVcGa5UtFlSXXBJJixHboXln
         Vdm3dodThccVO4S4XwViYolVUdMINOfwGMI3VVybkBlrKXsQeco9ecfxDsLHdnQG8BFG
         Oy4w==
X-Received: by 10.66.216.137 with SMTP id oq9mr24363554pac.97.1398682564311;
        Mon, 28 Apr 2014 03:56:04 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id hw8sm34171505pbc.62.2014.04.28.03.56.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:56:03 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:57:32 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247282>

This split-index mode is designed to keep write cost proportional to
the number of changes the user has made, not the size of the work
tree. (Read cost is another matter, to be dealt separately.)

This mode stores index info in a pair of $GIT_DIR/index and
$GIT_DIR/sharedindex.<SHA-1>. sharedindex is large and unchanged over
time while "index" is smaller and updated often. Format details are in
index-format.txt, although not everything is implemented in this
patch.

Shared indexes are not automatically removed, because it's unclear if
the shared index is needed by any (even temporary) indexes by just
looking at it. After a while you'll collect stale shared indexes. The
good news is one shared index is useable for long, until
$GIT_DIR/index becomes too big and sluggish that the new shared index
must be created.

The safest way to clean shared indexes is to turn off split index
mode, so shared files are all garbage, delete them all, then turn on
split index mode again.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitrepository-layout.txt   |  4 ++
 Documentation/technical/index-format.txt | 35 ++++++++++++
 Makefile                                 |  1 +
 cache.h                                  |  3 +
 read-cache.c                             | 96 ++++++++++++++++++++++++=
++++++--
 split-index.c (new)                      | 90 ++++++++++++++++++++++++=
++++++
 split-index.h (new)                      | 25 +++++++++
 unpack-trees.c                           |  4 ++
 8 files changed, 253 insertions(+), 5 deletions(-)
 create mode 100644 split-index.c
 create mode 100644 split-index.h

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 17d2ea6..79653f3 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -155,6 +155,10 @@ index::
 	The current index file for the repository.  It is
 	usually not found in a bare repository.
=20
+sharedindex.<SHA-1>::
+	The shared index part, to be referenced by $GIT_DIR/index and
+	other temporary index files. Only valid in split index mode.
+
 info::
 	Additional information about the repository is recorded
 	in this directory.
diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index f352a9b..fe6f316 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -129,6 +129,9 @@ Git index format
   (Version 4) In version 4, the padding after the pathname does not
   exist.
=20
+  Interpretation of index entries in split index mode is completely
+  different. See below for details.
+
 =3D=3D Extensions
=20
 =3D=3D=3D Cached tree
@@ -198,3 +201,35 @@ Git index format
   - At most three 160-bit object names of the entry in stages from 1 t=
o 3
     (nothing is written for a missing stage).
=20
+=3D=3D=3D Split index
+
+  In split index mode, the majority of index entries could be stored
+  in a separate file. This extension records the changes to be made on
+  top of that to produce the final index.
+
+  The signature for this extension is { 'l', 'i, 'n', 'k' }.
+
+  The extension consists of:
+
+  - 160-bit SHA-1 of the shared index file. The shared index file path
+    is $GIT_DIR/sharedindex.<SHA-1>. If all 160 bits are zero, the
+    index does not require a shared index file.
+
+  - An ewah-encoded delete bitmap, each bit represents an entry in the
+    shared index. If a bit is set, its corresponding entry in the
+    shared index will be removed from the final index.  Note, because
+    a delete operation changes index entry positions, but we do need
+    original positions in replace phase, it's best to just mark
+    entries for removal, then do a mass deletion after replacement.
+
+  - An ewah-encoded replace bitmap, each bit represents an entry in
+    the shared index. If a bit is set, its corresponding entry in the
+    shared index will be replaced with an entry in this index
+    file. All replaced entries are stored in sorted order in this
+    index. The first "1" bit in the replace bitmap corresponds to the
+    first index entry, the second "1" bit to the second entry and so
+    on. Replaced entries may have empty path names to save space.
+
+  The remaining index entries after replaced ones will be added to the
+  final index. These added entries are also sorted by entry namme then
+  stage.
diff --git a/Makefile b/Makefile
index 74a929b..c3957bb 100644
--- a/Makefile
+++ b/Makefile
@@ -884,6 +884,7 @@ LIB_OBJS +=3D sha1_name.o
 LIB_OBJS +=3D shallow.o
 LIB_OBJS +=3D sideband.o
 LIB_OBJS +=3D sigchain.o
+LIB_OBJS +=3D split-index.o
 LIB_OBJS +=3D strbuf.o
 LIB_OBJS +=3D streaming.o
 LIB_OBJS +=3D string-list.o
diff --git a/cache.h b/cache.h
index 0f6247c..90a5998 100644
--- a/cache.h
+++ b/cache.h
@@ -135,6 +135,7 @@ struct cache_entry {
 	unsigned int ce_mode;
 	unsigned int ce_flags;
 	unsigned int ce_namelen;
+	unsigned int index;	/* for link extension */
 	unsigned char sha1[20];
 	char name[FLEX_ARRAY]; /* more */
 };
@@ -275,12 +276,14 @@ static inline unsigned int canon_mode(unsigned in=
t mode)
 #define RESOLVE_UNDO_CHANGED	(1 << 4)
 #define CACHE_TREE_CHANGED	(1 << 5)
=20
+struct split_index;
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int version;
 	unsigned int cache_nr, cache_alloc, cache_changed;
 	struct string_list *resolve_undo;
 	struct cache_tree *cache_tree;
+	struct split_index *split_index;
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
diff --git a/read-cache.c b/read-cache.c
index 723d769..ff889ad 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "strbuf.h"
 #include "varint.h"
+#include "split-index.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -34,6 +35,10 @@ static struct cache_entry *refresh_cache_entry(struc=
t cache_entry *ce,
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
+#define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
+
+/* changes that can be kept in $GIT_DIR/index (basically all extension=
s) */
+#define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED)
=20
 struct index_state the_index;
 static const char *alternate_index_output;
@@ -63,6 +68,7 @@ void rename_index_entry_at(struct index_state *istate=
, int nr, const char *new_n
 	copy_cache_entry(new, old);
 	new->ce_flags &=3D ~CE_HASHED;
 	new->ce_namelen =3D namelen;
+	new->index =3D 0;
 	memcpy(new->name, new_name, namelen + 1);
=20
 	cache_tree_invalidate_path(istate, old->name);
@@ -1335,6 +1341,10 @@ static int read_index_extension(struct index_sta=
te *istate,
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo =3D resolve_undo_read(data, sz);
 		break;
+	case CACHE_EXT_LINK:
+		if (read_link_extension(istate, data, sz))
+			return -1;
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand=
",
@@ -1369,6 +1379,7 @@ static struct cache_entry *cache_entry_from_ondis=
k(struct ondisk_cache_entry *on
 	ce->ce_stat_data.sd_size  =3D get_be32(&ondisk->size);
 	ce->ce_flags =3D flags & ~CE_NAMEMASK;
 	ce->ce_namelen =3D len;
+	ce->index =3D 0;
 	hashcpy(ce->sha1, ondisk->sha1);
 	memcpy(ce->name, name, len);
 	ce->name[len] =3D '\0';
@@ -1443,7 +1454,8 @@ static struct cache_entry *create_from_disk(struc=
t ondisk_cache_entry *ondisk,
 }
=20
 /* remember to discard_cache() before reading a different cache! */
-int read_index_from(struct index_state *istate, const char *path)
+static int do_read_index(struct index_state *istate, const char *path,
+			 int must_exist)
 {
 	int fd, i;
 	struct stat st;
@@ -1460,9 +1472,9 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	istate->timestamp.nsec =3D 0;
 	fd =3D open(path, O_RDONLY);
 	if (fd < 0) {
-		if (errno =3D=3D ENOENT)
+		if (!must_exist && errno =3D=3D ENOENT)
 			return 0;
-		die_errno("index file open failed");
+		die_errno("%s: index file open failed", path);
 	}
=20
 	if (fstat(fd, &st))
@@ -1535,6 +1547,42 @@ unmap:
 	die("index file corrupt");
 }
=20
+int read_index_from(struct index_state *istate, const char *path)
+{
+	struct split_index *split_index;
+	int ret;
+
+	/* istate->initialized covers both .git/index and .git/sharedindex.xx=
x */
+	if (istate->initialized)
+		return istate->cache_nr;
+
+	ret =3D do_read_index(istate, path, 0);
+	split_index =3D istate->split_index;
+	if (!split_index)
+		return ret;
+
+	if (is_null_sha1(split_index->base_sha1))
+		return ret;
+	if (istate->cache_nr)
+		die("index in split-index mode must contain no entries");
+
+	if (split_index->base)
+		discard_index(split_index->base);
+	else
+		split_index->base =3D xcalloc(1, sizeof(*split_index->base));
+	ret =3D do_read_index(split_index->base,
+			    git_path("sharedindex.%s",
+				     sha1_to_hex(split_index->base_sha1)), 1);
+	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
+		die("broken index, expect %s in %s, got %s",
+		    sha1_to_hex(split_index->base_sha1),
+		    git_path("sharedindex.%s",
+				     sha1_to_hex(split_index->base_sha1)),
+		    sha1_to_hex(split_index->base->sha1));
+	merge_base_index(istate);
+	return ret;
+}
+
 int is_index_unborn(struct index_state *istate)
 {
 	return (!istate->cache_nr && !istate->timestamp.sec);
@@ -1544,8 +1592,15 @@ int discard_index(struct index_state *istate)
 {
 	int i;
=20
-	for (i =3D 0; i < istate->cache_nr; i++)
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		if (istate->cache[i]->index &&
+		    istate->split_index &&
+		    istate->split_index->base &&
+		    istate->cache[i]->index <=3D istate->split_index->base->cache_nr=
 &&
+		    istate->cache[i] =3D=3D istate->split_index->base->cache[istate-=
>cache[i]->index - 1])
+			continue;
 		free(istate->cache[i]);
+	}
 	resolve_undo_clear_index(istate);
 	istate->cache_nr =3D 0;
 	istate->cache_changed =3D 0;
@@ -1557,6 +1612,7 @@ int discard_index(struct index_state *istate)
 	free(istate->cache);
 	istate->cache =3D NULL;
 	istate->cache_alloc =3D 0;
+	discard_split_index(istate);
 	return 0;
 }
=20
@@ -1852,6 +1908,17 @@ static int do_write_index(struct index_state *is=
tate, int newfd)
 	strbuf_release(&previous_name_buf);
=20
 	/* Write extension data here */
+	if (istate->split_index) {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		err =3D write_link_extension(&sb, istate) < 0 ||
+			write_index_ext_header(&c, newfd, CACHE_EXT_LINK,
+					       sb.len) < 0 ||
+			ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
 	if (istate->cache_tree) {
 		struct strbuf sb =3D STRBUF_INIT;
=20
@@ -1916,10 +1983,29 @@ static int do_write_locked_index(struct index_s=
tate *istate, struct lock_file *l
 		return ret;
 }
=20
+static int write_split_index(struct index_state *istate,
+			     struct lock_file *lock,
+			     unsigned flags)
+{
+	int ret;
+	prepare_to_write_split_index(istate);
+	ret =3D do_write_locked_index(istate, lock, flags);
+	finish_writing_split_index(istate);
+	return ret;
+}
+
 int write_locked_index(struct index_state *istate, struct lock_file *l=
ock,
 		       unsigned flags)
 {
-	return do_write_locked_index(istate, lock, flags);
+	struct split_index *si =3D istate->split_index;
+
+	if (!si || (istate->cache_changed & ~EXTMASK)) {
+		if (si)
+			hashclr(si->base_sha1);
+		return do_write_locked_index(istate, lock, flags);
+	}
+
+	return write_split_index(istate, lock, flags);
 }
=20
 /*
diff --git a/split-index.c b/split-index.c
new file mode 100644
index 0000000..63b52bb
--- /dev/null
+++ b/split-index.c
@@ -0,0 +1,90 @@
+#include "cache.h"
+#include "split-index.h"
+
+struct split_index *init_split_index(struct index_state *istate)
+{
+	if (!istate->split_index) {
+		istate->split_index =3D xcalloc(1, sizeof(*istate->split_index));
+		istate->split_index->refcount =3D 1;
+	}
+	return istate->split_index;
+}
+
+int read_link_extension(struct index_state *istate,
+			 const void *data_, unsigned long sz)
+{
+	const unsigned char *data =3D data_;
+	struct split_index *si;
+	if (sz < 20)
+		return error("corrupt link extension (too short)");
+	si =3D init_split_index(istate);
+	hashcpy(si->base_sha1, data);
+	data +=3D 20;
+	sz -=3D 20;
+	if (sz)
+		return error("garbage at the end of link extension");
+	return 0;
+}
+
+int write_link_extension(struct strbuf *sb,
+			 struct index_state *istate)
+{
+	struct split_index *si =3D istate->split_index;
+	strbuf_add(sb, si->base_sha1, 20);
+	return 0;
+}
+
+static void mark_base_index_entries(struct index_state *base)
+{
+	int i;
+	/*
+	 * To keep track of the shared entries between
+	 * istate->base->cache[] and istate->cache[], base entry
+	 * position is stored in each base entry. All positions start
+	 * from 1 instead of 0, which is resrved to say "this is a new
+	 * entry".
+	 */
+	for (i =3D 0; i < base->cache_nr; i++)
+		base->cache[i]->index =3D i + 1;
+}
+
+void merge_base_index(struct index_state *istate)
+{
+	struct split_index *si =3D istate->split_index;
+
+	mark_base_index_entries(si->base);
+	istate->cache_nr =3D si->base->cache_nr;
+	ALLOC_GROW(istate->cache, istate->cache_nr, istate->cache_alloc);
+	memcpy(istate->cache, si->base->cache,
+	       sizeof(*istate->cache) * istate->cache_nr);
+}
+
+void prepare_to_write_split_index(struct index_state *istate)
+{
+	struct split_index *si =3D init_split_index(istate);
+	/* take cache[] out temporarily */
+	si->saved_cache_nr =3D istate->cache_nr;
+	istate->cache_nr =3D 0;
+}
+
+void finish_writing_split_index(struct index_state *istate)
+{
+	struct split_index *si =3D init_split_index(istate);
+	istate->cache_nr =3D si->saved_cache_nr;
+}
+
+void discard_split_index(struct index_state *istate)
+{
+	struct split_index *si =3D istate->split_index;
+	if (!si)
+		return;
+	istate->split_index =3D NULL;
+	si->refcount--;
+	if (si->refcount)
+		return;
+	if (si->base) {
+		discard_index(si->base);
+		free(si->base);
+	}
+	free(si);
+}
diff --git a/split-index.h b/split-index.h
new file mode 100644
index 0000000..8d74041
--- /dev/null
+++ b/split-index.h
@@ -0,0 +1,25 @@
+#ifndef SPLIT_INDEX_H
+#define SPLIT_INDEX_H
+
+struct index_state;
+struct strbuf;
+
+struct split_index {
+	unsigned char base_sha1[20];
+	struct index_state *base;
+	unsigned int saved_cache_nr;
+	int refcount;
+};
+
+struct split_index *init_split_index(struct index_state *istate);
+int read_link_extension(struct index_state *istate,
+			const void *data, unsigned long sz);
+int write_link_extension(struct strbuf *sb,
+			 struct index_state *istate);
+void move_cache_to_base_index(struct index_state *istate);
+void merge_base_index(struct index_state *istate);
+void prepare_to_write_split_index(struct index_state *istate);
+void finish_writing_split_index(struct index_state *istate);
+void discard_split_index(struct index_state *istate);
+
+#endif
diff --git a/unpack-trees.c b/unpack-trees.c
index f594932..a941f7c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,7 @@
 #include "progress.h"
 #include "refs.h"
 #include "attr.h"
+#include "split-index.h"
=20
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -1046,6 +1047,9 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
 	o->result.timestamp.sec =3D o->src_index->timestamp.sec;
 	o->result.timestamp.nsec =3D o->src_index->timestamp.nsec;
 	o->result.version =3D o->src_index->version;
+	o->result.split_index =3D o->src_index->split_index;
+	if (o->result.split_index)
+		o->result.split_index->refcount++;
 	hashcpy(o->result.sha1, o->src_index->sha1);
 	o->merge_size =3D len;
 	mark_all_ce_unused(o->src_index);
--=20
1.9.1.346.ga2b5940
