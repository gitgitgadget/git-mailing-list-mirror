From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 08/19] fsck: Make =?UTF-8?Q?fsck=5Fcommit=28=29=20warn-?=
 =?UTF-8?Q?friendly?=
Date: Thu, 18 Jun 2015 22:08:41 +0200
Organization: gmx
Message-ID: <2094aecd48db6dbd1bede21b3c814b73dfd21875.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:09:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g7W-00039w-CP
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757011AbbFRUJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:09:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:55820 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756966AbbFRUI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:08:57 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MSp1l-1ZWvkK2s6f-00Rqfw; Thu, 18 Jun 2015 22:08:41
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:A1NCWT2x48EWTqfSlY0hl9UZd7/kPivNg6oSELAU9JSpdPEKzUm
 oWORiDenmgLKsY62VduWgkEQswI5/ZRjkgB2j0ofqVqtZZpmbe6Nk4d/oWNqddHwTpDvqkg
 S8QrygBIaySu5FCr7DB5KxoNCw0YA/eYafRJ4jSRrvdgSdnW51NpMZJ/BKHjUtunX6odWp+
 Iu0He1gXI/sCrlmxabIfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VhPSZEJtevQ=:02+oKrs+YydUYH4H09sbVQ
 KFyoxeY09apcwEGCgNlaCpfDqOilGzEEtQ0hstKOH88qzqqPpRQmoHi2144QMDq0GGL++Fbp2
 J0fnsUTI7+Wyc9sLxV2O0wdJPxjM7rnUK0fc2TA5Lfwj6JZsFLMfQuzXBmEBtj9mqPOHO8LAK
 Ql9blyKqRmEZrxQnKzXZg07yEh4pLsUVpPm9FdT2TTppV8QLsl54RZdBmO/pGkQiQevaHxA7d
 L5+MdvIePGwGhsyYX2hW8c8XDk/t/ddchmjOGUbRPWU9nfI/UtyzM/Fw74ReMB2srvikqdzS1
 F02IfPUZcNqJ7J56OCZsNKPQN75+ODqdIyD1ew46AudEVNGJIwvsxR5LRNdhV61or9sKmRps5
 zcSl+4DdEsVLTCX4ZbEkpvgl4qj3Ky1h/XfCVOFwqck/VA9E46+F1c/z8XJejjQmOdthxiTH/
 +WnNDs2N1WmW3JQFFLJri8gbBskKK/0kRnemZV4QyAKu7i2CNewgfmItogOYHI3xWMnbAdzgs
 yzadIhJHanwjWNuoyECgiueOv5fpwdGNJDLAzZbur13RJt6ebGuZsbEmUaC3DIRbefFW+YEVn
 Q4sm/k0n+9el+l65nbmOcKFsLH/iOyHJP7eXtNgFekpxDw4h38dSHfLHUYUpvyAMqMaC9+VHC
 hq413MHxSwnehlc6BDVF8ZUWuuWyh4WN60t83DPa0kPhZdWCkW0TxvGufdMl4yxhNoLk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272051>

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
index 8a1eea3..31d218d 100644
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
