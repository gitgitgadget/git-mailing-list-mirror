From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Avoid unnecessary 'lstat()' calls in 'get_stat_data()'
Date: Sat, 9 May 2009 15:09:54 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905091501460.3586@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 10 00:13:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2unm-0000nq-JH
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 00:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbZEIWLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 18:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753263AbZEIWLH
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 18:11:07 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49200 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752560AbZEIWLF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2009 18:11:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n49M9ssi021944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 May 2009 15:10:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n49M9sHA007510;
	Sat, 9 May 2009 15:09:54 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.462 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118686>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 May 2009 14:57:30 -0700

When we ask get_stat_data() to get the mode and size of an index entry,
we can avoid the lstat() call if we have marked the index entry as being
uptodate due to earlier lstat() calls.

This avoids a lot of unnecessary lstat() calls in eg 'git checkout',
where the last phase shows the differences to the working tree
(requiring a diff), but earlier phases have already verified the index.

On the kernel repo (with a fast machine and everything cached), this 
changes timings of a nul 'git checkout' from

 - Before (best of ten):

	0.14user 0.05system 0:00.19elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+13237minor)pagefaults 0swaps

 - After 
	0.11user 0.03system 0:00.15elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+13235minor)pagefaults 0swaps

so it can obviously be noticeable, although equally obviously it's not a 
show-stopper on this particular machine. The difference is likely larger 
on slower machines, or with operating systems that don't do as good a job 
of name caching.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
I sent this as part of the "make 'git checkout' preload the index" patch, 
but since the preloading was of somewhat dubious value, and this part of 
it is not, I'll just send this one-liner as an "obvious performance fix".

 diff-lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index a310fb2..0aba6cd 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -214,7 +214,7 @@ static int get_stat_data(struct cache_entry *ce,
 	const unsigned char *sha1 = ce->sha1;
 	unsigned int mode = ce->ce_mode;
 
-	if (!cached) {
+	if (!cached && !ce_uptodate(ce)) {
 		int changed;
 		struct stat st;
 		changed = check_removed(ce, &st);
-- 
1.6.3
