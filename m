Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91FD71F404
	for <e@80x24.org>; Wed, 28 Feb 2018 13:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932073AbeB1N2L (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 08:28:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:40620 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752267AbeB1N2K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 08:28:10 -0500
Received: (qmail 820 invoked by uid 109); 28 Feb 2018 13:28:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Feb 2018 13:28:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1769 invoked by uid 111); 28 Feb 2018 13:28:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Feb 2018 08:28:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Feb 2018 08:28:08 -0500
Date:   Wed, 28 Feb 2018 08:28:08 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?=22Marcel_'childNo=CD=A1=2Ede'_Trautwein=22?= 
        <c0d3+gitscm@childno.de>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] [git 2.16.1] yeeek ... my files are gone .. by git pull
 <otherRepositoryUrl>
Message-ID: <20180228132807.GA6206@sigill.intra.peff.net>
References: <741A56BF-93C0-41EA-856F-C1170803F0A7@childno.de>
 <20180222232031.GE256918@aiede.svl.corp.google.com>
 <8A26AAB4-E2E5-4681-87D4-0D6727CA423A@childno.de>
 <20180223064549.GA19791@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1802270032520.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1802270032520.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 12:33:56AM +0100, Johannes Schindelin wrote:

> > So something like this helps:
> > 
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 81c5b42875..71e6cbb388 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -921,15 +921,20 @@ else
> >  
> >  		if test -z "$rebase_root"
> >  		then
> >  			preserve=t
> > +			p=
> >  			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
> >  			do
> >  				if test -f "$rewritten"/$p
> >  				then
> >  					preserve=f
> >  				fi
> >  			done
> > +			if test -z "$p"
> > +			then
> > +				preserve=f
> > +			fi
> >  		else
> >  			preserve=f
> >  		fi
> >  		if test f = "$preserve"
> > 
> > Because it at least adds "two" to the list of commits to pick. But
> > oddly, it picks it directly as a root commit again. Whereas a rebase
> > without --preserve-merges (and even "-i") picks it on top of commit
> > "one" (which is what I'd expect).
> > 
> > +cc Dscho, as the --preserve-merges guru.
> 
> Your analysis makes sense to me. Please note, though, that I would not
> consider myself a guru on preserve-merges. I think this mode is broken by
> design (you can blame me if you want).

I think that is doing the right thing for half of the problem. But
there's something else funny where we do not include the "upstream"
commits from the split history (i.e., we rebase onto nothing,
whereas a normal "git rebase" with a split history will graft the two
together).

I haven't figured that part out. But I do kind of wonder if we should
simply punt early and say "what you're doing is crazy and unsupported".
After all, the only known case of this was somebody doing it
accidentally.

-Peff
