From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 2/5] git-merge-base: follow 'prior' links to find merge bases
Date: Tue, 25 Apr 2006 16:31:06 +1200
Message-ID: <20060425043106.18382.48165.stgit@localhost.localdomain>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
X-From: git-owner@vger.kernel.org Tue Apr 25 06:32:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYFDU-0000IJ-EQ
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 06:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWDYEby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 00:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWDYEby
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 00:31:54 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:48618 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751025AbWDYEbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 00:31:52 -0400
Received: from samv by mail1.catalyst.net.nz with local (Exim 4.50)
	id 1FYFDK-0004Dm-HH
	for git@vger.kernel.org; Tue, 25 Apr 2006 16:31:50 +1200
To: git@vger.kernel.org
In-Reply-To: <20060425035421.18382.51677.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19124>

From: Sam Vilain <sam.vilain@catalyst.net.nz>

It is possible that a good merge base may be found looking via "prior"
links as well.  We follow them where possible.
---

 merge-base.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/merge-base.c b/merge-base.c
index 07f5ab4..ed6d18c 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -207,6 +207,18 @@ static int merge_base(struct commit *rev
 			p->object.flags |= flags;
 			insert_by_date(p, &list);
 		}
+		/* If the commit has a "prior" reference, add it */
+		if (commit->prior) {
+			struct commit *prior;
+			prior = lookup_commit_reference_gently(commit->prior, 1);
+			if (prior) {
+				if ((prior->object.flags & flags) != flags) {
+					parse_commit(prior);
+					prior->object.flags |= flags;
+					insert_by_date(prior, &list);
+				}
+			}
+		}
 	}
 
 	if (!result)
