From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] fast-export: Correctly generate initial commits with no parents
Date: Fri, 13 Jun 2008 00:38:55 -0400
Message-ID: <20080613043855.GA28644@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 06:40:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7152-0007xD-BU
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 06:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbYFMEjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 00:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbYFMEjD
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 00:39:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43356 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbYFMEjB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 00:39:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K713x-0004MZ-I6; Fri, 13 Jun 2008 00:38:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E829B20FBAE; Fri, 13 Jun 2008 00:38:55 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we are exporting a commit which has no parents we may be doing
it to a branch that already exists, causing fast-import to assume
the branch's current revision should be the sole parent of the
new commit.  This can cause `git fast-export | git fast-import`
to produce an incorrect graph for:

   A-------M----o------o  refs/heads/master
          /
       B-+

In this graph A and B are initial commits (no parents) but if A was
output first to refs/heads/master and then B is output fast-import
would assume the graph was this instead:

   A-------M----o------o  refs/heads/master
    \     /
     +-B-+

Which would cause B, M, and all later commits to have a different
SHA-1, and obviously be quite a different graph.

Sending a reset command prior to B informs fast-import to clear
the implied parent of A, allowing B to remain an initial commit.

Reported-by: Ben Lynn <benlynn@gmail.com>
Deemed-obviously-correct-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fast-export.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 1dfc01e..d0a462f 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -188,6 +188,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	mark_object(&commit->object);
 	if (!is_encoding_utf8(encoding))
 		reencoded = reencode_string(message, "UTF-8", encoding);
+	if (!commit->parents)
+		printf("reset %s\n", (const char*)commit->util);
 	printf("commit %s\nmark :%d\n%.*s\n%.*s\ndata %u\n%s",
 	       (const char *)commit->util, last_idnum,
 	       (int)(author_end - author), author,
-- 
1.5.6.rc2.165.g2a0cc
