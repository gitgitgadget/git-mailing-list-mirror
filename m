Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4791FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 11:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932369AbcLML7g (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 06:59:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:55626 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752747AbcLML7g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 06:59:36 -0500
Received: (qmail 30451 invoked by uid 109); 13 Dec 2016 11:59:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 11:59:35 +0000
Received: (qmail 13820 invoked by uid 111); 13 Dec 2016 12:00:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 07:00:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 06:59:31 -0500
Date:   Tue, 13 Dec 2016 06:59:31 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     git@vger.kernel.org, mah@jump-ing.de, jacob.keller@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCHv2 1/2] merge: Add '--continue' option as a synonym for
 'git commit'
Message-ID: <20161213115931.tz7ce3z2meaxydbh@sigill.intra.peff.net>
References: <20161212083413.7334-1-judge.packham@gmail.com>
 <20161213084859.13426-1-judge.packham@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161213084859.13426-1-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 09:48:58PM +1300, Chris Packham wrote:

> +	if (continue_current_merge) {
> +		int nargc = 1;
> +		const char *nargv[] = {"commit", NULL};
> +
> +		if (argc)
> +			usage_msg_opt("--continue expects no arguments",
> +			      builtin_merge_usage, builtin_merge_options);

This checks that we don't have:

  git merge --continue foobar

but still allows:

  git merge --continue --some-option

because parse_options() decrements argc.

It would be insane to check individually which options might have been
set. But I wonder if we could do something like:

  int orig_argc = argc;
  ...
  argc = parse_options(argc, argv, ...);

  if (continue_current_merge) {
	if (orig_argc != 1) /* maybe 2, to account for argv[0] ? */
		usage_msg_opt("--continue expects no arguments", ...);
  }

That gets trickier if there ever is an option that's OK to use with
--continue. We might want to forward along "--quiet", for example. On
the other hand, we silently ignore it now, so maybe it is better to
complain and then let --quiet get added later if somebody cares.

Whatever we do here, I think "--abort" should get the same treatment
(probably as a separate patch).

> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 85248a14b..44b34ef3a 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -154,6 +154,7 @@ test_expect_success 'test option parsing' '
>  	test_must_fail git merge -s foobar c1 &&
>  	test_must_fail git merge -s=foobar c1 &&
>  	test_must_fail git merge -m &&
> +	test_must_fail git merge --continue foobar &&
>  	test_must_fail git merge
>  '

Your tests look good, though obviously if you check for options above,
that should be covered in this test.

-Peff
