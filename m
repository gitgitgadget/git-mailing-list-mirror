From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 06/19] read-cache: add index reading api
Date: Fri, 12 Jul 2013 19:26:51 +0200
Message-ID: <1373650024-3001-7-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:28:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh8k-0003Ch-2Q
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933307Ab3GLR2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jul 2013 13:28:13 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:65409 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab3GLR2M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:28:12 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so9237917pac.15
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vdGhK817E7vt2ZM1F1uZIsStw69Tkc4i7E6InJP8alQ=;
        b=fOwp3DjWJWgy5gi078j/ervs9EDbO/oqDuiB/KheqHRp7w9T4zj7dMvz6EYIcGh+y6
         VKC6Sse1dV5GR9CFkK2TOJ+Gck+gOTD4Ngf+RIatCbT2NLLzpaunBtmd8lqhQEvWB88J
         mGG/82b0vnsEaqDRBtJxEW/qa5gbn7OoSdcC0kgKk1ns03KeWU1FXAe04OiaBu+FCCay
         I6t8GQXKen+cQZf3FD4E9sWjLungQ7P4Ypfk/ohthNgbRoF7Aq2ojYhSIYDEWBeAas/n
         BIUTRFzJddr3hmAtnfj+y2ubdHut8kK+eYy3L47gLNQlJLVPjfnUe9G6zLT31iMNKTBc
         enGw==
X-Received: by 10.68.129.10 with SMTP id ns10mr43136589pbb.13.1373650091672;
        Fri, 12 Jul 2013 10:28:11 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id s5sm46384282pbo.38.2013.07.12.10.28.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:28:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230216>

Add an api for access to the index file.  Currently there is only a ver=
y
basic api for accessing the index file, which only allows a full read o=
f
the index, and lets the users of the data filter it.  The new index api
gives the users the possibility to use only part of the index and
provides functions for iterating over and accessing cache entries.

This simplifies future improvements to the in-memory format, as changes
will be concentrated on one file, instead of the whole git source code.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h         | 42 +++++++++++++++++++++++++++++++++++++++++-
 read-cache-v2.c | 35 +++++++++++++++++++++++++++++++++--
 read-cache.c    | 44 ++++++++++++++++++++++++++++++++++++++++----
 read-cache.h    |  8 +++++++-
 4 files changed, 121 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 5082b34..d305d21 100644
--- a/cache.h
+++ b/cache.h
@@ -127,7 +127,7 @@ struct cache_entry {
 	unsigned int ce_flags;
 	unsigned int ce_namelen;
 	unsigned char sha1[20];
-	struct cache_entry *next;
+	struct cache_entry *next; /* used by name_hash */
 	char name[FLEX_ARRAY]; /* more */
 };
=20
@@ -258,6 +258,29 @@ static inline unsigned int canon_mode(unsigned int=
 mode)
=20
 #define cache_entry_size(len) (offsetof(struct cache_entry,name) + (le=
n) + 1)
=20
+/*
+ * Options by which the index should be filtered when read partially.
+ *
+ * pathspec: The pathspec which the index entries have to match
+ * seen: Used to return the seen parameter from match_pathspec()
+ * max_prefix_len: The common prefix length of the pathspecs
+ *
+ * read_staged: used to indicate if the conflicted entries (entries
+ *     with a stage) should be included
+ * read_cache_tree: used to indicate if the cache-tree should be read
+ * read_resolve_undo: used to indicate if the resolve undo data should
+ *     be read
+ */
+struct filter_opts {
+	const struct pathspec *pathspec;
+	char *seen;
+	int max_prefix_len;
+
+	int read_staged;
+	int read_cache_tree;
+	int read_resolve_undo;
+};
+
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int version;
@@ -270,6 +293,8 @@ struct index_state {
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
 	struct index_ops *ops;
+	struct internal_ops *internal_ops;
+	struct filter_opts *filter_opts;
 };
=20
 extern struct index_state the_index;
