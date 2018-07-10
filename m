Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8711F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeGJSVj (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:21:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:54226 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732245AbeGJSVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:21:39 -0400
Received: (qmail 28495 invoked by uid 109); 10 Jul 2018 17:54:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 17:54:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29073 invoked by uid 111); 10 Jul 2018 17:54:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 13:54:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 13:54:47 -0400
Date:   Tue, 10 Jul 2018 13:54:47 -0400
From:   Jeff King <peff@peff.net>
To:     William Chargin <wchargin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1-name.c: for ":/", find detached HEAD commits
Message-ID: <20180710175447.GB25861@sigill.intra.peff.net>
References: <20180710154106.5356-1-wchargin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180710154106.5356-1-wchargin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 08:41:06AM -0700, William Chargin wrote:

> This patch broadens the set of commits matched by ":/" pathspecs to
> include commits reachable from HEAD but not any named ref. This avoids
> surprising behavior when working with a detached HEAD and trying to
> refer to a commit that was recently created and only exists within the
> detached state.
> 
> Signed-off-by: William Chargin <wchargin@gmail.com>
> Based-on-patch-by: Jeff King <peff@peff.net>

Thanks, this looks perfect!

Just to be clear on licensing, I'll add my:

  Signed-off-by: Jeff King <peff@peff.net>

> diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
> index 62f335b2d..41b9f3eba 100755
> --- a/t/t4208-log-magic-pathspec.sh
> +++ b/t/t4208-log-magic-pathspec.sh
> @@ -25,6 +25,20 @@ test_expect_success '"git log :/a -- " should not be ambiguous' '
>  	git log :/a --
>  '
>  
> +test_expect_success '"git log :/detached -- " should find a commit only in HEAD' '
> +	test_when_finished "git checkout master" &&
> +	git checkout --detach &&
> +	test_tick &&
> +	git commit --allow-empty -m detached &&
> +	test_tick &&
> +	git commit --allow-empty -m something-else &&
> +	git log :/detached --
> +'

At first I wondered if you could just use test_commit here (instead of a
manual test_tick and commit). But we care about reachability only from
the detached HEAD here, so this must _not_ use test_commit, which
creates an extra tag.

It could be worth mentioning that in a comment (since somebody who later
refactors to make that change would not realize the problem, as it would
simply cause a broken test to return a false success). But...

> +test_expect_success '"git log :/detached -- " should not find an orphaned commit' '
> +	test_must_fail git log :/detached --
> +'

This follow-up test _would_ notice such a breakage. Very nicely done.

-Peff
