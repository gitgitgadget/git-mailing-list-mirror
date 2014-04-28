From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/32] split-index: strip pathname of on-disk replaced entries
Date: Mon, 28 Apr 2014 17:55:45 +0700
Message-ID: <1398682553-11634-25-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:56:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejEy-0003LV-Ma
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbaD1K4n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:56:43 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50762 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377AbaD1K4l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:56:41 -0400
Received: by mail-pa0-f50.google.com with SMTP id rd3so5649667pab.23
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=47FC9/m1gIgcqveuYDxOLmrxDvUD1b8aRVigSxxtYlw=;
        b=a31awMufYHXQGPrYJocyCIuaZ9tDn1qHZr+Ka1b5gStJlewoNG4seanz/slwcgLcEz
         jxX60yYxkngsv7ZZ/Zn95XQBJ057a1MidVBLr202eVWP1JQHDeABWzkI8AKCsQTHgQOY
         6/tvlenP785+vlPx4hndsD14YoFfiHtuNnxHb+srK/FAtEdIN/ua2PhFSYR46b8EnHzw
         R+CCIDLPMZpD+s0sq1mgqvlX5OzE120cYWA0FeueaR72hnlE3mNB5nIKCI7d/9KllhdV
         NldvttF3qamg8NlPDPUD+6dHofgsbe9qkJrMIwOPxCdGN/udOVEVLlBXlAmgbpzrhg+d
         zpLQ==
X-Received: by 10.68.139.2 with SMTP id qu2mr1744200pbb.164.1398682600908;
        Mon, 28 Apr 2014 03:56:40 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id lr3sm89694579pab.4.2014.04.28.03.56.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:56:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:58:09 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247289>

We know the positions of replaced entries via the replace bitmap in
"link" extension, so the "name" path does not have to be stored (it's
still in the shared index). With this, we also have a way to
distinguish additions vs replacements at load time and can catch
broken "link" extensions.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h       |  1 +
 read-cache.c  | 10 ++++++++++
 split-index.c | 14 ++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index be95b84..604328b 100644
--- a/cache.h
+++ b/cache.h
@@ -170,6 +170,7 @@ struct cache_entry {
 #define CE_MATCHED           (1 << 26)
=20
 #define CE_UPDATE_IN_BASE    (1 << 27)
+#define CE_STRIP_NAME        (1 << 28)
=20
 /*
  * Extended on-disk flags
diff --git a/read-cache.c b/read-cache.c
index 43a61d3..81835a6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1787,9 +1787,15 @@ static int ce_write_entry(git_SHA_CTX *c, int fd=
, struct cache_entry *ce,
 {
 	int size;
 	struct ondisk_cache_entry *ondisk;
+	int saved_namelen;
 	char *name;
 	int result;
=20
+	if (ce->ce_flags & CE_STRIP_NAME) {
+		saved_namelen =3D ce_namelen(ce);
+		ce->ce_namelen =3D 0;
+	}
+
 	if (!previous_name) {
 		size =3D ondisk_ce_size(ce);
 		ondisk =3D xcalloc(1, size);
@@ -1821,6 +1827,10 @@ static int ce_write_entry(git_SHA_CTX *c, int fd=
, struct cache_entry *ce,
 		strbuf_splice(previous_name, common, to_remove,
 			      ce->name + common, ce_namelen(ce) - common);
 	}
+	if (ce->ce_flags & CE_STRIP_NAME) {
+		ce->ce_namelen =3D saved_namelen;
+		ce->ce_flags &=3D ~CE_STRIP_NAME;
+	}
=20
 	result =3D ce_write(c, fd, ondisk, size);
 	free(ondisk);
diff --git a/split-index.c b/split-index.c
index 33c0c4b..ee3246f 100644
--- a/split-index.c
+++ b/split-index.c
@@ -89,6 +89,7 @@ static void replace_entry(size_t pos, void *data)
 	struct index_state *istate =3D data;
 	struct split_index *si =3D istate->split_index;
 	struct cache_entry *dst, *src;
+
 	if (pos >=3D istate->cache_nr)
 		die("position for replacement %d exceeds base index size %d",
 		    (int)pos, istate->cache_nr);
@@ -100,10 +101,14 @@ static void replace_entry(size_t pos, void *data)
 		die("entry %d is marked as both replaced and deleted",
 		    (int)pos);
 	src =3D si->saved_cache[si->nr_replacements];
+	if (ce_namelen(src))
+		die("corrupt link extension, entry %d should have "
+		    "zero length name", (int)pos);
 	src->index =3D pos + 1;
 	src->ce_flags |=3D CE_UPDATE_IN_BASE;
-	free(dst);
-	dst =3D src;
+	src->ce_namelen =3D dst->ce_namelen;
+	copy_cache_entry(dst, src);
+	free(src);
 	si->nr_replacements++;
 }
=20
@@ -131,6 +136,9 @@ void merge_base_index(struct index_state *istate)
 		remove_marked_cache_entries(istate);
=20
 	for (i =3D si->nr_replacements; i < si->saved_cache_nr; i++) {
+		if (!ce_namelen(si->saved_cache[i]))
+			die("corrupt link extension, entry %d should "
+			    "have non-zero length name", i);
 		add_index_entry(istate, si->saved_cache[i],
 				ADD_CACHE_OK_TO_ADD |
 				ADD_CACHE_KEEP_CACHE_TREE |
@@ -213,6 +221,7 @@ void prepare_to_write_split_index(struct index_stat=
e *istate)
 				ewah_set(si->delete_bitmap, i);
 			else if (ce->ce_flags & CE_UPDATE_IN_BASE) {
 				ewah_set(si->replace_bitmap, i);
+				ce->ce_flags |=3D CE_STRIP_NAME;
 				ALLOC_GROW(entries, nr_entries+1, nr_alloc);
 				entries[nr_entries++] =3D ce;
 			}
@@ -222,6 +231,7 @@ void prepare_to_write_split_index(struct index_stat=
e *istate)
 	for (i =3D 0; i < istate->cache_nr; i++) {
 		ce =3D istate->cache[i];
 		if ((!si->base || !ce->index) && !(ce->ce_flags & CE_REMOVE)) {
+			assert(!(ce->ce_flags & CE_STRIP_NAME));
 			ALLOC_GROW(entries, nr_entries+1, nr_alloc);
 			entries[nr_entries++] =3D ce;
 		}
--=20
1.9.1.346.ga2b5940
