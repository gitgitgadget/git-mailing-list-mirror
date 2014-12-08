From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 08/18] Make fsck_commit() warn-friendly
Date: Mon, 8 Dec 2014 17:14:54 +0100 (CET)
Message-ID: <eb66b08bc0092431021fc594b4ff3108dc3b5246.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:15:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0xx-0006BF-OP
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbaLHQPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:15:08 -0500
Received: from mout.gmx.net ([212.227.17.22]:64755 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755873AbaLHQPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:15:05 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MOjMY-1Y1sIz1fEM-0068Cd;
 Mon, 08 Dec 2014 17:14:55 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:dYdUbwyF3NpmDqfWcCSuvwU50+hvxd9qo9AcgqIf+CuVvti0rQO
 RSe57i+MAPhwQuh4xKYQOd9xiQDyrZXt/dHeH8vJlkvTfVgmyP5XSIDJCfAG+qp3lM0uDMi
 ePU2MVhUP8+UChc8qFl8A7UJCOyYnWTC10nvIq/+CrBUGX80uTYm5RCUtqWu0y185I8Cypj
 EvdFbv3ez+Ybg2hMCwY/w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261061>

When fsck_commit() identifies a problem with the commit, it should try
to make it possible to continue checking the commit object, in case the
user wants to demote the detected errors to mere warnings.

Note that some problems are too problematic to simply ignore. For
example, when the header lines are mixed up, we punt after encountering
an incorrect line. Therefore, demoting certain warnings to errors can
hide other problems. Example: demoting the missing-author error to
a warning would hide a problematic committer line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fsck.c b/fsck.c
index 256f567..a63654c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -499,12 +499,18 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 
 	if (!skip_prefix(buffer, "tree ", &buffer))
 		return report(options, &commit->object, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
-	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
-		return report(options, &commit->object, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
+	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n') {
+		err = report(options, &commit->object, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
+		if (err)
+			return err;
+	}
 	buffer += 41;
 	while (skip_prefix(buffer, "parent ", &buffer)) {
-		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
-			return report(options, &commit->object, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
+		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n') {
+			err = report(options, &commit->object, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
+			if (err)
+				return err;
+		}
 		buffer += 41;
 		parent_line_count++;
 	}
@@ -513,11 +519,17 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	if (graft) {
 		if (graft->nr_parent == -1 && !parent_count)
 			; /* shallow commit */
-		else if (graft->nr_parent != parent_count)
-			return report(options, &commit->object, FSCK_MSG_MISSING_GRAFT, "graft objects missing");
+		else if (graft->nr_parent != parent_count) {
+			err = report(options, &commit->object, FSCK_MSG_MISSING_GRAFT, "graft objects missing");
+			if (err)
+				return err;
+		}
 	} else {
-		if (parent_count != parent_line_count)
-			return report(options, &commit->object, FSCK_MSG_MISSING_PARENT, "parent objects missing");
+		if (parent_count != parent_line_count) {
+			err = report(options, &commit->object, FSCK_MSG_MISSING_PARENT, "parent objects missing");
+			if (err)
+				return err;
+		}
 	}
 	if (!skip_prefix(buffer, "author ", &buffer))
 		return report(options, &commit->object, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
-- 
2.0.0.rc3.9669.g840d1f9
