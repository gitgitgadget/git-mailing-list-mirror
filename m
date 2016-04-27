From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 02/19] read-cache: allow to keep mmap'd memory after reading
Date: Wed, 27 Apr 2016 16:04:24 -0400
Message-ID: <1461787481-877-3-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:06:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVjb-0003mY-Qe
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbcD0UGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2016 16:06:40 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36100 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbcD0UFM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:12 -0400
Received: by mail-qg0-f52.google.com with SMTP id d90so21813551qgd.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWsQqUT0TEbkQssEa8cmGJohJfXp0Da97rhFbruFwGg=;
        b=NCEtFnwYQE/NMUV1FGpj3Gcz/xP/cj9g9XwFsHbIq4rnWjcvWaTqxiPms4RJrkmQnh
         aJx0SrslEQ1OAVpw67/VgD+vgBkDu7+4l/MPQNC3rNHB5lRmPuhxVPDflVzjovxRhvBe
         POzjWuzymfM/vjbiHGfzx9dt9Mzze9Iny/P4cYBYt5hxxHXp6mFDed1NBx7i0LvjBI+j
         aQ9IGYbwSghgy4XzyQ/X6Omr4A77uyj2VX8i6tOLQtlLGtIxhJbBoe49Uc8vw92QjDUb
         Ws1BcYwBsbDcyzbFYIVWoAPyYLmuc7cgBaNAPxnl8w9jaWRJlUHT+say9OfrcN9Ca79h
         BWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWsQqUT0TEbkQssEa8cmGJohJfXp0Da97rhFbruFwGg=;
        b=M/GZ/Up4d8xH2ebCzklNTjY19zYAtuwT/dwoEvvNLi8e9teaxhE0ip7LqyMayn5dIA
         rAoGMcz6BMcSrRHgtjzlwvB0ZJ5UJydkvgdvfSVLllkcILPEkcl8vD8SilFcrwTR0ztH
         1a+aLhfn7dWDP3MYAzf/+KwccpkdlR/JnKk2vaTPR1kocYisj4NOb3IHSnG4ROXwUKDl
         +0eGllv/T4wzThcU27TfeVs6qeDWFRmxzOWVfdB95TcQP5T4FXAacShmCiiXz7DqxRfw
         sGiwUUSfWhv3Beh6ce+9XetVIacOakPJ8+pojHPLfikoQ9jaFnNsSRn+FBYKEUp9Q/IX
         Wv+Q==
X-Gm-Message-State: AOPr4FVWGhys2cbUo38VIZ6qVMs0Wrrz5dvLA2ZBt80I8b7mwQuqRjb06FenBp+jM6GjjQ==
X-Received: by 10.140.100.173 with SMTP id s42mr10036551qge.19.1461787511253;
        Wed, 27 Apr 2016 13:05:11 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:10 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292809>

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
