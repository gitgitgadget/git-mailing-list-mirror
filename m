From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH v2] revision.c: really honor --first-parent
Date: Mon, 12 May 2008 17:12:36 +0200
Message-ID: <1210605156-22926-1-git-send-email-hjemli@gmail.com>
References: <1210547651-32510-1-git-send-email-hjemli@gmail.com>
Cc: <nanako3@bluebottle.com>, "Stephen R. van den Berg" <srb@cuci.nl>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 17:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvZgu-0007tU-MA
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 17:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbYELPKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 11:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbYELPKz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 11:10:55 -0400
Received: from mail43.e.nsc.no ([193.213.115.43]:54848 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbYELPKy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 11:10:54 -0400
Received: from localhost.localdomain (ti0025a380-3285.bb.online.no [88.88.28.225])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id m4CF9auN018366;
	Mon, 12 May 2008 17:09:39 +0200 (MEST)
X-Mailer: git-send-email 1.5.5.1.148.g8ee22.dirty
In-Reply-To: <1210547651-32510-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81873>

In add_parents_to_list, if any parent of a revision had already been
SEEN, the current code would continue with the next parent, skipping
the test for --first-parent. This patch inverts the test for SEEN so
that the test for --first-parent is always performed.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
This is a slightly different approach which I think is less ugly.

 revision.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 44d780b..2fc26b8 100644
--- a/revision.c
+++ b/revision.c
@@ -468,10 +468,10 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 		if (parse_commit(p) < 0)
 			return -1;
 		p->object.flags |= left_flag;
-		if (p->object.flags & SEEN)
-			continue;
-		p->object.flags |= SEEN;
-		insert_by_date(p, list);
+		if (!(p->object.flags & SEEN)) {
+			p->object.flags |= SEEN;
+			insert_by_date(p, list);
+		}
 		if(revs->first_parent_only)
 			break;
 	}
-- 
1.5.5.1.148.g8ee22.dirty
