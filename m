X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: [PATCH] shortlog: fix segfault on empty authorname
Date: Fri, 8 Dec 2006 23:04:21 -0500
Message-ID: <20061209040421.GA29113@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0612082205240.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 04:04:39 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612082205240.2630@xanadu.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33796>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GstRx-0003Y8-US for gcvg-git@gmane.org; Sat, 09 Dec
 2006 05:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757648AbWLIEEZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 23:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757964AbWLIEEY
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 23:04:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:49917
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S1757648AbWLIEEY (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 23:04:24 -0500
Received: (qmail 2312 invoked from network); 8 Dec 2006 23:04:23 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 8 Dec 2006 23:04:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec
 2006 23:04:22 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

The old code looked backwards from the email address to parse the name,
allowing an arbitrary number of spaces between the two. However, in the case
of no name, we looked back too far to the 'author' (or 'Author:') header.
Instead, remove at most one space between name and address.

The bug was triggered by commit febf7ea4bed from linux-2.6.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-shortlog.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index f1124e2..7a2ddfe 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -188,7 +188,7 @@ static void read_from_stdin(struct path_list *list)
 				bob = buffer + strlen(buffer);
 			else {
 				offset = 8;
-				while (isspace(bob[-1]))
+				if (isspace(bob[-1]))
 					bob--;
 			}
 
@@ -236,7 +236,7 @@ static void get_from_rev(struct rev_info *rev, struct path_list *list)
 					author = scratch;
 					authorlen = strlen(scratch);
 				} else {
-					while (bracket[-1] == ' ')
+					if (bracket[-1] == ' ')
 						bracket--;
 
 					author = buffer + 7;
-- 
1.4.4.2.g3528-dirty

On Fri, Dec 08, 2006 at 10:23:14PM -0500, Nicolas Pitre wrote:

> On the Linux kernel repository, doing "git shortlog v2.6.18.." works 
> fine. "git shortlog v2.6.17.." works fine. "git shortlog v2.6.16.." also 
> works fine.  But "git shortlog v2.6.15.." dies with a segmentation 
> fault.  Trying "git log v2.6.15.. | git shortlog" also produces the same 
> crash while "git log v2.6.16.. | git shortlog" works fine.
> 
> The old perl version doesn't have any such issue with those test cases, 
> not even with the whole kernel history.
> 
> 
> Nicolas
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
