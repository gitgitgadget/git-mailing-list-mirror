From: Ashwin Jha <ajha.dev@gmail.com>
Subject: [PATCH] Modify fsck_commit. Replace memcmp by skip_prefix
Date: Sat, 22 Mar 2014 20:42:12 +0530
Message-ID: <1395501132-12894-1-git-send-email-ajha.dev@gmail.com>
Cc: Ashwin Jha <ajha.dev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 16:13:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRNcG-0007Hn-0z
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 16:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbaCVPNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 11:13:09 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:46251 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaCVPNI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 11:13:08 -0400
Received: by mail-pa0-f44.google.com with SMTP id bj1so3614498pad.31
        for <git@vger.kernel.org>; Sat, 22 Mar 2014 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=A3DkCYgPYZc1I3OGf9RRxsvphvOSWAI4xpVeWt6HTWU=;
        b=M0CvZuD1XpThU+3YvVnI7cwrCi9/0Hc/UJZiRzjptQTMOVq7rHUgbZ8rpEC36ve4HT
         704X6JpomOk/Tz/I6fi0Cegj4SFUCK25wxka9EFqK06u/66u9p9emp2At15WQHsk6zFD
         0Jy++1MNcq9vqjzTx+oBzrx1qweVPZGpWntwxnWVQRv9Ym3iNkH9XLstLE2hseNZREeA
         O7Z8YrxZvfjhR/GrSnw8Fd5IH8vC4Z6v2NLHKd4fXTZY8H8oZvIeFFwE9oO84fJ7vkLj
         yf64AZnT2U0vZJPul578ewc7Q2MR1xDjMpEf1U1Q36vCKuVChaC6TOkx0JKF3KrrqQ9v
         71HQ==
X-Received: by 10.66.197.164 with SMTP id iv4mr60502726pac.18.1395501187752;
        Sat, 22 Mar 2014 08:13:07 -0700 (PDT)
Received: from ubuntu.59.160.212.34 (nkn-admin-map.isical.ac.in. [14.139.222.67])
        by mx.google.com with ESMTPSA id pv4sm16159676pbb.55.2014.03.22.08.13.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Mar 2014 08:13:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244770>

Replace memcmp by skip_prefix as it serves the dual
purpose of checking the string for a prefix as well
as skipping that prefix.

Signed-off-by: Ashwin Jha <ajha.dev@gmail.com>
---
 fsck.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fsck.c b/fsck.c
index 64bf279..021b3fc 100644
--- a/fsck.c
+++ b/fsck.c
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "fsck.h"
+#include "git-compat-util.h"
 
 static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
 {
@@ -284,21 +285,23 @@ static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
 
 static int fsck_commit(struct commit *commit, fsck_error error_func)
 {
-	char *buffer = commit->buffer;
+	char *next_parent, *buffer = commit->buffer;
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
 	int parents = 0;
 	int err;
 
-	if (memcmp(buffer, "tree ", 5))
+	buffer = (char *)skip_prefix(buffer, "tree ");
+	if (buffer == NULL)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
-	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
+	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
 		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
-	buffer += 46;
-	while (!memcmp(buffer, "parent ", 7)) {
-		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
+	buffer += 41;
+	while ((next_parent = (char *)skip_prefix(buffer, "parent ")) != NULL) {
+		buffer = next_parent;
+		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
 			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
-		buffer += 48;
+		buffer += 41;
 		parents++;
 	}
 	graft = lookup_commit_graft(commit->object.sha1);
@@ -322,15 +325,15 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 		if (p || parents)
 			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
 	}
-	if (memcmp(buffer, "author ", 7))
+	buffer = (char *)skip_prefix(buffer, "author ");
+	if (buffer == NULL)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
-	buffer += 7;
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-	if (memcmp(buffer, "committer ", strlen("committer ")))
+	buffer = (char *)skip_prefix(buffer, "committer ");
+	if (buffer == NULL)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
-	buffer += strlen("committer ");
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-- 
1.7.9.5
