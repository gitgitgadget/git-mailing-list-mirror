From: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
Subject: [PATCH 2/6] Read the base offset or name of delta objects
Date: Sat,  3 Oct 2009 20:09:57 +0200
Message-ID: <1254593401-18801-3-git-send-email-herve@itaapy.com>
References: <1254593401-18801-1-git-send-email-herve@itaapy.com>
 <1254593401-18801-2-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 20:13:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu96c-0004eY-Bd
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 20:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756736AbZJCSJa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Oct 2009 14:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756720AbZJCSJa
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 14:09:30 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:54136 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756672AbZJCSJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 14:09:29 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id EAC984B01AB;
	Sat,  3 Oct 2009 20:08:47 +0200 (CEST)
Received: from localhost.localdomain (mon75-11-82-242-92-33.fbx.proxad.net [82.242.92.33])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 0289F4B014E;
	Sat,  3 Oct 2009 20:08:44 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.4
In-Reply-To: <1254593401-18801-2-git-send-email-herve@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129489>

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
index a562a19..3cfc932 100644
--- a/src/odb.c
+++ b/src/odb.c
@@ -97,8 +97,10 @@ struct git_odb {
 };
=20
 typedef struct {  /* object header data */
-	git_otype type;  /* object type */
-	size_t    size;  /* object size */
+	git_otype type;     /* object type */
+	size_t    size;     /* object size */
+	off_t base_offset;  /* delta base offset (GIT_OBJ_OFS_DELTA) */
+	git_oid base_name;  /* delta base name (GIT_OBJ_REF_DELTA) */
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
1.6.4.4
