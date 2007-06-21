From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix up "git log --follow" a bit..
Date: Thu, 21 Jun 2007 10:22:59 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706211017190.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 19:24:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1QOr-0002jc-Qr
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 19:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758639AbXFURYG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 13:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758637AbXFURYF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 13:24:05 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56210 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754878AbXFURYC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2007 13:24:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LHN4FL015037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2007 10:23:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LHMxZj000927;
	Thu, 21 Jun 2007 10:22:59 -0700
X-Spam-Status: No, hits=-2.535 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50647>


This fixes "git log --follow" to hopefully not leak memory any more, and 
also cleans it up a bit to look more like some of the other functions that 
use "diff_queued_diff" (by *not* using it directly as a global in the 
code, but by instead just taking a pointer to the diff queue and using 
that).

As to "diff_queued_diff", I think it would be better off not as a global 
at all, but as being just an entry in the "struct diff_options" structure, 
but that's a separate issue, and there may be some subtle reason for why 
it's currently a global.

Anyway, no real changes. Instead of having a magical first entry in the 
diff-queue, we now end up just keeping the diff-queue clean, and keeping 
our "preferred" file pairing in an internal "choice" variable. That makes 
it easy to switch the choice around when we find a better one.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

No changes outside of "try_to_follow_renames()", and most of the diff here 
really is just trivial re-organizations and the addition of "free all the 
filepairs we're not interested in.

Updated the comments a bit to match.

 tree-diff.c |   37 ++++++++++++++++++++++++++++---------
 1 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 42924e9..26bdbdd 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -305,9 +305,15 @@ static inline int diff_might_be_rename(void)
 static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
 {
 	struct diff_options diff_opts;
-	const char *paths[2];
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_filepair *choice;
+	const char *paths[1];
 	int i;
 
+	/* Remove the file creation entry from the diff queue, and remember it */
+	choice = q->queue[0];
+	q->nr = 0;
+
 	diff_setup(&diff_opts);
 	diff_opts.recursive = 1;
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
@@ -320,17 +326,21 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	diff_tree(t1, t2, base, &diff_opts);
 	diffcore_std(&diff_opts);
 
-	/* NOTE! Ignore the first diff! That was the old one! */
-	for (i = 1; i < diff_queued_diff.nr; i++) {
-		struct diff_filepair *p = diff_queued_diff.queue[i];
+	/* Go through the new set of filepairing, and see if we find a more interesting one */
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
 
 		/*
 		 * Found a source? Not only do we use that for the new
-		 * diff_queued_diff, we also use that as the path in
+		 * diff_queued_diff, we will also use that as the path in
 		 * the future!
 		 */
 		if ((p->status == 'R' || p->status == 'C') && !strcmp(p->two->path, opt->paths[0])) {
-			diff_queued_diff.queue[0] = p;
+			/* Switch the file-pairs around */
+			q->queue[i] = choice;
+			choice = p;
+
+			/* Update the path we use from now on.. */
 			opt->paths[0] = xstrdup(p->one->path);
 			diff_tree_setup_paths(opt->paths, opt);
 			break;
@@ -338,10 +348,19 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	}
 
 	/*
-	 * Then, ignore any but the first entry! It might be the old one,
-	 * or it might be the rename/copy we found
+	 * Then, discard all the non-relevane file pairs...
+	 */
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		diff_free_filepair(p);
+	}
+
+	/*
+	 * .. and re-instate the one we want (which might be either the
+	 * original one, or the rename/copy we found)
 	 */
-	diff_queued_diff.nr = 1;
+	q->queue[0] = choice;
+	q->nr = 1;
 }
 
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
