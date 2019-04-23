Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8192037F
	for <e@80x24.org>; Tue, 23 Apr 2019 03:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfDWDC4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 23:02:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:37644 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728527AbfDWDC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 23:02:56 -0400
Received: (qmail 15590 invoked by uid 109); 23 Apr 2019 03:02:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Apr 2019 03:02:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5302 invoked by uid 111); 23 Apr 2019 03:03:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 23:03:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 23:02:54 -0400
Date:   Mon, 22 Apr 2019 23:02:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: do people find t5504.8 flaky?
Message-ID: <20190423030254.GA19604@sigill.intra.peff.net>
References: <xmqqmukh5tj6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmukh5tj6.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 23, 2019 at 11:45:17AM +0900, Junio C Hamano wrote:

> I have been seeing occasional failures of t5504-fetch-receive-strict
> test on the cc/replace-graft-peel-tags topic, but it seems that the
> fork point of that topic from the mainline already fails the same
> step #8, only less frequently.
> 
> The push is rejected as expected, but the remote side that receives
> the "push" fails and the local side does not leave an expected
> output we expect when the test fails.

No, I haven't seen it fail, nor does running with --stress turn up
anything. But looking at the test I would not be at all surprised if we
have races around error hangups. I believe that index-pack will die
unceremoniously as soon as something fails to pass its fsck check.

The client will keep sending data, and may hit a SIGPIPE (or the network
equivalent), depending on how much slack there is in the buffers,
whether we hit the problem as a base object or after we receive
everything and start resolving deltas, etc.

I think after seeing a fatal error we probably ought to consider pumping
the rest of the bytes from the client to /dev/null. That's wasteful, but
it's the only clean way to get a message back, I think. It would also
give us the opportunity to complain about other objects, too, if there
are multiple (it might make sense to abort before resolving deltas,
though; at that point we have all of the data and that phase is very CPU
intensive).

-Peff
