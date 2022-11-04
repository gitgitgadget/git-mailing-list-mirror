Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2614C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiKDNAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiKDNA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:00:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0947B2E6BA
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:00:26 -0700 (PDT)
Received: (qmail 18921 invoked by uid 109); 4 Nov 2022 13:00:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Nov 2022 13:00:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29791 invoked by uid 111); 4 Nov 2022 13:00:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Nov 2022 09:00:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Nov 2022 09:00:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] bisect--helper: parse subcommand with OPT_SUBCOMMAND
Message-ID: <Y2UM6S+QUFkhz5d4@coredump.intra.peff.net>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover.1667561761.git.congdanhqx@gmail.com>
 <76c585d22bf415e719762fcf5decf4b71efa5bfb.1667561761.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76c585d22bf415e719762fcf5decf4b71efa5bfb.1667561761.git.congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 06:40:12PM +0700, Đoàn Trần Công Danh wrote:

> As of it is, we're parsing subcommand with OPT_CMDMODE, which will
> continue to parse more options even if the command has been found.
> 
> When we're running "git bisect run" with a command that expecting
> a "--log" or "--no-log" arguments, or one of those "--bisect-..."
> arguments, bisect--helper may mistakenly think those options are
> bisect--helper's option.

Right.

> We may fix those problems by passing "--" when calling from
> git-bisect.sh, and skip that "--" in bisect--helper. However, it may
> interfere with user's "--".

I think it won't interfere. A user can't put "--" as a separator now; it
gets taken as part of the command. So if we consistently added one in
the caller and stripped it away in bisect--helper, that would work
correctly (and if the user did have one later in their command, it would
be preserved as it is now).

That said, I do think your solution is nicer, and is potentially fixing
similar problems in other subcommand modes, too.

> Let's parse subcommand with OPT_SUBCOMMAND since that API was born for
> this specific use-case.

The implication here being that OPT_SUBCOMMAND stops parsing as soon as
it hits a subcommand, I assume.

>  builtin/bisect--helper.c    | 86 +++++++------------------------------
>  git-bisect.sh               | 20 ++++-----

The patch here looks sensible, but...

> +# We want to make sure --log is not eaten
> +test_expect_success '"git bisect run" simple case' '
> +	git bisect start &&
> +	git bisect good $HASH1 &&
> +	git bisect bad $HASH4 &&
> +	git bisect run printf "%s\n" --log >my_bisect_log.txt &&
> +	grep -e --log my_bisect_log.txt &&
> +	git bisect reset
> +'

...since you removed --log in the first commit, I think this would pass
even before this patch. You'd need to use another option like
--bisect-reset to show the problem. Of course then it is trivial that
the patch fixes it, since "--bisect-reset" becomes "bisect-reset"
afterwards. So there are no options left to parse at that point. But it
would be the best we could do to demonstrate it.

-Peff
