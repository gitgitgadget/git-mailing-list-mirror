From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/32] split-index: the reading part
Date: Fri, 13 Jun 2014 19:19:41 +0700
Message-ID: <1402661991-14977-23-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:22:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQUu-0004Ih-Am
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbaFMMWP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:22:15 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33835 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbaFMMWN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:22:13 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so1519136pab.32
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1Pj3MksbDgmHrZdQDzVf+kTjHEQfBxmNs016EgrI8Yg=;
        b=R3uUexb/BjXaP6GqAVXgcMqcv4/BU/3JXU2n4ReoT1OvRFrJXsQUhMkXK3qPI0o/0D
         13k+jmBYEhOrCHVA+MvEe88WuFr02t/I3E/J6hUZ62ve+BSnA99pPLN93pigBpBVP6RX
         4duGtjn53Z7pCyrNm1hEjiRlVmzHMbq2aCqUqwnoUWiKLgu3Y/tA9Nio3zSqsSHr+gDD
         6mD+D8PNpF9iD6N9CUzlsZLGCKiA0m1eJfzXTWlaRpxrkdz2U7UxwKAVJBknTxkl/HEB
         dzCzw/SWVyZnrl5AJmML3SH5BtTywKv36PvRH6cbD6rGSxgZxe8N9icQdLfdV2Grm2Yh
         I6pQ==
X-Received: by 10.69.10.164 with SMTP id eb4mr2896768pbd.35.1402662133432;
        Fri, 13 Jun 2014 05:22:13 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id xy2sm20773151pab.16.2014.06.13.05.22.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:22:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:22:13 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251578>

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
index 7966fb7..1a7ef7f 100644
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
