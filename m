From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] server-info: do not complain if a tag points at a non-commit.
Date: Thu, 28 Jul 2005 19:24:03 -0700
Message-ID: <7vr7diqri4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0507271504071.3227@g5.osdl.org>
	<7vack7q2k7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507271610010.3227@g5.osdl.org>
	<7vll3rn4sj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507271813330.3227@g5.osdl.org>
	<Pine.LNX.4.58.0507272244260.3227@g5.osdl.org>
	<Pine.LNX.4.58.0507272249140.3227@g5.osdl.org>
	<7vll3rjwld.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507280040380.3227@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 04:24:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyKXq-0008Pq-Dc
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 04:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVG2CYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 22:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVG2CYI
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 22:24:08 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:33775 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262130AbVG2CYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 22:24:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729022354.UWHR8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Jul 2005 22:23:54 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linux 2.6 tree has one of those tree tags.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 server-info.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

42fa3ca33f92381a73c08ab98dc4b54e6a6412cc
diff --git a/server-info.c b/server-info.c
--- a/server-info.c
+++ b/server-info.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "object.h"
 #include "commit.h"
+#include "tag.h"
 #include "rev-cache.h"
 
 /* refs */
@@ -518,10 +519,16 @@ static int update_info_packs(int force)
 /* rev-cache */
 static int record_rev_cache_ref(const char *path, const unsigned char *sha1)
 {
-	struct commit *commit;
-	if (!(commit = lookup_commit_reference(sha1)))
-		return error("not a commit: %s", sha1_to_hex(sha1));
-	return record_rev_cache(commit->object.sha1, NULL);
+	struct object *obj = parse_object(sha1);
+
+	if (!obj)
+		return error("ref %s has bad sha %s", path, sha1_to_hex(sha1));
+	while (obj && obj->type == tag_type)
+		obj = parse_object(((struct tag *)obj)->tagged->sha1);
+	if (!obj || obj->type != commit_type)
+		/* tag pointing at a non-commit */
+		return 0;
+	return record_rev_cache(obj->sha1, NULL);
 }
 
 static int update_info_revs(int force)
