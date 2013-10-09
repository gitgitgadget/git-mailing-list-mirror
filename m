From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/9] pv4_tree_desc: introduce new struct for pack v4 tree walker
Date: Wed,  9 Oct 2013 21:46:10 +0700
Message-ID: <1381329976-32082-4-git-send-email-pclouds@gmail.com>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 16:43:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTuyp-0007HA-JP
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 16:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580Ab3JIOnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Oct 2013 10:43:09 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:50806 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab3JIOnI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 10:43:08 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so1011216pbb.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=x5MGAUkCjNs3c7efF3RlClJidnwPDGW1k+J5HYxckfY=;
        b=rci6+HZwEZkEpD5zpPZ8Syl6r6udpY5cxMBlnlsU/bVDZiyfnnvkV3oHdSN2djmoq5
         a6FKTpwjrsfiARm17JsSjUL3TiYwF78r8qKXoi6vd0ABs/hcNqDwZIrIhajCyxKnxI2b
         DZD8VlNvDf8gUtMWs2hS9oxn6uA2pqX+YItpK5n4UE2UNMU7/QKG/whWiILBo/E5JrO1
         fWbxWbvOy6kqc3StEdZp0La20m7xZat48Z7Ynp0m9k77JD6Z29d7RhqYV8kCkq+YzYTB
         kA64JFfGONDDrnU7ab7T/Fmp8JKI9D73r9Avl3MpCTrwON+j97CsSW83C6s/iCTFkla7
         VU1g==
X-Received: by 10.68.160.130 with SMTP id xk2mr8306282pbb.7.1381329787133;
        Wed, 09 Oct 2013 07:43:07 -0700 (PDT)
Received: from lanh ([115.73.225.201])
        by mx.google.com with ESMTPSA id fl3sm55403491pad.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 07:43:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:46:47 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235816>

This struct is intended to be the successor of struct tree_desc. For
now it only holds a buffer for converting pv4 tree to canonical format.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 73 ++++++++++++++++++++++++++++----------------------=
--------
 packv4-parse.h |  9 ++++++++
 2 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index 7b096cb..f9db364 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -344,9 +344,8 @@ void *pv4_get_commit(struct packed_git *p, struct p=
ack_window **w_curs,
 	return dst;
 }
