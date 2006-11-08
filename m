X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Return non-zero status from pull if merge fails.
Date: Wed, 8 Nov 2006 00:52:57 -0500
Message-ID: <20061108055257.GC28498@spearce.org>
References: <20061107181053.GA26856@spearce.org> <7vy7qmzttk.fsf@assigned-by-dhcp.cox.net> <20061108051035.GA28498@spearce.org> <7vu01av6tb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 05:53:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vu01av6tb.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31120>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhgN2-0004wb-NA for gcvg-git@gmane.org; Wed, 08 Nov
 2006 06:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754327AbWKHFxE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 00:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754329AbWKHFxE
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 00:53:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:26308 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1754327AbWKHFxC
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 00:53:02 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GhgMu-0001CA-7I; Wed, 08 Nov 2006 00:53:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 209E820E487; Wed,  8 Nov 2006 00:52:58 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Yes.  Without it:
> >
> >   $ git checkout -b 931233bc666b^
> >   $ echo broken >builtin-pickaxe.c
> >   $ git pull . next && echo good merge
> >   Updating c2e525d..522da27
> >   builtin-pickaxe.c: needs update
> >   fatal: Entry 'builtin-pickaxe.c' not uptodate. Cannot merge.
> >   good merge
> >
> > Say what?  There's no way that fast forward was good!  Granted this
> > use case is horrible but that fast forward went very, very badly,
> > but the caller now thinks it was good.
> 
> I think fast forward went Ok in that "git-ls-tree HEAD" gives
> the correct merge result from pulling next on top of 931233^ (or
> whatever).

No it didn't.  After doing the pull:

	$ git rev-parse --verify HEAD
	c2e525d97f81bc178567cdf4dd7056ce6224eb58
	$ git rev-parse --verify 931233bc666b^
	c2e525d97f81bc178567cdf4dd7056ce6224eb58

so no the merge result wasn't put into HEAD.  Nothing was done.
Which is good because to do the merge the working directory has
to change but there's a conflict there due to one file being in a
modified state.  Better we don't change HEAD.

> I am undecided if we want to keep what dropsave is
> supposed to remove in that case, but exiting with non-zero to
> indicate an error condition is needed.

I think that elsewhere in git-merge we abort without calling dropsave
when things to south.  Which is why I aborted before.

-- 