@@ -311,6 +336,12 @@ extern void free_name_hash(struct index_state *ist=
ate);
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, =
at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(=
&the_index, (path), (sz))
+
+/* index api */
+#define read_cache_filtered(opts) read_index_filtered(&the_index, (opt=
s))
+#define read_cache_filtered_from(path, opts) read_index_filtered_from(=
&the_index, (path), (opts))
+#define for_each_cache_entry(fn, cb_data) \
+	for_each_index_entry(&the_index, (fn), (cb_data))
 #endif
=20
 enum object_type {
@@ -438,6 +469,15 @@ extern int init_db(const char *template_dir, unsig=
ned int flags);
 		} \
 	} while (0)
=20
+/* index api */
+extern int read_index_filtered(struct index_state *, struct filter_opt=
s *opts);
+extern int read_index_filtered_from(struct index_state *, const char *=
path, struct filter_opts *opts);
+
+typedef int each_cache_entry_fn(struct cache_entry *ce, void *);
+extern int for_each_index_entry(struct index_state *istate,
+				each_cache_entry_fn, void *);
+
+
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const char **paths=
pec);
diff --git a/read-cache-v2.c b/read-cache-v2.c
index a6883c3..51b618f 100644
--- a/read-cache-v2.c
+++ b/read-cache-v2.c
@@ -3,6 +3,7 @@
 #include "resolve-undo.h"
 #include "cache-tree.h"
 #include "varint.h"
+#include "dir.h"
=20
 /* Mask for the name length in ce_flags in the on-disk index */
 #define CE_NAMEMASK  (0x0fff)
@@ -207,8 +208,14 @@ static int read_index_extension(struct index_state=
 *istate,
 	return 0;
 }
=20
+/*
+ * The performance is the same if we read the whole index or only
+ * part of it, therefore we always read the whole index to avoid
+ * having to re-read it later.  The filter_opts will determine
+ * what part of the index is used when retrieving the cache-entries.
+ */
 static int read_index_v2(struct index_state *istate, void *mmap,
-			 unsigned long mmap_size)
+			 unsigned long mmap_size, struct filter_opts *opts)
 {
 	int i;
 	unsigned long src_offset;
@@ -238,7 +245,6 @@ static int read_index_v2(struct index_state *istate=
, void *mmap,
 		disk_ce =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset)=
;
 		ce =3D create_from_disk(disk_ce, &consumed, previous_name);
 		set_index_entry(istate, i, ce);
-
 		src_offset +=3D consumed;
 	}
 	strbuf_release(&previous_name_buf);
@@ -548,9 +554,34 @@ static int write_index_v2(struct index_state *ista=
te, int newfd)
 	return 0;
 }
=20
+int for_each_index_entry_v2(struct index_state *istate, each_cache_ent=
ry_fn fn, void *cb_data)
+{
+	int i, ret =3D 0;
+	struct filter_opts *opts=3D istate->filter_opts;
+
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce =3D istate->cache[i];
+
+		if (opts && !opts->read_staged && ce_stage(ce))
+			continue;
+
+		if (opts && !match_pathspec_depth(opts->pathspec, ce->name, ce_namel=
en(ce),
+						  opts->max_prefix_len, opts->seen))
+			continue;
+
+		if ((ret =3D fn(istate->cache[i], cb_data)))
+			break;
+	}
+	return ret;
+}
+
 struct index_ops v2_ops =3D {
 	match_stat_basic,
 	verify_hdr,
 	read_index_v2,
 	write_index_v2
 };
