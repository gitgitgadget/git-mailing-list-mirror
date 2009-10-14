From: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
Subject: [PATCH 2/6] Read the base offset or name of delta objects
Date: Wed, 14 Oct 2009 12:37:45 +0200
Message-ID: <1255516669-26745-2-git-send-email-herve@itaapy.com>
References: <1255516669-26745-1-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 12:50:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My1Qg-0004AO-Lj
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 12:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbZJNKpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 06:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755168AbZJNKpn
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 06:45:43 -0400
Received: from mailhost-p4-p2.nerim.net ([195.5.209.61]:52498 "EHLO
	smtp-delay1.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755526AbZJNKpl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 06:45:41 -0400
Received: from mallaury.nerim.net (smtp-103-wednesday.noc.nerim.net [62.4.17.103])
	by smtp-delay1.nerim.net (Postfix) with ESMTP id 95AAEB3B30E
	for <git@vger.kernel.org>; Wed, 14 Oct 2009 12:36:54 +0200 (CEST)
Received: from localhost.localdomain (itaapy-35-170.cnt.nerim.net [213.215.35.170])
	by mallaury.nerim.net (Postfix) with ESMTP id C1624A1087
	for <git@vger.kernel.org>; Wed, 14 Oct 2009 12:35:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1255516669-26745-1-git-send-email-herve@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130279>

Signed-off-by: Herv=C3=A9 Cauwelier <herve@itaapy.com>
---
 src/cc-compat.h |    3 +++
 src/odb.c       |   28 ++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/src/cc-compat.h b/src/cc-compat.h
index 8997caa..8dd6774 100644
--- a/src/cc-compat.h
+++ b/src/cc-compat.h
@@ -30,6 +30,9 @@
 # define GIT_TYPEOF(x)
 #endif
=20
+#define bitsizeof(x)  (CHAR_BIT * sizeof(x))
+#define MSB(x, bits) ((x) & GIT_TYPEOF(x)(~0ULL << (bitsizeof(x) - (bi=
ts))))
+
 /*
  * Does our compiler/platform support the C99 <inttypes.h> and
  * <stdint.h> header files. (C99 requires that <inttypes.h>
diff --git a/src/odb.c b/src/odb.c
index 2319998..2b4b016 100644
--- a/src/odb.c
+++ b/src/odb.c
@@ -97,8 +97,10 @@ struct git_odb {
 };
=20
 typedef struct {  /* object header data */
-	git_otype type;  /* object type */
-	size_t    size;  /* object size */
+	git_otype type;         /* object type */
+	size_t    size;         /* object size */
+	off_t     base_offset;  /* delta base offset (GIT_OBJ_OFS_DELTA) */
+	git_oid   base_name;    /* delta base name (GIT_OBJ_REF_DELTA) */
 } obj_hdr;
=20
 static struct {
@@ -238,6 +240,7 @@ static size_t get_binary_object_header(obj_hdr *hdr=
, gitfo_buf *obj)
 	unsigned char c;
 	unsigned char *data =3D obj->data;
 	size_t shift, size, used =3D 0;
+	off_t base_offset;
=20
 	if (obj->len =3D=3D 0)
 		return 0;
@@ -258,6 +261,27 @@ static size_t get_binary_object_header(obj_hdr *hd=
r, gitfo_buf *obj)
 	}
 	hdr->size =3D size;
=20
+	hdr->base_offset =3D 0;
+	hdr->base_name.id[0] =3D '\0';
+
+	if (hdr->type =3D=3D GIT_OBJ_OFS_DELTA) {
+		c =3D data[used++];
+		base_offset =3D c & 127;
+		while (c & 128) {
+			base_offset++;
+			if (!base_offset || MSB(base_offset, 7))
+				return 0;  /* overflow */
+			c =3D data[used++];
+			base_offset =3D (base_offset << 7) + (c & 127);
+		}
+		assert(base_offset > 0);
+		hdr->base_offset =3D base_offset;
+	}
+	else if (hdr->type =3D=3D GIT_OBJ_REF_DELTA) {
+		git_oid_mkraw(&hdr->base_name, data + used);
+		used +=3D 20;
+	}
+
 	return used;
 }
=20
--=20
1.6.5
