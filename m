From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 09/24] read-cache: add index reading api
Date: Sun, 18 Aug 2013 21:41:58 +0200
Message-ID: <1376854933-31241-10-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8xr-0003q6-9d
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab3HRTsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Aug 2013 15:48:35 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:62002 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab3HRTse (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:34 -0400
Received: by mail-wi0-f181.google.com with SMTP id en1so2348199wid.8
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Gwsxo6ZONRfozWY2tEFOcUGe1amUy3WyOkcrAy6eOgc=;
        b=UeOyTkgCa8R55WRQugCxJjomGwA884e3GwK3MPpPfBIUak9im7dxJXXPluTFDGJzIV
         hMUbvlt/YkyRpEfjNLGbJO3vv/kKAq1meNkCH4L10FCq9vIrccR2aALNTX8mmH/115aZ
         JDY+zk5guH2xJYBEP78qV1q7rYYX+0tddecKUFCOD33K6chYKjRucLQ27Z7S28rYT7S7
         1Rd310hsA03CV1/uBmEvukjlAFYpGwWC0XbcskcEk5kfGjJ7qvosCt8FqpoX/r/kVpyO
         Ir21HguRD9WDbgfscTKhcgAYtnhyuz4eD9QcYG1uVU0e/whTTsfY8EkEYj2Pn7Htl3DK
         odbA==
X-Received: by 10.194.122.99 with SMTP id lr3mr5632138wjb.21.1376855313390;
        Sun, 18 Aug 2013 12:48:33 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id ff5sm6917891wib.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232495>

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
 cache.h         | 41 ++++++++++++++++++++++++++++++++++++++++-
 read-cache-v2.c | 10 ++++++++--
 read-cache.c    | 47 +++++++++++++++++++++++++++++++++++++++++++----
 read-cache.h    |  3 ++-
 4 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index d4dae21..da224c9 100644
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
@@ -260,6 +260,29 @@ static inline unsigned int canon_mode(unsigned int=
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
@@ -272,6 +295,7 @@ struct index_state {
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
 	struct index_ops *ops;
+	struct filter_opts *filter_opts;
 };
=20
 extern struct index_state the_index;
@@ -315,6 +339,12 @@ extern void free_name_hash(struct index_state *ist=
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
@@ -448,6 +478,15 @@ extern void sanitize_stdfds(void);
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
 extern void initialize_index(struct index_state *istate, int version);
 extern void change_index_version(struct index_state *istate, int versi=
on);
diff --git a/read-cache-v2.c b/read-cache-v2.c
index 070d468..63be074 100644
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
@@ -202,8 +203,14 @@ static int read_index_extension(struct index_state=
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
@@ -229,7 +236,6 @@ static int read_index_v2(struct index_state *istate=
, void *mmap,
 		disk_ce =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset)=
;
 		ce =3D create_from_disk(disk_ce, &consumed, previous_name);
 		set_index_entry(istate, i, ce);
-
 		src_offset +=3D consumed;
 	}
 	strbuf_release(&previous_name_buf);
diff --git a/read-cache.c b/read-cache.c
index 2d12601..38b9a04 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1290,11 +1290,41 @@ static int verify_hdr_version(struct index_stat=
e *istate,
=20
 int read_index(struct index_state *istate)
 {
-	return read_index_from(istate, get_index_file());
+	return read_index_filtered_from(istate, get_index_file(), NULL);
 }
=20
-/* remember to discard_cache() before reading a different cache! */
-int read_index_from(struct index_state *istate, const char *path)
+int read_index_filtered(struct index_state *istate, struct filter_opts=
 *opts)
+{
+	return read_index_filtered_from(istate, get_index_file(), opts);
+}
+
+/*
+ * Execute fn for each index entry which is currently in istate.  Data
+ * can be given to the function using the cb_data parameter.
+ */
+int for_each_index_entry(struct index_state *istate, each_cache_entry_=
fn fn, void *cb_data)
+{
+	int i, ret =3D 0;
+	struct filter_opts *opts =3D istate->filter_opts;
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
+int read_index_filtered_from(struct index_state *istate, const char *p=
ath,
+			     struct filter_opts *opts)
 {
 	int fd, err, i;
 	struct stat_validity sv;
@@ -1309,6 +1339,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	errno =3D ENOENT;
 	istate->timestamp.sec =3D 0;
 	istate->timestamp.nsec =3D 0;
+	istate->filter_opts =3D opts;
 	sv.sd =3D NULL;
 	for (i =3D 0; i < 50; i++) {
 		err =3D 0;
@@ -1339,7 +1370,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 		if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
 			err =3D 1;
=20
-		if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
+		if (istate->ops->read_index(istate, mmap, mmap_size, opts) < 0)
 			err =3D 1;
 		istate->timestamp.sec =3D sv.sd->sd_mtime.sec;
 		istate->timestamp.nsec =3D sv.sd->sd_mtime.nsec;
@@ -1352,6 +1383,13 @@ int read_index_from(struct index_state *istate, =
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
@@ -1376,6 +1414,7 @@ int discard_index(struct index_state *istate)
 	istate->cache =3D NULL;
 	istate->cache_alloc =3D 0;
 	istate->ops =3D NULL;
+	istate->filter_opts =3D NULL;
 	return 0;
 }
=20
diff --git a/read-cache.h b/read-cache.h
index d8debb8..644b199 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -25,7 +25,8 @@ struct cache_header {
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
--=20
1.8.3.4.1231.g9fbf354.dirty
