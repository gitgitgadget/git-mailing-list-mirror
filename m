From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] pack v4: cache flattened v4 trees in delta base cache
Date: Thu, 12 Sep 2013 17:38:03 +0700
Message-ID: <1378982284-7848-3-git-send-email-pclouds@gmail.com>
References: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 12:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK4HT-0008TH-4t
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 12:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab3ILKhn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Sep 2013 06:37:43 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:52336 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab3ILKhm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 06:37:42 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so10513391pdj.11
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 03:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ONnlULdTp8FaqKDFkY0YWnmAtxc6z6jZASKCz071XOk=;
        b=RPudO4L13jZoa04FQJe4LD/qnuMLK/3nycYArfaoprA/OIYF6z2gjdqrbH5pKYwG2c
         9xSpVIYrCGM7PcaGEj9XfgeI7GlmYq/rsOaRM+M418ImMWoMYjzGtETzcnUcPOD7tWO0
         WBFrehitTIThfA1IFFo+mtQpdeDo4pOVik+CvDFkN+85TBKUTnpmSxR6FfEnnMQWT+kv
         lWu78yrBhdRRYVlJJ+LhXkwftyBQmC6IfModGOa2qgyZACOuBVi2uwrA0xUal8hqx6SZ
         J4noCdN09ZuiWnf3Eg8fO/V4XmZRXcM1PQbrWb4f/BESRQEBvmVSUsOzw6GKigrJmKuB
         T/jw==
X-Received: by 10.66.121.131 with SMTP id lk3mr8695971pab.61.1378982261925;
        Thu, 12 Sep 2013 03:37:41 -0700 (PDT)
