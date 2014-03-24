From: Ashwin Jha <ajha.dev@gmail.com>
Subject: [PATCH v3 2/2] fsck.c:fsck_commit replace memcmp by skip_prefix
Date: Mon, 24 Mar 2014 17:39:19 +0530
Message-ID: <1395662959-10660-1-git-send-email-ajha.dev@gmail.com>
Cc: Ashwin Jha <ajha.dev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 13:10:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS3hw-0003vi-KD
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 13:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbaCXMKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 08:10:18 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:52460 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbaCXMKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 08:10:17 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so5248419pdj.36
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MIAPeyLvZg41sjCADT7forjrhedRmM42jY/cRqP22Gk=;
        b=qBJtl/fhGXEKsn2NEYmxF6yqbzI2MHnzgTNythsk6LTOyJk5FtTCcjH9/F+bh5pESH
         5rBWLD+5EWUYeehDNj8cDdpdL/yeKMea057JdRVVHNplYac33DcfZqFvtDWtLBNue2Do
         sC7SSYaCJaXelvkQvUeYN2FjoB7ofXh6Gwf/+ZnGO+clqWuMdaijDeRzceqYHVx4xK1h
         nT67i8oemLzG6U+XH5daqjLboPGvwX/2CP7KGn7GEHHuz1amzg4lxljDGa12S/9TMhwC
         tF5MLUt6vNyYUh5z9RrmCG7KrQNdryVMLQz2d53nGz9LsjR9up58v5iBCF/TKtRnsHNT
         NAhA==
X-Received: by 10.69.17.230 with SMTP id gh6mr30155473pbd.0.1395663016764;
        Mon, 24 Mar 2014 05:10:16 -0700 (PDT)
Received: from ubuntu.59.160.212.34 (nkn-admin-map.isical.ac.in. [14.139.222.67])
        by mx.google.com with ESMTPSA id yx3sm32920159pbb.6.2014.03.24.05.10.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Mar 2014 05:10:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244819>

Replace memcmp by skip_prefix as it serves the dual
purpose of checking the string for a prefix as well
as skipping that prefix.

Signed-off-by: Ashwin Jha <ajha.dev@gmail.com>
---

fsck_commit(): After the first patch in this series, it is now safe to replace
memcmp() with skip_prefix().

Previous versions can be found at [v1] and [v2]:
[v1]: http://git.661346.n2.nabble.com/PATCH-GSoC-Miniproject-15-Rewrite-fsck-c-fsck-commit-td7606180.html
[v2]: http://git.661346.n2.nabble.com/PATCH-Modify-fsck-commit-Replace-memcmp-by-skip-prefix-td7606321.html

 fsck.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fsck.c b/fsck.c
index b5f017f..2232ce3 100644
--- a/fsck.c
+++ b/fsck.c
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "fsck.h"
+#include "git-compat-util.h"
 
 static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
 {
@@ -284,21 +285,23 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
 
 static int fsck_commit(struct commit *commit, fsck_error error_func)
 {
-	const char *buffer = commit->buffer;
+	const char *parent_id, *buffer = commit->buffer;
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
 	int parents = 0;
 	int err;
 
-	if (memcmp(buffer, "tree ", 5))
+	buffer = skip_prefix(buffer, "tree ");
+	if (!buffer)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
-	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
+	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
 		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
-	buffer += 46;
-	while (!memcmp(buffer, "parent ", 7)) {
-		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
+	buffer += 41;
+	while ((parent_id = skip_prefix(buffer, "parent "))) {
+		buffer = parent_id;
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
+	buffer = skip_prefix(buffer, "author ");
+	if (!buffer)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
-	buffer += 7;
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-	if (memcmp(buffer, "committer ", strlen("committer ")))
+	buffer = skip_prefix(buffer, "committer ");
+	if (!buffer)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
-	buffer += strlen("committer ");
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-- 
1.9.1
