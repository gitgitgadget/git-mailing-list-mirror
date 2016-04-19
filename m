From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 07/15] read-cache: add watchman 'WAMA' extension
Date: Tue, 19 Apr 2016 19:28:01 -0400
Message-ID: <1461108489-29376-8-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:28:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf4O-0008Hl-KM
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbcDSX20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 19:28:26 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36329 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbcDSX2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:24 -0400
Received: by mail-qg0-f53.google.com with SMTP id f52so19235747qga.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=No3CKCItPAlSjOXMXp0Q8DgbZAACnyb5Pq1P5MswYDU=;
        b=Z3b2gDNihVK0UHAUFpvLfhJ2k/M7kPqxK+DYjSzUctXenNkCIMLNoficpYqlXbymx/
         HgsrmU3D86dQ6OmoTHq3urbDGaKKF9QMFjeFI0ZtJyAl5s2zDThlcedbQ+otEAe8Q+O+
         C00hm6EeixdFWoncfhVkl+26/YPRcodCf+++GU0S4DqHDeidFgEScG46MwwizawXx81Y
         R0zujYwHF6gOFu5X4wD0q7iENlXPw+v/4co9LG7V8CcOFdyVHXSyWx+qzIhkm5op3pW6
         tyRzmBhQDcd3aFcpMPTFRpL5dTBXQguXAudkG5MnFhFTXk+xqjFw+wYFfgfs0VBYp5Jl
         RnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=No3CKCItPAlSjOXMXp0Q8DgbZAACnyb5Pq1P5MswYDU=;
        b=A/ysJ+wWi7tcfgx4odRtH0dG1KG944FZpUTbqxnjVT9dJN51GnXHhSNJkEAfQk4b7P
         fDe12JNg8LkROpO9SfQhyf8+vtWqwDUuvB7WbWH4BSVtKH8ot72AAOIqdIZCIwHKpmMJ
         st6UX67Ia0yDSX68JQoqsQjuxwbsMXFIangTHobbvnLkL1U57fpsTZBV6lG3ZOb75HR5
         ArO4nz3kUdxx4jyP+K9qb/hN9YzQGP2ofUod7VljLdgfzClLy2zj9uduzI+Yf1AIboHc
         K9d8Hv6FPqr776ohmtGmefinerCUXOE+FP3fjVBhUZmQNjxeOmab+0/8SxIG/gdLhtgW
         VOlA==
X-Gm-Message-State: AOPr4FUS2aI9s5LDUAGYNJ/748dgeWJ5sx2LsWe/Cy9pJUMTRT+o48YVWdoQpmufFecGZg==
X-Received: by 10.140.229.69 with SMTP id z66mr7310538qhb.48.1461108503191;
        Tue, 19 Apr 2016 16:28:23 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291959>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The extension contains a bitmap, one bit for each entry in the
index. If the n-th bit is zero, the n-th entry is considered
unchanged, we can ce_mark_uptodate() it without refreshing. If the bit
is non-zero and we found out the corresponding file is clean after
refresh, we can clear the bit.

In addition, there's a list of directories in the untracked-cache
to invalidate (because they have new or modified entries).

The 'skipping refresh' bit is not in this patch yet as we would need
watchman. More details in later patches.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/technical/index-format.txt |  22 ++++++
 cache.h                                  |   4 ++
 dir.h                                    |   3 +
 read-cache.c                             | 117 +++++++++++++++++++++++=
+++++++-
 4 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index ade0b0c..86ed3a6 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -295,3 +295,25 @@ The remaining data of each directory block is grou=
ped by type:
     in the previous ewah bitmap.
=20
   - One NUL.
