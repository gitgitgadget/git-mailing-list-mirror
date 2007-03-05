From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] fast-import: Fail if a non-existant commit is used for merge
Date: Mon, 5 Mar 2007 12:46:10 -0500
Message-ID: <20070305174610.GB22304@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <J.Sixt@eudaptics.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:46:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOHGW-00013x-P4
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 18:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbXCERqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 12:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbXCERqQ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 12:46:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50954 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbXCERqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 12:46:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOHG9-0007cz-MX; Mon, 05 Mar 2007 12:46:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8ED4420FBAE; Mon,  5 Mar 2007 12:46:10 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41467>

Johannes Sixt noticed during one of his own imports that fast-import
did not fail if a non-existant commit is referenced by SHA-1 value
as an argument to the 'merge' command.  This allowed the user to
unknowingly create commits that would fail in fsck, as the commit
contents would not be completely reachable.

A side effect of this bug was that a frontend process could mark
any SHA-1 object (blob, tree, tag) as a parent of a merge commit.
This should also fail in fsck, as the commit is not a valid commit.

We now use the same rule as the 'from' command.  If a commit is
referenced in the 'merge' command by hex formatted SHA-1 then the
SHA-1 must be a commit or a tag that can be peeled back to a commit,
the commit must already exist, and must be readable by the core Git
infrastructure code.  This requirement means that the commit must
have existed prior to fast-import starting, or the commit must have
been flushed out by a prior 'checkpoint' command.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 fast-import.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 490f640..d9492b9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1752,7 +1752,14 @@ static struct hash_list *cmd_merge(unsigned int *count)
 			if (oe->type != OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
 			hashcpy(n->sha1, oe->sha1);
-		} else if (get_sha1(from, n->sha1))
+		} else if (!get_sha1(from, n->sha1)) {
+			unsigned long size;
+			char *buf = read_object_with_reference(n->sha1,
+				type_names[OBJ_COMMIT], &size, n->sha1);
+			if (!buf || size < 46)
+				die("Not a valid commit: %s", from);
+			free(buf);
+		} else
 			die("Invalid ref name or SHA1 expression: %s", from);
 
 		n->next = NULL;
-- 
1.5.0.3.862.g71037
