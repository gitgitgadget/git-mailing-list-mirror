From: Othman Darraz <darrazo16@gmail.com>
Subject: [PATCHv2] fsck.c:fsck_commit() use skip_prefix() and starts_with()
Date: Wed, 19 Mar 2014 14:44:33 +0100
Message-ID: <1395236673-8936-1-git-send-email-darrazo16@gmail.com>
Cc: Othman Darraz <darrazo16@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 14:45:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQGoB-0004gv-My
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 14:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbaCSNpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 09:45:21 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:55548 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933817AbaCSNpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 09:45:19 -0400
Received: by mail-we0-f178.google.com with SMTP id u56so6900297wes.23
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+k7CEQ4SVSHZpLTzsTbCf6aZ8uiuO7tKSdfHe/KLQUA=;
        b=OOCo/vvJIUP6SBOdAI2sL28XRtj/wvHSujqAXogV3UJA/Fn4EEYXLrkl41ICktKf6f
         DzSz4zugh+LCQ1tAMnRsbai5nHEfQBKuD9c65eXqBuNpExAcRJykC3nNLiOajWul7Hoa
         AQM739aOrWZ6PmD8wqw18WM/mYcjrNFb+6CM/R2reF3+dOoAwM4IErA4EWgeBL8euPpF
         dfxXebHhkOHkgp1cMByVcH9e2PSqisYLfL62PY3x4kbc8LKywqbFRsHQV2JnHOwmn0Ue
         RcUdhBkSPwmneqpfXcddpzIjsvOXZ7RIMIrKzuYdGoo1+vGcwL8OHQEA4qaV+G/XWpbr
         sVcg==
X-Received: by 10.180.19.35 with SMTP id b3mr19934670wie.20.1395236709231;
        Wed, 19 Mar 2014 06:45:09 -0700 (PDT)
Received: from localhost.localdomain (mut38-h01-31-32-140-164.dsl.sta.abo.bbox.fr. [31.32.140.164])
        by mx.google.com with ESMTPSA id i7sm43754304wib.1.2014.03.19.06.44.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 06:45:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.258.g00eda23.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244448>

make buffer const char* because the content of the memory referenced by this variable doesn't change in this function. 
Add cast to buffer to match fsck_ident signature which is (char**,...)

use skip_prefix() instead of memcmp() to avoid using magic number.

Signed-off-by: Othman Darraz <darrazo16@gmail.com>
---
I am planning to apply for GSOC2014
 fsck.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fsck.c b/fsck.c
index 5eae856..128d426 100644
--- a/fsck.c
+++ b/fsck.c
@@ -284,21 +284,22 @@ static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
 
 static int fsck_commit(struct commit *commit, fsck_error error_func)
 {
-	char *buffer = commit->buffer;
+	const char *buffer = commit->buffer;
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
 	int parents = 0;
 	int err;
-
-	if (starts_with(buffer, "tree "))
+	buffer = skip_prefix(buffer, "tree ");
+	if (!buffer)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
-	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')() 
+	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
 		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
-	buffer += 46;
-	while (!memcmp(buffer, "parent ", 7)) {
-		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
+	buffer += 41;
+	while (starts_with(buffer, "parent ")) {
+		buffer = skip_prefix(buffer, "parent ");
+		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
 			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
-		buffer += 48;
+		buffer += 41;
 		parents++;
 	}
 	graft = lookup_commit_graft(commit->object.sha1);
@@ -322,16 +323,16 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 		if (p || parents)
 			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
 	}
-	if (starts_with(buffer, "author "))
+	buffer = skip_prefix(buffer, "author ");
+	if (!buffer)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
-	buffer += 7;
-	err = fsck_ident(&buffer, &commit->object, error_func);
+	err = fsck_ident((char **)&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-	buffer = (char* )skip_prefix(buffer,"committer ");
+	buffer = skip_prefix(buffer,"committer ");
 	if (!buffer)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
-	err = fsck_ident(&buffer, &commit->object, error_func);
+	err = fsck_ident((char **)&buffer, &commit->object, error_func);
 	if (err)
 		return err;
 	if (!commit->tree)
-- 
1.9.0.258.g00eda23.dirty
