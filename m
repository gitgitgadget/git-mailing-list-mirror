Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32056C433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60D521D7F
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgJNREO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:04:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:59920 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbgJNREO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 13:04:14 -0400
Received: (qmail 18015 invoked by uid 109); 14 Oct 2020 17:04:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2020 17:04:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18763 invoked by uid 111); 14 Oct 2020 17:04:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 13:04:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 13:04:13 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
Message-ID: <20201014170413.GB21687@coredump.intra.peff.net>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 07:19:44PM +0000, Elijah Newren via GitGitGadget wrote:

> Many of our test scripts have several "setup" tests.  It's a lot easier
> to say
> 
>    ./t0050-filesystem.sh --run=setup,9

I like this direction very well.

There was a small discussion recently that we might be better off
dropping test script numbers entirely, and allowing selection of script
names by word-hierarchy or regex, too. That's mostly orthogonal to what
you're doing here, but I think this is taking us in a good direction
there.

> @@ -819,9 +821,8 @@ match_test_selector_list () {
>  			*)
>  				if expr "z$selector" : "z[0-9]*[^0-9]" >/dev/null
>  				then
> -					echo "error: $title: invalid non-numeric in test" \
> -						"selector: '$orig_selector'" >&2
> -					exit 1
> +					echo "$title" | grep -q "$selector" && return
> +					continue
>  				fi

I like that you allow regexes. It's unfortunate that the skip-check
costs us a process in every test. It may not be that big a deal since we
only pay it if you use a non-numeric selector. But I wonder if there's
any reason not to use "expr" here, as well.

-Peff
