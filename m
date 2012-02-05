From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] Support compressing index when GIT_ZCACHE=1
Date: Sun,  5 Feb 2012 15:30:05 +0700
Message-ID: <1328430605-4566-4-git-send-email-pclouds@gmail.com>
References: <1328430605-4566-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Redstone <joshua.redstone@fb.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 09:31:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtxVR-0002Pw-IE
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 09:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765Ab2BEIbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 03:31:22 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36557 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab2BEIbN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 03:31:13 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so4091382pbd.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 00:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=svhaFevkoQKrCif0D3HF4uIU9fK5h6ZxwQW4ex4BtDM=;
        b=CkruIA4c2W1PT/PQLw0LUUJ2qiNH4iOiv6ZaP/znBoc9kNGYPYUNiV2WY91IDSNlHB
         Yrv/TZKVyecZElrvkd7d+vZnwibpbldOADDxeIcj8XcPeXgDb+IXYERUQo2gBmTl+4AY
         C90asv1bxRsj2FVajnHHaJ8+biNP1C1Ea2rv4=
Received: by 10.68.75.136 with SMTP id c8mr35273787pbw.113.1328430673647;
        Sun, 05 Feb 2012 00:31:13 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.57.120])
        by mx.google.com with ESMTPS id j4sm28944842pbg.12.2012.02.05.00.31.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 00:31:12 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 05 Feb 2012 15:30:30 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328430605-4566-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189936>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      |    1 +
 read-cache.c |  118 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++---
 2 files changed, 112 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 10afd71..112bc52 100644
--- a/cache.h
+++ b/cache.h
@@ -99,6 +99,7 @@ unsigned long git_deflate_bound(git_zstream *, unsign=
ed long);
  */
=20
 #define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
+#define ZCACHE_SIGNATURE 0x4452435A	/* "DRCZ" */
 struct cache_header {
 	unsigned int hdr_signature;
 	unsigned int hdr_version;
diff --git a/read-cache.c b/read-cache.c
index 7b9a989..45c1712 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1182,12 +1182,17 @@ static struct cache_entry *refresh_cache_entry(=
struct cache_entry *ce, int reall
 	return refresh_cache_ent(&the_index, ce, really, NULL, NULL);
 }
=20
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(struct cache_header *hdr, unsigned long size,
+		      int *deflated)
 {
 	git_SHA_CTX c;
 	unsigned char sha1[20];
=20
-	if (hdr->hdr_signature !=3D htonl(CACHE_SIGNATURE))
+	if (hdr->hdr_signature =3D=3D htonl(CACHE_SIGNATURE))
+		*deflated =3D 0;
+	else if (hdr->hdr_signature =3D=3D htonl(ZCACHE_SIGNATURE))
+		*deflated =3D 1;
+	else
 		return error("bad signature");
 	if (hdr->hdr_version !=3D htonl(2) && hdr->hdr_version !=3D htonl(3))
 		return error("bad index version");
@@ -1273,6 +1278,43 @@ static struct cache_entry *create_from_disk(stru=
ct ondisk_cache_entry *ondisk)
 	return ce;
 }
=20
+static int inflate_cache_entries(struct index_state *istate,
+				 const unsigned char *mmap, size_t mmap_size,
+				 unsigned long src_offset)
+{
+	unsigned char buf[sizeof(struct ondisk_cache_entry) + PATH_MAX];
+	struct ondisk_cache_entry *disk_ce;
+	struct cache_entry *ce;
+	struct git_zstream stream;
+	int i, status;
+
+	memset(&stream, 0, sizeof(stream));
+	stream.next_in =3D (unsigned char*)mmap + src_offset;
+	stream.avail_in =3D mmap_size - src_offset;
+	stream.next_out =3D buf;
+	stream.avail_out =3D sizeof(buf);
+	git_inflate_init(&stream);
+
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		int remaining;
+		do {
+			status =3D git_inflate(&stream, Z_FINISH);
+		} while (status =3D=3D Z_OK);
+
+		disk_ce =3D (struct ondisk_cache_entry *)buf;
+		ce =3D create_from_disk(disk_ce);
+		set_index_entry(istate, i, ce);
+
+		remaining =3D stream.next_out - (buf + ondisk_ce_size(ce));
+		memmove(buf, buf + ondisk_ce_size(ce), remaining);
+		stream.next_out =3D buf + remaining;
+		stream.avail_out =3D sizeof(buf) - remaining;
+	}
+	assert(status =3D=3D Z_STREAM_END);
+	git_inflate_end(&stream);
+	return stream.next_in - mmap;
+}
+
 static int read_cache_entries(struct index_state *istate,
 			      const char *mmap, unsigned long src_offset)
 {
@@ -1300,6 +1342,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	struct cache_header *hdr;
 	void *mmap;
 	size_t mmap_size;
+	int deflated;
=20
 	errno =3D EBUSY;
 	if (istate->initialized)
@@ -1329,7 +1372,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 		die_errno("unable to map index file");
=20
 	hdr =3D mmap;
-	if (verify_hdr(hdr, mmap_size) < 0)
+	if (verify_hdr(hdr, mmap_size, &deflated) < 0)
 		goto unmap;
=20
 	istate->cache_nr =3D ntohl(hdr->hdr_entries);
@@ -1337,7 +1380,11 @@ int read_index_from(struct index_state *istate, =
const char *path)
 	istate->cache =3D xcalloc(istate->cache_alloc, sizeof(struct cache_en=
try *));
 	istate->initialized =3D 1;
=20
-	src_offset =3D read_cache_entries(istate, mmap, sizeof(*hdr));
+	if (deflated)
+		src_offset =3D inflate_cache_entries(istate, mmap, mmap_size,
+						   sizeof(*hdr));
+	else
+		src_offset =3D read_cache_entries(istate, mmap, sizeof(*hdr));
 	istate->timestamp.sec =3D st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
=20
@@ -1594,6 +1641,10 @@ int write_index(struct index_state *istate, int =
newfd)
 	struct stat st;
 	void *ce_ondisk =3D NULL;
 	int ce_ondisk_size =3D 0;
+	struct git_zstream stream;
+	int deflate, status;
+	unsigned char *dbuf_out;
+	unsigned char *dbuf_in;
=20
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -1607,7 +1658,8 @@ int write_index(struct index_state *istate, int n=
ewfd)
 		}
 	}
