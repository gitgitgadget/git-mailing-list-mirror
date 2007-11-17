From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/3] send-pack: track errors for each ref
Date: Sat, 17 Nov 2007 14:34:44 +0100
Message-ID: <20071117133444.GB2716@steel.home>
References: <20071117125323.GA23125@sigill.intra.peff.net> <20071117125426.GA23186@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 14:35:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItNpA-0005wp-H7
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 14:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbXKQNes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 08:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbXKQNes
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 08:34:48 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:30497 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbXKQNer (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 08:34:47 -0500
Received: from tigra.home (Fcbd3.f.strato-dslnet.de [195.4.203.211])
	by post.webmailer.de (mrclete mo1) (RZmta 14.0)
	with ESMTP id e02664jAHA40M5 ; Sat, 17 Nov 2007 14:34:44 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B8645277AE;
	Sat, 17 Nov 2007 14:34:44 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 92A0A56D22; Sat, 17 Nov 2007 14:34:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071117125426.GA23186@sigill.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg+Ffo=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65277>

Jeff King, Sat, Nov 17, 2007 13:54:27 +0100:
> Instead of keeping the 'ret' variable, we instead have a
> status flag for each ref that tracks what happened to it.
> We then print the ref status after all of the refs have
> been examined.
> 
> This paves the way for three improvements:
>   - updating tracking refs only for non-error refs
>   - incorporating remote rejection into the printed status
>   - printing errors in a different order than we processed
>     (e.g., consolidating non-ff errors near the end with
>     a special message)
> 
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Alex Riesen <raa.lkml@gmail.com>

Still would like to see the deletion of tracing branches checked.
Like this perhaps?

diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index 799e47e..4fe4a07 100755
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
@@ -23,6 +24,7 @@ test_expect_success 'prepare pushable branches' '
 	cd aa &&
 	b1=$(git rev-parse origin/b1) &&
 	b2=$(git rev-parse origin/b2) &&
+	b3=$(git rev-parse origin/b3) &&
 	git checkout -b b1 origin/b1 &&
 	echo aa-b1 >>file &&
 	git commit -a -m aa-b1 &&
@@ -45,4 +47,12 @@ test_expect_success 'check tracking branches not updated for failed refs' '
 	test "$(git rev-parse origin/b2)" = "$b2"
 '
 
+test_expect_success 'delete remote branch' '
+	git push origin :refs/heads/b3 &&
+	{
+		git rev-parse --verify origin/b3
+		test $? != 0
+        }
+'
+
 test_done
-- 
1.5.3.5.747.gf06543
