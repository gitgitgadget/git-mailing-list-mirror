Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D162A1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 18:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440326AbfIWSHw (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 14:07:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57338 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2438123AbfIWSHw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 14:07:52 -0400
Received: (qmail 28938 invoked by uid 109); 23 Sep 2019 18:07:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Sep 2019 18:07:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27554 invoked by uid 111); 23 Sep 2019 18:10:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Sep 2019 14:10:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Sep 2019 14:07:51 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190923180751.GA21344@sigill.intra.peff.net>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 17, 2019 at 01:23:18PM +0200, Johannes Schindelin wrote:

> The only slightly challenging aspect might be that `merge-one-file` is
> actually not a merge strategy, but it is used as helper to be passed to
> `git merge-index` via the `-o <helper>` option, which makes it slightly
> awkward to be implemented as a built-in. A better approach would
> therefore be to special-case this value in `merge-index` and execute the
> C code directly, without the detour of spawning a built-in.

I think it could make sense for merge-index to be able to directly run
the merge-one-file code[1]. But I think we'd want to keep its ability to
run an arbitrary script, and for people to call merge-one-file
separately, since right now you can do:

  git merge-index my-script

and have "my-script" do some processing of its own, then hand off more
work to merge-one-file.

So the weird calling convention is actually a user-visible and
potentially useful interface. So it would need a deprecation period
before being removed.

-Peff

[1] Certainly doing it in-process would be faster for the common case of
    "git merge-index git-merge-one-file", but I wonder if anybody really
    does that. These days most people would just merge-recursive anyway.
