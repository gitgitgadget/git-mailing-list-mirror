From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 9/11] Allow merging bare trees in merge-recursive.
Date: Thu, 28 Dec 2006 02:35:24 -0500
Message-ID: <20061228073523.GI17867@spearce.org>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 08:35:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzpng-0000zP-2M
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 08:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWL1Hfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 02:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWL1Hfa
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 02:35:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45841 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964998AbWL1Hf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 02:35:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gzpn0-0007yX-Mb; Thu, 28 Dec 2006 02:34:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0CA1C20FB6B; Thu, 28 Dec 2006 02:35:24 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35533>

To support wider use cases, such as from within `git am -3`, the
merge-recursive utility needs to accept not just commit-ish but
also tree-ish as arguments on its command line.

If given a tree-ish then merge-recursive will create a virtual commit
wrapping it, with the subject of the commit set to the best name we
can derive for that tree, which is either the command line string
(probably the SHA1), or whatever string appears in GITHEAD_*.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 merge-recursive.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1c84ed7..bac16f5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1268,6 +1268,9 @@ static struct commit *get_ref(const char *ref)
 	if (get_sha1(ref, sha1))
 		die("Could not resolve ref '%s'", ref);
 	object = deref_tag(parse_object(sha1), ref, strlen(ref));
+	if (object->type == OBJ_TREE)
+		return make_virtual_commit((struct tree*)object,
+			better_branch_name(ref));
 	if (object->type != OBJ_COMMIT)
 		return NULL;
 	if (parse_commit((struct commit *)object))
-- 
1.4.4.3.gd2e4
