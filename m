From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 5/5] use mode of the tree in git-diff, if <tree>:<file> syntax is used
Date: Sun, 22 Apr 2007 18:44:00 +0200
Message-ID: <11772602403236-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <1177260240326-git-send-email-mkoegler@auto.tuwien.ac.at> <11772602402479-git-send-email-mkoegler@auto.tuwien.ac.at> <1177260240928-git-send-email-mkoegler@auto.tuwien.ac.at> <11772602401214-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 18:44:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HffB8-0001Ur-Pc
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 18:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161397AbXDVQo2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 12:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161487AbXDVQoJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 12:44:09 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:51168 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161469AbXDVQoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 12:44:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 04D357833E07;
	Sun, 22 Apr 2007 18:44:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gHnPPMmN59vb; Sun, 22 Apr 2007 18:44:02 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id B7B6A7833E02; Sun, 22 Apr 2007 18:44:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11772602401214-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45250>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-diff.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 21d13f0..f7fb914 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -13,13 +13,10 @@
 #include "log-tree.h"
 #include "builtin.h"
 
-/* NEEDSWORK: struct object has place for name but we _do_
- * know mode when we extracted the blob out of a tree, which
- * we currently lose.
- */
 struct blobinfo {
 	unsigned char sha1[20];
 	const char *name;
+	unsigned mode;
 };
 
 static const char builtin_diff_usage[] =
@@ -70,8 +67,12 @@ static int builtin_diff_b_f(struct rev_info *revs,
 		die("'%s': %s", path, strerror(errno));
 	if (!(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)))
 		die("'%s': not a regular file or symlink", path);
+
+	if (blob[0].mode == S_IFINVALID)
+		blob[0].mode = canon_mode(st.st_mode);
+
 	stuff_change(&revs->diffopt,
-		     canon_mode(st.st_mode), canon_mode(st.st_mode),
+		     blob[0].mode, canon_mode(st.st_mode),
 		     blob[0].sha1, null_sha1,
 		     path, path);
 	diffcore_std(&revs->diffopt);
@@ -88,8 +89,14 @@ static int builtin_diff_blobs(struct rev_info *revs,
 	if (argc > 1)
 		usage(builtin_diff_usage);
 
+	if (blob[0].mode == S_IFINVALID)
+		blob[0].mode = mode;
+
+	if (blob[1].mode == S_IFINVALID)
+		blob[1].mode = mode;
+
 	stuff_change(&revs->diffopt,
-		     mode, mode,
+		     blob[0].mode, blob[1].mode,
 		     blob[0].sha1, blob[1].sha1,
 		     blob[0].name, blob[1].name);
 	diffcore_std(&revs->diffopt);
@@ -271,6 +278,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				die("more than two blobs given: '%s'", name);
 			hashcpy(blob[blobs].sha1, obj->sha1);
 			blob[blobs].name = name;
+			blob[blobs].mode = list->mode;
 			blobs++;
 			continue;
 
-- 
1.5.1.1.206.g4a12-dirty
