From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/8] read-cache: allow to keep mmap'd memory after reading
Date: Tue, 13 May 2014 18:15:28 +0700
Message-ID: <1399979737-8577-2-git-send-email-pclouds@gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:15:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkAga-0007yx-4Z
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760297AbaEMLPn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 07:15:43 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38758 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbaEMLPl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 07:15:41 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so167262pab.20
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tIcrSlmY26WA5Ev3DNnpKmYHUrdjUm2PSd0ur1GhuH0=;
        b=QvRssSyZP4xqoJ5GabxlhC2zfhgvBIABWydQQ5nh376bLoOGljVuG3Bj+5uVl+U3Yl
         od+ztyydpZivsUSJrCh1cmojRbBOmHohp6nVwwOVQD4HsKZBOWDPs8dL8Bp0tToFpx4m
         DnXey/jLDPuNXrwRYNGUKv7pJw7w7ASRhIuDbai+2FRtoIwBcdRWI1av/8FGdqanzY7F
         P9mUBRJ28FCPAumwAY37QfN5/qP6Y/9Ljbf851sQZy5y1W7aYJvZPYo1P5xl+x1T8xuo
         7b4j5kidfy64C+0dH7OiFxxPatzxiY/Audem/44YyZdA8Hk1Pstr91tiH2M8W8uyqiPV
         5eEw==
X-Received: by 10.68.194.134 with SMTP id hw6mr4412305pbc.49.1399979740335;
        Tue, 13 May 2014 04:15:40 -0700 (PDT)
Received: from lanh ([115.73.238.182])
        by mx.google.com with ESMTPSA id ox3sm27681922pbb.88.2014.05.13.04.15.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 04:15:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 May 2014 18:15:45 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248761>

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
