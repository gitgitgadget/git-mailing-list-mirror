From: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
Subject: [PATCH 4/6] Inflate an object from a pack file
Date: Sat,  3 Oct 2009 20:09:59 +0200
Message-ID: <1254593401-18801-5-git-send-email-herve@itaapy.com>
References: <1254593401-18801-1-git-send-email-herve@itaapy.com>
 <1254593401-18801-2-git-send-email-herve@itaapy.com>
 <1254593401-18801-3-git-send-email-herve@itaapy.com>
 <1254593401-18801-4-git-send-email-herve@itaapy.com>
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
	id 1Mu96c-0004eY-Tf
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 20:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772AbZJCSJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Oct 2009 14:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756720AbZJCSJb
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 14:09:31 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:54143 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756704AbZJCSJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 14:09:29 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 86F154B016F;
	Sat,  3 Oct 2009 20:08:47 +0200 (CEST)
Received: from localhost.localdomain (mon75-11-82-242-92-33.fbx.proxad.net [82.242.92.33])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 8CD1C4B015F;
	Sat,  3 Oct 2009 20:08:45 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.4
In-Reply-To: <1254593401-18801-4-git-send-email-herve@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129487>

Support delta objects too.

Signed-off-by: Herv=C3=A9 Cauwelier <herve@itaapy.com>
---
 src/odb.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 files changed, 68 insertions(+), 1 deletions(-)

diff --git a/src/odb.c b/src/odb.c
index 89ee1f2..bc26cf7 100644
--- a/src/odb.c
+++ b/src/odb.c
@@ -28,6 +28,7 @@
 #include "git/zlib.h"
 #include "fileops.h"
 #include "hash.h"
+#include "delta-apply.h"
 #include "odb.h"
=20
 #define GIT_PACK_NAME_MAX (5 + 40 + 1)
@@ -232,7 +233,7 @@ static int is_zlib_compressed_data(unsigned char *d=
ata)
 	unsigned int w;
=20
 	w =3D ((unsigned int)(data[0]) << 8) + data[1];
-	return data[0] =3D=3D 0x78 && !(w %31);
+	return data[0] =3D=3D 0x78 && !(w % 31);
 }
=20
 static size_t get_binary_object_header(obj_hdr *hdr, gitfo_buf *obj)
@@ -1192,6 +1193,72 @@ int git_odb__read_loose(git_obj *out, git_odb *d=
b, const git_oid *id)
 	return GIT_SUCCESS;
 }
=20
+static int inflate_pack_obj(git_obj *out, git_pack *p, off_t offset)
+{
+	obj_hdr hdr;
+	gitfo_buf buf;
+	size_t used;
+	void *data;
+	git_obj base;
+
+	/* Cast the map to a gitfo_buf */
+	buf.data =3D (unsigned char *)p->pack_map.data + offset;
+	buf.len =3D p->pack_map.len - offset;
+
+	/*
+	 * Read the object header, which is an (uncompressed)
+	 * binary encoding of the object type and size.
+	 */
+	if (!(used =3D get_binary_object_header(&hdr, &buf)))
+		return GIT_ERROR;
+
+	/*
+	 * Read the object data as a zlib compressed data
+	 */
+	buf.data +=3D used;
+	buf.len -=3D used;
+	assert(is_zlib_compressed_data(buf.data));
+
+	if (!(data =3D git__malloc(hdr.size + 1)))
+		return GIT_ERROR;
+	if (inflate_buffer(buf.data, buf.len, data, hdr.size))
+		goto inflate_fail;
+
+	switch (hdr.type) {
+		case GIT_OBJ_COMMIT:
+		case GIT_OBJ_TREE:
+		case GIT_OBJ_BLOB:
+		case GIT_OBJ_TAG:
+			out->data =3D data;
+			out->len =3D hdr.size;
+			out->type =3D hdr.type;
+			return GIT_SUCCESS;
+		case GIT_OBJ_OFS_DELTA:
+			offset -=3D hdr.base_offset;
+			if (inflate_pack_obj(&base, p, offset))
+				goto inflate_fail;
+			if (git__delta_apply(out, base.data, base.len, data, hdr.size))
+				goto inflate_fail;
+			out->type =3D base.type;
+			return GIT_SUCCESS;
+		case GIT_OBJ_REF_DELTA:
+			if (p->idx_search(&offset, p, &hdr.base_name))
+				goto inflate_fail;
+			if (inflate_pack_obj(&base, p, offset))
+				goto inflate_fail;
+			if (git__delta_apply(out, base.data, base.len, data, hdr.size))
+				goto inflate_fail;
+			out->type =3D base.type;
+			return GIT_SUCCESS;
+		default:
+			goto inflate_fail;
+	}
+
+inflate_fail:
+	free(data);
+	return GIT_ERROR;
+}
+
 static int read_packed(git_obj *out, git_pack *p, const git_oid *id)
 {
 	off_t pos;
--=20
1.6.4.4
