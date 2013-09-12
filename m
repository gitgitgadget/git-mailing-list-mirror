From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] pack v4: avoid strlen() in tree_entry_prefix
Date: Thu, 12 Sep 2013 17:38:01 +0700
Message-ID: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 12:37:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK4HA-0008C2-Pw
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 12:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab3ILKhT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Sep 2013 06:37:19 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40087 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab3ILKhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 06:37:17 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so10514833pdj.35
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ixL+QB/pkR24zGXEB/hwuReQPzAgvT42Fh6R2hc+Czo=;
        b=YMGikkeXqNxhVNT0oXHfxy9FC5mPuxEQx57bedrBznCMUX5tXYHSulpvRuliaK75jk
         XPv/jAYucfY6c6BtvEixOU2A+EeCqJiyUXGluIHTwWzMmuyT3ndZJYXa+GNeQgZ/jv7P
         HXAQO3C70Gs6oM1AKhHBr/lqRZcF04h2POvasHe0klXCEFtEaaBzitsEgSJjDuF0aAAk
         FTHOXd8ZilyP3BpIv7SoOvZl89dQ0R6Y1OEpDOzaPBfFuQfsig/Gfyeif/+iEuESUwfL
         iCQ0Dg19Fg5vs++Qa4t5bTeEEsQV7KeaKxigUCu6uywoDmIf2BYmH5PF7XSW8c0AN122
         ocWQ==
X-Received: by 10.67.21.226 with SMTP id hn2mr8786421pad.69.1378982237259;
        Thu, 12 Sep 2013 03:37:17 -0700 (PDT)
Received: from lanh ([115.73.201.215])
        by mx.google.com with ESMTPSA id yo2sm9883609pab.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 03:37:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 12 Sep 2013 17:40:30 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234640>

We do know the length of the path name of an tree entry from the tree
dictionary. On an unoptimized build, this cuts down "git rev-list
--objects v1.8.4"'s time from 6.2s to 5.8s. This difference is less on
optimized builds.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index c00a014..ae3e6a5 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -50,15 +50,17 @@ struct packv4_dict *pv4_create_dict(const unsigned =
char *data, int dict_size)
 		return NULL;
 	}
=20
-	dict =3D xmalloc(sizeof(*dict) + nb_entries * sizeof(dict->offsets[0]=
));
+	dict =3D xmalloc(sizeof(*dict) +
+		       (nb_entries + 1) * sizeof(dict->offsets[0]));
 	dict->data =3D data;
 	dict->nb_entries =3D nb_entries;
=20
+	dict->offsets[0] =3D 0;
 	cp =3D data;
 	for (i =3D 0; i < nb_entries; i++) {
-		dict->offsets[i] =3D cp - data;
 		cp +=3D 2;
 		cp +=3D strlen((const char *)cp) + 1;
+		dict->offsets[i + 1] =3D cp - data;
 	}
=20
 	return dict;
@@ -163,7 +165,8 @@ static void load_path_dict(struct packed_git *p)
 	p->path_dict =3D paths;
 }
=20
-const unsigned char *get_pathref(struct packed_git *p, unsigned int in=
dex)
+const unsigned char *get_pathref(struct packed_git *p, unsigned int in=
dex,
+				 int *len)
 {
 	if (!p->path_dict)
 		load_path_dict(p);
@@ -172,6 +175,9 @@ const unsigned char *get_pathref(struct packed_git =
*p, unsigned int index)
 		error("%s: index overflow", __func__);
 		return NULL;
 	}
+	if (len)
+		*len =3D p->path_dict->offsets[index + 1] -
+			p->path_dict->offsets[index];
 	return p->path_dict->data + p->path_dict->offsets[index];
 }
=20
@@ -373,9 +379,9 @@ static int copy_canonical_tree_entries(struct packe=
d_git *p, off_t offset,
 }
=20
 static int tree_entry_prefix(unsigned char *buf, unsigned long size,
-			     const unsigned char *path, unsigned mode)
+			     const unsigned char *path, int path_len,
+			     unsigned mode)
 {
-	int path_len =3D strlen((const char *)path) + 1;
 	int mode_len =3D 0;
 	int len;
 	unsigned char mode_buf[8];
@@ -463,14 +469,15 @@ static int decode_entries(struct packed_git *p, s=
truct pack_window **w_curs,
 			 */
 			const unsigned char *path, *sha1;
 			unsigned mode;
-			int len;
+			int len, pathlen;
=20
-			path =3D get_pathref(p, what >> 1);
+			path =3D get_pathref(p, what >> 1, &pathlen);
 			sha1 =3D get_sha1ref(p, &scp);
 			if (!path || !sha1)
 				return -1;
 			mode =3D (path[0] << 8) | path[1];
-			len =3D tree_entry_prefix(*dstp, *sizep, path + 2, mode);
+			len =3D tree_entry_prefix(*dstp, *sizep,
+						path + 2, pathlen - 2, mode);
 			if (!len || len + 20 > *sizep)
 				return -1;
 			hashcpy(*dstp + len, sha1);
--=20
1.8.2.83.gc99314b
