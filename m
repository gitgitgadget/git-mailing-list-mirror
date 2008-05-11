From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] revision.c: really honor --first-parent
Date: Mon, 12 May 2008 01:14:11 +0200
Message-ID: <1210547651-32510-1-git-send-email-hjemli@gmail.com>
References: <7vd4ns3cll.fsf@gitster.siamese.dyndns.org>
Cc: <nanako3@bluebottle.com>, "Stephen R. van den Berg" <srb@cuci.nl>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 01:12:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvKia-0002R3-48
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 01:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757282AbYEKXLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 19:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756727AbYEKXLp
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 19:11:45 -0400
Received: from mail44.e.nsc.no ([193.213.115.44]:63976 "EHLO mail44.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755256AbYEKXLo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 19:11:44 -0400
Received: from localhost.localdomain (ti0025a380-3285.bb.online.no [88.88.28.225])
	by mail44.nsc.no (8.13.8/8.13.5) with ESMTP id m4BNBEvH027326;
	Mon, 12 May 2008 01:11:17 +0200 (MEST)
X-Mailer: git-send-email 1.5.5.1.148.g8ee22.dirty
In-Reply-To: <7vd4ns3cll.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81823>

In add_parents_to_list, if any parent of a revision had already been
SEEN, the current code would continue with the next parent. But if the
first parent has been SEEN and --first-parent has been specified we need
to break, not continue.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 revision.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 44d780b..974ad10 100644
--- a/revision.c
+++ b/revision.c
@@ -468,8 +468,11 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 		if (parse_commit(p) < 0)
 			return -1;
 		p->object.flags |= left_flag;
-		if (p->object.flags & SEEN)
+		if (p->object.flags & SEEN) {
+			if (revs->first_parent_only)
+				break;
 			continue;
+		}
 		p->object.flags |= SEEN;
 		insert_by_date(p, list);
 		if(revs->first_parent_only)
-- 
1.5.5.1.148.g8ee22.dirty
