From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 02/17] read-cache: allow to keep mmap'd memory after reading
Date: Fri, 18 Mar 2016 21:04:35 -0400
Message-ID: <1458349490-1704-3-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:06:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5LM-0008DR-Gt
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147AbcCSBGO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 21:06:14 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35268 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbcCSBGH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:06:07 -0400
Received: by mail-qk0-f169.google.com with SMTP id o6so56421726qkc.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z/6KOLSuc5Oq2erYy3RnQd6P4QWgQbxWKKNezlRLVAQ=;
        b=bW7yfzmhZC0l2NNwq9FBx+MU4jHYhe6EFoO/U7DpuBmDUyFe4eakQGEgMjYKpuqn10
         +sHcvhPa6uJZLPU/HScnbpQZ82w/aclUlHd050GjZ3zA2zCxg3t5/ZzX6G16WX/cqfQL
         kVjY/6/N7Urjj+ROl4m6kE3u0cD8ZO9XD6wXbq77SFaGsS+OxGmiSLQHxbOMkWAgCZhu
         DvlBoCvawtnkGGJpzCi+gZnV9GUyvELridkpw9hDoME61dGM3ARM8qga8TYjL6htEzt/
         0XPKqL+5YQ9aqGjN1gpn0neXAa3w/aRlnpj07JSUAnYDqTTBpT3gCkEdTS4QbSdJY0HR
         JFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/6KOLSuc5Oq2erYy3RnQd6P4QWgQbxWKKNezlRLVAQ=;
        b=JUegER+PIcGb9cB9b3dSAiCgevF93R22dZjtYNT+Q9YeJgDG+LulTIJRlVVNvl9XEy
         kyNOsRqe886EW4GxSlWvvmmqYhHOJ24wWawJ9oShaNFD7Ea1ZZ3eSCoBPwjgVOHyPXre
         9eiB/6QT3j0y3zdlvSd1e53Fg4qd2FvJz0Je5EkrH3JxLNgBoGBqZKMwHn15LDsL+tSU
         yNBvzVwfWVyv8uE5SzAvCZ+QcyXxluS+xWObdIJiRR8sZ5GdP/Vi9n1oOcGH4nh9gHe+
         nXxG9qnS9VOakmgZjdAREf3au72jjV1ssN/OYXDsgFlxLnF8XWqyuky/FFf9733tGmzh
         H4fg==
X-Gm-Message-State: AD7BkJK5huaEf9kyzWHnVq/almjMPScuaNhUZm8bpXhTKS9mP2CWM9f1TUZPXJX6//xIBw==
X-Received: by 10.55.73.74 with SMTP id w71mr26446614qka.60.1458349566632;
        Fri, 18 Mar 2016 18:06:06 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.06.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:06:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289267>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Later, we will introduce git index-helper to share this memory with
other git processes.

Since the memory will be shared, it will never be unmapped (although
the kernel may of course choose to page it out).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      |  3 +++
 read-cache.c | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index b829410..4180e2b 100644
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
