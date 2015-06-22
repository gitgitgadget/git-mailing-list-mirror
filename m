From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 08/19] fsck: Make =?UTF-8?Q?fsck=5Fcommit=28=29=20warn-?=
 =?UTF-8?Q?friendly?=
Date: Mon, 22 Jun 2015 17:26:11 +0200
Organization: gmx
Message-ID: <4fb19d2bf037c528de9c98068d083d49575876e5.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:26:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73cE-0006yo-MR
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbbFVP00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:26:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:59475 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517AbbFVP0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:26:24 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LeALI-1Yk4ja0jT2-00puad; Mon, 22 Jun 2015 17:26:14
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:sEf6hMqzrD0nPUM8ZkSnYl830APKnRyUPVCQjDr16uT4LzdzT83
 p48w3aOcpVpggGc+9r1sEL6eo4MGlos/Aq+O9rgzKJw+0dANNw0mMSdp/YGF6eVaj9b03CA
 3pbRLEN5+bhDHqazJ8sSynyNcUy2vswpJ27nIYuUgjCCdtFihOg5hDT403m7v9gIaw6PRwK
 UxhcMH7yp1b8meKki0riw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mqiW7rOvwhE=:O4Ws5BMVNVOBbc1CAhFr74
 ZJQy3Wxgf6+d9EemkKhB/vuEEy4aZtoqLh7MAOlT6akVi1IBJZMWtryMV4yInfIpb7zrBvGkr
 V/1uC+mOTqkWGqcnUGXLEbnxUB9dp04X+FLcgvG+658y4P6+8NGTdL/gXNBAq+vV5VK9+Z5Kn
 n96EDPIPzH+DxooHdWf+0/y/Tafm6u/n42gRZc5u+/KbRIi5AwR+70vxBjivVpPK2Umb7hH/i
 jpM8o5vCVTvhrRSgGA86baJAvGBaa80Y1v3JXS+UVW1cx+lOkzuZtTbjVnT1CXBh47JVgBJ0/
 9foJxXpr+BIBPUfVDLYon4H3cTV/uX2ME/NQ7cISE8FEXTMI3n4+6o1xDGoWIYdpyZssk6c33
 eTH6FwPQJh7jJ5qejFQmuQUOiH0wlX0S34LphgE45apMFA+XzAg0LF9a3+NgZ5QQauR4P4FDG
 gkWzVbCtpwlTRUXADcq5jueWQAyp4pwZVUfz4xwMdDP9v8wcORvuDnUA92bDRLi8H8xoicW5s
 UGMwWmPJt6sOCVmkYbU+7wRB1ckvs0ArfIhbr8qwfzGuZXtsbn6sfaOVGd3ZkgF1hnLPp76HS
 9IBcPRLORhKZZoBzNyIeeMJVBnEI3soSoGXZd61cQZvQfyZlUQEuKhrjii4xLiBHDdiHG+ysm
 KcDP0dA3YckRK4XNqU81g+f3R2Eew2tT3diYYWhjfqtFWRETmxJU9u/fDcv2+RxXdeqg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272378>

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
index d0a7282..ef3bf68 100644
--- a/fsck.c
+++ b/fsck.c
@@ -536,12 +536,18 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 
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
@@ -550,11 +556,17 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
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
