From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Do the fuzzy rename detection limits with the exact
 renames removed
Date: Fri, 26 Oct 2007 16:56:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710261654300.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710261646230.30120@woody.linux-foundation.or
 g>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 01:57:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlZ3E-0006fG-Kf
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 01:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757678AbXJZX5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 19:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753870AbXJZX5D
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 19:57:03 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51400 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752608AbXJZX5B (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Oct 2007 19:57:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9QNuZrq008677
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Oct 2007 16:56:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9QNuY61020956;
	Fri, 26 Oct 2007 16:56:35 -0700
In-Reply-To: <alpine.LFD.0.999.0710261646230.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62457>


When we do the fuzzy rename detection, we don't care about the
destinations that we already handled with the exact rename detector.
And, in fact, the code already knew that - but the rename limiter, which
used to run *before* exact renames were detected, did not.

This fixes it so that the rename detection limiter now bases its
decisions on the *remaining* rename counts, rather than the original
ones.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Pretty obvious. It just moves the tests around a bit, and uses the updated 
counters.

Works For Me(tm), although this isn't all that obviously testable (ie I 
should find a test that is border-line, and triggers the rename detection 
limits, but then has enough exact renames that the rename detection array 
goes away).

 diffcore-rename.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 7ed5ef8..f9ebea5 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -435,33 +435,37 @@ void diffcore_rename(struct diff_options *options)
 	 */
 	rename_count = find_exact_renames();
 
+	/* Did we only want exact renames? */
+	if (minimum_score == MAX_SCORE)
+		goto cleanup;
+
+	/*
+	 * Calculate how many renames are left (but all the source
+	 * files still remain as options for rename/copies!)
+	 */
+	num_create = (rename_dst_nr - rename_count);
+	num_src = rename_src_nr;
+
+	/* All done? */
+	if (!num_create)
+		goto cleanup;
+
 	/*
 	 * This basically does a test for the rename matrix not
 	 * growing larger than a "rename_limit" square matrix, ie:
 	 *
-	 *    rename_dst_nr * rename_src_nr > rename_limit * rename_limit
+	 *    num_create * num_src > rename_limit * rename_limit
 	 *
 	 * but handles the potential overflow case specially (and we
 	 * assume at least 32-bit integers)
 	 */
 	if (rename_limit <= 0 || rename_limit > 32767)
 		rename_limit = 32767;
-	if (rename_dst_nr > rename_limit && rename_src_nr > rename_limit)
+	if (num_create > rename_limit && num_src > rename_limit)
 		goto cleanup;
-	if (rename_dst_nr * rename_src_nr > rename_limit * rename_limit)
+	if (num_create * num_src > rename_limit * rename_limit)
 		goto cleanup;
 
-	/* Have we run out the created file pool?  If so we can avoid
-	 * doing the delta matrix altogether.
-	 */
-	if (rename_count == rename_dst_nr)
-		goto cleanup;
-
-	if (minimum_score == MAX_SCORE)
-		goto cleanup;
-
-	num_create = (rename_dst_nr - rename_count);
-	num_src = rename_src_nr;
 	mx = xmalloc(sizeof(*mx) * num_create * num_src);
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
 		int base = dst_cnt * num_src;
