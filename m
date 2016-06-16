From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 02/20] read-cache: allow to keep mmap'd memory after reading
Date: Thu, 12 May 2016 16:19:57 -0400
Message-ID: <1463084415-19826-3-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:20:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6B-0004k4-1b
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbcELUU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2016 16:20:27 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36133 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbcELUUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:25 -0400
Received: by mail-io0-f182.google.com with SMTP id i75so103982101ioa.3
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWsQqUT0TEbkQssEa8cmGJohJfXp0Da97rhFbruFwGg=;
        b=yXGK1T8CeDJWij3vjiyvC9+GhtGEThjG9XfrHK7xBiIt1NwIidH8DUPigOOd5tfP8Y
         BsDAGuJaJYHKD4d4zMfrlIy3m8RxC0cMFAu2sDcC9QdC0SuVtIBPv20PntSL5I2r431Y
         jVB/JCmSbzGAHLQFfb4ch13LpgpdNmOH/4nyELKfBLuuc2uIJMOfE1jsyND4c9m7ATFq
         KhbB9C340ws50gFg2Dr/L05UJWp0bvdBVV2SJGq61Cb7/tZjcnlnB4nAp5GfGDzXOTxW
         1wc5W3M62b5yoAjUI8Hkm5vOomblPOq4rNgHw+Gf2vhDNTGhJ/wdoDRk1/3Axd6/AZkE
         2ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWsQqUT0TEbkQssEa8cmGJohJfXp0Da97rhFbruFwGg=;
        b=afu8yXftY7N6SpTrx0iuWV8F4XvoJzg2S9nQJE1+Ub4hlMk593ai3teSVwN4NC3pCt
         ejU93YVqYjmdOCquODu+J0YmHxcK2e4B+PC3M5IVGeyE/DvteBVxYYoGlHBFUXLoeweB
         zfRinGmcGK1pNqhIN+u3Eoqo+gBKY6N69vNYbGQMkFmchbsoU4FBqGYLUat/ec4vDP6J
         cBTaYlXBp1Xo5E0eeBfDPqdk1BVo1QKx+VS8tb6PadOwQ3+T1jlVAES/B6OrmmSicDfB
         qV6PJzCXkR9AfG9rmUicx1SX5flcEWvXBtAycu2tvKwR+sVDS/Zhwk5/cbdY58+yVCXO
         MgGQ==
X-Gm-Message-State: AOPr4FUWxBzsu9g3Mz29LgNckVBKsG4Ucjq5+xu9J7GOG/2/sx46YQNtKFluBFmJjQrvIA==
X-Received: by 10.107.130.71 with SMTP id e68mr10198577iod.175.1463084424424;
        Thu, 12 May 2016 13:20:24 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294452>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Later, we will introduce git index-helper to share this memory with
other git processes.

We only unmap it when we discard the index (although the kernel may of
course choose to page it out).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
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
index 16cc487..3cb0ec3 100644
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
@@ -1626,11 +1630,13 @@ int do_read_index(struct index_state *istate, c=
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
 	munmap(mmap, mmap_size);
+	istate->mmap =3D NULL;
 	die("index file corrupt");
 }
=20
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
