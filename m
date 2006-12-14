X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/1] Bypass expensive content comparsion during rename detection.
Date: Thu, 14 Dec 2006 06:08:58 -0500
Message-ID: <20061214110858.GE1747@spearce.org>
References: <20061214100746.GA31191@spearce.org> <Pine.LNX.4.63.0612141151220.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 11:09:41 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612141151220.3635@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34313>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuoT3-000374-Qu for gcvg-git@gmane.org; Thu, 14 Dec
 2006 12:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932281AbWLNLJe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 06:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWLNLJe
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 06:09:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35352 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932281AbWLNLJd (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 06:09:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuoSf-0005xJ-Hv; Thu, 14 Dec 2006 06:09:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 CBE3820FB65; Thu, 14 Dec 2006 06:08:58 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 14 Dec 2006, Shawn O. Pearce wrote:
> > Unfortunately we still have to at least initialize the sizes of the 
> > source and destination files even if the SHA1 values don't match. 
> > Failing to initialize the sizes causes a number of test cases to fail 
> > and start reporting different copy/rename behavior than was expected.
> 
> It has a wrong feel to it when you say we have to check the sizes first. 
> After all, we are heavily relying on the hashes being different, including 
> the case when the sizes are different. So, the order of the checks should 
> _not_ matter. I suspect that somewhere sha1_valid should be set to 0, but 
> isn't.

Yes.  :-)

I'll admit, I don't understand the diffcore rename code very well
so I'm treading around in code that I'm not used to.  I'm not sure
why the size member of diff_filespec needs to be initialized to get
rename and copy detection to work properly, but it apparently does.


My first version of the patch had the hash comparsion right after
we called diff_populate_filespec to get the size data.  But then
I realized that very often the sizes will be different and the
src->size != dst->size comparsion will tend to be true most of
the time, thus saving us a (relatively) expensive hash comparsion,
which we know must fail anyway if the sizes differed.

-- 
