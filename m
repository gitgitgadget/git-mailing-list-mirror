X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/1] Bypass expensive content comparsion during rename detection.
Date: Thu, 14 Dec 2006 06:50:54 -0500
Message-ID: <20061214115054.GJ1747@spearce.org>
References: <20061214100746.GA31191@spearce.org> <Pine.LNX.4.63.0612141151220.3635@wbgn013.biozentrum.uni-wuerzburg.de> <20061214110858.GE1747@spearce.org> <Pine.LNX.4.63.0612141214440.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 11:51:08 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612141214440.3635@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34323>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gup79-0008LX-8v for gcvg-git@gmane.org; Thu, 14 Dec
 2006 12:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932636AbWLNLvA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 06:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWLNLu7
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 06:50:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36902 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932636AbWLNLu7 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 06:50:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gup6y-0000RR-BI; Thu, 14 Dec 2006 06:50:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6444A20FB65; Thu, 14 Dec 2006 06:50:54 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Thu, 14 Dec 2006, Shawn Pearce wrote:
> 
> > My first version of the patch had the hash comparsion right after we 
> > called diff_populate_filespec to get the size data.  But then I realized 
> > that very often the sizes will be different and the src->size != 
> > dst->size comparsion will tend to be true most of the time, thus saving 
> > us a (relatively) expensive hash comparsion, which we know must fail 
> > anyway if the sizes differed.
> 
> Ah! I misunderstood. Since the call to diff_populate_filespec was not 
> visible in the hunk, I erroneously assumed that you meant to _check_ the 
> sizes before checking the hashes.
> 
> But your explanation makes lots of sense to me. May I request a short 
> comment above the new code, like "let diff_populate_filespec() do its 
> thing since we need the filesize later on anyway, and having that, do the 
> cheaper filesize check before the more expensive hashcmp()"?

-- 8> --
Bypass expensive content comparsion during rename detection.

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
 diffcore-rename.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 57a74b6..f7748ce 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -109,6 +109,15 @@ static int is_exact_match(struct diff_filespec *src,
 		return 0;
 	if (src->size != dst->size)
 		return 0;
+	/* Although we can avoid a byte-by-byte comparsion by checking
+	 * hashes we needed to allow diff_populate_filespec to fill in
+	 * the size members, as we need that later on to correctly do
+	 * rename and copy detection.  Not filling in size before we
+	 * return back when contents_too is true causes all sorts of
+	 * havoc (been there, done that, lets not try it again).
+	 */
+	if (src->sha1_valid && dst->sha1_valid)
+	    return !hashcmp(src->sha1, dst->sha1);
 	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
 		return 0;
 	if (src->size == dst->size &&
-- 
1.4.4.2.g72f5
