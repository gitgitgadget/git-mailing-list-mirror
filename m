X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-clone: stop dumb protocol from copying refs outside heads/ and tags/.
Date: Fri, 24 Nov 2006 19:17:05 -0800
Message-ID: <7vac2g8bbi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 03:17:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32253>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gno2U-0007Kd-8Y for gcvg-git@gmane.org; Sat, 25 Nov
 2006 04:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934508AbWKYDRJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 22:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935110AbWKYDRI
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 22:17:08 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:6132 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S934508AbWKYDRG
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 22:17:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125031706.MWVP18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 22:17:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qrHD1V01A1kojtg0000000; Fri, 24 Nov 2006
 22:17:14 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Most notably, the original code first copied refs/remotes/ that
remote side had to local, and overwrote them by mapping refs/heads/
from the remote when a dumb protocol transport was used.

This makes the clone behaviour by dumb protocol in line with the
git native and rsync transports.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is another one of those patches I've been doing recently
   after making --use-separate-remote the default.  Judging from
   my experience in the past few days, it is quite surprising
   that none of these were found and reported earlier, given
   that many people made loud noises to make separate-remote the
   default layout.  Maybe they do not eat their own dog food?  I
   honestly do not know...

 git-clone.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 9ed4135..d4ee93f 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -48,6 +48,10 @@ Perhaps git-update-server-info needs to be run there?"
 		case "$name" in
 		*^*)	continue;;
 		esac
+		case "$bare,$name" in
+		yes,* | ,heads/* | ,tags/*) ;;
+		*)	continue ;;
+		esac
 		if test -n "$use_separate_remote" &&
 		   branch_name=`expr "z$name" : 'zheads/\(.*\)'`
 		then
-- 
1.4.4.1.g61fba

