Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A261F597
	for <e@80x24.org>; Wed, 25 Jul 2018 18:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeGYTx7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 15:53:59 -0400
Received: from mout.web.de ([212.227.15.3]:56607 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbeGYTx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 15:53:58 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkhUq-1gIYPp0UKq-00aUcX; Wed, 25
 Jul 2018 20:41:01 +0200
Date:   Wed, 25 Jul 2018 20:41:00 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] pass st.st_size as hint for strbuf_readlink()
Message-ID: <20180725184100.GA30961@tor.lan>
References: <20180724104852.GA14638@sigill.intra.peff.net>
 <20180724105139.GE17165@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724105139.GE17165@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:uLTBxjhx6EJdKIjTqacwnnWwKtzk4fYduwouzhhKY2jkH/Ie88l
 xz7eMne6460hnYz1654iGASD6agHGhKgkf3bWe7/kGb0t9LoN2mLPOeQb1BThSdTfnk2hxY
 5H6fLjKPAYtYch6HaRUqUKhffG6jqj2ixWK/ePXgeuym4VDescv9UbhBrYnt/8RclQtYlvR
 Wa+WnazL7NwZdar8CHAPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jNv/hlIIuoo=:LnsFf2kbfE/40YfGYrEfBe
 eSKWuC34XuTOxSDgPM4CVFNS1VGp3fKZaOX0gi9N3KCUQEpPm3UA4N8PQl6/JaxKMbbFdCiyx
 gRHFmuJvYpoxQQP7Yrcl21W4cuzmVJlW82CrqYrnlYRWIQkjO3gzFnSRmGyvJGBe9LFAlHGT2
 9647IB/+wS9gMFPRGelwTU3TS5hZMFvCxoDT7cinhbPZPDXp6S7WLYLhLrfDotq7xllDFtu6p
 lz3MDb3L2zLDhrDSh06uXEFCMMb564WDQ5083SvV+vFOjpAUlAcYZ+MQI0U+uV0q67FM2suyU
 Dk9RXaeukDF6vUzsXrNqsL+aNlwTc+0oZpMiFXO55YQoK6P1aDUYSajq7OkwYMYQXUurFllZ4
 tFIjFh1zmlYlRPSLuIxcedjUL+hctTgmQXHFvtEyYig8HnZwQJ2TBQIjx2DHV9ft4al1xI0MB
 0nwe6hxLSDE+dd0UivpyTyCscWJSxHR29/ZtX6TDZannQpC+OR9OwCABCMxPMJjvw2hHw5SGX
 FZEPmm0042UZt86buSAKzkSM71mzT7NBgDFg3HGKEphhRztryLowJ4Lq8sTrgxWm9QAhX6i9i
 4cNSJWq7XzmerVUmrsfQnUstp7EHmMy2sLJCtilcwpJClB2TAwHvYn7uUlytyGVINWBB7Zgat
 7+VoPzAuxuUkcHPLkLvxaLQOhXbZCiPoyrUPoWWrRmXikak6UgqGSSolod6xxvVX1lsTtN43z
 dtFS8eJSoGrl2qdZvcmWb/yRXAldJgLJxathAbwWzS9rmjZQHcus9oxEpLY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 06:51:39AM -0400, Jeff King wrote:
> When we initially added the strbuf_readlink() function in
> b11b7e13f4 (Add generic 'strbuf_readlink()' helper function,
> 2008-12-17), the point was that we generally have a _guess_
> as to the correct size based on the stat information, but we
> can't necessarily trust it.
> 
> Over the years, a few callers have grown up that simply pass
> in 0, even though they have the stat information. Let's have
> them pass in their hint for consistency (and in theory
> efficiency, since it may avoid an extra resize/syscall loop,
> but neither location is probably performance critical).
> 
> Note that st.st_size is actually an off_t, so in theory we
> need xsize_t() here. But none of the other callsites use it,
> and since this is just a hint, it doesn't matter either way
> (if we wrap we'll simply start with a too-small hint and
> then eventually complain when we cannot allocate the
> memory).

Thanks a lot for the series.

 For the last paragraph I would actually vote the other way around -
 how about something like this ?
 Note that st.st_size is actually an off_t, so we should use
 xsize_t() here. In pratise we don't expect links to be large like that,
 but let's give a good example in the source code and use xsize_t()
 whenever an off_t is converted into size_t.
 This will make live easier whenever someones diggs into 32/64 bit
 "conversion safetyness"

