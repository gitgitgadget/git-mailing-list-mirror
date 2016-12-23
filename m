Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837A71FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 22:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753873AbcLWWUc (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 17:20:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:60067 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759300AbcLWWUb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 17:20:31 -0500
Received: (qmail 4296 invoked by uid 109); 23 Dec 2016 22:20:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Dec 2016 22:20:31 +0000
Received: (qmail 26931 invoked by uid 111); 23 Dec 2016 22:21:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Dec 2016 17:21:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Dec 2016 17:20:28 -0500
Date:   Fri, 23 Dec 2016 17:20:28 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, novalis@novalis.org
Subject: Re: [PATCH v2 2/2] repack: die on incremental + write-bitmap-index
Message-ID: <20161223222028.7zuwl2bktyyiatrl@sigill.intra.peff.net>
References: <1482522215-13401-1-git-send-email-dturner@twosigma.com>
 <1482522215-13401-2-git-send-email-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1482522215-13401-2-git-send-email-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 23, 2016 at 02:43:35PM -0500, David Turner wrote:

> The bitmap index only works for single packs, so requesting an
> incremental repack with bitmap indexes makes no sense.

OK. I doubt this will come up much after the git-gc change from the
first patch. And it should already be printing a warning in this case
anyway[1]. But I do not mind turning the warning into a hard failure; it
may make things more obvious for the user.  The only weird thing is that
the bitmap option may come from the config, so this effectively means
you can never run "git repack -d" in a repo with bitmap config. I'm not
sure if anybody cares or not, with the new git-gc patch.

[1] Technically "repack -d" could actually create bitmaps (with no
    warning) in a repo that has no existing packs. But that's probably
    an uninteresting corner case (the user should say "-ad" there, and
    the "-a" ends up being a noop).

> @@ -206,6 +212,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (pack_kept_objects < 0)
>  		pack_kept_objects = write_bitmaps;
>  
> +	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
> +		die(incremental_bitmap_conflict_error);

I double-checked that ALL_INTO_ONE covers both -A and -a, which I think
should be sufficient here.

> -test_expect_success 'incremental repack cannot create bitmaps' '
> +test_expect_success 'incremental repack fails when bitmaps are requested' '
>  	test_commit more-1 &&
>  	find .git/objects/pack -name "*.bitmap" >expect &&
> -	git repack -d &&
> +	test_must_fail git repack -d 2>err &&
> +	test_i18ngrep "Incremental repacks are incompatible with bitmap" err &&
>  	find .git/objects/pack -name "*.bitmap" >actual &&
>  	test_cmp expect actual
>  '

The final `find` is probably overkill now after we know the command
failed and reported the error. But it does not hurt to be thorough. :)

-Peff
