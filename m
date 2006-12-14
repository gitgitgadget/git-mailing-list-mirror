X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Performance problems in diffcore rename
Date: Thu, 14 Dec 2006 04:11:45 -0500
Message-ID: <20061214091145.GB1747@spearce.org>
References: <20061214033925.GA1408@spearce.org> <7v7iwvatrt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 09:12:12 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v7iwvatrt.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34289>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GumdN-0004jD-OQ for gcvg-git@gmane.org; Thu, 14 Dec
 2006 10:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932110AbWLNJME (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 04:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWLNJMB
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 04:12:01 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59883 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932110AbWLNJL6 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 04:11:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gumd2-0000Dj-Kz; Thu, 14 Dec 2006 04:11:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1F5EA20FB65; Thu, 14 Dec 2006 04:11:45 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > But looking at is_exact_match I'm now wondering why we bother
> > to open the working tree file at all here.
> 
> You are right.  When we _know_ both SHA-1 can be trusted, we
> should be able to do just this, regardless of contents_too
> (whose only purpose is to delay comparing a cache dirty working
> tree file with something else):
> 
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 57a74b6..677db85 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -100,9 +100,8 @@ static int is_exact_match(struct diff_filespec *src,
>  			  struct diff_filespec *dst,
>  			  int contents_too)
>  {
> -	if (src->sha1_valid && dst->sha1_valid &&
> -	    !hashcmp(src->sha1, dst->sha1))
> -		return 1;
> +	if (src->sha1_valid && dst->sha1_valid)
> +		return !hashcmp(src->sha1, dst->sha1);
>  	if (!contents_too)
>  		return 0;
>  	if (diff_populate_filespec(src, 1) || diff_populate_filespec(dst, 1))
> 

OK, I've stared at this problem for hours.  The above patch breaks
a number of test cases (such as ./t4005-diff-rename-2.sh) as it
causes the rename/copy detection to come out differently.

It turns out the difference is not filling in the size field of
struct diff_filespec.  By bypassing that step in is_exact_match
during the second pass we are altering the outcome.

-- 
