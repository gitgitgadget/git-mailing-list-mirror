From: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
Subject: [PATCH 1/6] Open the pack file and keep a map on it.
Date: Wed, 14 Oct 2009 12:37:44 +0200
Message-ID: <1255516669-26745-1-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 12:50:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My1Qh-0004AO-7K
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 12:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbZJNKpr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 06:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbZJNKpo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 06:45:44 -0400
Received: from mailhost-p4-p2.nerim.net ([195.5.209.61]:52500 "EHLO
	smtp-delay1.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756164AbZJNKpl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 06:45:41 -0400
Received: from mallaury.nerim.net (smtp-103-wednesday.noc.nerim.net [62.4.17.103])
	by smtp-delay1.nerim.net (Postfix) with ESMTP id 9581DB3B2FD
	for <git@vger.kernel.org>; Wed, 14 Oct 2009 12:36:54 +0200 (CEST)
Received: from localhost.localdomain (itaapy-35-170.cnt.nerim.net [213.215.35.170])
	by mallaury.nerim.net (Postfix) with ESMTP id 9742BA1086
	for <git@vger.kernel.org>; Wed, 14 Oct 2009 12:35:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130282>

On the same model than the idx file.

Signed-off-by: Herv=C3=A9 Cauwelier <herve@itaapy.com>
---
 src/odb.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 src/odb.h |    1 +
 2 files changed, 65 insertions(+), 1 deletions(-)

diff --git a/src/odb.c b/src/odb.c
index 6d646a4..2319998 100644
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
+		if (decode32(&data[0]) !=3D PACK_HDR)
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
index 2f205b2..121583f 100644
--- a/src/odb.h
+++ b/src/odb.h
@@ -15,5 +15,6 @@
  * cannot be true for an idx v1 file.
  */
 #define PACK_TOC 0xff744f63 /* -1tOc */
+#define PACK_HDR 0x5041434b /* PACK */
=20
 #endif
--=20
1.6.5