Received: from lanh ([115.73.201.215])
        by mx.google.com with ESMTPSA id j9sm9856316paj.18.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 03:37:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 12 Sep 2013 17:40:54 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234642>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The memmove in pv4_get_tree() may look inefficient. I added a
 heuristics to avoid moving if nb_entries takes 2 bytes (most common,
 I think), but it does not improve much. So memmove() is probably ok.

 packv4-parse.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+-------
 packv4-parse.h |  3 ++-
 sha1_file.c    |  8 +++++++-
 3 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index ae3e6a5..5002f42 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -406,7 +406,10 @@ static int tree_entry_prefix(unsigned char *buf, u=
nsigned long size,
=20
 static int decode_entries(struct packed_git *p, struct pack_window **w=
_curs,
 			  off_t offset, unsigned int start, unsigned int count,
-			  unsigned char **dstp, unsigned long *sizep, int hdr)
+			  unsigned char **dstp, unsigned long *sizep,
+			  unsigned char **v4_dstp, unsigned long *v4_sizep,
+			  unsigned int *v4_entries,
+			  int hdr)
 {
 	unsigned long avail;
 	unsigned int nb_entries;
@@ -422,10 +425,18 @@ static int decode_entries(struct packed_git *p, s=
truct pack_window **w_curs,
 			if (++scp - src >=3D avail - 20)
 				return -1;
 		/* is this a canonical tree object? */
-		if ((*scp & 0xf) =3D=3D OBJ_TREE)
+		if ((*scp & 0xf) =3D=3D OBJ_TREE) {
+			/*
+			 * we could try to convert to v4 tree before
+			 * giving up, provided that the number of
+			 * inconvertible trees is small. But that's
+			 * for later.
+			 */
+			*v4_dstp =3D NULL;
 			return copy_canonical_tree_entries(p, offset,
 							   start, count,
 							   dstp, sizep);
+		}
 		/* let's still make sure this is actually a pv4 tree */
 		if ((*scp++ & 0xf) !=3D OBJ_PV4_TREE)
 			return -1;
@@ -484,6 +495,16 @@ static int decode_entries(struct packed_git *p, st=
ruct pack_window **w_curs,
 			*dstp +=3D len + 20;
 			*sizep -=3D len + 20;
 			count--;
+			if (*v4_dstp) {
+				if (scp - src > *v4_sizep)
+					*v4_dstp =3D NULL;
+				else {
+					memcpy(*v4_dstp, src, scp - src);
+					*v4_dstp +=3D scp - src;
+					*v4_sizep -=3D scp - src;
+					(*v4_entries)++;
+				}
+			}
 		} else if (what & 1) {
 			/*
 			 * Copy from another tree object.
@@ -537,7 +558,8 @@ static int decode_entries(struct packed_git *p, str=
uct pack_window **w_curs,
 				count -=3D copy_count;
 				ret =3D decode_entries(p, w_curs,
 					copy_objoffset, copy_start, copy_count,
-					dstp, sizep, 1);
+					dstp, sizep, v4_dstp, v4_sizep,
+					v4_entries, 1);
 				if (ret)
 					return ret;
 				/* force pack window readjustment */
@@ -554,11 +576,13 @@ static int decode_entries(struct packed_git *p, s=
truct pack_window **w_curs,
 }
=20
 void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
-		   off_t offset, unsigned long size)
+		   off_t offset, unsigned long size,
+		   void **v4_data, unsigned long *v4_size)
 {
-	unsigned long avail;
-	unsigned int nb_entries;
+	unsigned long avail, v4_max_size;
+	unsigned int nb_entries, v4_entries;
 	unsigned char *dst, *dcp;
+	unsigned char *v4_dst, *v4_dcp;
 	const unsigned char *src, *scp;
 	int ret;
=20
@@ -570,11 +594,33 @@ void *pv4_get_tree(struct packed_git *p, struct p=
ack_window **w_curs,
=20
 	dst =3D xmallocz(size);
 	dcp =3D dst;
-	ret =3D decode_entries(p, w_curs, offset, 0, nb_entries, &dcp, &size,=
 0);
+	if (v4_data) {
+		/*
+		 * v4 can't be larger than canonical, so "size" should
+		 * be enough
+		 */
+		v4_max_size =3D size;
+		v4_dst =3D v4_dcp =3D xmallocz(v4_max_size);
+		v4_entries =3D 0;
+	}
+	ret =3D decode_entries(p, w_curs, offset, 0, nb_entries,
+			     &dcp, &size,
+			     v4_data ? &v4_dcp : NULL, &v4_max_size,
+			     &v4_entries, 0);
 	if (ret < 0 || size !=3D 0) {
 		free(dst);
+		free(v4_dst);
 		return NULL;
 	}
+	if (v4_data && v4_dcp) {
+		unsigned char hdr[10];
+		int len =3D encode_varint(v4_entries, hdr);
+		memmove(v4_dst + len, v4_dst, v4_dcp - v4_dst);
+		memcpy(v4_dst, hdr, len);
+		*v4_data =3D v4_dst;
+		*v4_size =3D len + v4_dcp - v4_dst;
+	} else
+		free(v4_dst);
 	return dst;
 }
=20
diff --git a/packv4-parse.h b/packv4-parse.h
index d674a3f..647b73c 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -20,6 +20,7 @@ const unsigned char *get_sha1ref(struct packed_git *p=
,
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs=
,
 		     off_t offset, unsigned long size);
 void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
-		   off_t offset, unsigned long size);
+		   off_t offset, unsigned long size,
+		   void **v4_data, unsigned long *v4_size);
=20
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 03c66bb..b176316 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2103,6 +2103,8 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
 	struct unpack_entry_stack_ent *delta_stack =3D small_delta_stack;
 	int delta_stack_nr =3D 0, delta_stack_alloc =3D UNPACK_ENTRY_STACK_PR=
EALLOC;
 	int base_from_cache =3D 0;
+	void *v4_data;
+	unsigned long v4_size;
=20
 	if (log_pack_access !=3D no_log_pack_access)
 		write_pack_access_log(p, obj_offset);
@@ -2181,7 +2183,11 @@ void *unpack_entry(struct packed_git *p, off_t o=
bj_offset,
 		type -=3D 8;
 		break;
 	case OBJ_PV4_TREE:
-		data =3D pv4_get_tree(p, &w_curs, curpos, size);
+		v4_data =3D NULL;
+		data =3D pv4_get_tree(p, &w_curs, curpos, size, &v4_data, &v4_size);
+		if (v4_data)
+			add_delta_base_cache(p, obj_offset, v4_data,
+					     size, v4_size, type);
 		type -=3D 8;
 		break;
 	case OBJ_COMMIT:
--=20
1.8.2.83.gc99314b
