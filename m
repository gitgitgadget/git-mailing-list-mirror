From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 08/19] fsck: Make =?UTF-8?Q?fsck=5Fcommit=28=29=20warn-?=
 =?UTF-8?Q?friendly?=
Date: Sat, 31 Jan 2015 22:05:49 +0100
Organization: gmx
Message-ID: <0575169ea5b47fd0a585db515736d10d5f9e8c14.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:06:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfEv-0004Xq-L2
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131AbbAaVF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:05:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:49483 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbbAaVF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:05:56 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MAloF-1YOZug3PvH-00BwZ1; Sat, 31 Jan 2015 22:05:49
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:PKL4Ilh4AIQvxJniDxhAIYO4XEKv35smaHEIM2SucUUVn0IBN3b
 RWDubDuZ6R/Z2ejGGYR9V6tCQju0hlW9Zy+nkNcXFOhKA0GjTXVwZEKjJJ0+3i40cvCeBuq
 dWUNAN1u3nZbPY+2/w3aswoSYXZ5cTZR7MDbsT4/HDJJdQkfLY5vkrwb8HQiZR0XzIIe4V4
 M9I2DJZgo5TAfF+Q6b77g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263218>

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
index cd3ee48..7ce7857 100644
--- a/fsck.c
+++ b/fsck.c
@@ -514,12 +514,18 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 
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
@@ -528,11 +534,17 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
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
2.2.0.33.gc18b867
