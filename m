Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B728C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 10:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5720F20770
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 10:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgLAK1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:27:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:46944 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgLAK1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 05:27:16 -0500
Received: (qmail 25481 invoked by uid 109); 1 Dec 2020 10:26:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Dec 2020 10:26:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24794 invoked by uid 111); 1 Dec 2020 10:26:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 05:26:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 05:26:35 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/6] fixup! reftable: rest of library
Message-ID: <X8YaWySkyRU3DA87@coredump.intra.peff.net>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
 <58f2b0394546e8da2922adcbc38bdb6b53f2b313.1606545878.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58f2b0394546e8da2922adcbc38bdb6b53f2b313.1606545878.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 28, 2020 at 06:44:35AM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> 0-sized arrays are actually not portable.

Definitely.

>  static void test_sizes_to_segments_empty(void)
>  {
> -	uint64_t sizes[0];
> +	uint64_t sizes[1];
>  
>  	int seglen = 0;
>  	struct segment *segs =
> -		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
> +		sizes_to_segments(&seglen, sizes, 0);
>  	EXPECT(seglen == 0);
>  	reftable_free(segs);

I think passing:

  sizes_to_segments(&seglen, NULL, 0);

may make the code more obvious. Unlike system functions like memcpy(),
we can be assured of whether our functions avoid looking at a
zero-length array (and size_to_segments does follow that rule).

  This function, of course, is nonsense that real code would not do, and
  is just unit-testing sizes_to_segments. I'm not wild in general about
  having a parallel suite of C tests that does not interact with our
  usual tests, but it may be the least bad way to benefit from the
  unit-test coverage that reftable ships with. As a rule, I'd much
  rather see a tool exposing functionality to the command-line, which
  can then be driven independently. I recognize that can end up
  complicated, though.

-Peff