=20
-static int copy_canonical_tree_entries(struct packed_git *p, off_t off=
set,
-				       unsigned int start, unsigned int count,
-				       unsigned char **dstp, unsigned long *sizep)
+static int copy_canonical_tree_entries(struct pv4_tree_desc *v4, off_t=
 offset,
+				       unsigned int start, unsigned int count)
 {
 	void *data;
 	const unsigned char *from, *end;
@@ -354,7 +353,7 @@ static int copy_canonical_tree_entries(struct packe=
d_git *p, off_t offset,
 	unsigned long size;
 	struct tree_desc desc;
=20
-	data =3D unpack_entry(p, offset, &type, &size);
+	data =3D unpack_entry(v4->p, offset, &type, &size);
 	if (!data)
 		return -1;
 	if (type !=3D OBJ_TREE) {
@@ -372,13 +371,11 @@ static int copy_canonical_tree_entries(struct pac=
ked_git *p, off_t offset,
 		update_tree_entry(&desc);
 	end =3D desc.buffer;
=20
-	if (end - from > *sizep) {
+	if (end - from > strbuf_avail(&v4->buf)) {
 		free(data);
 		return -1;
 	}
-	memcpy(*dstp, from, end - from);
-	*dstp +=3D end - from;
-	*sizep -=3D end - from;
+	strbuf_add(&v4->buf, from, end - from);
 	free(data);
 	return 0;
 }
@@ -417,7 +414,7 @@ static struct pv4_tree_cache *get_tree_offset_cache=
(struct packed_git *p, off_t
 	return c;
 }
=20
-static int tree_entry_prefix(unsigned char *buf, unsigned long size,
+static int tree_entry_prefix(char *buf, unsigned long size,
 			     const unsigned char *path, int path_len,
 			     unsigned mode)
 {
@@ -443,35 +440,33 @@ static int tree_entry_prefix(unsigned char *buf, =
unsigned long size,
 	return len;
 }
=20
-static int generate_tree_entry(struct packed_git *p,
+static int generate_tree_entry(struct pv4_tree_desc *desc,
 			       const unsigned char **bufp,
-			       unsigned char **dstp, unsigned long *sizep,
 			       int what)
 {
 	const unsigned char *path, *sha1;
+	char *buf =3D desc->buf.buf + desc->buf.len;
 	unsigned mode;
 	int len, pathlen;
=20
-	path =3D get_pathref(p, what >> 1, &pathlen);
-	sha1 =3D get_sha1ref(p, bufp);
+	path =3D get_pathref(desc->p, what >> 1, &pathlen);
+	sha1 =3D get_sha1ref(desc->p, bufp);
 	if (!path || !sha1)
 		return -1;
 	mode =3D (path[0] << 8) | path[1];
-	len =3D tree_entry_prefix(*dstp, *sizep,
+	len =3D tree_entry_prefix(buf, strbuf_avail(&desc->buf),
 				path + 2, pathlen - 2, mode);
-	if (!len || len + 20 > *sizep)
+	if (!len || len + 20 > strbuf_avail(&desc->buf))
 		return -1;
-	hashcpy(*dstp + len, sha1);
-	len +=3D 20;
-	*dstp +=3D len;
-	*sizep -=3D len;
+	memcpy(buf + len, sha1, 20);
+	desc->buf.len +=3D len + 20;
 	return 0;
 }
=20
-static int decode_entries(struct packed_git *p, struct pack_window **w=
_curs,
-			  off_t obj_offset, unsigned int start, unsigned int count,
-			  unsigned char **dstp, unsigned long *sizep)
+static int decode_entries(struct pv4_tree_desc *desc, off_t obj_offset=
,
+			  unsigned int start, unsigned int count)
 {
+	struct packed_git *p =3D desc->p;
 	unsigned long avail;
 	const unsigned char *src, *scp;
 	unsigned int curpos;
@@ -490,7 +485,7 @@ static int decode_entries(struct packed_git *p, str=
uct pack_window **w_curs,
 	} else {
 		unsigned int nb_entries;
=20
-		src =3D use_pack(p, w_curs, obj_offset, &avail);
+		src =3D use_pack(p, &desc->w_curs, obj_offset, &avail);
 		scp =3D src;
=20
 		/* we need to skip over the object header */
@@ -502,9 +497,8 @@ static int decode_entries(struct packed_git *p, str=
uct pack_window **w_curs,
 		/* is this a canonical tree object? */
 		case OBJ_TREE:
 		case OBJ_REF_DELTA:
-			return copy_canonical_tree_entries(p, obj_offset,
-							   start, count,
-							   dstp, sizep);
+			return copy_canonical_tree_entries(desc, obj_offset,
+							   start, count);
 		/* let's still make sure this is actually a pv4 tree */
 		case OBJ_PV4_TREE:
 			break;
@@ -542,7 +536,7 @@ static int decode_entries(struct packed_git *p, str=
uct pack_window **w_curs,
 		unsigned int what;
=20
 		if (avail < 20) {
-			src =3D use_pack(p, w_curs, offset, &avail);
+			src =3D use_pack(p, &desc->w_curs, offset, &avail);
 			if (avail < 20)
 				return -1;
 		}
@@ -568,7 +562,7 @@ static int decode_entries(struct packed_git *p, str=
uct pack_window **w_curs,
 			/*
 			 * This is an actual tree entry to recreate.
 			 */
-			if (generate_tree_entry(p, &scp, dstp, sizep, what))
+			if (generate_tree_entry(desc, &scp, what))
 				return -1;
 			count--;
 			curpos++;
@@ -638,9 +632,8 @@ static int decode_entries(struct packed_git *p, str=
uct pack_window **w_curs,
 					start =3D 0;
 				}
=20
-				ret =3D decode_entries(p, w_curs, copy_objoffset,
-						     copy_start, copy_count,
-						     dstp, sizep);
+				ret =3D decode_entries(desc, copy_objoffset,
+						     copy_start, copy_count);
 				if (ret)
 					return ret;
=20
@@ -672,17 +665,21 @@ static int decode_entries(struct packed_git *p, s=
truct pack_window **w_curs,
 void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
 		   off_t obj_offset, unsigned long size)
 {
-	unsigned char *dst, *dcp;
+	struct pv4_tree_desc desc;
 	int ret;
=20
-	dst =3D xmallocz(size);
-	dcp =3D dst;
-	ret =3D decode_entries(p, w_curs, obj_offset, 0, 0, &dcp, &size);
-	if (ret < 0 || size !=3D 0) {
-		free(dst);
+	memset(&desc, 0, sizeof(desc));
+	desc.p =3D p;
+	desc.w_curs =3D *w_curs;
+	strbuf_init(&desc.buf, size);
+
+	ret =3D decode_entries(&desc, obj_offset, 0, 0);
+	*w_curs =3D desc.w_curs;
+	if (ret < 0 || desc.buf.len !=3D size) {
+		strbuf_release(&desc.buf);
 		return NULL;
 	}
-	return dst;
+	return strbuf_detach(&desc.buf, NULL);
 }
=20
 unsigned long pv4_unpack_object_header_buffer(const unsigned char *bas=
e,
diff --git a/packv4-parse.h b/packv4-parse.h
index b437159..cad7a82 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -22,4 +22,13 @@ void *pv4_get_commit(struct packed_git *p, struct pa=
ck_window **w_curs,
 void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
 		   off_t obj_offset, unsigned long size);
=20
+struct pv4_tree_desc {
+	/* v4 entry */
+	struct packed_git *p;
+	struct pack_window *w_curs;
+
+	/* full canonical tree */
+	struct strbuf buf;
+};
+
 #endif
--=20
1.8.2.83.gc99314b
