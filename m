From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] fsck: simplify fsck_commit_buffer() by using commit_list_count()
Date: Thu, 10 Jul 2014 11:48:26 +0200
Message-ID: <53BE616A.4000709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 11:48:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Ay1-0001pA-64
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 11:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbaGJJsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 05:48:37 -0400
Received: from mout.web.de ([212.227.17.12]:59994 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbaGJJsg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 05:48:36 -0400
Received: from [192.168.178.27] ([79.253.174.99]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LfRvZ-1WGyxn2Wkb-00p8sj; Thu, 10 Jul 2014 11:48:34
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:ZlIBnBqin5zABaG6ZEXM2EtdiAECq7XE6Z738UYiiPVSsAVLvkh
 EPURpeYonM5Kf+WU7+3K4jf21CzefDUs9W3BhDKy6V6djEfF5R7LjtR6w6zGVy7m/9wO32p
 Rb1NnDUAs6H1hPvCv0fCfmTgAO/fV4CuoDmg+rlIpLxbkSMdJ8M54b4XDWCigWS542YUNTR
 /nc0wj4us7XnvDGEZMUgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253184>

fsck_commit_buffer() checks that the number of items in the parents
list of a commit matches the number of parent lines in its buffer or --
if a graft is used -- the number of parents in that graft.  Simplify
the code by using commit_list_count() instead of counting by hand.
Also use different variables for the number of lines and the number of
list items, making it easier to compare them.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 fsck.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fsck.c b/fsck.c
index a4e8593..56156ff 100644
--- a/fsck.c
+++ b/fsck.c
@@ -281,7 +281,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 {
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
-	int parents = 0;
+	unsigned parent_count, parent_line_count = 0;
 	int err;
 
 	if (!skip_prefix(buffer, "tree ", &buffer))
@@ -293,27 +293,17 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
 			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
 		buffer += 41;
-		parents++;
+		parent_line_count++;
 	}
 	graft = lookup_commit_graft(commit->object.sha1);
+	parent_count = commit_list_count(commit->parents);
 	if (graft) {
-		struct commit_list *p = commit->parents;
-		parents = 0;
-		while (p) {
-			p = p->next;
-			parents++;
-		}
-		if (graft->nr_parent == -1 && !parents)
+		if (graft->nr_parent == -1 && !parent_count)
 			; /* shallow commit */
-		else if (graft->nr_parent != parents)
+		else if (graft->nr_parent != parent_count)
 			return error_func(&commit->object, FSCK_ERROR, "graft objects missing");
 	} else {
-		struct commit_list *p = commit->parents;
-		while (p && parents) {
-			p = p->next;
-			parents--;
-		}
-		if (p || parents)
+		if (parent_count != parent_line_count)
 			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
 	}
 	if (!skip_prefix(buffer, "author ", &buffer))
-- 
2.0.0
