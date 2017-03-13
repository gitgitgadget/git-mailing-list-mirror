Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18A71FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 15:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbdCMPN1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 11:13:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:43196 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbdCMPN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 11:13:26 -0400
Received: (qmail 14569 invoked by uid 109); 13 Mar 2017 15:13:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 15:13:25 +0000
Received: (qmail 18681 invoked by uid 111); 13 Mar 2017 15:13:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 11:13:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Mar 2017 11:13:22 -0400
Date:   Mon, 13 Mar 2017 11:13:22 -0400
From:   Jeff King <peff@peff.net>
To:     Dan Shumow <danshu@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc.stevens@cwi.nl>
Subject: Re: [PATCH] Put sha1dc on a diet
Message-ID: <20170313151322.ouryghyb5orkpk5g@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
 <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
 <CA+55aFwf3sxKW+dGTMjNAeHMOf=rvctEQohm+rbhEb=e3KLpHw@mail.gmail.com>
 <20170301203427.e5xa5ej3czli7c3o@sigill.intra.peff.net>
 <CA+55aFz4ixVKVURki8FeXjL5H51A_cQXsZpzKJ-N9n574Yy1rg@mail.gmail.com>
 <CY1PR0301MB21073D82F4A6AB0DAD8BF1FCC4280@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <xmqq1suge1jn.fsf@gitster.mtv.corp.google.com>
 <CY1PR0301MB2107112BCC2DECD215E70549C42A0@CY1PR0301MB2107.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY1PR0301MB2107112BCC2DECD215E70549C42A0@CY1PR0301MB2107.namprd03.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 04, 2017 at 01:07:16AM +0000, Dan Shumow wrote:

> You are very welcome.  Thank you for the warm welcome.  As it turns
> out, Marc and I are working on the simplifications / removal of c99
> and performance upstream in our GitHub repo.  I am happy to help for
> any GitHub specific customizations that are needed as well.  But for
> now, lets see if we can get you everything you want upstream -- I
> think that's the most simple.

I've been watching the repo at:

  https://github.com/cr-marcstevens/sha1collisiondetection

The work on the feature/performance branch seems to be producing good
results. The best timings I got show sha1dc (with checks enabled) at
1.75x block-sha1, which is pretty good. That was using your
ad744c8b7a841d2afcb2d4c04f8952d9005501be.

Curiously, the performance gets worse after that. Even more curious, the
bad performance bisects to a merge, and it performs worse than either
side of the merge.

Try this:

  # mine is a 1.2GB linux packfile, but anything big should do
  file=/some/large/file

  # the merge with the funny behavior
  merge=55d1db0980501e582f6cd103a04f493995b1df78

  for i in $merge^ $merge^2 $merge; do
    git checkout $i &&
    rm -f bin/* &&
    make &&
    time bin/sha1dcsum $file
  done

I get:

  [$merge^, the feature/performance branch before the merge]
  real	0m3.391s
  user	0m3.304s
  sys	0m0.084s

  [$merge^2, the master branch before the merge]
  real	0m5.272s
  user	0m5.164s
  sys	0m0.096s

  [$merge, the merge of the two]
  real	0m7.038s
  user	0m6.924s
  sys	0m0.104s

So that's odd. Looking at the diff, I don't see anything that obviously
jumps out as a mis-merge.

Feel free to tell me "stop looking at that branch; it's a work in
progress". But I think the results from $merge^ (ad744c8b7) are getting
good enough to consider moving forward with integrating it into git.

-Peff
