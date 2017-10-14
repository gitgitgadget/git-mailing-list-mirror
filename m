Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F4901FF32
	for <e@80x24.org>; Sat, 14 Oct 2017 18:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbdJNSGD (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Oct 2017 14:06:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:52836 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750970AbdJNSGC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Oct 2017 14:06:02 -0400
Received: (qmail 31538 invoked by uid 109); 14 Oct 2017 18:05:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 14 Oct 2017 18:05:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1011 invoked by uid 111); 14 Oct 2017 18:05:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 14 Oct 2017 14:05:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Oct 2017 14:05:50 -0400
Date:   Sat, 14 Oct 2017 14:05:50 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     =?utf-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>,
        git@vger.kernel.org
Subject: Re: Can I remove multiple stashed states at a time?
Message-ID: <20171014180549.q35km6t44pkpwzdh@sigill.intra.peff.net>
References: <CAC2JkrLm3QCNW1t-Yju-sA=9Tbv8hH1AHZUEDux8kSG9mkG5wg@mail.gmail.com>
 <20171013173522.vprwjwprhnoiyajy@sigill.intra.peff.net>
 <20171014150123.GA28038@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171014150123.GA28038@alpha.vpn.ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 14, 2017 at 05:01:23PM +0200, Kevin Daudt wrote:

> On Fri, Oct 13, 2017 at 01:35:22PM -0400, Jeff King wrote:
> > On Fri, Oct 13, 2017 at 11:58:12AM +0900, 小川恭史 wrote:
> > 
> > You can also just do:
> > 
> >   for i in 1 2 3; do
> >      git stash drop $i
> >   done
> > 
> 
> Doesn't stash 2 become stash 1 after the first drop, and the same for 3,
> resulting in dropping stash 1, 3 and 5?
> 
> So something like
> 
>   for i in 3 2 1; do
>       git stash drop $i;
>   done
> 
> Or leave $i out altogether.

Oops, you're right.

For that matter, I didn't double check that a single "reflog delete"
handles this case correctly. That should be easy to test, though:

  git init
  echo base >file
  git add file
  git commit -m base

  for i in $(seq 10); do
    echo $i >file
    git stash push -m $i
  done

  git reflog delete --updateref --rewrite refs/stash@{1} refs/stash@{2} refs/stash@{3}

That seems to leave:

  $ git stash list
  stash@{0}: On master: 10
  stash@{1}: On master: 8
  stash@{2}: On master: 6
  stash@{3}: On master: 4
  stash@{4}: On master: 3
  stash@{5}: On master: 2
  stash@{6}: On master: 1

which is not what we wanted (I'd guess also that it rewrites the reflog
3 times, negating any efficiency I claimed earlier).

-Peff
