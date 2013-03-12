From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 11/13] Preallocate hash tables when the number of inserts are known in advance
Date: Tue, 12 Mar 2013 20:04:58 +0700
Message-ID: <1363093500-16796-12-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:07:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOvG-00086y-7Z
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534Ab3CLNGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:06:43 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:53898 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932528Ab3CLNGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:06:38 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so4951629pbc.26
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=g7KXJ9roIdepTojpix7KjqRhA0+OYIQmUJZoPgXplM0=;
        b=lRlW9tjmcpy/YNihbTUQtzuk6rfdDzwvRntAir7AEjDgULf8dbzUgLpEBG+k/Z3JL4
         xLA1Hj6eQaR9a8+72Lb27MSrodOZ51XBmLh59rYgeRKce1KIbtAzz9D2KR3RZ+jkSjOY
         wZFgz+WlyTtS9hwraBn47mjIaw8ZNh+U3WHPkucVORPZk+fx8i1wFbDmnRzonihviY3G
         Irm80iwl5AWkELRKlXpoA5ZUxpZz6dFOHggvceTHqiarAIkz7QD51IXNkeV+tMK7bkL/
         J6A1cWmN++NVET/ryiWpTFhElPaOOVIBv5BsD3B90RqS5d0JND8ziPi4NraHHH1Jz7A/
         X7Og==
X-Received: by 10.68.213.66 with SMTP id nq2mr36769119pbc.29.1363093598009;
        Tue, 12 Mar 2013 06:06:38 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id rr14sm24987814pbb.34.2013.03.12.06.06.35
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:06:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:06:32 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217960>

This avoids unnecessary allocations and reinsertions. On webkit.git
(i.e. about 100k inserts to the name hash table), this reduces about
100ms out of 3s user time.

treat_leading_path:   0.000  0.000
read_directory:       1.299  1.305
+treat_one_path:      0.599  0.599
++is_excluded:        0.103  0.103
+++prep_exclude:      0.040  0.040
+++matching:          0.036  0.035
++dir_exist:          0.036  0.035
++index_name_exists:  0.291  0.292
lazy_init_name_hash:  0.257  0.155
+simplify_away:       0.082  0.083
+dir_add_name:        0.000  0.000


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diffcore-rename.c | 1 +
 hash.h            | 7 +++++++
 name-hash.c       | 1 +
 3 files changed, 9 insertions(+)

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
index 942c459..1287a19 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -92,6 +92,7 @@ static void lazy_init_name_hash(struct index_state *i=
state)
=20
 	if (istate->name_hash_initialized)
 		return;
+	preallocate_hash(&istate->name_hash, istate->cache_nr * 2);
 	for (nr =3D 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
 	istate->name_hash_initialized =3D 1;
--=20
1.8.1.2.536.gf441e6d
