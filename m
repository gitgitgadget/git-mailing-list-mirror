Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79C3C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 10:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjDRK43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 06:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjDRK40 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 06:56:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B178944B7
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 03:56:23 -0700 (PDT)
Received: (qmail 5148 invoked by uid 109); 18 Apr 2023 10:56:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 10:56:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1251 invoked by uid 111); 18 Apr 2023 10:56:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 06:56:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 06:56:22 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] t/t6501-freshen-objects.sh: prepare for `gc
 --cruft` by default
Message-ID: <20230418105622.GA516715@coredump.intra.peff.net>
References: <cover.1681764848.git.me@ttaylorr.com>
 <4ccc525c39dd23db1136681bc0ffd572db0ed2f2.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ccc525c39dd23db1136681bc0ffd572db0ed2f2.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 04:54:36PM -0400, Taylor Blau wrote:

> We could run this test twice, once with `--cruft` and once with
> `--no-cruft`, but doing so is unnecessary, since the object rescuing and
> freshening behavior is already extensively tested via t5329.

That's doubtless true for the general case of freshening (after all,
that's the point of cruft packs). I do wonder about these "broken links"
cases:

> @@ -151,7 +151,7 @@ test_expect_success 'do not complain about existing broken links (commit)' '
>  	some message
>  	EOF
>  	commit=$(git hash-object -t commit -w broken-commit) &&
> -	git gc -q 2>stderr &&
> +	git gc --no-cruft -q 2>stderr &&
>  	verbose git cat-file -e $commit &&
>  	test_must_be_empty stderr
>  '

The idea is that we don't complain when repacking unreachable-but-broken
segments of history. Which could perhaps behave differently for objects
that are going into a cruft pack versus being turned loose. So maybe
it's worth covering for the --cruft case, too. I dunno.

Certainly your patch is not making the test coverage worse, but it might
be highlighting an existing blind-spot (and one that will become the
default behavior in the next patch).

-Peff
