From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 02/15] read-cache: allow to keep mmap'd memory after reading
Date: Tue, 19 Apr 2016 19:27:56 -0400
Message-ID: <1461108489-29376-3-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:28:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf4D-0008Bb-GE
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbcDSX2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 19:28:20 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33708 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbcDSX2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:17 -0400
Received: by mail-qg0-f44.google.com with SMTP id v14so19449955qge.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ekjAg6xDgyvPohJwU4J+YHYZbuoZ+VN3zd1N7IiKp1M=;
        b=wRltV+gczKe/BBfpQMbS3MKAT65Sgl3Cx5O9Pz17n6N4WfasbYMIff+MWKhsfbyAZ+
         6vB33m9haHztNle7QEzDKSLDTLinSnni+WZHlMl4SVfX5nk9JyfqERv6GJn+6Pu6dBYe
         Tw3S2OfItmjD4pJZ3j6nCiSykB/CNASnjfIdgdLkt2K89uklCGbHksDZ7Cl0vJ9bPR9I
         WsGSO8yPUpSwYudls9RYi2s7KQ/G98BqfLuAyKQsF7MyBCdGACg11TW7cSxXkquc17PE
         ojiG7fK0vm56FMXE0Ib8uyxnp8z7yEVFiupkO9ptHs5gmci6BtrWQ4cbaR+E75YIxROg
         cntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ekjAg6xDgyvPohJwU4J+YHYZbuoZ+VN3zd1N7IiKp1M=;
        b=a86b/8axQT7hS7/rdp2P/H3TcrovkQ6TljfaQuqi60YAuqA2X2TeBXNgSbsRGNUrXm
         ErCMjiSzr+4DKsJp9HxPUFNQYUimWDuVJBbIXlfPmyTX8eH6QNRzLV9l2sqF2W2ASFfB
         fV552Jykn+okMjLmCJyRsIJOEqTig985oE5oX/h5YPSOyq0WIwiQhj9zWyW0SyPqeAtk
         1Upmes7WUMqUeZgmo63hN1myivVflW10nl01wAp76bpLh4CUJ/u0g6CaY5vtDjC9+AcR
         efysA+xj2Yr15r+M1kxQhlA1c2XmqYL50vquk78Piq72EeDekrtQwQ6RoW1jGtz+o6eH
         uLCA==
X-Gm-Message-State: AOPr4FWj/SsiCgzlTEVW16mMT0sJUc+o7aB0daUd57Kn8YiJOI//4yIE3BHydMl4ePuPPg==
X-Received: by 10.140.92.65 with SMTP id a59mr5732951qge.93.1461108496734;
        Tue, 19 Apr 2016 16:28:16 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:15 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291954>

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
