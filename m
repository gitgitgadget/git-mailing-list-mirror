From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH v3 2/2] fsck.c: Rewrite fsck_commit() to use skip_prefix()
Date: Thu, 13 Mar 2014 12:45:51 +0800
Message-ID: <1394685951-9726-3-git-send-email-yshuiv7@gmail.com>
References: <1394685951-9726-1-git-send-email-yshuiv7@gmail.com>
Cc: Yuxuan Shui <yshuiv7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 05:46:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNxXF-00079G-22
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 05:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbaCMEqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 00:46:16 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:39397 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbaCMEqM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 00:46:12 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so529686pdi.30
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 21:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GHy2NgyYNEMz+Yn6Bvy0s1DChXbxnoXiPZcF+um7JwY=;
        b=pVirgnLTFyWte1EWuEfRdVUjTWH3JiahOE3qsoRcIK8YFAwWO348ru7J0uwnhikn9f
         AtLWudtPRrftkHi/AgDcpdMQ9JR+GIGAlOQ/oJZ3luY5MwpNyilo/dWyqGO6Nnv1VWU+
         na8eOVognLp0xlv3OnXzgG4WMfZA3L8MgR/3jbVwjbgiveXcckq0jX0ZxjVbqw/P8dvK
         YhoRau5VldiDqt/gQbaZ1KhuBRT9TD6aCz95sTgZyqPEgNM3d9MRl+zikQ5jbXNiWbWp
         fRs5gqfMp5gdlSV21AVBWbgXztK33fDMEBeK8xd6wdXowZXGAibJk8MxdK30M0Pf1B9V
         t2Fg==
X-Received: by 10.68.196.226 with SMTP id ip2mr1758262pbc.106.1394685972508;
        Wed, 12 Mar 2014 21:46:12 -0700 (PDT)
Received: from localhost.localdomain ([123.151.32.162])
        by mx.google.com with ESMTPSA id zb2sm2528040pbc.30.2014.03.12.21.46.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Mar 2014 21:46:12 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394685951-9726-1-git-send-email-yshuiv7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244020>

Currently we use memcmp() in fsck_commit() to check if buffer start
with a certain prefix, and skip the prefix if it does. This is exactly
what skip_prefix() does. And since skip_prefix() has a self-explaintory
name, this could make the code more readable.

Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
---
 fsck.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fsck.c b/fsck.c
index 7776660..7e6b829 100644
--- a/fsck.c
+++ b/fsck.c
@@ -281,7 +281,7 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
 
 static int fsck_commit(struct commit *commit, fsck_error error_func)
 {
-	const char *buffer = commit->buffer;
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