+
+struct internal_ops v2_internal_ops =3D {
+	for_each_index_entry_v2,
+};
diff --git a/read-cache.c b/read-cache.c
index 3e3a0e2..9053d43 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -996,6 +996,7 @@ int add_index_entry(struct index_state *istate, str=
uct cache_entry *ce, int opti
 		memmove(istate->cache + pos + 1,
 			istate->cache + pos,
 			(istate->cache_nr - pos - 1) * sizeof(ce));
+
 	set_index_entry(istate, pos, ce);
 	istate->cache_changed =3D 1;
 	return 0;
@@ -1272,7 +1273,32 @@ static int verify_hdr_version(struct index_state=
 *istate,
=20
 int read_index(struct index_state *istate)
 {
-	return read_index_from(istate, get_index_file());
+	return read_index_filtered_from(istate, get_index_file(), NULL);
+}
+
+int read_index_filtered(struct index_state *istate, struct filter_opts=
 *opts)
+{
+	return read_index_filtered_from(istate, get_index_file(), opts);
+}
+
+int set_internal_ops(struct index_state *istate)
+{
+	if (!istate->internal_ops && istate->cache)
+		istate->internal_ops =3D &v2_internal_ops;
+	if (!istate->internal_ops)
+		return 0;
+	return 1;
+}
+
+/*
+ * Execute fn for each index entry which is currently in istate.  Data
+ * can be given to the function using the cb_data parameter.
+ */
+int for_each_index_entry(struct index_state *istate, each_cache_entry_=
fn fn, void *cb_data)
+{
+	if (!set_internal_ops(istate))
+		return 0;
+	return istate->internal_ops->for_each_index_entry(istate, fn, cb_data=
);
 }
=20
 static int index_changed(struct stat *st_old, struct stat *st_new)
@@ -1295,8 +1321,9 @@ static int index_changed(struct stat *st_old, str=
uct stat *st_new)
 	return 0;
 }
=20
-/* remember to discard_cache() before reading a different cache! */
-int read_index_from(struct index_state *istate, const char *path)
+
+int read_index_filtered_from(struct index_state *istate, const char *p=
ath,
+			     struct filter_opts *opts)
 {
 	int fd, err, i;
 	struct stat st_old, st_new;
@@ -1337,7 +1364,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 		if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
 			err =3D 1;
=20
-		if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
+		if (istate->ops->read_index(istate, mmap, mmap_size, opts) < 0)
 			err =3D 1;
 		istate->timestamp.sec =3D st_old.st_mtime;
 		istate->timestamp.nsec =3D ST_MTIME_NSEC(st_old);
@@ -1345,6 +1372,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 			die_errno("cannot stat the open index");
=20
 		munmap(mmap, mmap_size);
+		istate->filter_opts =3D opts;
 		if (!index_changed(&st_old, &st_new) && !err)
 			return istate->cache_nr;
 	}
@@ -1352,6 +1380,13 @@ int read_index_from(struct index_state *istate, =
const char *path)
 	die("index file corrupt");
 }
=20
+
+/* remember to discard_cache() before reading a different cache! */
+int read_index_from(struct index_state *istate, const char *path)
+{
+	return read_index_filtered_from(istate, path, NULL);
+}
+
 int is_index_unborn(struct index_state *istate)
 {
 	return (!istate->cache_nr && !istate->timestamp.sec);
@@ -1374,6 +1409,7 @@ int discard_index(struct index_state *istate)
 	free(istate->cache);
 	istate->cache =3D NULL;
 	istate->cache_alloc =3D 0;
+	istate->filter_opts =3D NULL;
 	return 0;
 }
=20
diff --git a/read-cache.h b/read-cache.h
index f31a38b..e72a585 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -24,11 +24,17 @@ struct cache_version_header {
 struct index_ops {
 	int (*match_stat_basic)(const struct cache_entry *ce, struct stat *st=
, int changed);
 	int (*verify_hdr)(void *mmap, unsigned long size);
-	int (*read_index)(struct index_state *istate, void *mmap, unsigned lo=
ng mmap_size);
+	int (*read_index)(struct index_state *istate, void *mmap, unsigned lo=
ng mmap_size,
+			  struct filter_opts *opts);
 	int (*write_index)(struct index_state *istate, int newfd);
 };
=20
+struct internal_ops {
+	int (*for_each_index_entry)(struct index_state *istate, each_cache_en=
try_fn fn, void *cb_data);
+};
+
 extern struct index_ops v2_ops;
+extern struct internal_ops v2_internal_ops;
=20
 #ifndef NEEDS_ALIGNED_ACCESS
 #define ntoh_s(var) ntohs(var)
--=20
1.8.3.453.g1dfc63d
