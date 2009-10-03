From: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
Subject: [PATCH 1/6] Open the pack file and keep a map on it.
Date: Sat,  3 Oct 2009 20:09:56 +0200
Message-ID: <1254593401-18801-2-git-send-email-herve@itaapy.com>
References: <1254593401-18801-1-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 20:13:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu96b-0004eY-R1
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 20:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716AbZJCSJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Oct 2009 14:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756711AbZJCSJ2
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 14:09:28 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:54121 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756437AbZJCSJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 14:09:27 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id F39034B0184;
	Sat,  3 Oct 2009 20:08:45 +0200 (CEST)
Received: from localhost.localdomain (mon75-11-82-242-92-33.fbx.proxad.net [82.242.92.33])
	by smtp2-g21.free.fr (Postfix) with ESMTP id EFC854B007A;
	Sat,  3 Oct 2009 20:08:42 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.4
In-Reply-To: <1254593401-18801-1-git-send-email-herve@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129486>

On the same model than the idx file.

Signed-off-by: Herv=C3=A9 Cauwelier <herve@itaapy.com>
---
 src/odb.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++-
 src/odb.h |    5 ++-
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/src/odb.c b/src/odb.c
index 6d646a4..a562a19 100644
--- a/src/odb.c
+++ b/src/odb.c
@@ -64,6 +64,10 @@ struct git_pack {
=20
 	/** Name of the pack file(s), without extension ("pack-abc"). */
 	char pack_name[GIT_PACK_NAME_MAX];
+
+	/** The .pack file, mapped into memory. */
+	git_file pack_fd;
+	git_map pack_map;
 };
 typedef struct git_pack git_pack;
=20
@@ -782,7 +786,7 @@ static int pack_openidx(git_pack *p)
 			goto invalid_fail;
 		data =3D p->idx_map.data;
=20
-		if (decode32(&data[0]) =3D=3D PACK_TOC) {
+		if (decode32(&data[0]) =3D=3D IDX_TOC) {
 			switch (decode32(&data[1])) {
 			case 2:
 				if (pack_openidx_v2(p))
@@ -809,6 +813,59 @@ unlock_fail:
 	return GIT_ERROR;
 }
=20
+static int pack_openpack_map(git_pack *p)
+{
+	char pb[GIT_PATH_MAX];
+	off_t len;
+
+	if (git__fmt(pb, sizeof(pb), "%s/pack/%s.pack",
+			p->db->objects_dir,
+			p->pack_name) < 0)
+		return GIT_ERROR;
+
+	if ((p->pack_fd =3D gitfo_open(pb, O_RDONLY)) < 0)
+		return GIT_ERROR;
+
+	if ((len =3D gitfo_size(p->pack_fd)) < 0
+			|| !git__is_sizet(len)
+			|| gitfo_map_ro(&p->pack_map, p->pack_fd, 0, (size_t)len)) {
+		gitfo_close(p->pack_fd);
+		return GIT_ERROR;
+	}
+
+	return GIT_SUCCESS;
+}
+
+static int pack_openpack(git_pack *p)
+{
+	gitlck_lock(&p->lock);
+	if (p->invalid)
+		goto unlock_fail;
+	if (p->pack_fd < 0) {
+		uint32_t *data;
+
+		if (pack_openpack_map(p))
+			goto invalid_fail;
+		data =3D p->pack_map.data;
+
+		if (decode32(&data[0]) !=3D PACK_TOC)
+			goto unmap_fail;
+	}
+	gitlck_unlock(&p->lock);
+	return GIT_SUCCESS;
+
+unmap_fail:
+	gitfo_free_map(&p->pack_map);
+
+invalid_fail:
+	p->invalid =3D 1;
+	p->pack_fd =3D -1;
+
+unlock_fail:
+	gitlck_unlock(&p->lock);
+	return GIT_ERROR;
+}
+
 static void pack_decidx(git_pack *p)
 {
 	gitlck_lock(&p->lock);
@@ -830,6 +887,11 @@ static void pack_dec(git_pack *p)
 			gitfo_close(p->idx_fd);
 			free(p->im_fanout);
 		}
+		if (p->pack_fd >=3D 0) {
+			gitfo_free_map(&p->pack_map);
+			gitfo_close(p->pack_fd);
+			p->pack_fd =3D -1;
+		}
=20
 		gitlck_free(&p->lock);
 		free(p);
@@ -861,6 +923,7 @@ static git_pack *alloc_pack(const char *pack_name)
 	gitlck_init(&p->lock);
 	strcpy(p->pack_name, pack_name);
 	p->refcnt =3D 1;
+	p->pack_fd =3D -1;
 	return p;
 }
=20
@@ -895,7 +958,7 @@ static int scan_one_pack(void *state, char *name)
=20
 	r->next =3D *ret;
 	*ret =3D r;
-	return 0;
+	return GIT_SUCCESS;
 }
=20
 static git_packlist* scan_packs(git_odb *db)
diff --git a/src/odb.h b/src/odb.h
index 2f205b2..0311d78 100644
--- a/src/odb.h
+++ b/src/odb.h
@@ -11,9 +11,10 @@
  *   uint32_t *fanout =3D ... the file data at offset 0 ...
  *   ntohl(fanout[0]) < ntohl(fanout[1])
  *
- * The value chosen here for PACK_TOC is such that the above
+ * The value chosen here for IDX_TOC is such that the above
  * cannot be true for an idx v1 file.
  */
-#define PACK_TOC 0xff744f63 /* -1tOc */
+#define IDX_TOC 0xff744f63 /* -1tOc */
+#define PACK_TOC 0x5041434b /* PACK */
=20
 #endif
--=20
1.6.4.4
