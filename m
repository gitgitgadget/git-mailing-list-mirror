From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/32] read-cache: save index SHA-1 after reading
Date: Mon, 28 Apr 2014 17:55:37 +0700
Message-ID: <1398682553-11634-17-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:56:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejEy-0003LV-58
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbaD1K4L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:56:11 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:44391 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbaD1Kz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:55:59 -0400
Received: by mail-pb0-f53.google.com with SMTP id jt11so3971259pbb.40
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=srgv/9zNTFCb8TynvOCkHA/LXoTFfzKiubK20lW1By0=;
        b=X41nzWUtNBElaMd2aCEd2hw2hV/fNkBnpS6siWkdjDFwQhEeDHPtpXo7gPOkA/1EE/
         yL+kP88EKrgbo0B21vq49939BoFxXptQdzv3NKBtqB8D7fsgpHRf0lZJ/jY+KeaSBc4Y
         iJDh2z26MKVhS+igKZvtG9/cEYwECkcNR3BTqzPxTBfodkFYEJr0BxUQLdy5fHnEmdGd
         buRG+9jom8DXs5gbFT+y1kmWB42XbE4KdLdC+hNC/d3gvlblUGdjulsD67ONCuPupQYJ
         dMPBoQneVKldJB5oFVESIgJXXBZJ6JpH9e/GVssttOAHPus2AFte3/WoN7Mo2zKM1YOu
         lYAQ==
X-Received: by 10.66.252.135 with SMTP id zs7mr24774274pac.13.1398682559005;
        Mon, 28 Apr 2014 03:55:59 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id dy7sm89667708pad.9.2014.04.28.03.55.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:55:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:57:26 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247288>

Also update SHA-1 after writing. If we do not do that, the second
read_index() will see "initialized" variable already set and not read
=2Egit/index again, which is fine, except istate->sha1 now has a stale
value.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        | 1 +
 read-cache.c   | 6 ++++--
 unpack-trees.c | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 9bbebab..0f6247c 100644
--- a/cache.h
+++ b/cache.h
@@ -286,6 +286,7 @@ struct index_state {
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
+	unsigned char sha1[20];
 };
=20
 extern struct index_state the_index;
diff --git a/read-cache.c b/read-cache.c
index f1265d4..723d769 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1481,6 +1481,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
=20
+	hashcpy(istate->sha1, (const unsigned char *)hdr + mmap_size - 20);
 	istate->version =3D ntohl(hdr->hdr_version);
 	istate->cache_nr =3D ntohl(hdr->hdr_entries);
 	istate->cache_alloc =3D alloc_nr(istate->cache_nr);
@@ -1616,7 +1617,7 @@ static int write_index_ext_header(git_SHA_CTX *co=
ntext, int fd,
 		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
 }
=20
-static int ce_flush(git_SHA_CTX *context, int fd)
+static int ce_flush(git_SHA_CTX *context, int fd, unsigned char *sha1)
 {
 	unsigned int left =3D write_buffer_len;
=20
@@ -1634,6 +1635,7 @@ static int ce_flush(git_SHA_CTX *context, int fd)
=20
 	/* Append the SHA1 signature at the end */
 	git_SHA1_Final(write_buffer + left, context);
+	hashcpy(sha1, write_buffer + left);
 	left +=3D 20;
 	return (write_in_full(fd, write_buffer, left) !=3D left) ? -1 : 0;
 }
@@ -1872,7 +1874,7 @@ static int do_write_index(struct index_state *ist=
ate, int newfd)
 			return -1;
 	}
=20
-	if (ce_flush(&c, newfd) || fstat(newfd, &st))
+	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
 		return -1;
 	istate->timestamp.sec =3D (unsigned int)st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
diff --git a/unpack-trees.c b/unpack-trees.c
index 26f65c7..f594932 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1046,6 +1046,7 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
 	o->result.timestamp.sec =3D o->src_index->timestamp.sec;
 	o->result.timestamp.nsec =3D o->src_index->timestamp.nsec;
 	o->result.version =3D o->src_index->version;
+	hashcpy(o->result.sha1, o->src_index->sha1);
 	o->merge_size =3D len;
 	mark_all_ce_unused(o->src_index);
=20
--=20
1.9.1.346.ga2b5940
