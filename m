From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH v2 2/2] fsck.c: Rewrite fsck_commit() to use skip_prefix()
Date: Thu, 13 Mar 2014 02:51:30 +0800
Message-ID: <1394650290-3750-3-git-send-email-yshuiv7@gmail.com>
References: <1394650290-3750-1-git-send-email-yshuiv7@gmail.com>
Cc: Yuxuan Shui <yshuiv7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 19:51:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNoFw-0007ID-ED
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbaCLSvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:51:52 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:54857 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaCLSvv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:51:51 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so1457674pdb.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nhUukYbn2pp8fzsv00IsZhz1ZixTHTrrRW/ASRqb37g=;
        b=i5WIq0/j3b+fAjMdj/SLsHsQaf32N2Fift15x7gdUCDzTJfrH8ndQGUJHcKe42VRbg
         uBsLXy6ClbimxtOEzxxfCv6wAEqCN7/DFSRMyW8/aVuDqC7FF/b8nQ9v1vlsAbrcWQ7G
         Wj14zSmjTGW9GkwO9jbRsHhEtDN/MyzBmec0IxDjGxmOW9ANCQRjXHD9r2YPpq4pJikf
         UT0mhsE0Q2HXDiP+W3aVJkVU7iAH+Hr4x4KbptBRC82+EC80jo+hEjuXmRcKH+IyJVsc
         fZOFc646jwflyFv7awo2USS76cXyNmb78igV+AHyF4S2ROI6kagCVwNrC+MrVQqeb445
         L/kw==
X-Received: by 10.69.25.69 with SMTP id io5mr7056409pbd.22.1394650310636;
        Wed, 12 Mar 2014 11:51:50 -0700 (PDT)
Received: from localhost.localdomain ([123.151.32.162])
        by mx.google.com with ESMTPSA id tu3sm25142283pab.1.2014.03.12.11.51.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Mar 2014 11:51:49 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394650290-3750-1-git-send-email-yshuiv7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243961>

The purpose of skip_prefix() is much clearer than memcmp(). Also
skip_prefix() takes one less argument and its return value makes more
sense.

Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
---
 fsck.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fsck.c b/fsck.c
index 1789c34..7e6b829 100644
--- a/fsck.c
+++ b/fsck.c
@@ -281,7 +281,7 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
 
 static int fsck_commit(struct commit *commit, fsck_error error_func)
 {
-	char *buffer = commit->buffer;
+	const char *buffer = commit->buffer, *tmp;
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
 	int parents = 0;
@@ -290,15 +290,17 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 	if (commit->date == ULONG_MAX)
 		return error_func(&commit->object, FSCK_ERROR, "invalid author/committer line");
 
-	if (memcmp(buffer, "tree ", 5))
+	buffer = skip_prefix(buffer, "tree ");
+	if (buffer == NULL)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
-	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
+	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
 		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
-	buffer += 46;
-	while (!memcmp(buffer, "parent ", 7)) {
-		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
+	buffer += 41;
+	while ((tmp = skip_prefix(buffer, "parent "))) {
+		buffer = tmp;
+		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
 			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
-		buffer += 48;
+		buffer += 41;
 		parents++;
 	}
 	graft = lookup_commit_graft(commit->object.sha1);
@@ -322,15 +324,15 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 		if (p || parents)
 			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
 	}
-	if (memcmp(buffer, "author ", 7))
+	buffer = skip_prefix(buffer, "author ");
+	if (buffer == NULL)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
-	buffer += 7;
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-	if (memcmp(buffer, "committer ", strlen("committer ")))
+	buffer = skip_prefix(buffer, "committer ");
+	if (buffer == NULL)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
-	buffer += strlen("committer ");
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-- 
1.9.0
