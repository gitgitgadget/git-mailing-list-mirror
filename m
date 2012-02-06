From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] read-cache: use sha1file for sha1 calculation
Date: Mon,  6 Feb 2012 12:48:34 +0700
Message-ID: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 06:43:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuHMp-0002e8-Lx
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864Ab2BFFnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 00:43:51 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52869 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab2BFFnu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:43:50 -0500
Received: by daed14 with SMTP id d14so163782dae.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 21:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ynOZphlxybPv6nHodO60Q1/SBw92MAqS2rZh+iUP7lc=;
        b=pTgMh3D20J6jDcDfgOLWpsN248t2tJeaZb1fkm2XgKnZEnTQP3jU5xxVBh7UfCbjQa
         +btnX5nwR4f61Ex08+wmt5EIiRNWFFe0HCIv2hGDlR9uxqm38p99zCWTOBLg467q+dca
         v4xqzsEvlKD+btzW47zklHr8S2Dtg+qMeeDJs=
Received: by 10.68.189.65 with SMTP id gg1mr44467455pbc.66.1328507029951;
        Sun, 05 Feb 2012 21:43:49 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id b7sm36761425pba.2.2012.02.05.21.43.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 21:43:48 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 06 Feb 2012 12:48:40 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190016>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c |   90 +++++++++++++++-----------------------------------=
--------
 1 files changed, 23 insertions(+), 67 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a51bba1..e9a20b6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -12,6 +12,7 @@
 #include "commit.h"
 #include "blob.h"
 #include "resolve-undo.h"
+#include "csum-file.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,=
 int really);
=20
@@ -1395,73 +1396,28 @@ int unmerged_index(const struct index_state *is=
tate)
 	return 0;
 }
=20
-#define WRITE_BUFFER_SIZE 8192
-static unsigned char write_buffer[WRITE_BUFFER_SIZE];
-static unsigned long write_buffer_len;
-
-static int ce_write_flush(git_SHA_CTX *context, int fd)
-{
-	unsigned int buffered =3D write_buffer_len;
-	if (buffered) {
-		git_SHA1_Update(context, write_buffer, buffered);
-		if (write_in_full(fd, write_buffer, buffered) !=3D buffered)
-			return -1;
-		write_buffer_len =3D 0;
-	}
-	return 0;
-}
-
-static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned=
 int len)
+static int ce_write(struct sha1file *f, void *data, unsigned int len)
 {
-	while (len) {
-		unsigned int buffered =3D write_buffer_len;
-		unsigned int partial =3D WRITE_BUFFER_SIZE - buffered;
-		if (partial > len)
-			partial =3D len;
-		memcpy(write_buffer + buffered, data, partial);
-		buffered +=3D partial;
-		if (buffered =3D=3D WRITE_BUFFER_SIZE) {
-			write_buffer_len =3D buffered;
-			if (ce_write_flush(context, fd))
-				return -1;
-			buffered =3D 0;
-		}
-		write_buffer_len =3D buffered;
-		len -=3D partial;
-		data =3D (char *) data + partial;
-	}
-	return 0;
+	return sha1write(f, data, len);
 }
=20
-static int write_index_ext_header(git_SHA_CTX *context, int fd,
+static int write_index_ext_header(struct sha1file *f,
 				  unsigned int ext, unsigned int sz)
 {
 	ext =3D htonl(ext);
 	sz =3D htonl(sz);
-	return ((ce_write(context, fd, &ext, 4) < 0) ||
-		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
+	return ((ce_write(f, &ext, 4) < 0) ||
+		(ce_write(f, &sz, 4) < 0)) ? -1 : 0;
 }
=20
-static int ce_flush(git_SHA_CTX *context, int fd)
+static int ce_flush(struct sha1file *f)
 {
-	unsigned int left =3D write_buffer_len;
-
-	if (left) {
-		write_buffer_len =3D 0;
-		git_SHA1_Update(context, write_buffer, left);
-	}
-
-	/* Flush first if not enough space for SHA1 signature */
-	if (left + 20 > WRITE_BUFFER_SIZE) {
-		if (write_in_full(fd, write_buffer, left) !=3D left)
-			return -1;
-		left =3D 0;
-	}
+	unsigned char sha1[20];
+	int fd =3D sha1close(f, sha1, 0);
=20
-	/* Append the SHA1 signature at the end */
-	git_SHA1_Final(write_buffer + left, context);
-	left +=3D 20;
-	return (write_in_full(fd, write_buffer, left) !=3D left) ? -1 : 0;
+	if (fd < 0)
+		return -1;
+	return (write_in_full(fd, sha1, 20) !=3D 20) ? -1 : 0;
 }
=20
 static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
@@ -1513,7 +1469,7 @@ static void ce_smudge_racily_clean_entry(struct c=
ache_entry *ce)
 	}
 }
=20
-static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *=
ce)
+static int ce_write_entry(struct sha1file *f, struct cache_entry *ce)
 {
 	int size =3D ondisk_ce_size(ce);
 	struct ondisk_cache_entry *ondisk =3D xcalloc(1, size);
@@ -1542,7 +1498,7 @@ static int ce_write_entry(git_SHA_CTX *c, int fd,=
 struct cache_entry *ce)
 		name =3D ondisk->name;
 	memcpy(name, ce->name, ce_namelen(ce));
=20
-	result =3D ce_write(c, fd, ondisk, size);
+	result =3D ce_write(f, ondisk, size);
 	free(ondisk);
 	return result;
 }
@@ -1574,7 +1530,7 @@ void update_index_if_able(struct index_state *ist=
ate, struct lock_file *lockfile
=20
 int write_index(struct index_state *istate, int newfd)
 {
-	git_SHA_CTX c;
+	struct sha1file *f;
 	struct cache_header hdr;
 	int i, err, removed, extended;
 	struct cache_entry **cache =3D istate->cache;
@@ -1598,8 +1554,8 @@ int write_index(struct index_state *istate, int n=
ewfd)
 	hdr.hdr_version =3D htonl(extended ? 3 : 2);
 	hdr.hdr_entries =3D htonl(entries - removed);
=20
-	git_SHA1_Init(&c);
-	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
+	f =3D sha1fd(newfd, NULL);
+	if (ce_write(f, &hdr, sizeof(hdr)) < 0)
 		return -1;
=20
 	for (i =3D 0; i < entries; i++) {
@@ -1608,7 +1564,7 @@ int write_index(struct index_state *istate, int n=
ewfd)
 			continue;
 		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
 			ce_smudge_racily_clean_entry(ce);
-		if (ce_write_entry(&c, newfd, ce) < 0)
+		if (ce_write_entry(f, ce) < 0)
 			return -1;
 	}
=20
@@ -1617,8 +1573,8 @@ int write_index(struct index_state *istate, int n=
ewfd)
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		cache_tree_write(&sb, istate->cache_tree);
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < =
0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err =3D write_index_ext_header(f, CACHE_EXT_TREE, sb.len) < 0
+			|| ce_write(f, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -1627,15 +1583,15 @@ int write_index(struct index_state *istate, int=
 newfd)
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		resolve_undo_write(&sb, istate->resolve_undo);
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_RESOLVE_UNDO,
+		err =3D write_index_ext_header(f, CACHE_EXT_RESOLVE_UNDO,
 					     sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+			|| ce_write(f, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
 			return -1;
 	}
=20
-	if (ce_flush(&c, newfd) || fstat(newfd, &st))
+	if (ce_flush(f) || fstat(newfd, &st))
 		return -1;
 	istate->timestamp.sec =3D (unsigned int)st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
--=20
1.7.8.36.g69ee2
