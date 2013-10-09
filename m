From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/9] pv4_tree_desc: allow decode_entries to return v4 trees, one at a time
Date: Wed,  9 Oct 2013 21:46:12 +0700
Message-ID: <1381329976-32082-6-git-send-email-pclouds@gmail.com>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 16:43:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTuz5-0007UJ-KB
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 16:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637Ab3JIOn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Oct 2013 10:43:26 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:42201 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab3JIOnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 10:43:25 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so1007288pdj.21
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wAUQNl87FNckcgPrcIzxA4y1xjfTS89s21dIv+mp1E8=;
        b=rPbNylZWi1mp9Lh3QlrICT8W3+f81Vnm2kIHozPUvFy03xahDc/DedR47ql1E10C6N
         xxg6ZJWSXHfDEKh0HfV7f5c7ZAOuRuFK4JFTxkfxVclKeyByEdEHGQkTlbwj11wwCEGk
         7NgxPXvQF2cbkTiyizZ53THQim9HHYKPd6s9+eRVQo5SOf3QY1zgU4ZIvxsevD+OqEnJ
         iB7KkzHM0PqMEKcmRKXK3JPNMO0cSfvX8RONi42Amm+tyDaH6XSAl7H5JOAy7KREYZEX
         mBPULc3JRzM90dqPZ9nrMBjb9rgcPPvL2AB42nSKE1xYBpNKDSE/Jw5Qqaa0sO1Dx84S
         AJBw==
X-Received: by 10.66.162.167 with SMTP id yb7mr10092191pab.16.1381329801753;
        Wed, 09 Oct 2013 07:43:21 -0700 (PDT)
Received: from lanh ([115.73.225.201])
        by mx.google.com with ESMTPSA id iu7sm47021298pbc.45.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 07:43:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:47:03 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235818>

When PV4_TREE_CANONICAL is passed, decode_entries() generates <count>
tree entries in canonical format. When this flag is not passed _and_
count is 1, decode_entries fills struct name_entry and saves
sha1_index.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 packv4-parse.h | 10 ++++++++++
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index f5c486e..f222456 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -365,6 +365,12 @@ static int copy_canonical_tree_entries(struct pv4_=
tree_desc *v4, off_t offset,
 	while (start--)
 		update_tree_entry(desc);
=20
+	if (!(v4->flags & PV4_TREE_CANONICAL)) {
+		v4->sha1_index =3D 0;
+		v4->pathlen =3D tree_entry_len(&desc->entry);
+		return 0;
+	}
+
 	from =3D desc->buffer;
 	while (count--)
 		update_tree_entry(desc);
@@ -462,6 +468,33 @@ static int generate_tree_entry(struct pv4_tree_des=
c *desc,
 	return 0;
 }
=20
+static int get_tree_entry_v4(struct pv4_tree_desc *desc,
+			     const unsigned char **bufp,
+			     int what)
+{
+	const unsigned char *path;
+
+	path =3D get_pathref(desc->p, what >> 1, &desc->pathlen);
+	if (!path)
+		return -1;
+	desc->v2.entry.mode =3D (path[0] << 8) | path[1];
+	desc->v2.entry.path =3D (const char *)path + 2;
+
+	if (**bufp) {
+		desc->sha1_index =3D decode_varint(bufp);
+		if (desc->sha1_index < 1 ||
+		    desc->sha1_index - 1 > desc->p->num_objects)
+			return error("bad index in get_sha1ref");
+		desc->v2.entry.sha1 =3D desc->p->sha1_table + (desc->sha1_index - 1)=
 * 20;
+	} else {
+		desc->sha1_index =3D 0;
+		desc->v2.entry.sha1 =3D *bufp + 1;
+		*bufp +=3D 21;
+	}
+
+	return 0;
+}
+
 static int decode_entries(struct pv4_tree_desc *desc, off_t obj_offset=
,
 			  unsigned int start, unsigned int count)
 {
@@ -561,8 +594,14 @@ static int decode_entries(struct pv4_tree_desc *de=
sc, off_t obj_offset,
 			/*
 			 * This is an actual tree entry to recreate.
 			 */
-			if (generate_tree_entry(desc, &scp, what))
-				return -1;
+			if (desc->flags & PV4_TREE_CANONICAL) {
+				if (generate_tree_entry(desc, &scp, what))
+					return -1;
+			} else if (count =3D=3D 1) {
+				if (get_tree_entry_v4(desc, &scp, what))
+					return -1;
+			} else
+				die("generating multiple v4 entries is not supported");
 			count--;
 			curpos++;
 		} else if (what & 1) {
@@ -668,6 +707,7 @@ void *pv4_get_tree(struct packed_git *p, struct pac=
k_window **w_curs,
 	int ret;
=20
 	memset(&desc, 0, sizeof(desc));
+	desc.flags =3D PV4_TREE_CANONICAL;
 	desc.p =3D p;
 	desc.w_curs =3D *w_curs;
 	strbuf_init(&desc.buf, size);
diff --git a/packv4-parse.h b/packv4-parse.h
index 04b9a59..fe0ea38 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -24,10 +24,20 @@ void *pv4_get_commit(struct packed_git *p, struct p=
ack_window **w_curs,
 void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
 		   off_t obj_offset, unsigned long size);
=20
+/*
+ * These are private flags, never pass them directly to
+ * pv4_tree_desc_*
+ */
+#define PV4_TREE_CANONICAL   0x800
+
 struct pv4_tree_desc {
+	unsigned flags;
+
 	/* v4 entry */
 	struct packed_git *p;
 	struct pack_window *w_curs;
+	unsigned int sha1_index;
+	int pathlen;
=20
 	/* v2 entry */
 	struct tree_desc v2;
--=20
1.8.2.83.gc99314b
