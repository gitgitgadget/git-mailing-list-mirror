From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 3/3] simplify output of conflicting merge
Date: Sun,  5 Apr 2009 02:47:00 +0200
Message-ID: <1238892420-721-4-git-send-email-drizzd@aon.at>
References: <20090401180627.GA14716@localhost>
 <1238892420-721-1-git-send-email-drizzd@aon.at>
 <1238892420-721-2-git-send-email-drizzd@aon.at>
 <1238892420-721-3-git-send-email-drizzd@aon.at>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Michael Johnson <redbeard@mdjohnson.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 02:48:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqGXP-0004hw-7N
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 02:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293AbZDEArJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 20:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756218AbZDEArI
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 20:47:08 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:51887 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626AbZDEArE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 20:47:04 -0400
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 5 Apr 2009 02:46:57 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LqGVo-0000CZ-FS; Sun, 05 Apr 2009 02:47:00 +0200
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1238892420-721-3-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 05 Apr 2009 00:46:58.0043 (UTC) FILETIME=[062AFCB0:01C9B588]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115613>

This simplifies the code without changing the semantics and removes
the unhelpful "needs $sha1" part of the conflicting submodule message.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 merge-recursive.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f1b120b..d6f0582 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1116,22 +1116,13 @@ static int process_entry(struct merge_options *o,
 				 o->branch1, o->branch2);
 
 		clean_merge = mfi.clean;
-		if (mfi.clean)
-			update_file(o, 1, mfi.sha, mfi.mode, path);
-		else if (S_ISGITLINK(mfi.mode)) {
-			output(o, 1, "CONFLICT (submodule): Merge conflict in %s "
-			       "- needs %s", path, sha1_to_hex(b.sha1));
-			update_file(o, 0, mfi.sha, mfi.mode, path);
-		} else {
+		if (!mfi.clean) {
+			if (S_ISGITLINK(mfi.mode))
+				reason = "submodule";
 			output(o, 1, "CONFLICT (%s): Merge conflict in %s",
 					reason, path);
-
-			if (o->call_depth)
-				update_file(o, 0, mfi.sha, mfi.mode, path);
-			else
-				update_file_flags(o, mfi.sha, mfi.mode, path,
-					      0 /* update_cache */, 1 /* update_working_directory */);
 		}
+		update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
 	} else if (!o_sha && !a_sha && !b_sha) {
 		/*
 		 * this entry was deleted altogether. a_mode == 0 means
-- 
1.6.2.1
