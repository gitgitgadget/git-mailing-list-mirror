Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A581CC3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4BC20714
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 17:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCWRc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:32:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:48100 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727257AbgCWRc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 13:32:59 -0400
Received: (qmail 9262 invoked by uid 109); 23 Mar 2020 17:32:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Mar 2020 17:32:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11698 invoked by uid 111); 23 Mar 2020 17:42:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2020 13:42:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Mar 2020 13:32:58 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] tests(gpg): increase verbosity to allow debugging
Message-ID: <20200323173258.GA3977@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <dd26cb05a37a54d9d245823772d33fe0daab8ffa.1584968990.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd26cb05a37a54d9d245823772d33fe0daab8ffa.1584968990.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 01:09:50PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Especially when debugging a test failure that can only be reproduced in
> the CI build (e.g. when the developer has no access to a macOS machine
> other than running the tests on a macOS build agent), output should not
> be suppressed.
> 
> In the instance of `hi/gpg-prefer-check-signature`, where one
> GPG-related test failed for no apparent reason, the entire output of
> `gpg` and `gpgsm` was suppressed, even in verbose mode, leaving
> interested readers no clue what was going wrong.
> 
> Let's fix this by redirecting the output not to `/dev/null`, but to the
> file descriptors that may, or may not, be redirected via
> `--verbose-log`. For good measure, also turn on tracing if the user
> asked for it, and prefix it with a helpful info message.

It definitely makes sense for this info to be shown in verbose (and
"-x") mode. I'm OK with this patch as easiest way to get from A to B,
but I think the existing code shows a bit of an anti-pattern: trying to
do too much outside of test blocks where verbosity and tracing is
already handled.

In this case if the whole thing were in a "test_lazy_prereq" we would
have gotten all that for free. I don't think the laziness would matter
too much in practice, though it is a little funny that it has side
effects (like setting up $GPGHOME). Having an immediate version like
"test_check_prereq" would make sense to me.

I don't know if it's worth re-doing this patch (I'll leave that decision
to you). But something to keep in mind when we run into similar
situations (or are writing new prereq code).

-Peff
