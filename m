From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 08/19] fsck: Make =?UTF-8?Q?fsck=5Fcommit=28=29=20warn-?=
 =?UTF-8?Q?friendly?=
Date: Fri, 19 Jun 2015 15:33:58 +0200
Organization: gmx
Message-ID: <1ce6b2b32cb94d9697056d1181bb1fe396c64a5b.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:34:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wQr-0008Q3-6Q
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbbFSNeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:34:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:62680 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753231AbbFSNeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:34:03 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M9K5G-1ZGQ1p3h6c-00Ciy5; Fri, 19 Jun 2015 15:33:59
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:YxPHDQVsukMC2zR3reRIFIMs6g08+FY7sfV9Y8njj6BhypBXooJ
 AG0zpAMqshZERGY5TUwIJdy5aECFAsApojZQlmNFU6np7uNHLOmQ6LvxcEJtZ7rum+LLJaI
 KPbD0QDIf3GgooYsERWvbogXdYHkdMJ1lByhaqDeicgUsm1RNcZY4rIitJ8oUowgoWOAkUX
 Cnq+GWqBi8zno6j/IZtCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iEf0ps8PPaY=:2r94YOgR3Affaa46yQCVBZ
 Vh9gZGZ3Q0dAwPsr+m4x3pMeZ+Lo/V1qRIWIF8orWTI6XQcdw58R4BmVOr1EtTR3KumYrURJr
 6j2URDsq7com1rTPm0eYFAnqEBbi7e9AsYXBXbIGhCRC28M3btulBNnNaj/Unlyrbd8ZNogHH
 YrJxFRsNgbs2oV5tTy0o6CfV+5ZAwZpgjfY7fjNmVrbGgVXY+juXCcf/0etCBwW0ae4K2L3t1
 n8BrmZey046BIWs5jq3+rH5dVdCRK3g7D1OA1dnSQJ7NR4GurOVJR8jdfihHnRq94dsNBsvTi
 ys9MK671EbMY1ISP5A6yKucWxPwfizLPDJaSe5ctbDNb44JslbZe3jQplgrf95r4W33Iare6L
 ZIZgZJ4fFk5RdETPEMw05ywnQiMjqoRyupayfT//usiqjnv7T/jyWPb5ZMP/qQM2z25xyw881
 VuNgK1i50i280g6FotkHgEZ84P7Me+JdV/uRMMTc0AUOEhdyJM4DDdxCVgvuE3lzEsitasZvk
 hNtCVaE7cC2wkAKMahvIpMdy0jgVfucCcL+TzmWfHafH8d+bis1OeycQjK2JXHhY7j3jAgY6P
 P62yt7rDt+GtNm+lvFBlqNvAmLBcsVwY2XOXqwgmNyjAnkbKk8g6XF+zSsvTWAZROXF5XAR1o
 +rT0C4/BsCeW8FhBpP3PkwXlLOHZG/n5TkVg//Gk7qycadSPy9D8UTLQajsL9b9ZsLPo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272146>

When fsck_commit() identifies a problem with the commit, it should try
to make it possible to continue checking the commit object, in case the
user wants to demote the detected errors to mere warnings.

Note that some problems are too problematic to simply ignore. For
example, when the header lines are mixed up, we punt after encountering
an incorrect line. Therefore, demoting certain warnings to errors can
hide other problems. Example: demoting the missingauthor error to
a warning would hide a problematic committer line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fsck.c b/fsck.c
index 9faaf53..9fe9f48 100644
--- a/fsck.c
+++ b/fsck.c
@@ -534,12 +534,18 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 
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
@@ -548,11 +554,17 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
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
2.3.1.windows.1.9.g8c01ab4
