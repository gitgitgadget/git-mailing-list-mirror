X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 18:29:36 -0500
Message-ID: <20061214232936.GH26202@spearce.org>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se> <Pine.LNX.4.63.0612141513130.3635@wbgn013.biozentrum.uni-wuerzburg.de> <4581685D.1070407@op5.se> <C287764F-6755-4291-A87A-3E8816E90B49@adacore.com> <20061214194636.GO1747@spearce.org> <Pine.LNX.4.63.0612150013390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 23:29:51 +0000 (UTC)
Cc: Geert Bosch <bosch@adacore.com>, Andreas Ericsson <ae@op5.se>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612150013390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34437>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv01L-0001Wj-15 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751917AbWLNX3o (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWLNX3o
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:29:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42005 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751917AbWLNX3n (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 18:29:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gv012-0000mz-LG; Thu, 14 Dec 2006 18:29:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0C9A520FB65; Thu, 14 Dec 2006 18:29:37 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 14 Dec 2006, Shawn Pearce wrote:
> > Geert Bosch <bosch@adacore.com> wrote:
> > >    if (compressed_size > expanded_size / 4 * 3 + 1024) {
> > >      /* don't try to deltify if blob doesn't compress well */
> > >      return ...;
> > >    }
> > 
> > And yet I get good delta compression on a number of ZIP formatted files 
> > which don't get good additional zlib compression (<3%). Doing the above 
> > would cause those packfiles to explode to about 10x their current size.
> 
> A pity. Geert's proposition sounded good to me.
> 
> However, there's got to be a way to cut short the search for a delta 
> base/deltification when a certain (maybe even configurable) amount of time 
> has been spent on it.

I'm not sure time is the best rule there.

Maybe if the object is large (e.g. over 512 KiB or some configured
limit) and did not compress well when we last deflated it
(e.g. Geert's rule above) then only try to delta it against another
object whose hinted filename is very close/exactly matches and
whose size is very close, and don't make nearly as many attempts
on the matching hunks within any two files if the file appears to
be binary and not text.

I'm OK with a small increase in packfile size as a result of slightly
less optimal delta base selection on the really large binary files
due to something like the above, but 10x is insane.

-- 
