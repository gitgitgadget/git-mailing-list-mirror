From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/4] Use binary searching on large buckets in git-describe.
Date: Sat, 13 Jan 2007 17:29:00 -0500
Message-ID: <20070113222900.GC18011@spearce.org>
References: <8e29bab8b4b9f53cbdc85e6e783bf3b5d3787f0f.1168727248.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 23:29:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5rN9-0002M7-L1
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 23:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbXAMW3H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 17:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbXAMW3H
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 17:29:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36034 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030521AbXAMW3F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 17:29:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5rMq-0000PL-IL; Sat, 13 Jan 2007 17:28:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8148F20FBAE; Sat, 13 Jan 2007 17:29:00 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <8e29bab8b4b9f53cbdc85e6e783bf3b5d3787f0f.1168727248.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36780>

If a project has a really huge number of tags (such as several
thousand tags) then we are likely to have nearly a hundred tags in
some buckets.  Scanning those buckets as linked lists could take
a large amount of time if done repeatedly during history traversal.

Since we are searching for a unique commit SHA1 we can sort all
tags by commit SHA1 and perform a binary search within the bucket.
Once we identify a particular tag as matching this commit we walk
backwards within the bucket matches to make sure we pick up the
highest priority tag for that commit, as the binary search may
have landed us in the middle of a set of tags which point at the
same commit.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-describe.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 582ef02..5d6865b 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -23,14 +23,24 @@ static struct commit_name {
 
 static struct commit_name *match(struct commit *cmit)
 {
-	unsigned char m = cmit->object.sha1[0];
-	unsigned int i = names[m];
-	struct commit_name **p = name_array[m];
-
-	while (i-- > 0) {
-		struct commit_name *n = *p++;
-		if (n->commit == cmit)
-			return n;
+	unsigned char level0 = cmit->object.sha1[0];
+	struct commit_name **p = name_array[level0];
+	unsigned int hi = names[level0];
+	unsigned int lo = 0;
+
+	while (lo < hi) {
+		unsigned int mi = (lo + hi) / 2;
+		int cmp = hashcmp(p[mi]->commit->object.sha1,
+			cmit->object.sha1);
+		if (!cmp) {
+			while (mi && p[mi - 1]->commit == cmit)
+				mi--;
+			return p[mi];
+		}
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi+1;
 	}
 	return NULL;
 }
@@ -95,7 +105,10 @@ static int compare_names(const void *_a, const void *_b)
 	struct commit_name *b = *(struct commit_name **)_b;
 	unsigned long a_date = a->commit->date;
 	unsigned long b_date = b->commit->date;
+	int cmp = hashcmp(a->commit->object.sha1, b->commit->object.sha1);
 
+	if (cmp)
+		return cmp;
 	if (a->prio != b->prio)
 		return b->prio - a->prio;
 	return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
-- 
1.5.0.rc1.g4494
