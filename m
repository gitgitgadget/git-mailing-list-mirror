From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] reflog-expire: brown paper bag fix.
Date: Thu, 11 Jan 2007 19:59:00 -0800
Message-ID: <7vzm8ox5dn.fsf@assigned-by-dhcp.cox.net>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 12 04:59:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5DZQ-0002qJ-Lw
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 04:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbXALD7C (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 22:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbXALD7B
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 22:59:01 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:42948 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbXALD7B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 22:59:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112035900.BZCR9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 22:59:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id A3y91W00G1kojtg0000000; Thu, 11 Jan 2007 22:58:09 -0500
To: git@vger.kernel.org
In-Reply-To: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 11 Jan 2007 18:43:53 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36656>

When --stale-fix is not passed, the code did not initialize the
two commit objects properly.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * If you see Segfault from "git gc", it would have left two
   .lock files under .git/refs/ and .git/logs/refs; your
   repository has not be corrupted with this.  Please remove the
   two leftover .lock files by hand, apply this patch and
   re-run.

 builtin-reflog.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index ca22452..7206b7a 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -173,7 +173,6 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
 {
 	struct commit *commit;
 
-	*it = NULL;
 	if (is_null_sha1(sha1))
 		return 1;
 	commit = lookup_commit_reference_gently(sha1, 1);
@@ -204,15 +203,22 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	if (timestamp < cb->cmd->expire_total)
 		goto prune;
 
+	old = new = NULL;
 	if (cb->cmd->stalefix &&
 	    (!keep_entry(&old, osha1) || !keep_entry(&new, nsha1)))
 		goto prune;
 
-	if ((timestamp < cb->cmd->expire_unreachable) &&
-	    (!cb->ref_commit ||
-	     (old && !in_merge_bases(old, cb->ref_commit)) ||
-	     (new && !in_merge_bases(new, cb->ref_commit))))
-		goto prune;
+	if (timestamp < cb->cmd->expire_unreachable) {
+		if (!cb->ref_commit)
+			goto prune;
+		if (!old && !is_null_sha1(osha1))
+			old = lookup_commit_reference_gently(osha1, 1);
+		if (!new && !is_null_sha1(nsha1))
+			new = lookup_commit_reference_gently(nsha1, 1);
+		if ((old && !in_merge_bases(old, cb->ref_commit)) ||
+		    (new && !in_merge_bases(new, cb->ref_commit)))
+			goto prune;
+	}
 
 	if (cb->newlog) {
 		char sign = (tz < 0) ? '-' : '+';
-- 
1.5.0.rc1
