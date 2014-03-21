From: Ashwin Jha <ajha.dev@gmail.com>
Subject: [PATCH] GSoC Miniproject 15. Rewrite fsck.c:fsck_commit()
Date: Fri, 21 Mar 2014 07:24:46 +0530
Message-ID: <1395366886-16839-1-git-send-email-ajha.dev@gmail.com>
Cc: Ashwin Jha <ajha.dev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 02:55:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQogU-0006xV-HD
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 02:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760198AbaCUBzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 21:55:42 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35681 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760108AbaCUBzl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 21:55:41 -0400
Received: by mail-pa0-f44.google.com with SMTP id bj1so1756472pad.17
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 18:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=M8VgFoandhXUer24zK9XAKKy5IlgoH85vgBBhGmfym0=;
        b=kJVmxs8KuPHlaScZuYZDDKEuSqFJudqh3ZzBgFP1Shkqk/SjkQFEurfm63KScjM1TL
         BuYIHugnVlmKDAqKX9Ao5iVaVr69QFi0uERY3S5RieyXVrAqG5cqqBWtrh8iENEaD32x
         U4Aq/gepD0teCAuQDbWa0U1ay0Zhd6zPosWjBQOxrtGp6UIAlh1jU9MIgcxgcM6GU8qU
         YAvZHiVP8GoW1uWuQ/BFJQC77bp0dMj8MBfGa1jReGaiYnFyomRRp2DuA7V/tX6hcaEj
         cWTmg6JqqlZzI3Z2366EAqh8Wk2xiniKUK/Jhx9/m/u01HwTYRXp1VegLCN+7Zim6UNL
         6RAw==
X-Received: by 10.66.142.170 with SMTP id rx10mr50457632pab.117.1395366940607;
        Thu, 20 Mar 2014 18:55:40 -0700 (PDT)
Received: from ubuntu.59.160.212.34 (nkn-admin-map.isical.ac.in. [14.139.222.67])
        by mx.google.com with ESMTPSA id n6sm6560151pbj.22.2014.03.20.18.55.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 18:55:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244629>

modified fsck.c:fsck_commit(). Replaced memcmp() with starts_with() function.
starts_with() seems much more relevant than memcmp(). It uses one less argument
and its return value makes more sense.
skip_prefix() is not used as it uses strcmp() internally which seems unnecessarily
for current task. The current task can be easily done by providing offsets to the
buffer pointer (the way it is implemented currently).

Signed-off-by: Ashwin Jha <ajha.dev@gmail.com>
---
 fsck.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fsck.c b/fsck.c
index 64bf279..82e1640 100644
--- a/fsck.c
+++ b/fsck.c
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "fsck.h"
+#include "strbuf.h"
 
 static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
 {
@@ -290,12 +291,12 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 	int parents = 0;
 	int err;
 
-	if (memcmp(buffer, "tree ", 5))
+	if (!starts_with(buffer, "tree "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
 		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
 	buffer += 46;
-	while (!memcmp(buffer, "parent ", 7)) {
+	while (starts_with(buffer, "parent ")) {
 		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
 			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
 		buffer += 48;
@@ -322,15 +323,15 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 		if (p || parents)
 			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
 	}
-	if (memcmp(buffer, "author ", 7))
+	if (!starts_with(buffer, "author "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
 	buffer += 7;
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-	if (memcmp(buffer, "committer ", strlen("committer ")))
+	if (!starts_with(buffer, "committer "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
-	buffer += strlen("committer ");
+	buffer += 10;
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-- 
1.7.9.5
