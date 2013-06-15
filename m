From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] unpack-trees: don't shift conflicts left and right
Date: Sun, 16 Jun 2013 01:44:43 +0200
Message-ID: <1371339883-22775-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 01:45:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo09e-0001ad-HB
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 01:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab3FOXov convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Jun 2013 19:44:51 -0400
Received: from india601.server4you.de ([85.25.151.105]:59711 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679Ab3FOXou (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 19:44:50 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFDB913.dip0.t-ipconnect.de [79.253.185.19])
	by india601.server4you.de (Postfix) with ESMTPSA id C7F8520B;
	Sun, 16 Jun 2013 01:44:48 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227977>

If o->merge is set, the struct traverse_info member conflicts is shifte=
d
left in unpack_callback, then passed through traverse_trees_recursive
to unpack_nondirectories, where it is shifted right before use.  Stop
the shifting and just pass the conflict bit mask as is.  Rename the
member to df_conflicts to prove that it isn't used anywhere else.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 tree-walk.h    |  2 +-
 unpack-trees.c | 18 +++---------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index 2bf0db9..ae04b64 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -46,7 +46,7 @@ struct traverse_info {
 	int pathlen;
 	struct pathspec *pathspec;
=20
-	unsigned long conflicts;
+	unsigned long df_conflicts;
 	traverse_callback_t fn;
 	void *data;
 	int show_all_errors;
diff --git a/unpack-trees.c b/unpack-trees.c
index 57b4074..b27f2a6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -464,7 +464,7 @@ static int traverse_trees_recursive(int n, unsigned=
 long dirmask,
 	newinfo.pathspec =3D info->pathspec;
 	newinfo.name =3D *p;
 	newinfo.pathlen +=3D tree_entry_len(p) + 1;
-	newinfo.conflicts |=3D df_conflicts;
+	newinfo.df_conflicts |=3D df_conflicts;
=20
 	for (i =3D 0; i < n; i++, dirmask >>=3D 1) {
 		const unsigned char *sha1 =3D NULL;
@@ -565,17 +565,12 @@ static int unpack_nondirectories(int n, unsigned =
long mask,
 {
 	int i;
 	struct unpack_trees_options *o =3D info->data;
-	unsigned long conflicts;
+	unsigned long conflicts =3D info->df_conflicts | dirmask;
=20
 	/* Do we have *only* directories? Nothing to do */
 	if (mask =3D=3D dirmask && !src[0])
 		return 0;
=20
-	conflicts =3D info->conflicts;
-	if (o->merge)
-		conflicts >>=3D 1;
-	conflicts |=3D dirmask;
-
 	/*
 	 * Ok, we've filled in up to any potential index entry in src[0],
 	 * now do the rest.
@@ -807,13 +802,6 @@ static int unpack_callback(int n, unsigned long ma=
sk, unsigned long dirmask, str
=20
 	/* Now handle any directories.. */
 	if (dirmask) {
-		unsigned long conflicts =3D mask & ~dirmask;
-		if (o->merge) {
-			conflicts <<=3D 1;
-			if (src[0])
-				conflicts |=3D 1;
-		}
-
 		/* special case: "diff-index --cached" looking at a tree */
 		if (o->diff_index_cached &&
 		    n =3D=3D 1 && dirmask =3D=3D 1 && S_ISDIR(names->mode)) {
@@ -832,7 +820,7 @@ static int unpack_callback(int n, unsigned long mas=
k, unsigned long dirmask, str
 			}
 		}
=20
-		if (traverse_trees_recursive(n, dirmask, conflicts,
+		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
 					     names, info) < 0)
 			return -1;
 		return mask;
--=20
1.8.3
