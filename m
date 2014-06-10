From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] read-cache: allow to keep mmap'd memory after reading
Date: Tue, 10 Jun 2014 20:24:21 +0700
Message-ID: <1402406665-27988-2-git-send-email-pclouds@gmail.com>
References: <1402406665-27988-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 15:26:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuM4M-00045n-B8
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 15:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbaFJN00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 09:26:26 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:62151 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbaFJN0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 09:26:25 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so711454pad.9
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tIcrSlmY26WA5Ev3DNnpKmYHUrdjUm2PSd0ur1GhuH0=;
        b=xMrCpdiM4vc5hAxzsB6upQ/xw5dW4lbC8P9lhYmOxbOKLbkprMsRUkxDizOQ+gdQsq
         RX1HGgtisWEqobrDUv2Lz9apP56kDRQKfvv4BS8AjSGO7pz7PMBFNlIoXiTVZChnXRbJ
         k+Fqu6tTgJacAG8o73CTHSwgwxkf18qOEVG8K5dLVz8rmy1d6kKonIh0NduXPF94r3Gt
         2WDkg5i0q10HOPXu8aamd0UKn5YfmtilgJTI26HM5gk5dyU9t63cJfxyQ+4Zc2WCBJs/
         wYNXfA948mFdqFPjXvZVvQ15b2dS8m5byCzIlAybSpET5oLAyeolBYEpuatRoWq90k69
         jrMA==
X-Received: by 10.68.220.103 with SMTP id pv7mr34836114pbc.17.1402406784894;
        Tue, 10 Jun 2014 06:26:24 -0700 (PDT)
Received: from lanh ([115.73.243.79])
        by mx.google.com with ESMTPSA id gq3sm3108000pbb.52.2014.06.10.06.26.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jun 2014 06:26:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 Jun 2014 20:26:20 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402406665-27988-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251187>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      |  3 +++
 read-cache.c | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index c6b7770..6549e02 100644
--- a/cache.h
+++ b/cache.h
@@ -290,10 +290,13 @@ struct index_state {
 	struct split_index *split_index;
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
+		 keep_mmap : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
+	void *mmap;
+	size_t mmap_size;
 };
=20
 extern struct index_state the_index;
diff --git a/read-cache.c b/read-cache.c
index 342fe52..a5031f3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1495,6 +1495,10 @@ int do_read_index(struct index_state *istate, co=
nst char *path, int must_exist)
 	mmap =3D xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, =
fd, 0);
 	if (mmap =3D=3D MAP_FAILED)
 		die_errno("unable to map index file");
+	if (istate->keep_mmap) {
+		istate->mmap =3D mmap;
+		istate->mmap_size =3D mmap_size;
+	}
 	close(fd);
=20
 	hdr =3D mmap;
@@ -1547,10 +1551,12 @@ int do_read_index(struct index_state *istate, c=
onst char *path, int must_exist)
 		src_offset +=3D 8;
 		src_offset +=3D extsize;
 	}
-	munmap(mmap, mmap_size);
+	if (!istate->keep_mmap)
+		munmap(mmap, mmap_size);
 	return istate->cache_nr;
=20
 unmap:
+	istate->mmap =3D NULL;
 	munmap(mmap, mmap_size);
 	die("index file corrupt");
 }
@@ -1576,6 +1582,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 		discard_index(split_index->base);
 	else
 		split_index->base =3D xcalloc(1, sizeof(*split_index->base));
+	split_index->base->keep_mmap =3D istate->keep_mmap;
 	ret =3D do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -1618,6 +1625,10 @@ int discard_index(struct index_state *istate)
 	free(istate->cache);
 	istate->cache =3D NULL;
 	istate->cache_alloc =3D 0;
+	if (istate->keep_mmap && istate->mmap) {
+		munmap(istate->mmap, istate->mmap_size);
+		istate->mmap =3D NULL;
+	}
 	discard_split_index(istate);
 	return 0;
 }
--=20
1.9.1.346.ga2b5940
