From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/26] read-cache: new flag CE_WATCHED to mark what file is watched
Date: Mon,  3 Feb 2014 11:28:58 +0700
Message-ID: <1391401754-15347-11-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:30:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABAu-0001A3-Ot
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbaBCEaR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:30:17 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42814 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbaBCEaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:30:15 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so6634027pab.29
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rTOBSveGEk9TB/m2b1hJx08nIU89XslAmMuQJbIr0Ac=;
        b=qypusTHdm7HBg5a7rdTa+ds1FVtnVbV6Hq3diNx/Fu6/eKU/Wl9u2jKr2VMZuwGM73
         d2pZEnK07BPxwVfiPoUJmtjzAcCI7PfWNBnyLCB2+98DsLRCHsoziKOiq3h0B0/IcsjH
         pLu0+TfV6RYhlK6bFqIm1/ZPXehyHbNXdSP36yzmYV4cFULmXs2bXZBMYZZYukP4kxmk
         QaMAfL6XP7GeDgurGWSmWiPxgt7aHExMczqeY5eE3gPnAd+u22R8qjVn8HTYciBD5zyZ
         xGgY2Sm2aB5VAVC6rl4whjW/HUNLxvUOe4rKWjvVE22WdL53socWZs199gD0a3bz7SoJ
         4pCQ==
X-Received: by 10.66.118.71 with SMTP id kk7mr34840922pab.14.1391401814382;
        Sun, 02 Feb 2014 20:30:14 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id pp5sm36796743pbb.33.2014.02.02.20.30.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:30:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:30:12 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241405>

This bit is basically "dynamic CE_VALID". It marks entries that are
being watched by the incoming file-watcher. When an index is loaded,
file watcher is contacted and the list of updated paths is retrieved.

These paths will have CE_WATCHED cleared and lstat() will be called on
them. Those that have CE_WATCHED and not in the list will have
CE_VALID turn on to skip lstat(). The setting is temporarily, CE_VALID
is not saved to disk if CE_WATCHED is also set.

We keep the CE_WATCHED in a new extension, separated from the entries
to save some space because extended ce_flags adds 2 bytes per entry
and this flag would be present in the majority of entries. When stored
as bitmap, this extension could compress very well with ewah algorithm.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/index-format.txt |  6 +++++
 cache.h                                  |  3 +++
 read-cache.c                             | 41 ++++++++++++++++++++++++=
+++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index f352a9b..24fd0ae 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -198,3 +198,9 @@ Git index format
   - At most three 160-bit object names of the entry in stages from 1 t=
o 3
     (nothing is written for a missing stage).
=20
+=3D=3D=3D File watcher
+
+  The signature of this extension is { 'W', 'A', 'T', 'C' }.
+
+  - A bit map of all entries in the index, n-th bit of m-th byte
+    corresponds to CE_WATCHED of the <m * 8+ n>-th index entry.
diff --git a/cache.h b/cache.h
index f14d535..a0af2a5 100644
--- a/cache.h
+++ b/cache.h
@@ -169,6 +169,9 @@ struct cache_entry {
 /* used to temporarily mark paths matched by pathspecs */
 #define CE_MATCHED           (1 << 26)
=20
+/* set CE_VALID at runtime if the entry is guaranteed not updated */
+#define CE_WATCHED           (1 << 27)
+
 /*
  * Extended on-disk flags
  */
diff --git a/read-cache.c b/read-cache.c
index 3b6daf1..098d3b6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -33,6 +33,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce, int reall
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
+#define CACHE_EXT_WATCH 0x57415443	  /* "WATC" */
=20
 struct index_state the_index;
=20
@@ -1289,6 +1290,19 @@ static int verify_hdr(struct cache_header *hdr,
 	return 0;
 }
=20
+static void read_watch_extension(struct index_state *istate, uint8_t *=
data,
+				 unsigned long sz)
+{
+	int i;
+	if ((istate->cache_nr + 7) / 8 !=3D sz) {
+		error("invalid 'WATC' extension");
+		return;
+	}
+	for (i =3D 0; i < istate->cache_nr; i++)
+		if (data[i / 8] & (1 << (i % 8)))
+			istate->cache[i]->ce_flags |=3D CE_WATCHED;
+}
+
 static int read_index_extension(struct index_state *istate,
 				const char *ext, void *data, unsigned long sz)
 {
@@ -1299,6 +1313,9 @@ static int read_index_extension(struct index_stat=
e *istate,
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo =3D resolve_undo_read(data, sz);
 		break;
+	case CACHE_EXT_WATCH:
+		read_watch_extension(istate, data, sz);
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand=
",
@@ -1777,7 +1794,7 @@ int write_index(struct index_state *istate, int n=
ewfd)
 {
 	git_SHA_CTX c;
 	struct cache_header hdr;
-	int i, err, removed, extended, hdr_version;
+	int i, err, removed, extended, hdr_version, has_watches =3D 0;
 	struct cache_entry **cache =3D istate->cache;
 	int entries =3D istate->cache_nr;
 	struct stat st;
@@ -1786,6 +1803,8 @@ int write_index(struct index_state *istate, int n=
ewfd)
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
+		else if (cache[i]->ce_flags & CE_WATCHED)
+			has_watches++;
=20
 		/* reduce extended entries if possible */
 		cache[i]->ce_flags &=3D ~CE_EXTENDED;
@@ -1857,6 +1876,26 @@ int write_index(struct index_state *istate, int =
newfd)
 		if (err)
 			return -1;
 	}
+	if (has_watches) {
+		int id, sz =3D (entries - removed + 7) / 8;
+		uint8_t *data =3D xmalloc(sz);
+		memset(data, 0, sz);
+		for (i =3D 0, id =3D 0; i < entries && has_watches; i++) {
+			struct cache_entry *ce =3D cache[i];
+			if (ce->ce_flags & CE_REMOVE)
+				continue;
+			if (ce->ce_flags & CE_WATCHED) {
+				data[id / 8] |=3D 1 << (id % 8);
+				has_watches--;
+			}
+			id++;
+		}
+		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_WATCH, sz) < 0
+			|| ce_write(&c, newfd, data, sz) < 0;
+		free(data);
+		if (err)
+			return -1;
+	}
=20
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
--=20
1.8.5.2.240.g8478abd
