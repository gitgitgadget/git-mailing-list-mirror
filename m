From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/3] update cache for conflicting submodule entries
Date: Sun,  5 Apr 2009 02:46:59 +0200
Message-ID: <1238892420-721-3-git-send-email-drizzd@aon.at>
References: <20090401180627.GA14716@localhost>
 <1238892420-721-1-git-send-email-drizzd@aon.at>
 <1238892420-721-2-git-send-email-drizzd@aon.at>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Michael Johnson <redbeard@mdjohnson.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 02:48:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqGXQ-0004hw-05
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 02:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405AbZDEArM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 20:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756305AbZDEArL
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 20:47:11 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:51887 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886AbZDEArI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 20:47:08 -0400
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 5 Apr 2009 02:46:57 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LqGVo-0000CX-Dx; Sun, 05 Apr 2009 02:47:00 +0200
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1238892420-721-2-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 05 Apr 2009 00:46:57.0996 (UTC) FILETIME=[0623D0C0:01C9B588]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115614>

When merging merge bases during a recursive merge we do not want to
leave any unmerged entries. Otherwise we cannot create a temporary
tree for the recursive merge to work with.

We failed to do so in case of a submodule conflict between merge
bases, causing a NULL pointer dereference in the next step of the
recursive merge.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 merge-recursive.c          |    5 +++--
 t/t7405-submodule-merge.sh |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3e1bc3e..f1b120b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1118,10 +1118,11 @@ static int process_entry(struct merge_options *o,
 		clean_merge = mfi.clean;
 		if (mfi.clean)
 			update_file(o, 1, mfi.sha, mfi.mode, path);
-		else if (S_ISGITLINK(mfi.mode))
+		else if (S_ISGITLINK(mfi.mode)) {
 			output(o, 1, "CONFLICT (submodule): Merge conflict in %s "
 			       "- needs %s", path, sha1_to_hex(b.sha1));
-		else {
+			update_file(o, 0, mfi.sha, mfi.mode, path);
+		} else {
 			output(o, 1, "CONFLICT (%s): Merge conflict in %s",
 					reason, path);
 
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 9778ad4..aa6c44c 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -63,7 +63,7 @@ test_expect_failure 'merging with modify/modify conflict' '
 
 '
 
-test_expect_failure 'merging with a modify/modify conflict between merge bases' '
+test_expect_success 'merging with a modify/modify conflict between merge bases' '
 
 	git reset --hard HEAD &&
 	git checkout -b test2 c &&
-- 
1.6.2.1
