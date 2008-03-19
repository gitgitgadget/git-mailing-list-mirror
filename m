From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 14:52:14 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803191444490.3020@woody.linux-foundation.org>
References: <20080318180118.GC17940@kernel.dk> <7vd4pq2ymo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Axboe <jens.axboe@oracle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:54:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6F8-00083h-NP
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934157AbYCSVxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933662AbYCSVxJ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:53:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58809 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934119AbYCSVxE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2008 17:53:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2JLqFWQ020511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Mar 2008 14:52:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2JLqEu7005561;
	Wed, 19 Mar 2008 14:52:15 -0700
In-Reply-To: <7vd4pq2ymo.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.284 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77564>



On Wed, 19 Mar 2008, Junio C Hamano wrote:
> 
> Having said that, I am not sure how the auto gc is triggering for your
> (presumably reasonably well maintained) repository that has only small
> number of loose objects.  I haven't seen auto-gc annoyance myself (and
> git.git is not the only project I have my git experience with), and Linus
> also said he hasn't seen breakages.

I think it was 'autopacklimit'.

I think the correct solution is along the following lines:

 - disable "git gc --auto" entirely when "gc.auto <= 0" (ie we don't even 
   care about 'autopacklimit' unless automatic packing is on at all)

   Rationale: I do think that if you set gc.auto to zero, you should 
   expect git gc --auto to be disabled.

 - make the default for autopacklimit rather higher (pick number at 
   random: 50 instead of 20).

   Rationale: the reason for "git gc --auto" wasn't to keep things 
   perfectly packed, but to avoid the _really_ bad cases. The old default 
   of 20 may be fine if you want to always keep the repo very tight, but 
   that wasn't why "git gc --auto" was done, was it?

Suggested patch appended. Comments?

		Linus
---
 builtin-gc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 95917d7..16a912a 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -25,7 +25,7 @@ static const char * const builtin_gc_usage[] = {
 static int pack_refs = 1;
 static int aggressive_window = -1;
 static int gc_auto_threshold = 6700;
-static int gc_auto_pack_limit = 20;
+static int gc_auto_pack_limit = 50;
 static char *prune_expire = "2.weeks.ago";
 
 #define MAX_ADD 10
@@ -163,7 +163,7 @@ static int need_to_gc(void)
 	 * Setting gc.auto and gc.autopacklimit to 0 or negative can
 	 * disable the automatic gc.
 	 */
-	if (gc_auto_threshold <= 0 && gc_auto_pack_limit <= 0)
+	if (gc_auto_threshold <= 0)
 		return 0;
 
 	/*
