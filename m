From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/23] untracked cache: save to an index extension
Date: Mon,  8 Dec 2014 21:04:54 +0700
Message-ID: <1418047507-22892-12-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:55:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxymv-0004cf-P1
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbaLHNzl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:55:41 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:44256 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbaLHNzi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:55:38 -0500
Received: by mail-pd0-f171.google.com with SMTP id y13so5203624pdi.16
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kEy5HSDPSDvplt2BoAIaD5zEOQi0zZL9xlXrUOcJN/0=;
        b=fmr89qjLukhyYpMzz9rceGhwhqetoc8r9WLBbw4qmD5w0tLzbhKCGtRagWEkjoUhzW
         PxghevMF8jqZipNQG/Ce3e6XPWbR8Y8edsEvz9z0O3APhpipnAUY1spSZWBQ+1DkUnzs
         vOjiXLriELmVeg7xhDL2663B/NJI/3XFp2k5fWFK4u1HBJ+BmXh9/T7Q6Dp/AypjKxI3
         73wbfhSerluoBsbUCcJZDed1i6EmgH0ECydxB/p9G3HvRIY9sSBTcfQ3xkSLb7wGSut2
         KSL/qmrw1enwZ2P1D/USyttnacRns3ttSDEMtV1eE+WPdJBpI/bK+gfhX8J9uv0u24dt
         6CSQ==
X-Received: by 10.68.174.131 with SMTP id bs3mr60318787pbc.20.1418046938111;
        Mon, 08 Dec 2014 05:55:38 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id fn4sm36823401pab.39.2014.12.08.05.55.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:55:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:06:13 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261028>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/index-format.txt |  58 +++++++++++++
 cache.h                                  |   3 +
 dir.c                                    | 134 +++++++++++++++++++++++=
++++++++
 dir.h                                    |   1 +
 read-cache.c                             |  12 +++
 5 files changed, 208 insertions(+)

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index fe6f316..b97ac8d 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -233,3 +233,61 @@ Git index format
   The remaining index entries after replaced ones will be added to the
   final index. These added entries are also sorted by entry namme then
   stage.
+
+=3D=3D Untracked cache
+
+  Untracked cache saves the untracked file list and necessary data to
+  verify the cache. The signature for this extension is { 'U', 'N',
+  'T', 'R' }.
+
+  The extension starts with
+
+  - Stat data of $GIT_DIR/info/exclude. See "Index entry" section from
+    ctime field until "file size".
+
+  - Stat data of core.excludesfile
+
+  - 32-bit dir_flags (see struct dir_struct)
+
+  - 160-bit SHA-1 of $GIT_DIR/info/exclude. Null SHA-1 means the file
+    does not exist.
+
+  - 160-bit SHA-1 of core.excludesfile. Null SHA-1 means the file does
+    not exist.
+
+  - NUL-terminated string of per-dir exclude file name. This usually
+    is ".gitignore".
+
+  - The number of following directory blocks, variable width
+    encoding. If this number is zero, the extension ends here with a
+    following NUL.
+
+  - A number of directory blocks in depth-first-search order, each
+    consists of
+
+    - The number of untracked entries, variable witdh encoding.
+
+    - The number of sub-directory blocks, variable with encoding.
+
+    - The directory name terminated by NUL.
+
+    - A number of untrached file/dir names terminated by NUL.
+
+The remaining data of each directory block is grouped by type:
+
+  - An ewah bitmap, the n-th bit marks whether the n-th directory has
+    valid untracked cache entries.
+
+  - An ewah bitmap, the n-th bit records "check-only" bit of
+    read_directory_recursive() for the n-th directory.
+
+  - An ewah bitmap, the n-th bit indicates whether SHA-1 and stat data
+    is valid for the n-th directory and exists in the next data.
+
+  - An array of stat data. The n-th data corresponds with the n-th
+    "one" bit in the previous ewah bitmap.
+
+  - An array of SHA-1. The n-th SHA-1 corresponds with the n-th "one" =
bit
+    in the previous ewah bitmap.
+
+  - One NUL.
diff --git a/cache.h b/cache.h
index dcf3a2a..b14d6e2 100644
--- a/cache.h
+++ b/cache.h
@@ -297,6 +297,8 @@ static inline unsigned int canon_mode(unsigned int =
mode)
 #define SPLIT_INDEX_ORDERED	(1 << 6)