+
+=3D=3D Watchman cache
+
+  The watchman cache tracks files for which watchman has told us about
+  changes.  The signature for this extension is { 'W', 'A', 'M', 'A' }=
=2E
+
+  The extension starts with
+
+  - A NUL-terminated string: the watchman vector clock at the last
+    time we heard from watchman.
+
+  - 32-bit bitmap size: the size of the CE_WATCHMAN_DIRTY bitmap
+
+  - 32-bit untracked cache entry count: the number of dirty untracked
+    cache entries
+
+  - An ewah bitmap, the n-th bit indicates whether the n-th index entr=
y
+    is CE_WATCHMAN_DIRTY.
+
+  - a list of N NUL-terminated strings.  Each is a directory that shou=
ld
+    be marked dirty in the untracked cache because watchman has told u=
s
+    about an update to a file in it.
diff --git a/cache.h b/cache.h
index 0aeb994..f4f7eef 100644
--- a/cache.h
+++ b/cache.h
@@ -182,6 +182,8 @@ struct cache_entry {
 #define CE_VALID     (0x8000)
 #define CE_STAGESHIFT 12
=20
+#define CE_WATCHMAN_DIRTY  (0x0001)
+
 /*
  * Range 0xFFFF0FFF in ce_flags is divided into
  * two parts: in-memory flags and on-disk ones.
@@ -320,6 +322,7 @@ static inline unsigned int canon_mode(unsigned int =
mode)
 #define CACHE_TREE_CHANGED	(1 << 5)
 #define SPLIT_INDEX_ORDERED	(1 << 6)
 #define UNTRACKED_CHANGED	(1 << 7)
+#define WATCHMAN_CHANGED	(1 << 8)
=20
 struct split_index;
 struct untracked_cache;
@@ -344,6 +347,7 @@ struct index_state {
 	struct untracked_cache *untracked;
 	void *mmap;
 	size_t mmap_size;
+	char *last_update;
 };
=20
 extern struct index_state the_index;
diff --git a/dir.h b/dir.h
index 3ec3fb0..3d540de 100644
--- a/dir.h
+++ b/dir.h
@@ -142,6 +142,9 @@ struct untracked_cache {
 	int gitignore_invalidated;
 	int dir_invalidated;
 	int dir_opened;
+	/* watchman invalidation data */
+	unsigned int use_watchman : 1;
+	struct string_list invalid_untracked;
 };
