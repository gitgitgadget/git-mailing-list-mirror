From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Avoid excessive rewrites in merge-recursive
Date: Wed, 25 Apr 2007 22:06:59 +0200
Message-ID: <20070425200659.GA30061@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 22:07:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgnlq-0001Xh-R8
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 22:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993044AbXDYUHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 16:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993042AbXDYUHG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 16:07:06 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:13640 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993045AbXDYUHD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 16:07:03 -0400
Received: from tigra.home (Fac4b.f.strato-dslnet.de [195.4.172.75])
	by post.webmailer.de (fruni mo40) (RZmta 5.6)
	with ESMTP id A015fbj3PJ3vaQ ; Wed, 25 Apr 2007 22:07:00 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BCE05277BD;
	Wed, 25 Apr 2007 22:07:00 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2C77DBDDE; Wed, 25 Apr 2007 22:07:00 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFqtlg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45558>

If a file is changed in one branch, and renamed and changed to the
same content in another branch than we can skip the rewrite of this
file in the working directory, as the content does not change.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Just as you may have thought merge-recursive cannot get any uglier
someone comes and does just this: puts another level of indentation.

It is a nice speed up, though. Besides, I had some directories moved
between branches, and the rewrites caused a rebuild of hefty 8000
objects, which in windows terms is around 2 hours.

 merge-recursive.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 403a4c8..37f1ba9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1342,20 +1342,26 @@ static int process_renames(struct path_list *a_renames,
 				mfi = merge_file(o, a, b,
 						a_branch, b_branch);
 
-				if (mfi.merge || !mfi.clean)
-					output(1, "Renamed %s => %s", ren1_src, ren1_dst);
-				if (mfi.merge)
-					output(2, "Auto-merged %s", ren1_dst);
-				if (!mfi.clean) {
-					output(1, "CONFLICT (rename/modify): Merge conflict in %s",
-					       ren1_dst);
-					clean_merge = 0;
-
-					if (!index_only)
-						update_stages(ren1_dst,
-								o, a, b, 1);
+				if (mfi.merge && mfi.clean &&
+				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
+				    mfi.mode == ren1->pair->two->mode)
+					output(3, "Skipped %s (merged same as existing)", ren1_dst);
+				else {
+					if (mfi.merge || !mfi.clean)
+						output(1, "Renamed %s => %s", ren1_src, ren1_dst);
+					if (mfi.merge)
+						output(2, "Auto-merged %s", ren1_dst);
+					if (!mfi.clean) {
+						output(1, "CONFLICT (rename/modify): Merge conflict in %s",
+						       ren1_dst);
+						clean_merge = 0;
+
+						if (!index_only)
+							update_stages(ren1_dst,
+								      o, a, b, 1);
+					}
+					update_file(mfi.clean, mfi.sha, mfi.mode, ren1_dst);
 				}
-				update_file(mfi.clean, mfi.sha, mfi.mode, ren1_dst);
 			}
 		}
 	}
-- 
1.5.2.rc0.63.gdfc8-dirty
