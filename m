From: blacksimit <cengoguzhanunlu@gmail.com>
Subject: [PATCH v2] Rewrite fsck.c:fsck_commit() replace memcmp() with starts_with()
Date: Fri, 21 Mar 2014 18:37:18 +0200
Message-ID: <1395419838-25527-1-git-send-email-cengoguzhanunlu@gmail.com>
Cc: Oguzhan Unlu <cengoguzhanunlu@gmail.com>
To: sunshine@sunshineco.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 17:37:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR2S0-0007GE-Gx
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 17:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760256AbaCUQha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 12:37:30 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:40446 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759733AbaCUQh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 12:37:27 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so1985885eek.37
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CUM1OMgup3MndsBtxITHXtM+erDCQeeoKBoSq5JYPVE=;
        b=Esu2pjYwx3QwX0GiuC+s0gelt22JenNJ2XHOnhYV/QBh60PaDe74HMpGfCxeWVtNjV
         PuKRG9kD0EEn1tjh3lH0UhHtMTjvN1NlUMmfSJvG8AjMor66nFP9TIMeUgXUsb9aRYKD
         ue78+i8AFEvKdfelly5ThrLAPyj+JR9q22jQeYHhgwyAWY6tJOTBhxY05dZBg8zhMbWm
         r8RA231YQ977YYaZnO2wUNlEVb88qY7gRlxfYweujTOuxSs+yzp+hcnevqvPs5Nu9Vyo
         RnNLDGt3hzLuBVDBQppyzsQO+FuWBG18ZHPsodE/G+pgQiBCBZP/vii+kd+Nc6mzGHAy
         VtXw==
X-Received: by 10.14.199.8 with SMTP id w8mr3268043een.94.1395419846304;
        Fri, 21 Mar 2014 09:37:26 -0700 (PDT)
Received: from localhost.localdomain ([144.122.187.225])
        by mx.google.com with ESMTPSA id w6sm12647922eex.9.2014.03.21.09.37.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 09:37:25 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.286.g5172cb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244697>

From: Oguzhan Unlu <cengoguzhanunlu@gmail.com>

My solution to make lines containing buffer += a_number; clearer to anyone is following; I defined a new int, magic_num, then assigned lengths of used strings to magic_num and then changed assignment lines through using magic_num so that where the number which is added to buffer is known although I eliminated 3rd parameter of memcmp() when using starts_with().   

Signed-off-by: Oguzhan Unlu <cengoguzhanunlu@gmail.com>
---
 I didn't use skip_prefix() in this microproject and I plan to apply for GSOC 2014. I expect your feedbacks!
 fsck.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fsck.c b/fsck.c
index d43be98..4e5ca30 100644
--- a/fsck.c
+++ b/fsck.c
@@ -289,14 +289,17 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 	struct commit_graft *graft;
 	int parents = 0;
 	int err;
-
+    int magic_num;
+    
+    magic_num = strlen("tree "); /* magic_num is 5 */
 	if (!starts_with(buffer, "tree "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
-	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
+	if (get_sha1_hex(buffer+magic_num, tree_sha1) || buffer[45] != '\n')
 		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
 	buffer += 46;
+    magic_num = strlen("parent "); /* magic_num is 7 */
 	while (starts_with(buffer, "parent ")) {
-		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
+		if (get_sha1_hex(buffer+magic_num, sha1) || buffer[47] != '\n')
 			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
 		buffer += 48;
 		parents++;
@@ -322,15 +325,17 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 		if (p || parents)
 			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
 	}
+    magic_num = strlen("author "); /* magic_num is 7 */
 	if (!starts_with(buffer, "author "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
-	buffer += 7;
+	buffer += magic_num;
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
+    magic_num = strlen("committer"); /* magic_num is 7 */
 	if (!starts_with(buffer, "committer "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
-	buffer += strlen("committer ");
+	buffer += magic_num;
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-- 
1.9.1.286.g5172cb3
