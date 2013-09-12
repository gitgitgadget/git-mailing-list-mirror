From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/4] pack v4: convert v4 tree to canonical format if found in base cache
Date: Thu, 12 Sep 2013 20:29:10 +0700
Message-ID: <1378992550-11771-1-git-send-email-pclouds@gmail.com>
References: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 15:26:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK6uQ-0000S6-Jr
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 15:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab3ILN0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Sep 2013 09:26:04 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:37891 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab3ILN0B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 09:26:01 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so10602395pbb.14
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pFpovRat8kqJeIIE/L7z4wn1WOj8sBMgemXx7Cv7BPo=;
        b=ApeXQxkaYA9AhhisWsLqswPLDlzm9q6JdBNBFjQxWLkpc0a5mavtgYyaokZXhCl2bG
         95EZDXYFAdGBXqrGXgHP0kQYlpMEpCuwd9ayavPk6U2z2hzjIX9LvYW/iyN8LMgxGQTY
         Zth3AZGH5TzSZnUEzyOeDrcGT70gjlaknScZYkxhB2BGCPgBf9W90StvRJvW4ztWIgK9
         6QPu6Jf051L2pD24p8CU9TIairx8bf/j3o2/e5KxIRtDWdVeGFJEA6JdciM2i/xNG9UD
         +n9tQ9ohGzjERdwVVElEIfo9EAYf3EwuDXspuObQQZotITSD7A9AnM4QCf+ctxZR2D4h
         SYUg==
X-Received: by 10.66.190.198 with SMTP id gs6mr9334278pac.49.1378992361344;
        Thu, 12 Sep 2013 06:26:01 -0700 (PDT)
Received: from lanh ([115.73.201.215])
        by mx.google.com with ESMTPSA id kz4sm4841222pbc.39.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 06:26:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 12 Sep 2013 20:29:14 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234650>

"git log --stat -10000 v1.4.8 >/dev/null" takes 13s with v4 (8s with
v2). Of course we could do better when v4-aware tree-diff interface is
in place..

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Oops.. forgot this and broke git.

 Another option is change cache_or_unpack_entry() to force
 OBJ_PV4_TREE to go through unpack_entry(), then update pv4_get_tree() =
to
 lookup the base cache at the first decode_entries() call. Right now
 it does not (hdr =3D=3D 0) so we need more processing.

 packv4-parse.c | 22 ++++++++++++++++++++++
 packv4-parse.h |  2 ++
 sha1_file.c    | 11 +++++++++++
 3 files changed, 35 insertions(+)

diff --git a/packv4-parse.c b/packv4-parse.c
index b8855b0..448c91e 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -461,6 +461,10 @@ static int decode_entries(struct packed_git *p, st=
ruct pack_window **w_curs,
 	avail -=3D scp - src;
 	src =3D scp;
=20
+	/* special case for pv4_cached_tree_to_canonical() */
+	if (!count && cached)
+		count =3D nb_entries;
+
 	while (count) {
 		unsigned int what;
=20
@@ -648,3 +652,21 @@ unsigned long pv4_unpack_object_header_buffer(cons=
t unsigned char *base,
 	*sizep =3D val >> 4;
 	return cp - base;
 }
+
+/* offset must already be cached! */
+void *pv4_cached_tree_to_canonical(struct packed_git *p, off_t offset,
+				   unsigned long size)
+{
+	int ret;
+	unsigned char *dst, *dcp;
+	unsigned char *v4_dstp =3D NULL;
+	dst =3D xmallocz(size);
+	dcp =3D dst;
+	ret =3D decode_entries(p, NULL, offset, 0, 0,
+			     &dcp, &size, &v4_dstp, NULL, NULL, 1);
+	if (ret < 0 || size !=3D 0) {
+		free(dst);
+		return NULL;
+	}
+	return dst;
+}
diff --git a/packv4-parse.h b/packv4-parse.h
index f584c31..ad21e19 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -24,5 +24,7 @@ void *pv4_get_commit(struct packed_git *p, struct pac=
k_window **w_curs,
 void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
 		   off_t offset, unsigned long size,
 		   void **v4_data, unsigned long *v4_size);
+void *pv4_cached_tree_to_canonical(struct packed_git *p, off_t offset,
+				   unsigned long size);
=20
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 82570be..0944ef6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2000,6 +2000,17 @@ static void *cache_or_unpack_entry(struct packed=
_git *p, off_t base_offset,
 	if (!eq_delta_base_cache_entry(ent, p, base_offset))
 		return unpack_entry(p, base_offset, type, base_size);
=20
+	if (ent->type =3D=3D OBJ_PV4_TREE) {
+		ret =3D pv4_cached_tree_to_canonical(p, base_offset, ent->size);
+		if (!ret)
+			return NULL;
+		if (!keep_cache)
+			clear_delta_base_cache_entry(ent);
+		*type =3D OBJ_TREE;
+		*base_size =3D ent->size;
+		return ret;
+	}
+
 	ret =3D ent->data;
=20
 	if (!keep_cache)
--=20
1.8.2.83.gc99314b
