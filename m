From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RESEND PATCH 1/2] Fix builtin-fetch memory corruption by not overstepping array
Date: Fri, 14 Sep 2007 18:59:53 -0400
Message-ID: <20070914225953.GC16512@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 01:00:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWK8m-0007Of-AW
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 01:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520AbXINW75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 18:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757443AbXINW75
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:59:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50972 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757338AbXINW74 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:59:56 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWK8u-0000Sz-QP; Fri, 14 Sep 2007 19:00:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 93F3620FBAE; Fri, 14 Sep 2007 18:59:53 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58209>

A long time ago Junio added this line to always ensure that the
output array created by remove_duplicates() had a NULL as its
terminating node.  Today none of the downstream consumers of this
array care about a NULL terminator; they only pay attention to the
size of the array (as indicated by nr_heads).  In (nearly?) all
cases passing a NULL element will cause SIGSEGV failures.  So this
NULL terminal is not actually necessary.

Unfortunately we cannot continue to NULL terminate the array at
this point as the array may only have been allocated large enough
to match the input of nr_heads.  If there are no duplicates than
we would be trying to store NULL into heads[nr_heads] and that may
be outside of the array.

My recent series to cleanup builtin-fetch changed the allocation of
the heads array from 256 entries to exactly nr_heads thus ensuring
we were always overstepping the array and causing memory corruption.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 *** RESEND TO CORRECT FROM+SBO ***

 Sorry Junio.  I realized too late that the headers were wrong.
 That's what I get for not configuring ~/.gitconfig on my amd64
 Linux box.  ;-)

 builtin-fetch-pack.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index b0936cc..2977a94 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -654,7 +654,6 @@ static int remove_duplicates(int nr_heads, char **heads)
 			heads[dst] = heads[src];
 		dst++;
 	}
-	heads[dst] = 0;
 	return dst;
 }
 
-- 
1.5.3.1.921.g8c3b
