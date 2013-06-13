From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] match-trees: factor out fill_tree_desc_strict
Date: Thu, 13 Jun 2013 20:19:28 +0200
Message-ID: <1371147568-31348-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 13 20:19:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnC7c-0000zH-LZ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758917Ab3FMSTh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 14:19:37 -0400
Received: from india601.server4you.de ([85.25.151.105]:59377 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab3FMSTf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:19:35 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFDA26B.dip0.t-ipconnect.de [79.253.162.107])
	by india601.server4you.de (Postfix) with ESMTPSA id 002AB1DA;
	Thu, 13 Jun 2013 20:19:32 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227768>

Deduplicate code by moving tree_desc initialtization into a helper
function, fill_tree_desc_strict.  It is like fill_tree_descriptor,
except that it only accepts tree hashes and no tree references (tags,
commits).  No functional change.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 match-trees.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 2bb734d..7873cde 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -47,6 +47,22 @@ static int score_matches(unsigned mode1, unsigned mo=
de2, const char *path)
 	return score;
 }
=20
+static void *fill_tree_desc_strict(struct tree_desc *desc,
+				   const unsigned char *hash)
+{
+	void *buffer;
+	enum object_type type;
+	unsigned long size;
+
+	buffer =3D read_sha1_file(hash, &type, &size);
+	if (!buffer)
+		die("unable to read tree (%s)", sha1_to_hex(hash));
+	if (type !=3D OBJ_TREE)
+		die("%s is not a tree", sha1_to_hex(hash));
+	init_tree_desc(desc, buffer, size);
+	return buffer;
+}
+
 static int base_name_entries_compare(const struct name_entry *a,
 				     const struct name_entry *b)
 {
@@ -61,23 +77,10 @@ static int score_trees(const unsigned char *hash1, =
const unsigned char *hash2)
 {
 	struct tree_desc one;
 	struct tree_desc two;
-	void *one_buf, *two_buf;
+	void *one_buf =3D fill_tree_desc_strict(&one, hash1);
+	void *two_buf =3D fill_tree_desc_strict(&two, hash2);
 	int score =3D 0;
-	enum object_type type;
-	unsigned long size;
=20
-	one_buf =3D read_sha1_file(hash1, &type, &size);
-	if (!one_buf)
-		die("unable to read tree (%s)", sha1_to_hex(hash1));
-	if (type !=3D OBJ_TREE)
-		die("%s is not a tree", sha1_to_hex(hash1));
-	init_tree_desc(&one, one_buf, size);
-	two_buf =3D read_sha1_file(hash2, &type, &size);
-	if (!two_buf)
-		die("unable to read tree (%s)", sha1_to_hex(hash2));
-	if (type !=3D OBJ_TREE)
-		die("%s is not a tree", sha1_to_hex(hash2));
-	init_tree_desc(&two, two_buf, size);
 	for (;;) {
 		struct name_entry e1, e2;
 		int got_entry_from_one =3D tree_entry(&one, &e1);
@@ -124,16 +127,7 @@ static void match_trees(const unsigned char *hash1=
,
 			int recurse_limit)
 {
 	struct tree_desc one;
-	void *one_buf;
-	enum object_type type;
-	unsigned long size;
-
-	one_buf =3D read_sha1_file(hash1, &type, &size);
-	if (!one_buf)
-		die("unable to read tree (%s)", sha1_to_hex(hash1));
-	if (type !=3D OBJ_TREE)
-		die("%s is not a tree", sha1_to_hex(hash1));
-	init_tree_desc(&one, one_buf, size);
+	void *one_buf =3D fill_tree_desc_strict(&one, hash1);
=20
 	while (one.size) {
 		const char *path;
--=20
1.8.3
