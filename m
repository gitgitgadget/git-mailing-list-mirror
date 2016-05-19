From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 02/20] read-cache: allow to keep mmap'd memory after reading
Date: Thu, 19 May 2016 17:45:39 -0400
Message-ID: <1463694357-6503-3-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:46:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3VmG-0006Um-Ll
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbcESVqm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 17:46:42 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36466 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbcESVqk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:40 -0400
Received: by mail-qg0-f54.google.com with SMTP id w36so51240215qge.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWsQqUT0TEbkQssEa8cmGJohJfXp0Da97rhFbruFwGg=;
        b=Wy/t6EibWuVfF+BVjAkoXthqybdEYNxD9yyuhadv3KH6U9YqHMNAiX+THEjmnbeg79
         PjkJmo+cX3+cobm95/ZbJ7AN4rbSuuft1gxm0CAuRs2Las71J49D8DtkI00Y6UjAPNKj
         YeM6gB5FYfm9oF2HN8ea/KVk3gyXgabH+SQdgXVQoEMujWJ/UtMytI/GJZPT2WoMYVXr
         1MtxY8esoi55c/IVrbWTKz9f49E/4JcX3sSyn3TBY7lwQpDyFiEMIyHXnqgmP4vw451V
         yy9Vy+BahqeTHHRKjHrEtzVRP/UNBXijR+ODrPnGl6zZQLe3AXJeuqeJC4EjfKEUXRtP
         g1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWsQqUT0TEbkQssEa8cmGJohJfXp0Da97rhFbruFwGg=;
        b=O3x5ZpJeWw/FFdsmIfqZarVhkbn5ydtlZguQ5R8KhldZNKHgFf3Lbx6dsCpuBGYhMN
         c4IX8PZdKGF2r1By7lhTsdvXogdgMPjv56frVmJbitypY7mMu57zQ5f/P2jGwWm4cg/J
         IotefyQ+uymUE8++o5YZ2QKSbZX/Fq4sHl//ewgHaGk+Y8IqleChoA473gaUfI0Q6iTd
         30PHrT0ub1gobQYivHDc6KNa7AR4sQwupZKyvWOV8NHkPVs5SPtLgC1xTFGFjjsouRUx
         umcfBcJDyrwV5HC+VFl4+vNVhHNxYq7Bwtwk2NYApUUkLc77O4uF8ZNYPDbho5LhYbCw
         IR7Q==
X-Gm-Message-State: AOPr4FXtuz4lKRbwGbOrXVHRQ2/LXqGnQTfiWM3qJWjGjzDaYeOKJyFgfHrhBE0diqglzQ==
X-Received: by 10.140.27.163 with SMTP id 32mr16166674qgx.4.1463694399566;
        Thu, 19 May 2016 14:46:39 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:38 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295105>

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
