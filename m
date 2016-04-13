From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 02/16] read-cache: allow to keep mmap'd memory after reading
Date: Tue, 12 Apr 2016 20:32:55 -0400
Message-ID: <1460507589-25525-3-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:33:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8kM-0002e5-H6
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758905AbcDMAdY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 20:33:24 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35867 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758896AbcDMAdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:23 -0400
Received: by mail-qg0-f54.google.com with SMTP id f52so30909569qga.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ekjAg6xDgyvPohJwU4J+YHYZbuoZ+VN3zd1N7IiKp1M=;
        b=I6e2NKmO2/ZM1fRSQoEJXL5yJIk31kWj2iz7oHo7n0quLlZC9noZcxPOPlCDNBS0Sq
         f3sODK/uIyG+l6++PKFgCqU3iQhXlOYHjSKjeQ0ephcmmqvlyDax9eUfAknMCtmQcEmq
         GqubXjb9pKSCPTARuF7fWIk5vs0nzO6e5jKsRLYVGjbGgvH+saWoY4Z7+1wqJkQiPTlM
         KZHzIXA1IW3mWeTTZyBxRKHUXlsL4IgmRAZdR81I2QumVdrEnrlBr/hJc7HpYmqMHAbB
         2nV6esHlvgdKNSFRvPTr+tE9g9IlHxXpzS+rgBd7++BrpfuW0TkRpCRAVYbmKKpISRDg
         BG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ekjAg6xDgyvPohJwU4J+YHYZbuoZ+VN3zd1N7IiKp1M=;
        b=kTGkf0U0M0PPfZcAE4dgjt102+CxrNPHxNvzjC6FE7aXKmmF9rjJO1D3mSUlmWZr/f
         SSldneHLyd6DTp6pWeRDKhcC2ukkRFuMsJfSlXWbAccK8DMmJFzTfSix9S2PAxDRomsQ
         kxYTKwzi0Q7GOq5HbF/k0Cz+JbTp8b4V77uCcQtMjAMOWOO3YGTJd06ItoH5KJ5PfNFz
         yI2eBjUK4MMAvbSGTZtaJHQaV9eZvvUsjTKhABts17ktAPb4PhL4kUyuaGuGmCNXEorQ
         y4TSqw7mivw9mzTbQ593l9saekZMFnAB3aq6PX+pIjgKlSX4HiiT0J9YviiFKrqZGJoD
         mW3g==
X-Gm-Message-State: AOPr4FW96HxLWZrV3RLg5x0a2KHG/mtU9mtO2HkKvSsDopN7S2btwi8UipK/tp2Mcd5rNg==
X-Received: by 10.140.29.7 with SMTP id a7mr7422784qga.98.1460507602479;
        Tue, 12 Apr 2016 17:33:22 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291337>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Later, we will introduce git index-helper to share this memory with
other git processes.

Since the memory will be shared, it will never be unmapped (although
the kernel may of course choose to page it out).

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
