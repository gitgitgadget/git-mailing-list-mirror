From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/5] builtin-prune: separate ref walking from reflog walking.
Date: Sat, 06 Jan 2007 02:16:14 -0800
Message-ID: <7vzm8w5ukx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 06 11:16:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H38b6-0001Rd-Pl
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 11:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbXAFKQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 05:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXAFKQQ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 05:16:16 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:41824 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbXAFKQP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 05:16:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106101615.LOYS29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sat, 6 Jan 2007 05:16:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7mGW1W0071kojtg0000000; Sat, 06 Jan 2007 05:16:30 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36079>

This is necessary for the next step, because the reason I am
making the connectivity walker into a library is because I want
to use it for cleaning up stale reflog entries.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-prune.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 9522864..cd079b4 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -203,8 +203,12 @@ static int add_one_ref(const char *path, const unsigned char *sha1, int flag, vo
 		die("bad object ref: %s:%s", path, sha1_to_hex(sha1));
 	add_pending_object(revs, object, "");
 
-	for_each_reflog_ent(path, add_one_reflog_ent, cb_data);
+	return 0;
+}
 
+static int add_one_reflog(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+{
+	for_each_reflog_ent(path, add_one_reflog_ent, cb_data);
 	return 0;
 }
 
@@ -267,12 +271,15 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	revs.blob_objects = 1;
 	revs.tree_objects = 1;
 
-	/* Add all external refs, along with its reflog info */
+	/* Add all external refs */
 	for_each_ref(add_one_ref, &revs);
 
 	/* Add all refs from the index file */
 	add_cache_refs(&revs);
 
+	/* Add all reflog info from refs */
+	for_each_ref(add_one_reflog, &revs);
+
 	/*
 	 * Set up the revision walk - this will move all commits
 	 * from the pending list to the commit walking list.
-- 
1.5.0.rc0.ge0f6
