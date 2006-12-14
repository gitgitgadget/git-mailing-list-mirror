X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/1] Bypass expensive content comparsion during rename detection.
Date: Thu, 14 Dec 2006 05:07:46 -0500
Message-ID: <20061214100746.GA31191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 10:08:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34298>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GunVM-0003ES-5p for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751838AbWLNKHx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWLNKHx
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:07:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33299 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751838AbWLNKHw (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 05:07:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GunVD-0002sC-IM; Thu, 14 Dec 2006 05:07:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 BBAB020FB65; Thu, 14 Dec 2006 05:07:46 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

When comparing file contents during the second loop through a rename
detection attempt we can skip the expensive byte-by-byte comparsion
if both source and destination files have valid SHA1 values.  This
improves performance by avoiding either an expensive open/mmap to
read the working tree copy, or an expensive inflate of a blob object.

Unfortunately we still have to at least initialize the sizes of the
source and destination files even if the SHA1 values don't match.
Failing to initialize the sizes causes a number of test cases to fail
and start reporting different copy/rename behavior than was expected.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 diffcore-rename.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 57a74b6..91fa2be 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -109,6 +109,8 @@ static int is_exact_match(struct diff_filespec *src,
 		return 0;
 	if (src->size != dst->size)
 		return 0;
+	if (src->sha1_valid && dst->sha1_valid)
+	    return !hashcmp(src->sha1, dst->sha1);
 	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
 		return 0;
 	if (src->size == dst->size &&
-- 
