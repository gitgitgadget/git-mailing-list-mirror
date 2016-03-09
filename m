From: David Turner <dturner@twopensource.com>
Subject: [PATCH 10/19] read-cache: add watchman 'WAMA' extension
Date: Wed,  9 Mar 2016 13:36:13 -0500
Message-ID: <1457548582-28302-11-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiys-0007PD-8U
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933843AbcCIShB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:37:01 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33067 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624AbcCISgn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:43 -0500
Received: by mail-qk0-f182.google.com with SMTP id s5so24030753qkd.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VmMHEvH1e2pn9yqNiowGZBO2a+DlcODHp4MSkLkLxqk=;
        b=UQ2NoOnBvHoL7yx2wIPxf4T6jg1aOAV1e1Iv/xGdTKKWp+C5u8dJ7xrP501LvHAYcO
         o9cZf83xn2lcUBhViQcaDZpMgGsViSYuQbU9FWFrci2/Lka7AMsWvkGPK8szDNdmk+Nu
         D9Dj0t85ymaqgA8mtp51834uqHBtbct49KgTZE2oq829GE8NSo4zjQncpK33W/Tngvfi
         1m3u5O9IZniOYGkMfxs7pLtnbVR1k0hQpujDANMXBbxpaLxwJQQexfNn0B681OqLOQmp
         rr0pc9bsSXes5hofFLfdXO4/x7TsRTakuKx1819nfNKKbd1s6SGtmxZ/MbigBSkifaAB
         FpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VmMHEvH1e2pn9yqNiowGZBO2a+DlcODHp4MSkLkLxqk=;
        b=MjytBNz5z0XMQNrTtLmUK9q3stLjkDsSHZPvfo6oPd+2dmNBskM+PCjiIZTjT4am51
         SAvPXEHSa8MojGi8vmNbpLW/g0bWYAyV8OPyKhn+dKZ1VLbWOUzwwHVef/2FabuKMXSS
         NmQ2eWb5wRuX34iyxuTdomh/9VkO6yAX5Tob/8WneNvYpcePFv4qLThpvBv9unUn/olF
         q8Y7//fCE4qp2+1Hs2fpW0wWlfT8Y4gm9c+DwOEOn+rTMHWrTafWreo34wth4DT2sgom
         mBjU6Lp/+jMwFl6MVi7JA1KFysmefsqY97rTK0Da23y0ljycmKSZHxbqhUMKYMTXNEym
         HaMg==
X-Gm-Message-State: AD7BkJLX+qz/0zssPUX8bmb7z9fYlTbSBHYUsFzVDHPwfvkzZNd6OHxuhSgL6PMVCK0a2A==
X-Received: by 10.55.212.207 with SMTP id s76mr45222828qks.78.1457548602323;
        Wed, 09 Mar 2016 10:36:42 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:41 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288556>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The extension contains a bitmap, one bit for each entry in the
index. If the n-th bit is zero, the n-th entry is considered
unchanged, we can ce_mark_uptodate() it without refreshing. If the bit
is non-zero and we found out the corresponding file is clean after
refresh, we can clear the bit.

The 'skipping refresh' bit is not in this patch yet as we would need
watchman. More details in later patches.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      |  4 ++++
 read-cache.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index cc1f6f5..8f7b4b1 100644
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
diff --git a/read-cache.c b/read-cache.c
index 16fbdf6..85ef15b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -19,6 +19,7 @@
 #include "split-index.h"
 #include "utf8.h"
 #include "shm.h"
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
@@ -1224,8 +1227,13 @@ int refresh_index(struct index_state *istate, un=
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
@@ -1369,6 +1377,48 @@ static int verify_hdr(const struct cache_header =
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
+
+	if (memchr(data, 0, sz) =3D=3D NULL)
+		return error("invalid extension");
+	len =3D strlen(data) + 1;
+	bitmap =3D ewah_new();
+	ret =3D ewah_read_mmap(bitmap, (const char *)data + len, sz - len);
+	if (ret !=3D sz - len) {
+		ewah_free(bitmap);
+		return error("failed to parse ewah bitmap reading watchman index ext=
ension");
+	}
+	istate->last_update =3D xstrdup(data);
+	ewah_each_bit(bitmap, mark_no_watchman, istate);
+	ewah_free(bitmap);
+	return 0;
+}
+
+static void write_watchman_ext(struct strbuf *sb, struct index_state* =
istate)
+{
+	struct ewah_bitmap *bitmap;
+	int i;
+
+	strbuf_add(sb, istate->last_update, strlen(istate->last_update) + 1);
+	bitmap =3D ewah_new();
+	for (i =3D 0; i < istate->cache_nr; i++)
+		if (istate->cache[i]->ce_flags & CE_WATCHMAN_DIRTY)
+			ewah_set(bitmap, i);
+	ewah_serialize_strbuf(bitmap, sb);
+	ewah_free(bitmap);
+}
+
 static int read_index_extension(struct index_state *istate,
 				const char *ext, void *data, unsigned long sz)
 {
@@ -1386,6 +1436,11 @@ static int read_index_extension(struct index_sta=
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
@@ -1817,6 +1872,8 @@ int discard_index(struct index_state *istate)
 	istate->untracked =3D NULL;
 	istate->from_shm =3D 0;
 	istate->to_shm   =3D 0;
+	free(istate->last_update);
+	istate->last_update =3D NULL;
 	return 0;
 }
=20
@@ -2214,6 +2271,16 @@ static int do_write_index(struct index_state *is=
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
