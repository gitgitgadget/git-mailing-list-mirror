From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 02/19] read-cache: allow to keep mmap'd memory after reading
Date: Thu,  5 May 2016 17:46:54 -0400
Message-ID: <1462484831-13643-3-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:48:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR8d-0000Dd-FL
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757850AbcEEVrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 17:47:31 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34925 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959AbcEEVr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:28 -0400
Received: by mail-qg0-f48.google.com with SMTP id f74so47440224qge.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWsQqUT0TEbkQssEa8cmGJohJfXp0Da97rhFbruFwGg=;
        b=b4ozA7RWvIVW8Er9MXOs3MeGyZerbQxFLdE6/sJkB4o4JDfofTVs4aJ8JOZxNDUFK4
         MLh5kiHOkZsCP8Q41ZZwav+jVmYEWJBDLpM9CZ8JguPf+GdSxRcibP9Hxx6DQz6P6OV2
         oMYUp9Y0Z1gtJAxqWgx6twPwdRsfOHuXDC7Ifp1bbYEh84WIiiVRc7aIKz97s/oeTlN0
         EWbDWGjGtHmKLPUch2GsjIEVLFmVg0M9oA7Vnk1UBWDuhqqVO4aNA3UgHcpmYyFFy02z
         x1dvzDZsiE+M+icZWgNjOfz5ZRrYk2/xfONW1qkV0e4/mrwCpIhsA5+DYKUfcPEg8IIN
         11Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWsQqUT0TEbkQssEa8cmGJohJfXp0Da97rhFbruFwGg=;
        b=OTBQLHdy0IiEm8Z9zZYNc/ZNAYLjEq56SAS2LcPzltAbmZBI6uLz7e2C6g+wZ8F1Da
         ybvRKBz0nd7c5urTQNqSDCUR509PvK9uF2+VmQcRlKcDItKin159Zv9Eite5tapoO1DT
         HZyUP2mOivPRGw71ElpxxPQ+FjMmGFszgwJoUdb2gHJCY+tNQwLpXlzEX5mdWg11W7pu
         qNsAd39K1UOAqpnlCEQr7QPaKFoJqN+DtbYJMWL+TSzcgc289uYjaAEYsk/CsY4lTfX1
         i6dT2yCPYDQrjT9znMi9jUFv+CwodGwNdB+QWsoDfx6pmd+oF++P2Q7TRE44dYijGG0Q
         dwkg==
X-Gm-Message-State: AOPr4FUt9tgpKlm4K04Kc6njoh6yx74K5dNOtvCV+uXY53yliIC9ROibnZhZGxWspZbbUQ==
X-Received: by 10.141.3.66 with SMTP id f63mr17749097qhd.55.1462484847114;
        Thu, 05 May 2016 14:47:27 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293704>

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
