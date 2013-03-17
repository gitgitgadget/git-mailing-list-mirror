From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Preallocate hash tables when the number of inserts are known in advance
Date: Sun, 17 Mar 2013 10:28:06 +0700
Message-ID: <1363490886-29729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 17 04:29:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH4HR-0001GT-3H
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 04:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab3CQD22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Mar 2013 23:28:28 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49644 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab3CQD22 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 23:28:28 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo15so5430629pbc.33
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 20:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=TxwaRR5Zy/5RK/fTFX25UOAKTCXL1r9UJuXX/MEWtd4=;
        b=K1hzVIYoUnAwpU3GAidZebb6NPW8HcQkzpTm0AkHsBd10YTQEl+bPEbQcSo+lLgqRK
         zGkyP7kXqyuBn6ctrcY1zyKqAnxaZe/Rq09t/tjovBiIIJDieTmqvp7q2szmLLojjiZn
         4XpyFdCZQa6DYPkTiKxxYKyGauGdYNbFXtIOCM0pXN6/nmovaOsQQpy+BlxGgajIFkNf
         5KclXV3BqXQY7JdV9U3HyliKaQDZUGrb7NOJML/MoQWiUFRN/jy68gerMuz0W8GsJG5t
         f4z0deb0ujWpCHhIc2g39hBtSx9OiA/89uh5VXT8nsuRsLIVRVHQ1aUmE/m49TEgtjfY
         2R4w==
X-Received: by 10.69.3.97 with SMTP id bv1mr26869045pbd.73.1363490907445;
        Sat, 16 Mar 2013 20:28:27 -0700 (PDT)
Received: from lanh ([115.74.60.201])
        by mx.google.com with ESMTPS id ri1sm15331053pbc.16.2013.03.16.20.28.23
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 16 Mar 2013 20:28:26 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 17 Mar 2013 10:28:21 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218324>

This avoids unnecessary re-allocations and reinsertions. On webkit.git
(i.e. about 182k inserts to the name hash table), this reduces about
100ms out of 3s user time.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 nd/read-directory-recursive-optim reduces the number of input (from
 182k to 11k on webkit) to exclude machinery that all patches in the
 exclude optimization series I posted seem insignificant. So I won't
 repost them for inclusion unless you think it has cleanup values.

 This one is worth doing though. I think keeping "untracked index"
 would help avoid looking up in name-hash, where all user-space CPU
 cycles are spent. But I have nothing to show about that.

 diffcore-rename.c | 1 +
 hash.h            | 7 +++++++
 name-hash.c       | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 512d0ac..8d3d9bb 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -389,6 +389,7 @@ static int find_exact_renames(struct diff_options *=
options)
 	struct hash_table file_table;
=20
 	init_hash(&file_table);
+	preallocate_hash(&file_table, (rename_src_nr + rename_dst_nr) * 2);
 	for (i =3D 0; i < rename_src_nr; i++)
 		insert_file_table(&file_table, -1, i, rename_src[i].p->one);
=20
diff --git a/hash.h b/hash.h
index b875ce6..244d1fe 100644
--- a/hash.h
+++ b/hash.h
@@ -40,4 +40,11 @@ static inline void init_hash(struct hash_table *tabl=
e)
 	table->array =3D NULL;
 }
=20
+static inline void preallocate_hash(struct hash_table *table, unsigned=
 int size)
+{
+	assert(table->size =3D=3D 0 && table->nr =3D=3D 0 && table->array =3D=
=3D NULL);
+	table->size =3D size;
+	table->array =3D xcalloc(sizeof(struct hash_table_entry), size);
+}
+
 #endif
diff --git a/name-hash.c b/name-hash.c
index 942c459..12364d1 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -92,6 +92,8 @@ static void lazy_init_name_hash(struct index_state *i=
state)
=20
 	if (istate->name_hash_initialized)
 		return;
+	if (istate->cache_nr)
+		preallocate_hash(&istate->name_hash, istate->cache_nr * 2);
 	for (nr =3D 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
 	istate->name_hash_initialized =3D 1;
--=20
1.8.2.83.gc99314b
