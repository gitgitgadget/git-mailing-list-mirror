From: David Turner <dturner@twopensource.com>
Subject: [PATCH 03/19] read-cache: allow to keep mmap'd memory after reading
Date: Wed,  9 Mar 2016 13:36:06 -0500
Message-ID: <1457548582-28302-4-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:36:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiyT-0007AS-AA
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933649AbcCISgm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:36:42 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34087 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624AbcCISgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:36 -0500
Received: by mail-qg0-f41.google.com with SMTP id w104so49416365qge.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5Hk4IaTcjFS6TlaRTPDWTTt9mZsJBSqnaTKxA2zXPNw=;
        b=Isic8uusyrAU0nEySynh9f6byEGOn8rBeEmXZWEuEsbuIVMYjw5RTUi7e2QmjhHz76
         3STM0ykEvKI4yF9g5f1mb8xtSSHQCWix2Y6+iqbP3Yfa5EM+BZM7HvPvRF+09eBPc4pq
         RZx55xpuXyYb9ao/jdgQT/8pHZZa7JcJLf0f5gKMueLwgqlKMUd+vh16qFy/lPn0RVBl
         xz/xZvEbiOjuoBUrkymOgiRkvVhETs/iGE0S8GoJHoEJ6iPIWW/g5g0TLnFDG/1oF/lQ
         x2HnV6XJH0JV2UenP8CGX01//YB92Dgde7y3or3kQwzYgsBU6oLB8bAJVTRXG4U/EsDt
         qBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Hk4IaTcjFS6TlaRTPDWTTt9mZsJBSqnaTKxA2zXPNw=;
        b=Q2AljJ+d2fA845UX/8mWq6fW6vHxBEC3ZYx0SI5uZexRKNBGwyZ0QTcpD5V9Kx5pXC
         VLYyuzsDjzzLp4wM8IpvuTGJ/dZ/2ZHLGdTTOYPWfLkBwBRtRSKlICOmKJNyfplGzaKG
         cZyaqNqsKWbkzqTN2wGaKb7x7n+jqIePDN6Ujerq79BZONGLeNTCqca9AxGjTry97zla
         OqL3jgBgCKb9zeRcK1fVWbGOnTlL8/Dc1gztODYQ+g/Mm0KrGWuJzQjvRaHJc4Fph7XU
         qArW+VqY25cnwkDwbVGHmNdGHeyk/UE3Bq9vOFxm1NaC+2uj2A3QsZJUAqJYMtz3gktB
         CyaA==
X-Gm-Message-State: AD7BkJKNb126jMG1u2F0AWLBhkaFHmvJmDojw7nySYi3keoUqXTRf16PkYLOsHcX4nhyiQ==
X-Received: by 10.140.88.11 with SMTP id s11mr44193234qgd.93.1457548595962;
        Wed, 09 Mar 2016 10:36:35 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:35 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288550>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      |  3 +++
 read-cache.c | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 7e01403..c43ef3d 100644
--- a/cache.h
+++ b/cache.h
@@ -333,11 +333,14 @@ struct index_state {
 	struct split_index *split_index;
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
+		 keep_mmap : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
 	struct untracked_cache *untracked;
+	void *mmap;
+	size_t mmap_size;
 };
=20
 extern struct index_state the_index;
diff --git a/read-cache.c b/read-cache.c
index 16cc487..7e387e9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1574,6 +1574,10 @@ int do_read_index(struct index_state *istate, co=
nst char *path, int must_exist)
 	mmap =3D xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (mmap =3D=3D MAP_FAILED)
 		die_errno("unable to map index file");
+	if (istate->keep_mmap) {
+		istate->mmap =3D mmap;
+		istate->mmap_size =3D mmap_size;
+	}
 	close(fd);
=20
 	hdr =3D mmap;
@@ -1626,10 +1630,12 @@ int do_read_index(struct index_state *istate, c=
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
@@ -1655,6 +1661,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 		discard_index(split_index->base);
 	else
 		split_index->base =3D xcalloc(1, sizeof(*split_index->base));
+	split_index->base->keep_mmap =3D istate->keep_mmap;
 	ret =3D do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -1698,6 +1705,10 @@ int discard_index(struct index_state *istate)
 	free(istate->cache);
 	istate->cache =3D NULL;
 	istate->cache_alloc =3D 0;
+	if (istate->keep_mmap && istate->mmap) {
+		munmap(istate->mmap, istate->mmap_size);
+		istate->mmap =3D NULL;
+	}
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
 	istate->untracked =3D NULL;
--=20
2.4.2.767.g62658d5-twtrsrc
