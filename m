Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D47AF1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 19:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfG3TpQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 15:45:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:55762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725911AbfG3TpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 15:45:16 -0400
Received: (qmail 7333 invoked by uid 109); 30 Jul 2019 19:45:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Jul 2019 19:45:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10105 invoked by uid 111); 30 Jul 2019 19:46:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2019 15:46:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jul 2019 15:45:15 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Message-ID: <20190730194515.GA1088@sigill.intra.peff.net>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 01:08:37PM -0400, Randall S. Becker wrote:

> t0016: oidmap
> 
> Subtest 6 had an ordering issue. We do not know whether the problem is the code or the test result not keeping up with the code changes.
> --- expect      2019-07-30 16:56:36 +0000
> +++ actual      2019-07-30 16:56:36 +0000
> @@ -1,6 +1,6 @@
>  NULL
>  NULL
>  NULL
> +7c7cd714e262561f73f3079dfca4e8724682ac21 3
>  139b20d8e6c5b496de61f033f642d0e3dbff528d 2
>  d79ce1670bdcb76e6d1da2ae095e890ccb326ae9 1
> -7c7cd714e262561f73f3079dfca4e8724682ac21 3

This one is very curious. It's iterating a hash, which _seems_ like it
would produce non-deterministic output. But neither this test nor the
hashmap test it is based on sorts the output, and they pass consistently
for me. I assume that's because while hash ordering is not guaranteed,
it happens to be the same as long the pattern of inserts is the same
(with our implementation, which does not do any hash randomization).

But I am scratching my head as to what could be different on your
platform that would cause a different ordering (especially when the
hashmap test this is based on doesn't get one!).

I guess in some sense it may not be worth tracking down, and we should
just sort the output of a hash iteration unconditionally when comparing
it to expected output.

-Peff
