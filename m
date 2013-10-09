From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/9] pack v4: move v2 tree entry generation code out of decode_entries
Date: Wed,  9 Oct 2013 21:46:09 +0700
Message-ID: <1381329976-32082-3-git-send-email-pclouds@gmail.com>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 16:43:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTuyi-00079X-Ga
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 16:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab3JIOm7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Oct 2013 10:42:59 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:62254 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab3JIOm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 10:42:59 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so1018968pde.23
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/ely/Mg2C38srO4S6s0pUZ6L1wbvBsyFi07yC1QKGFQ=;
        b=NQ8f1FcPaDuGbzYg8Z7nOOcCDxkBZO5Dm5H5yD+Naux5i0wUDOqB2yv1F20bEdksoF
         TC1VXVtynvJSIJa1rkFHDIWpxlxz2p4287DwSeJScvyTwWyNSs9C6pU4Fyu09z5YhbWI
         +OEl5WqvSmaCMpeygZMgC81pTKofa9QO2jOpkhxwhjWlammw8Px2t2rJhdDrMh0jvpk4
         Bv4Qbw7VhoktCWv0HxbZoUmQWl/98WdXjHncqxUjCq1f6blUZrRjNaycMMO0g7j/BWEt
         /GuPyxp/gQSOMYLXa9WyyXXnTWDPcX+Ja4XUxiAKcPhYn6gI6UP7PbY+6aNAlIeOq0YF
         glYA==
X-Received: by 10.66.146.42 with SMTP id sz10mr10105503pab.100.1381329778689;
        Wed, 09 Oct 2013 07:42:58 -0700 (PDT)
Received: from lanh ([115.73.225.201])
        by mx.google.com with ESMTPSA id bp4sm44472858pbb.42.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 07:42:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:46:41 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235815>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index 31c89c7..7b096cb 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -443,6 +443,31 @@ static int tree_entry_prefix(unsigned char *buf, u=
nsigned long size,
 	return len;
 }
=20
+static int generate_tree_entry(struct packed_git *p,
+			       const unsigned char **bufp,
+			       unsigned char **dstp, unsigned long *sizep,
+			       int what)
+{
+	const unsigned char *path, *sha1;
+	unsigned mode;
+	int len, pathlen;
+
+	path =3D get_pathref(p, what >> 1, &pathlen);
+	sha1 =3D get_sha1ref(p, bufp);
+	if (!path || !sha1)
+		return -1;
+	mode =3D (path[0] << 8) | path[1];
+	len =3D tree_entry_prefix(*dstp, *sizep,
+				path + 2, pathlen - 2, mode);
+	if (!len || len + 20 > *sizep)
+		return -1;
+	hashcpy(*dstp + len, sha1);
+	len +=3D 20;
+	*dstp +=3D len;
+	*sizep -=3D len;
+	return 0;
+}
+
 static int decode_entries(struct packed_git *p, struct pack_window **w=
_curs,
 			  off_t obj_offset, unsigned int start, unsigned int count,
 			  unsigned char **dstp, unsigned long *sizep)
@@ -543,22 +568,8 @@ static int decode_entries(struct packed_git *p, st=
ruct pack_window **w_curs,
 			/*
 			 * This is an actual tree entry to recreate.
 			 */
-			const unsigned char *path, *sha1;
-			unsigned mode;
-			int len, pathlen;
-
-			path =3D get_pathref(p, what >> 1, &pathlen);
-			sha1 =3D get_sha1ref(p, &scp);
-			if (!path || !sha1)
-				return -1;
-			mode =3D (path[0] << 8) | path[1];
-			len =3D tree_entry_prefix(*dstp, *sizep,
-						path + 2, pathlen - 2, mode);
-			if (!len || len + 20 > *sizep)
+			if (generate_tree_entry(p, &scp, dstp, sizep, what))
 				return -1;
-			hashcpy(*dstp + len, sha1);
-			*dstp +=3D len + 20;
-			*sizep -=3D len + 20;
 			count--;
 			curpos++;
 		} else if (what & 1) {
--=20
1.8.2.83.gc99314b