=20
 struct split_index;
+struct untracked_cache;
+
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int version;
@@ -310,6 +312,7 @@ struct index_state {
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
+	struct untracked_cache *untracked;
 };
=20
 extern struct index_state the_index;
diff --git a/dir.c b/dir.c
index 95a0f0a..a0a7330 100644
--- a/dir.c
+++ b/dir.c
@@ -12,6 +12,8 @@
 #include "refs.h"
 #include "wildmatch.h"
 #include "pathspec.h"
+#include "varint.h"
+#include "ewah/ewok.h"
=20
 struct path_simplify {
 	int len;
@@ -2139,3 +2141,135 @@ void clear_directory(struct dir_struct *dir)
 	}
 	strbuf_release(&dir->basebuf);
 }
+
+struct ondisk_untracked_cache {
+	struct stat_data info_exclude_stat;
+	struct stat_data excludes_file_stat;
+	uint32_t dir_flags;
+	unsigned char info_exclude_sha1[20];
+	unsigned char excludes_file_sha1[20];
+	char exclude_per_dir[1];
+};
+
+struct write_data {
+	int index;	   /* number of written untracked_cache_dir */
+	struct ewah_bitmap *check_only; /* from untracked_cache_dir */
+	struct ewah_bitmap *valid;	/* from untracked_cache_dir */
+	struct ewah_bitmap *sha1_valid; /* set if exclude_sha1 is not null */
+	struct strbuf out;
+	struct strbuf sb_stat;
+	struct strbuf sb_sha1;
+};
+
+static void stat_data_to_disk(struct stat_data *to, const struct stat_=
data *from)
+{
+	to->sd_ctime.sec  =3D htonl(from->sd_ctime.sec);
+	to->sd_ctime.nsec =3D htonl(from->sd_ctime.nsec);
+	to->sd_mtime.sec  =3D htonl(from->sd_mtime.sec);
+	to->sd_mtime.nsec =3D htonl(from->sd_mtime.nsec);
+	to->sd_dev	  =3D htonl(from->sd_dev);
+	to->sd_ino	  =3D htonl(from->sd_ino);
+	to->sd_uid	  =3D htonl(from->sd_uid);
+	to->sd_gid	  =3D htonl(from->sd_gid);
+	to->sd_size	  =3D htonl(from->sd_size);
+}
+
+static void write_one_dir(struct untracked_cache_dir *untracked,
+			  struct write_data *wd)
+{
+	struct stat_data stat_data;
+	struct strbuf *out =3D &wd->out;
+	unsigned char intbuf[16];
+	unsigned int intlen, value;
+	int i =3D wd->index++;
+
+	/*
+	 * untracked_nr should be reset whenever valid is clear, but
+	 * for safety..
+	 */
+	if (!untracked->valid) {
+		untracked->untracked_nr =3D 0;
+		untracked->check_only =3D 0;
+	}
+
+	if (untracked->check_only)
+		ewah_set(wd->check_only, i);
+	if (untracked->valid) {
+		ewah_set(wd->valid, i);
+		stat_data_to_disk(&stat_data, &untracked->stat_data);
+		strbuf_add(&wd->sb_stat, &stat_data, sizeof(stat_data));
+	}
+	if (!is_null_sha1(untracked->exclude_sha1)) {
+		ewah_set(wd->sha1_valid, i);
+		strbuf_add(&wd->sb_sha1, untracked->exclude_sha1, 20);
+	}
+
+	intlen =3D encode_varint(untracked->untracked_nr, intbuf);
+	strbuf_add(out, intbuf, intlen);
+
+	/* skip non-recurse directories */
+	for (i =3D 0, value =3D 0; i < untracked->dirs_nr; i++)
+		if (untracked->dirs[i]->recurse)
+			value++;
+	intlen =3D encode_varint(value, intbuf);
+	strbuf_add(out, intbuf, intlen);
+
+	strbuf_add(out, untracked->name, strlen(untracked->name) + 1);
+
+	for (i =3D 0; i < untracked->untracked_nr; i++)
+		strbuf_add(out, untracked->untracked[i],
+			   strlen(untracked->untracked[i]) + 1);
+
+	for (i =3D 0; i < untracked->dirs_nr; i++)
+		if (untracked->dirs[i]->recurse)
+			write_one_dir(untracked->dirs[i], wd);
+}
+
+void write_untracked_extension(struct strbuf *out, struct untracked_ca=
che *untracked)
+{
+	struct ondisk_untracked_cache *ouc;
+	struct write_data wd;
+	unsigned char varbuf[16];
+	int len =3D 0, varint_len;
+	if (untracked->exclude_per_dir)
+		len =3D strlen(untracked->exclude_per_dir);
+	ouc =3D xmalloc(sizeof(*ouc) + len);
+	stat_data_to_disk(&ouc->info_exclude_stat, &untracked->ss_info_exclud=
e.stat);
+	stat_data_to_disk(&ouc->excludes_file_stat, &untracked->ss_excludes_f=
ile.stat);
+	hashcpy(ouc->info_exclude_sha1, untracked->ss_info_exclude.sha1);
+	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.sha1);
+	ouc->dir_flags =3D htonl(untracked->dir_flags);
+	memcpy(ouc->exclude_per_dir, untracked->exclude_per_dir, len + 1);
+	strbuf_add(out, ouc, sizeof(*ouc) + len);
+	if (!untracked->root) {
+		varint_len =3D encode_varint(0, varbuf);
+		strbuf_add(out, varbuf, varint_len);
+		return;
+	}
+
+	wd.index      =3D 0;
+	wd.check_only =3D ewah_new();
+	wd.valid      =3D ewah_new();
+	wd.sha1_valid =3D ewah_new();
+	strbuf_init(&wd.out, 1024);
+	strbuf_init(&wd.sb_stat, 1024);
+	strbuf_init(&wd.sb_sha1, 1024);
+	write_one_dir(untracked->root, &wd);
+
+	varint_len =3D encode_varint(wd.index, varbuf);
+	strbuf_add(out, varbuf, varint_len);
+	strbuf_addbuf(out, &wd.out);
+	ewah_serialize_strbuf(wd.valid, out);
+	ewah_serialize_strbuf(wd.check_only, out);
+	ewah_serialize_strbuf(wd.sha1_valid, out);
+	strbuf_addbuf(out, &wd.sb_stat);
+	strbuf_addbuf(out, &wd.sb_sha1);
+	strbuf_addch(out, '\0'); /* safe guard for string lists */
+
+	ewah_free(wd.valid);
+	ewah_free(wd.check_only);
+	ewah_free(wd.sha1_valid);
+	strbuf_release(&wd.out);
+	strbuf_release(&wd.sb_stat);
+	strbuf_release(&wd.sb_sha1);
+}
diff --git a/dir.h b/dir.h
index 95baf01..dc3ee0b 100644
--- a/dir.h
+++ b/dir.h
@@ -298,4 +298,5 @@ static inline int dir_path_match(const struct dir_e=
ntry *ent,
 			      has_trailing_dir);
 }
=20
+void write_untracked_extension(struct strbuf *out, struct untracked_ca=
che *untracked);
 #endif
diff --git a/read-cache.c b/read-cache.c
index 6f0057f..baf3057 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -37,6 +37,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce,
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
 #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
+#define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
=20
 /* changes that can be kept in $GIT_DIR/index (basically all extension=
s) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
@@ -2016,6 +2017,17 @@ static int do_write_index(struct index_state *is=
tate, int newfd,
 		if (err)
 			return -1;
 	}
+	if (!strip_extensions && istate->untracked) {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		write_untracked_extension(&sb, istate->untracked);
+		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_UNTRACKED,
+					     sb.len) < 0 ||
+			ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
=20
 	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
 		return -1;
--=20
2.2.0.60.gb7b3c64
