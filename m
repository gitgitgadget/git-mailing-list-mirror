X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Performance problems in diffcore rename
Date: Wed, 13 Dec 2006 22:39:26 -0500
Message-ID: <20061214033925.GA1408@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 03:39:37 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34277>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuhRW-00011I-Sv for gcvg-git@gmane.org; Thu, 14 Dec
 2006 04:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750844AbWLNDjc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 22:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWLNDjc
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 22:39:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50249 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750802AbWLNDjb (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 22:39:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuhRE-0001OQ-GC; Wed, 13 Dec 2006 22:39:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 69C6F20FB6E; Wed, 13 Dec 2006 22:39:26 -0500 (EST)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Originally I had thought I was running into an infinite loop in
git-merge-recursive while trying to merge two branches together
which have been troublesome in the past.

That's not the case.  I spent some time debugging it tonight on
the private (unpublishable) repository that is showing the problem.
What is actually occuring is one of the branches has 6735 files
added between the merge base and its tip, and the other branch
has roughly the same number.

git-merge-recursive very quickly goes down into the diffcore code to
perform rename detection, at which point we come up with 6735 files
for rename_dst_nr (in diffcore_rename) and we almost immediately
wind up with contents_too = 1, which means we are now doing full
content comparsions in is_exact_match.

What really hurts is when we go into diff_populate_filespec we
proceed to take the optimization that Junio added in 6973dcae,
which is to favor mmap'ing the working tree file over inflating
the blob from the ODB.

Except that in my case I'm running on Cygwin/Windows 2000 and almost
everything is packed.  So inflating the blob out of the ODB is a
thousand times faster than opening the working directory file and
mmap'ing it.  If I modify work_tree_matches to always return false
the merge goes through in under 3 seconds.


Running the same merge on Solaris doesn't show the problem at all,
as that OS has reasonably well performing open and mmap syscalls.


But looking at is_exact_match I'm now wondering why we bother
to open the working tree file at all here.  Its almost like
we are missing the following, as both src and dst are coming out
of tree objects and therefore their sha1's should match.


diff --git a/diffcore-rename.c b/diffcore-rename.c
index 57a74b6..29480ca 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -105,6 +105,8 @@ static int is_exact_match(struct diff_filespec *src,
 		return 1;
 	if (!contents_too)
 		return 0;
+	if (src->sha1_valid && dst->sha1_valid)
+		return 0;
 	if (diff_populate_filespec(src, 1) || diff_populate_filespec(dst, 1))
 		return 0;
 	if (src->size != dst->size)

-- 
