Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270381F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 20:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbeGLU0E (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 16:26:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:57504 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727082AbeGLU0E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 16:26:04 -0400
Received: (qmail 10994 invoked by uid 109); 12 Jul 2018 20:14:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Jul 2018 20:14:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27143 invoked by uid 111); 12 Jul 2018 20:14:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 12 Jul 2018 16:14:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jul 2018 16:14:54 -0400
Date:   Thu, 12 Jul 2018 16:14:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t3404: fix use of "VAR=VAL cmd" with a shell function
Message-ID: <20180712201454.GA6281@sigill.intra.peff.net>
References: <xmqqefg8w73c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefg8w73c.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 01:07:51PM -0700, Junio C Hamano wrote:

> Bash may take it happily but running test with dash reveals a breakage.
> 
> This was not discovered for a long time as no tests after this test
> depended on GIT_AUTHOR_NAME to be reverted correctly back to the
> original value after this step is done.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * We could enclose the setting and exporting inside a subshell and
>    do without the oGIT_AUTHOR_NAME temporary variable, but that
>    would interfere with the timestamp increments done by
>    test_commit, so I think doing it this way may be preferrable.

Yeah, I agree that setting/unsetting is probably more sane for this
case. Though...

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 7e9f375a24..fd43443ff5 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -280,8 +280,11 @@ test_expect_success 'retain authorship w/ conflicts' '
>  	git reset --hard twerp &&
>  	test_commit a conflict a conflict-a &&
>  	git reset --hard twerp &&
> -	GIT_AUTHOR_NAME=AttributeMe \
> +	oGIT_AUTHOR_NAME=$GIT_AUTHOR_NAME &&
> +	GIT_AUTHOR_NAME=AttributeMe &&
> +	export GIT_AUTHOR_NAME &&
>  	test_commit b conflict b conflict-b &&
> +	GIT_AUTHOR_NAME=$oGIT_AUTHOR_NAME &&

...would you want to use test_when_finished here (both for robustness,
but also to make it more clear to a reader what's going on)?

It's too bad test_commit does not take arbitrary options, as you could
just use --author then, side-stepping the whole thing.

-Peff