=20
-	hdr.hdr_signature =3D htonl(CACHE_SIGNATURE);
+	deflate =3D getenv("GIT_ZCACHE") !=3D NULL;
+	hdr.hdr_signature =3D htonl(deflate ? ZCACHE_SIGNATURE : CACHE_SIGNAT=
URE);
 	/* for extended format, increase version so older git won't try to re=
ad it */
 	hdr.hdr_version =3D htonl(extended ? 3 : 2);
 	hdr.hdr_entries =3D htonl(entries - removed);
@@ -1616,6 +1668,17 @@ int write_index(struct index_state *istate, int =
newfd)
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
=20
+	if (deflate) {
+		dbuf_out =3D xmalloc(WRITE_BUFFER_SIZE);
+		dbuf_in =3D xmalloc(WRITE_BUFFER_SIZE);
+		memset(&stream, 0, sizeof(stream));
+		stream.next_out =3D dbuf_out;
+		stream.avail_out =3D WRITE_BUFFER_SIZE;
+		stream.next_in =3D dbuf_in;
+		stream.avail_in =3D 0;
+		git_deflate_init(&stream, zlib_compression_level);
+	}
+
 	for (i =3D 0; i < entries; i++) {
 		struct cache_entry *ce =3D cache[i];
 		int size;
@@ -1625,11 +1688,52 @@ int write_index(struct index_state *istate, int=
 newfd)
 		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
 			ce_smudge_racily_clean_entry(ce);
 		size =3D ce_prepare_ondisk_entry(ce, &ce_ondisk, &ce_ondisk_size);
-		if (ce_write(&c, newfd, ce_ondisk, size) < 0)
-			return -1;
+		if (!deflate) {
+			if (ce_write(&c, newfd, ce_ondisk, size) < 0)
+				return -1;
+			continue;
+		}
+
+		if (stream.avail_in)
+			memmove(dbuf_in, stream.next_in, stream.avail_in);
+		memcpy(dbuf_in + stream.avail_in, ce_ondisk, size);
+		stream.next_in =3D dbuf_in;
+		stream.avail_in +=3D size;
+		do {
+			status =3D git_deflate(&stream, 0);
+			if (stream.next_out > dbuf_out) {
+				size =3D stream.next_out - dbuf_out;
+				if (ce_write(&c, newfd, dbuf_out, size) < 0)
+					return -1;
+				stream.next_out =3D dbuf_out;
+				stream.avail_out =3D WRITE_BUFFER_SIZE;
+			}
+		} while (status =3D=3D Z_OK);
 	}
 	free(ce_ondisk);
=20
+	if (deflate) {
+		do {
+			status =3D git_deflate(&stream, Z_FINISH);
+			if (stream.next_out > dbuf_out) {
+				int size =3D stream.next_out - dbuf_out;
+				if (ce_write(&c, newfd, dbuf_out, size) < 0)
+					return -1;
+				stream.next_out =3D dbuf_out;
+				stream.avail_out =3D WRITE_BUFFER_SIZE;
+			}
+		} while (status =3D=3D Z_OK);
+
+		git_deflate_end(&stream);
+		if (stream.next_out > dbuf_out) {
+			int size =3D stream.next_out - dbuf_out;
+			if (ce_write(&c, newfd, dbuf_out, size) < 0)
+				return -1;
+		}
+		free(dbuf_in);
+		free(dbuf_out);
+	}
+
 	/* Write extension data here */
 	if (istate->cache_tree) {
 		struct strbuf sb =3D STRBUF_INIT;
--=20
1.7.8.36.g69ee2
