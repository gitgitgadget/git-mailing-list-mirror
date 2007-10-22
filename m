From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Mon, 22 Oct 2007 03:16:44 -0400
Message-ID: <20071022071644.GA7290@coredump.intra.peff.net>
References: <20071022063222.GS14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 09:17:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjrX2-0001vY-I9
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 09:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbXJVHQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 03:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754576AbXJVHQt
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 03:16:49 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4277 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbXJVHQs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 03:16:48 -0400
Received: (qmail 17806 invoked by uid 111); 22 Oct 2007 07:16:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 22 Oct 2007 03:16:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2007 03:16:44 -0400
Content-Disposition: inline
In-Reply-To: <20071022063222.GS14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61963>

On Mon, Oct 22, 2007 at 02:32:22AM -0400, Shawn O. Pearce wrote:

> * lt/rename (Sun Oct 21 16:59:03 2007 -0700) 2 commits
>  - Linear-time/space rename logic (exact renames only)
>  - Split out "exact content match" phase of rename detection
> 
> t4001-diff-rename.sh failed while running tests on pu.  I'm pretty
> sure its this topic from Linus.  Need to look at it further.

Hrm, the problem is that it's not favoring basenames anymore. But I
think it is because the loop in find_identical_files is inside out. For
every source file, it picks the best destination file. But I think we
want to do the opposite: for every destination file, pick the best
source file. Otherwise, if a non-basename source file is connected with
a particular destination file, we no longer try that destination file
again.

Patch is below (please just squash with the one from Linus).

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 05d39db..8881818 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -252,17 +252,18 @@ static int find_identical_files(struct file_similarity *src,
 {
 	int renames = 0;
 	do {
-		struct diff_filespec *one = src->filespec;
+		struct diff_filespec *one = dst->filespec;
 		struct file_similarity *p, *best;
 		int i = 100;
 
 		best = NULL;
-		for (p = dst; p; p = p->next) {
+		for (p = src; p; p = p->next) {
 			struct diff_filespec *two = p->filespec;
 
-			/* Already picked as a destination? */
+			/* Already picked as a source? */
 			if (!p->src_dst)
 				continue;
+
 			/* False hash collission? */
 			if (hashcmp(one->sha1, two->sha1))
 				continue;
@@ -276,10 +277,10 @@ static int find_identical_files(struct file_similarity *src,
 		}
 		if (best) {
 			best->src_dst = 0;
-			record_rename_pair(best->index, src->index, MAX_SCORE);
+			record_rename_pair(dst->index, best->index, MAX_SCORE);
 			renames++;
 		}
-	} while ((src = src->next) != NULL);
+	} while ((dst = dst->next) != NULL);
 	return renames;
 }
 
