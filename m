From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Fix ugly magic special case in exact rename detection
Date: Fri, 26 Oct 2007 16:51:28 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710261646230.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 01:51:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlYxx-0005fp-Ci
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 01:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbXJZXvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 19:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753452AbXJZXvh
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 19:51:37 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50235 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752403AbXJZXvg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Oct 2007 19:51:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9QNpTr1008560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Oct 2007 16:51:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9QNpSxT020783;
	Fri, 26 Oct 2007 16:51:29 -0700
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62456>


For historical reasons, the exact rename detection had populated the
filespecs for the entries it compared, and the rest of the similarity
analysis depended on that.  I hadn't even bothered to debug why that was
the case when I re-did the rename detection, I just made the new one
have the same broken behaviour, with a note about this special case.

This fixes that fixme.  The reason the exact rename detector needed to
fill in the file sizes of the files it checked was that the _inexact_
rename detector was broken, and started comparing file sizes before it
filled them in.

Fixing that allows the exact phase to do the sane thing of never even
caring (since all *it* cares about is really just the SHA1 itself, not
the size nor the contents).

It turns out that this also indirectly fixes a bug: trying to populate
all the filespecs will run out of virtual memory if there is tons and
tons of possible rename options.  The fuzzy similarity analysis does the
right thing in this regard, and free's the blob info after it has
generated the hash tables, so the special case code caused more trouble
than just some extra illogical code.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Without this, when I try to do a "git commit --amend" on my 
horror-repository with the commit that moved around a hundred thousand 
files, I actually have "git runstatus" die() on me, because xmmap() fails 
(mmap() returns NULL due to running out of vm mappings).

Not to mention that this is "obviously correct" (tm) and the "right thing" 
(tm)" to do (famous last words). It's wrong of estimate_similarity() to 
try to compare the sizes of the filespec entries before they have been 
filled in, and it really shouldn't expect the exact rename detection to 
fill them in, since the exact rename detection doesn't even care!

 diffcore-rename.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3946932..7ed5ef8 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -144,6 +144,20 @@ static int estimate_similarity(struct diff_filespec *src,
 	if (!S_ISREG(src->mode) || !S_ISREG(dst->mode))
 		return 0;
 
+	/*
+	 * Need to check that source and destination sizes are
+	 * filled in before comparing them.
+	 *
+	 * If we already have "cnt_data" filled in, we know it's
+	 * all good (avoid checking the size for zero, as that
+	 * is a possible size - we really should have a flag to
+	 * say whether the size is valid or not!)
+	 */
+	if (!src->cnt_data && diff_populate_filespec(src, 0))
+		return 0;
+	if (!dst->cnt_data && diff_populate_filespec(dst, 0))
+		return 0;
+
 	max_size = ((src->size > dst->size) ? src->size : dst->size);
 	base_size = ((src->size < dst->size) ? src->size : dst->size);
 	delta_size = max_size - base_size;
@@ -159,11 +173,6 @@ static int estimate_similarity(struct diff_filespec *src,
 	if (base_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
-	if ((!src->cnt_data && diff_populate_filespec(src, 0))
-		|| (!dst->cnt_data && diff_populate_filespec(dst, 0)))
-		return 0; /* error but caught downstream */
-
-
 	delta_limit = (unsigned long)
 		(base_size * (MAX_SCORE-minimum_score) / MAX_SCORE);
 	if (diffcore_count_changes(src, dst,
@@ -270,19 +279,11 @@ static int find_identical_files(struct file_similarity *src,
 	return renames;
 }
 
-/*
- * Note: the rest of the rename logic depends on this
- * phase also populating all the filespecs for any
- * entry that isn't matched up with an exact rename.
- */
 static void free_similarity_list(struct file_similarity *p)
 {
 	while (p) {
 		struct file_similarity *entry = p;
 		p = p->next;
-
-		/* Stupid special case, see note above! */
-		diff_populate_filespec(entry->filespec, 0);
 		free(entry);
 	}
 }
