From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Wrong damage counting in diffcore_count_changes?
Date: Fri, 4 Dec 2009 12:07:47 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912041200120.24579@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 21:08:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGeS3-0004pc-NI
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 21:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230AbZLDUIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 15:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757221AbZLDUIQ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 15:08:16 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49117 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754455AbZLDUIP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2009 15:08:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id nB4K7mfw010895
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Dec 2009 12:07:49 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id nB4K7l6l012546;
	Fri, 4 Dec 2009 12:07:47 -0800
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.458 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134568>


Ok, so I had somebody actually ask me about '--dirstat', and as a result I 
ended up looking at how well the numbers it calculates really reflect the 
damage done to a file.

And to my horror, it doesn't necessarily reflect the damage well at all!

Now, dirstat just takes the same damage numbers that git uses to estimate 
similarity for renames, so if dirstat gets odd numbers, then that implies 
that file similarity will also be somewhat odd.

So looking at _why_ the dirstat numbers were odd, I came up with this 
patch that seems to make much sense. What used to happen is that 
diffcore_count_changes() simply ignored any hashes in the destination that 
didn't match hashes in the source. EXCEPT if the source hash didn't exist 
at all, in which case it would count _one_ destination hash that happened 
to have the "next" hash value. 

This changes it so that

 - whenever it bypasses a destination hash (because it doesn't match a 
   source), it counts the bytes associated with that as "literal added"

 - at the end (once we have used up all the source hashes), we do the same 
   thing with the remaining destination hashes.

 - when hashes do match, and we use the difference in counts as a value, 
   we also use up that destination hash entry (the 'd++'

This _seems_ to make --dirstat output more sensible, and I'd hope that 
that in turn should mean that file rename detection should also be more 
sensible. But I haven't actually verified it in any way. Maybe I just 
screwed up file rename detection entirely.

Did I miss something?

		Linus
---
 diffcore-delta.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index e670f85..7cf431d 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -201,10 +201,15 @@ int diffcore_count_changes(struct diff_filespec *src,
 		while (d->cnt) {
 			if (d->hashval >= s->hashval)
 				break;
+			la += d->cnt;
 			d++;
 		}
 		src_cnt = s->cnt;
-		dst_cnt = d->hashval == s->hashval ? d->cnt : 0;
+		dst_cnt = 0;
+		if (d->cnt && d->hashval == s->hashval) {
+			dst_cnt = d->cnt;
+			d++;
+		}
 		if (src_cnt < dst_cnt) {
 			la += dst_cnt - src_cnt;
 			sc += src_cnt;
@@ -213,6 +218,10 @@ int diffcore_count_changes(struct diff_filespec *src,
 			sc += dst_cnt;
 		s++;
 	}
+	while (d->cnt) {
+		la += d->cnt;
+		d++;
+	}
 
 	if (!src_count_p)
 		free(src_count);
