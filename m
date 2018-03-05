Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A691F404
	for <e@80x24.org>; Mon,  5 Mar 2018 15:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932084AbeCEPqe (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 10:46:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:47334 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751977AbeCEPqb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 10:46:31 -0500
Received: (qmail 5264 invoked by uid 109); 5 Mar 2018 15:46:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Mar 2018 15:46:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25918 invoked by uid 111); 5 Mar 2018 15:47:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Mar 2018 10:47:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Mar 2018 16:46:26 +0100
Date:   Mon, 5 Mar 2018 16:46:26 +0100
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?=22Marcel_'childNo=CD=A1=2Ede'_Trautwein=22?= 
        <c0d3+gitscm@childno.de>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] [git 2.16.1] yeeek ... my files are gone .. by git pull
 <otherRepositoryUrl>
Message-ID: <20180305154626.GA26740@sigill.intra.peff.net>
References: <741A56BF-93C0-41EA-856F-C1170803F0A7@childno.de>
 <20180222232031.GE256918@aiede.svl.corp.google.com>
 <8A26AAB4-E2E5-4681-87D4-0D6727CA423A@childno.de>
 <20180223064549.GA19791@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1802270032520.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180228132807.GA6206@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803051546200.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1803051546200.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 05, 2018 at 03:49:13PM +0100, Johannes Schindelin wrote:

> > I think that is doing the right thing for half of the problem. But
> > there's something else funny where we do not include the "upstream"
> > commits from the split history (i.e., we rebase onto nothing,
> > whereas a normal "git rebase" with a split history will graft the two
> > together).
> 
> Let me ask to make sure I am understanding you correctly. Are you
> referring to "split history" as the case where the commit graph has *two*
> root commits?

Yes, I mean two root commits. But especially when one is in the history
to be rebased, and the other is in the "upstream" history.

So as a concrete example, if I have this repo:

  git init
  >one && git add one && git commit -m one
  git checkout --orphan other
  git mv one two && git commit -m two

and I do this:

  git rebase master

I end up with a two-commit history, with "two" on top of "one". That
makes sense to me. Similarly if I instead do:

  git rebase -i master

the todo list has "pick two", and if I leave it as-is then I get the
same history. But if I do:

  git rebase --preserve-merges master

I end up with a single-commit history, with only commit "one". That's
wrong, because it threw away the history on the "other" branch.

If I apply the patch I showed earlier, then I get a single-branch
history, but this time it contains only "two". That also seems wrong,
because we didn't build on top of "master". I'd expect this command to
give the same results as a non-merge-preserving rebase.

Does that make more sense?

-Peff
