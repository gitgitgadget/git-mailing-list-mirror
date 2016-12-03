Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1EA1FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 04:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbcLCEc6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 23:32:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:51053 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbcLCEc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 23:32:57 -0500
Received: (qmail 1962 invoked by uid 109); 3 Dec 2016 04:32:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Dec 2016 04:32:57 +0000
Received: (qmail 19508 invoked by uid 111); 3 Dec 2016 04:33:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Dec 2016 23:33:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Dec 2016 23:32:55 -0500
Date:   Fri, 2 Dec 2016 23:32:55 -0500
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: make --only --allow-empty work without paths
Message-ID: <20161203043254.7ozjyucfn6uivnsh@sigill.intra.peff.net>
References: <20161202221513.GA5370@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161202221513.GA5370@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2016 at 11:15:13PM +0100, Andreas Krey wrote:

> --only is implied when paths are present, and required
> them unless --amend. But with --allow-empty it should
> be allowed as well - it is the only way to create an
> empty commit in the presence of staged changes.

OK. I'm not sure why you would want to create an empty commit in such a
case. But I do agree that this seems like a natural outcome for "--only
--allow-empty". So whether it is particularly useful or not, it seems
like the right thing to do. The patch itself looks good to me.

> Arguably, requiring paths with --only is
> pointless anyway because it is implicit
> in that case, but I'm happy when it works
> like in this patch.

I think the point is just to warn the user that what they've asked for
is by definition a noop (and that's why there's already an exception for
--amend, which _does_ make it do something). The fact that --only is
implicit with paths is mostly historical; at one point it was not the
default. These days it's unnecessary, but retained for backwards
compatibility.

> (The interdepence of the tests is a strange thing;
> making --run=N somewhat pointless.)

Yes, I think --run is a misfeature (I actually had to look it up, as I
had completely forgotten that it was added). It's too hard to know which
tests are required setup for later ones, and often the dependency is
implicit. If a single test script is annoyingly long to run, I'd argue
it should be broken out into its own script (and that will let it run in
parallel when the full suite is run, too). I don't know that t7501
qualifies, though; it runs in about 800ms on my machine.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 8976c3d29..89b66816f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1206,7 +1206,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  
>  	if (also + only + all + interactive > 1)
>  		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
> -	if (argc == 0 && (also || (only && !amend)))
> +	if (argc == 0 && (also || (only && !amend && !allow_empty)))
>  		die(_("No paths with --include/--only does not make sense."));
>  	if (argc == 0 && only && amend)
>  		only_include_assumed = _("Clever... amending the last one with dirty index.");

I think this should be sufficient. Obviously we'll end up with an empty
commit, but allow_empty should cover that case later on.

> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index d84897a67..0d8d89309 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -155,6 +155,15 @@ test_expect_success 'amend --only ignores staged contents' '
>  	git diff --exit-code
>  '
>  
> +test_expect_success 'allow-empty --only ignores staged contents' '
> +	echo changed-again >file &&
> +	git add file &&
> +	git commit --allow-empty --only -m "empty" &&
> +	git cat-file blob HEAD:file >file.actual &&
> +	test_cmp file.expect file.actual &&
> +	git diff --exit-code
> +'
> +

Usually we'd put new tests at the end. I guess you wanted this here to
match the "--amend --only" test before it. That kind of sticks this
oddball in the middle of a bunch of --amend tests, but I'm not sure it
would go better anywhere else. So I'm fine with it here.

-Peff