=20
 struct dir_struct {
diff --git a/read-cache.c b/read-cache.c
index 5df5b21..050668f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -19,6 +19,7 @@
 #include "split-index.h"
 #include "utf8.h"
 #include "unix-socket.h"
+#include "ewah/ewok.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -41,11 +42,13 @@ static struct cache_entry *refresh_cache_entry(stru=
ct cache_entry *ce,
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
 #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
 #define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
+#define CACHE_EXT_WATCHMAN 0x57414D41	  /* "WAMA" */
=20
 /* changes that can be kept in $GIT_DIR/index (basically all extension=
s) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
 		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED | \
-		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED)
+		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED | \
+		 WATCHMAN_CHANGED)
=20
 struct index_state the_index;
 static const char *alternate_index_output;
@@ -1220,8 +1223,13 @@ int refresh_index(struct index_state *istate, un=
signed int flags,
 			continue;
=20
 		new =3D refresh_cache_ent(istate, ce, options, &cache_errno, &change=
d);
-		if (new =3D=3D ce)
+		if (new =3D=3D ce) {
+			if (ce->ce_flags & CE_WATCHMAN_DIRTY) {
+				ce->ce_flags          &=3D ~CE_WATCHMAN_DIRTY;
+				istate->cache_changed |=3D WATCHMAN_CHANGED;
+			}
 			continue;
+		}
 		if (!new) {
 			const char *fmt;
=20
@@ -1365,6 +1373,94 @@ static int verify_hdr(const struct cache_header =
*hdr, unsigned long size)
 	return 0;
 }
=20
+static void mark_no_watchman(size_t pos, void *data)
+{
+	struct index_state *istate =3D data;
+	assert(pos < istate->cache_nr);
+	istate->cache[pos]->ce_flags |=3D CE_WATCHMAN_DIRTY;
+}
+
+static int read_watchman_ext(struct index_state *istate, const void *d=
ata,
+			     unsigned long sz)
+{
+	struct ewah_bitmap *bitmap;
+	int ret, len;
+	uint32_t bitmap_size;
+	uint32_t untracked_nr;
+
+	if (memchr(data, 0, sz) =3D=3D NULL)
+		return error("invalid extension");
+
+	len =3D strlen(data) + 1;
+	memcpy(&bitmap_size, (const char *)data + len, 4);
+	memcpy(&untracked_nr, (const char *)data + len + 4, 4);
+	untracked_nr =3D ntohl(untracked_nr);
+	bitmap_size =3D ntohl(bitmap_size);
+
+	bitmap =3D ewah_new();
+	ret =3D ewah_read_mmap(bitmap, (const char *)data + len + 8, bitmap_s=
ize);
+	if (ret !=3D bitmap_size) {
+		ewah_free(bitmap);
+		return error("failed to parse ewah bitmap reading watchman index ext=
ension");
+	}
+	istate->last_update =3D xstrdup(data);
+	ewah_each_bit(bitmap, mark_no_watchman, istate);
+	ewah_free(bitmap);
+
+	/*
+	 * TODO: update the untracked cache from the untracked data in this
+	 * extension.
+	 */
+	return 0;
+}
+
+static int untracked_entry_append(struct string_list_item *item, void =
*sbvoid)
+{
+	struct strbuf *sb =3D sbvoid;
+
+	strbuf_addstr(sb, item->string);
+	strbuf_addch(sb, 0);
+	return 0;
+}
+
+void write_watchman_ext(struct strbuf *sb, struct index_state* istate)
+{
+	struct ewah_bitmap *bitmap;
+	int i;
+	int ewah_start;
+	int ewah_size =3D 0;
+	int fixup =3D 0;
+
+	strbuf_add(sb, istate->last_update, strlen(istate->last_update) + 1);
+	fixup =3D sb->len;
+	strbuf_add(sb, &ewah_size, 4); /* we'll fix this up later */
+	if (istate->untracked) {
+		uint32_t nr =3D istate->untracked->invalid_untracked.nr;
+		nr =3D htonl(nr);
+		strbuf_add(sb, &nr, 4);
+	} else {
+		/* zero */
+		strbuf_add(sb, &ewah_size, 4);
+	}
+
+	ewah_start =3D sb->len;
+	bitmap =3D ewah_new();
+	for (i =3D 0; i < istate->cache_nr; i++)
+		if (istate->cache[i]->ce_flags & CE_WATCHMAN_DIRTY)
+			ewah_set(bitmap, i);
+	ewah_serialize_strbuf(bitmap, sb);
+	ewah_free(bitmap);
+
+	/* fix up size field */
+	ewah_size =3D sb->len - ewah_start;
+	ewah_size =3D htonl(ewah_size);
+	memcpy(sb->buf + fixup, &ewah_size, 4);
+
+	if (istate->untracked)
+		for_each_string_list(&istate->untracked->invalid_untracked,
+				     untracked_entry_append, sb);
+}
+
 static int read_index_extension(struct index_state *istate,
 				const char *ext, void *data, unsigned long sz)
 {
@@ -1382,6 +1478,11 @@ static int read_index_extension(struct index_sta=
te *istate,
 	case CACHE_EXT_UNTRACKED:
 		istate->untracked =3D read_untracked_extension(data, sz);
 		break;
+
+	case CACHE_EXT_WATCHMAN:
+		read_watchman_ext(istate, data, sz);
+		break;
+
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand=
",
@@ -1812,6 +1913,8 @@ int discard_index(struct index_state *istate)
 	istate->untracked =3D NULL;
 	istate->from_shm =3D 0;
 	istate->to_shm   =3D 0;
+	free(istate->last_update);
+	istate->last_update =3D NULL;
 	return 0;
 }
=20
@@ -2209,6 +2312,16 @@ static int do_write_index(struct index_state *is=
tate, int newfd,
 		if (err)
 			return -1;
 	}
+	if (!strip_extensions && istate->last_update) {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		write_watchman_ext(&sb, istate);
+		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_WATCHMAN, sb.len=
) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
=20
 	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
 		return -1;
--=20
2.4.2.767.g62658d5-twtrsrc
