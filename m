From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6/6] Do exact rename detection regardless of rename limits
Date: Thu, 25 Oct 2007 11:24:47 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251123280.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or
 g>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:27:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7QM-0005Jq-Ob
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbXJYS1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbXJYS1E
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:27:04 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38212 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752550AbXJYS1B (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 14:27:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIOm7l019440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Oct 2007 11:24:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PIOmGu008116;
	Thu, 25 Oct 2007 11:24:48 -0700
In-Reply-To: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.221 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62351>


From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6/6] Do exact rename detection regardless of rename limits

Now that the exact rename detection is linear-time (with a very small
constant factor to boot), there is no longer any reason to limit it by
the number of files involved.

In some trivial testing, I created a repository with a directory that
had a hundred thousand files in it (all with different contents), and
then moved that directory to show the effects of renaming 100,000 files.

With the new code, that resulted in

	[torvalds@woody big-rename]$ time ~/git/git show -C | wc -l
	400006

	real    0m2.071s
	user    0m1.520s
	sys     0m0.576s

ie the code can correctly detect the hundred thousand renames in about 2
seconds (the number "400006" comes from four lines for each rename:

	diff --git a/really-big-dir/file-1-1-1-1-1 b/moved-big-dir/file-1-1-1-1-1
	similarity index 100%
	rename from really-big-dir/file-1-1-1-1-1
	rename to moved-big-dir/file-1-1-1-1-1

and the extra six lines is from a one-liner commit message and all the
commit information and spacing).

Most of those two seconds weren't even really the rename detection, it's
really all the other stuff needed to get there.

With the old code, this wouldn't have been practically possible.  Doing
a pairwise check of the ten billion possible pairs would have been
prohibitively expensive.  In fact, even with the rename limiter in
place, the old code would waste a lot of time just on the diff_filespec
checks, and despite not even trying to find renames, it used to look
like:

	[torvalds@woody big-rename]$ time git show -C | wc -l
	1400006

	real    0m12.337s
	user    0m12.285s
	sys     0m0.192s

ie we used to take 12 seconds for this load and not even do any rename
detection! (The number 1400006 comes from fourteen lines per file moved:
seven lines each for the delete and the create of a one-liner file, and
the same extra six lines of commit information).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This obviously just moves the rename detection call. It made sense as a 
separate patch largely because of the explanation that goes along with it, 
but it conceptually is very different from actually improving the rename 
detection logic itself. So it got a patch of its own.

 diffcore-rename.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index e7e370b..3946932 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -429,6 +429,12 @@ void diffcore_rename(struct diff_options *options)
 		goto cleanup; /* nothing to do */
 
 	/*
+	 * We really want to cull the candidates list early
+	 * with cheap tests in order to avoid doing deltas.
+	 */
+	rename_count = find_exact_renames();
+
+	/*
 	 * This basically does a test for the rename matrix not
 	 * growing larger than a "rename_limit" square matrix, ie:
 	 *
@@ -444,12 +450,6 @@ void diffcore_rename(struct diff_options *options)
 	if (rename_dst_nr * rename_src_nr > rename_limit * rename_limit)
 		goto cleanup;
 
-	/*
-	 * We really want to cull the candidates list early
-	 * with cheap tests in order to avoid doing deltas.
-	 */
-	rename_count = find_exact_renames();
-
 	/* Have we run out the created file pool?  If so we can avoid
 	 * doing the delta matrix altogether.
 	 */
-- 
1.5.3.4.330.g1dec6
