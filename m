From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/32] split-index: the reading part
Date: Mon, 28 Apr 2014 17:55:43 +0700
Message-ID: <1398682553-11634-23-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:56:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejEq-0003D6-PJ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbaD1K4d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:56:33 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48225 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377AbaD1K4b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:56:31 -0400
Received: by mail-pd0-f179.google.com with SMTP id y10so635197pdj.38
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dfX8nB5oLvbHbIqx9mvvnikvrXzwTGRk/AW/KF0bZ8w=;
        b=AivO6LDb8fTuD1O3IfN6WeGuQeLf9YnUSUcZhGfROsP93cTokqygpaaNKbKijtF6oD
         cFMsxsHZhd8hPEuzrRhDw1MSLboFgNBVFXDx6XGS19Bpnkg+11Tb55uFVsAdBDw55xNV
         Ij5utlnvTzbmkskTLuM6BEHYSuDHHchqLkL21CVYd54gzfdWNmx5TeA7AsBQpi95mM3y
         YpTxAuv6P8I0kw7ksmwToKW/3tBjZzlrejUuepYvIy6MJe1Zd4opUeYAdk5NvtAyORnb
         rNbAUs4sMKO/ffh7Gsdeggu7RSI+ddcTW9pPRcMIwm1kEZPgWH9X3Zv3ctt4aSrbYF3C
         dCsQ==
X-Received: by 10.66.171.76 with SMTP id as12mr24684350pac.52.1398682590584;
        Mon, 28 Apr 2014 03:56:30 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id ci4sm34199284pbb.50.2014.04.28.03.56.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:56:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:57:58 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247286>

CE_REMOVE'd entries are removed here because only parts of the code
base (unpack_trees in fact) test this bit when they look for the
presence of an entry. Leaving them may confuse the code ignores this
bit and expects to see a real entry.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c  |  2 --
 split-index.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 split-index.h |  2 ++
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a717171..a5517bf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1569,8 +1569,6 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
=20
 	if (is_null_sha1(split_index->base_sha1))
 		return ret;
-	if (istate->cache_nr)
-		die("index in split-index mode must contain no entries");
=20
 	if (split_index->base)
 		discard_index(split_index->base);
diff --git a/split-index.c b/split-index.c
index 5708807..b03a250 100644
--- a/split-index.c
+++ b/split-index.c
@@ -16,13 +16,27 @@ int read_link_extension(struct index_state *istate,
 {
 	const unsigned char *data =3D data_;
 	struct split_index *si;
+	int ret;
+
 	if (sz < 20)
 		return error("corrupt link extension (too short)");
 	si =3D init_split_index(istate);
 	hashcpy(si->base_sha1, data);
 	data +=3D 20;
 	sz -=3D 20;
-	if (sz)
+	if (!sz)
+		return 0;
+	si->delete_bitmap =3D ewah_new();
+	ret =3D ewah_read_mmap(si->delete_bitmap, data, sz);
+	if (ret < 0)
+		return error("corrupt delete bitmap in link extension");
+	data +=3D ret;
+	sz -=3D ret;
+	si->replace_bitmap =3D ewah_new();
+	ret =3D ewah_read_mmap(si->replace_bitmap, data, sz);
+	if (ret < 0)
+		return error("corrupt replace bitmap in link extension");
+	if (ret !=3D sz)
 		return error("garbage at the end of link extension");
 	return 0;
 }
@@ -60,15 +74,81 @@ static void mark_base_index_entries(struct index_st=
ate *base)
 		base->cache[i]->index =3D i + 1;
 }
=20
+static void mark_entry_for_delete(size_t pos, void *data)
+{
+	struct index_state *istate =3D data;
+	if (pos >=3D istate->cache_nr)
+		die("position for delete %d exceeds base index size %d",
+		    (int)pos, istate->cache_nr);
+	istate->cache[pos]->ce_flags |=3D CE_REMOVE;
+	istate->split_index->nr_deletions =3D 1;
+}
+
+static void replace_entry(size_t pos, void *data)
+{
+	struct index_state *istate =3D data;
+	struct split_index *si =3D istate->split_index;
+	struct cache_entry *dst, *src;
+	if (pos >=3D istate->cache_nr)
+		die("position for replacement %d exceeds base index size %d",
+		    (int)pos, istate->cache_nr);
+	if (si->nr_replacements >=3D si->saved_cache_nr)
+		die("too many replacements (%d vs %d)",
+		    si->nr_replacements, si->saved_cache_nr);
+	dst =3D istate->cache[pos];
+	if (dst->ce_flags & CE_REMOVE)
+		die("entry %d is marked as both replaced and deleted",
+		    (int)pos);
+	src =3D si->saved_cache[si->nr_replacements];
+	src->index =3D pos + 1;
+	src->ce_flags |=3D CE_UPDATE_IN_BASE;
+	free(dst);
+	dst =3D src;
+	si->nr_replacements++;
+}
+
 void merge_base_index(struct index_state *istate)
 {
 	struct split_index *si =3D istate->split_index;
+	unsigned int i;
=20
 	mark_base_index_entries(si->base);
-	istate->cache_nr =3D si->base->cache_nr;
+
+	si->saved_cache	    =3D istate->cache;
+	si->saved_cache_nr  =3D istate->cache_nr;
+	istate->cache_nr    =3D si->base->cache_nr;
+	istate->cache	    =3D NULL;
+	istate->cache_alloc =3D 0;
 	ALLOC_GROW(istate->cache, istate->cache_nr, istate->cache_alloc);
 	memcpy(istate->cache, si->base->cache,
 	       sizeof(*istate->cache) * istate->cache_nr);
+
+	si->nr_deletions =3D 0;
+	si->nr_replacements =3D 0;
+	ewah_each_bit(si->replace_bitmap, replace_entry, istate);
+	ewah_each_bit(si->delete_bitmap, mark_entry_for_delete, istate);
+	if (si->nr_deletions)
+		remove_marked_cache_entries(istate);
+
+	for (i =3D si->nr_replacements; i < si->saved_cache_nr; i++) {
+		add_index_entry(istate, si->saved_cache[i],
+				ADD_CACHE_OK_TO_ADD |
+				/*
+				 * we may have to replay what
+				 * merge-recursive.c:update_stages()
+				 * does, which has this flag on
+				 */
+				ADD_CACHE_SKIP_DFCHECK);
+		si->saved_cache[i] =3D NULL;
+	}
+
+	ewah_free(si->delete_bitmap);
+	ewah_free(si->replace_bitmap);
+	free(si->saved_cache);
+	si->delete_bitmap  =3D NULL;
+	si->replace_bitmap =3D NULL;
+	si->saved_cache	   =3D NULL;
+	si->saved_cache_nr =3D 0;
 }
=20
 void prepare_to_write_split_index(struct index_state *istate)
diff --git a/split-index.h b/split-index.h
index 53b778f..c1324f5 100644
--- a/split-index.h
+++ b/split-index.h
@@ -12,6 +12,8 @@ struct split_index {
 	struct ewah_bitmap *replace_bitmap;
 	struct cache_entry **saved_cache;
 	unsigned int saved_cache_nr;
+	unsigned int nr_deletions;
+	unsigned int nr_replacements;
 	int refcount;
 };
=20
--=20
1.9.1.346.ga2b5940
