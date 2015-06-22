From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 09/19] fsck: Handle multiple authors in commits specially
Date: Mon, 22 Jun 2015 17:26:23 +0200
Organization: gmx
Message-ID: <e82ab8cfa698c4a5b5d0be5df2ae59760b9f046d.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:26:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73cI-000712-O6
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbbFVP0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:26:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:49450 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517AbbFVP02 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:26:28 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LevUh-1Yktwe3gLP-00qi3b; Mon, 22 Jun 2015 17:26:23
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:A0yYKV9easGNc2i+O78+U4spqzW3l9gMxaYPIbuDMeK/uEHHBxg
 llCBXXTZUQRr+04XrgxdzzsdvSbArj5ZmkOX17UVhMEI6GbXIp0E1RWdhDkVJZm6AZ7YLtB
 bMrkkIxEF3npQQFLGUjUBQs0iZaakopu+iOuYmsKgCrtJ7iGsH88TObxLDjL9quY1fVQTMV
 jHKbKIxgNK0U7LaGOXywg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272380>

This problem has been detected in the wild, and is the primary reason
to introduce an option to demote certain fsck errors to warnings. Let's
offer to ignore this particular problem specifically.

Technically, we could handle such repositories by setting
receive.fsck.<msg-id> to missingCommitter=warn, but that could hide
missing tree objects in the same commit because we cannot continue
verifying any commit object after encountering a missing committer line,
while we can continue in the case of multiple author lines.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index ef3bf68..daa07ad 100644
--- a/fsck.c
+++ b/fsck.c
@@ -38,6 +38,7 @@
 	FUNC(MISSING_TREE, ERROR) \
 	FUNC(MISSING_TYPE, ERROR) \
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
+	FUNC(MULTIPLE_AUTHORS, ERROR) \
 	FUNC(NUL_IN_HEADER, ERROR) \
 	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
 	FUNC(TREE_NOT_SORTED, ERROR) \
@@ -528,7 +529,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 {
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
-	unsigned parent_count, parent_line_count = 0;
+	unsigned parent_count, parent_line_count = 0, author_count;
 	int err;
 
 	if (require_end_of_header(buffer, size, &commit->object, options))
@@ -568,9 +569,17 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 				return err;
 		}
 	}
-	if (!skip_prefix(buffer, "author ", &buffer))
-		return report(options, &commit->object, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
-	err = fsck_ident(&buffer, &commit->object, options);
+	author_count = 0;
+	while (skip_prefix(buffer, "author ", &buffer)) {
+		author_count++;
+		err = fsck_ident(&buffer, &commit->object, options);
+		if (err)
+			return err;
+	}
+	if (author_count < 1)
+		err = report(options, &commit->object, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
+	else if (author_count > 1)
+		err = report(options, &commit->object, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
 	if (err)
 		return err;
 	if (!skip_prefix(buffer, "committer ", &buffer))
-- 
2.3.1.windows.1.9.g8c01ab4
