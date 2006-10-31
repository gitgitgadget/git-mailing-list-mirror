X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [PATCH] Continue traversal when rev-list --unpacked finds a packed commit.
Date: Mon, 30 Oct 2006 20:37:49 -0500
Message-ID: <20061031013749.GA19885@delft.aura.cs.cmu.edu>
References: <20061029093754.GD3847@spearce.org> <Pine.LNX.4.64.0610301332440.11384@xanadu.home> <20061030202611.GA5775@spearce.org> <20061030205200.GA20236@delft.aura.cs.cmu.edu> <7v3b95wjmg.fsf@assigned-by-dhcp.cox.net> <20061030225500.GG3617@delft.aura.cs.cmu.edu> <7vhcxltmit.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 01:38:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhcxltmit.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30558>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeiZg-00025k-NJ for gcvg-git@gmane.org; Tue, 31 Oct
 2006 02:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161569AbWJaBhx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 20:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161570AbWJaBhx
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 20:37:53 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:14049 "EHLO
 delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP id S1161569AbWJaBhx
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 20:37:53 -0500
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.63)
 (envelope-from <jaharkes@cs.cmu.edu>) id 1GeiZZ-0005BJ-4I; Mon, 30 Oct 2006
 20:37:49 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


When getting the list of all unpacked objects by walking the commit history,
we would stop traversal whenever we hit a packed commit. However the fact
that we found a packed commit does not guarantee that all previous commits
are also packed. As a result the commit walkers did not show all reachable
unpacked objects.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 revision.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 280e92b..a69c873 100644
--- a/revision.c
+++ b/revision.c
@@ -418,9 +418,6 @@ static void limit_list(struct rev_info *
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
-		if (revs->unpacked &&
-		    has_sha1_pack(obj->sha1, revs->ignore_packed))
-			obj->flags |= UNINTERESTING;
 		add_parents_to_list(revs, commit, &list);
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
@@ -1149,17 +1146,18 @@ struct commit *get_revision(struct rev_i
 		 * that we'd otherwise have done in limit_list().
 		 */
 		if (!revs->limited) {
-			if ((revs->unpacked &&
-			     has_sha1_pack(commit->object.sha1,
-					   revs->ignore_packed)) ||
-			    (revs->max_age != -1 &&
-			     (commit->date < revs->max_age)))
+			if (revs->max_age != -1 &&
+			    (commit->date < revs->max_age))
 				continue;
 			add_parents_to_list(revs, commit, &revs->commits);
 		}
 		if (commit->object.flags & SHOWN)
 			continue;
 
+		if (revs->unpacked && has_sha1_pack(commit->object.sha1,
+						    revs->ignore_packed))
+		    continue;
+
 		/* We want to show boundary commits only when their
 		 * children are shown.  When path-limiter is in effect,
 		 * rewrite_parents() drops some commits from getting shown,
-- 
1.4.2.4.gd5de
