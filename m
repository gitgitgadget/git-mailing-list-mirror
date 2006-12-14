X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Performance problems in diffcore rename
Date: Wed, 13 Dec 2006 22:14:30 -0800
Message-ID: <7v7iwvatrt.fsf@assigned-by-dhcp.cox.net>
References: <20061214033925.GA1408@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 06:14:42 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061214033925.GA1408@spearce.org> (Shawn Pearce's message of
	"Wed, 13 Dec 2006 22:39:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34280>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GujrX-0004P5-CS for gcvg-git@gmane.org; Thu, 14 Dec
 2006 07:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751958AbWLNGOc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 01:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbWLNGOc
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 01:14:32 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:51002 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751958AbWLNGOb (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 01:14:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214061430.JWWC7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Thu, 14
 Dec 2006 01:14:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id yWDr1V00D1kojtg0000000; Thu, 14 Dec 2006
 01:13:52 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> But looking at is_exact_match I'm now wondering why we bother
> to open the working tree file at all here.

You are right.  When we _know_ both SHA-1 can be trusted, we
should be able to do just this, regardless of contents_too
(whose only purpose is to delay comparing a cache dirty working
tree file with something else):

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 57a74b6..677db85 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -100,9 +100,8 @@ static int is_exact_match(struct diff_filespec *src,
 			  struct diff_filespec *dst,
 			  int contents_too)
 {
-	if (src->sha1_valid && dst->sha1_valid &&
-	    !hashcmp(src->sha1, dst->sha1))
-		return 1;
+	if (src->sha1_valid && dst->sha1_valid)
+		return !hashcmp(src->sha1, dst->sha1);
 	if (!contents_too)
 		return 0;
 	if (diff_populate_filespec(src, 1) || diff_populate_filespec(dst, 1))
