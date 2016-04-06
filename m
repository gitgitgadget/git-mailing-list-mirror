From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 02/16] read-cache: allow to keep mmap'd memory after reading
Date: Wed,  6 Apr 2016 18:11:48 -0400
Message-ID: <1459980722-4836-3-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:12:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvgp-0004h6-5x
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbcDFWMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 18:12:40 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36379 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802AbcDFWMi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:38 -0400
Received: by mail-qg0-f51.google.com with SMTP id f52so48325291qga.3
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z/6KOLSuc5Oq2erYy3RnQd6P4QWgQbxWKKNezlRLVAQ=;
        b=UbVkXErYkbKEyLhDbbCrIyx97hIi0aMpDEBkLinKupl0LwZ4c/YSjANnXMspqF9M8P
         pw+4/Ekz9fvbStKy/k3jwwSYolumRVCL/5ehm58hqqfTfwzSJHKI22Z7+5PJOk6nn3X0
         Ubta2nYOV5fEtlGjTk7nXJ6FAbx1PtOhj9QVoCTXcO/c3r5Yguud2an5fPHY9KAtDt27
         aVjpaofunm5n52x7YKRPSZgwZl3YDpQMaFxkYTiSBQ2NOsByc5kpDT5qHfXD7q9EMzXR
         1mV05z4n8kj5VCAXqzmW/+6AtgW7JycEn1y1sQL+xWvKJJVXZyLqpLLObaFoZ11EZA2B
         PLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/6KOLSuc5Oq2erYy3RnQd6P4QWgQbxWKKNezlRLVAQ=;
        b=aEt2VEA18rWxUNC0H2i+RLC4SlS8D5Jpejghi78i1uZZqWWJaPqys/zdTC9tSbWf4a
         vOZlfMQ4iZVTn+/F8Tzc8reHQEgVl9V021UzR3yUGbzrfOHhgmMNTaXkmG+LDxxCaOMl
         S4Pxp8fHazIC/nIyIX58guk3cZgzJJYRGCYVMzkGiHgrsiEPoz57lplYEctXeHv0IkSL
         N4h4F/hYeiUlW6ipV0twpywTLeY7BGTd/8mYPglNDBsdc5bQvbSUUGuGcbqnE+p6Bvh0
         EOEfA62OGD6H6jIugKI4EM9YRAYy7ulEZU+qdFU0/0U6mkB0u6CHl2AanCCjNtb2JN/O
         N+Jg==
X-Gm-Message-State: AD7BkJLmNlrf6SlLMgK9+Ql3WfRM6VR3467xya/s1poWKnVa13dbYH4cCdjsfli3WTCDaw==
X-Received: by 10.140.239.66 with SMTP id k63mr8887020qhc.11.1459980757641;
        Wed, 06 Apr 2016 15:12:37 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290872>

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
