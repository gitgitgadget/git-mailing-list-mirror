From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add test that checks diverse aspects of updating remote
	and tracking branches
Date: Thu, 15 Nov 2007 21:46:11 +0100
Message-ID: <20071115204611.GB3552@steel.home>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home> <20071113075240.GA21799@sigill.intra.peff.net> <20071113194731.GC3268@steel.home> <20071113194909.GD3268@steel.home> <20071113230234.GI3268@steel.home> <20071113231048.GB19444@sigill.intra.peff.net> <20071115042625.GA10094@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 21:46:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Islbd-0007wJ-Ai
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 21:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761056AbXKOUqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 15:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760336AbXKOUqP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 15:46:15 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:57723 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757249AbXKOUqO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 15:46:14 -0500
Received: from tigra.home (Fcbc7.f.strato-dslnet.de [195.4.203.199])
	by post.webmailer.de (fruni mo57) (RZmta 14.0)
	with ESMTP id w02251jAFIOttP ; Thu, 15 Nov 2007 21:46:11 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 98F9B277AE;
	Thu, 15 Nov 2007 21:46:11 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 3435F56D22; Thu, 15 Nov 2007 21:46:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071115042625.GA10094@sigill.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsKmZA=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65158>

Because we haven't settled on what the exit status from
"git push" command itself should be in such a partial
failure case, do not check the exit status from it for
now.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Jeff King, Thu, Nov 15, 2007 05:26:26 +0100:
> On Tue, Nov 13, 2007 at 06:10:48PM -0500, Jeff King wrote:
> 
> > > This one is on top of what is in next. It also include the check for
> > > deleting remote braches I sent before. Regarding this one: if a remote
> > > branch is deleted, shouldn't the matching tracking branch be removed
> > > as well? The code in master seem to do that.
> > 
> > Yes, it should (the code in update_tracking_ref seems to handle that
> > case, but I haven't tested, so I may have bungled something). I am
> > literally walking out the door, now, though, so I will be out of touch
> > for at least a day.
> 
> After I became disconnected, I looked at my 'next', and the reason for
> the failure to delete the ref seems to be your is_null_sha1
> error-checking patch, which Junio put in next. But maybe you have
> figured that out in the intervening time. :)

I didn't. But Junio already has all your patches in pu, so I activated
the deletion test and rebased it on top of your patches in his tree
(jk/send-pack, according to merge commit). Tried: works.

 t/t5404-tracking-branches.sh |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index 20718d4..a6f60ac 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -10,6 +10,7 @@ test_expect_success 'setup' '
 	git commit -m 1 &&
 	git branch b1 &&
 	git branch b2 &&
+	git branch b3 &&
 	git clone . aa &&
 	git checkout b1 &&
 	echo b1 >>file &&
@@ -19,10 +20,13 @@ test_expect_success 'setup' '
 	git commit -a -m b2
 '
 
+start_dir="$(pwd)"
+
 test_expect_success 'check tracking branches updated correctly after push' '
 	cd aa &&
 	b1=$(git rev-parse origin/b1) &&
 	b2=$(git rev-parse origin/b2) &&
+	b3=$(git rev-parse origin/b3) &&
 	git checkout -b b1 origin/b1 &&
 	echo aa-b1 >>file &&
 	git commit -a -m aa-b1 &&
@@ -32,9 +36,27 @@ test_expect_success 'check tracking branches updated correctly after push' '
 	git checkout master &&
 	echo aa-master >>file &&
 	git commit -a -m aa-master &&
-	git push &&
-	test "$(git rev-parse origin/b1)" = "$b1" &&
-	test "$(git rev-parse origin/b2)" = "$b2"
+	{
+		git push
+		test "$(git rev-parse origin/b1)" = "$b1" &&
+		test "$(git rev-parse origin/b2)" = "$b2" &&
+		test "$(git rev-parse origin/b3)" = "$b3" &&
+		test "$(git rev-parse origin/master)" = \
+		"$(git rev-parse master)"
+	}
+'
+
+test_expect_success 'delete remote branch' '
+	git push origin :refs/heads/b3
+	{
+		git rev-parse --verify origin/b3
+		test $? != 0
+        } &&
+	cd "$start_dir" &&
+	{
+		git rev-parse refs/heads/b3
+		test $? != 0
+        }
 '
 
 test_done
-- 
1.5.3.5.692.ge1737
