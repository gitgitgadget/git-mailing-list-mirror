Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 733382021E
	for <e@80x24.org>; Fri, 11 Nov 2016 08:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756018AbcKKIlw (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 03:41:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:41637 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755879AbcKKIlv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 03:41:51 -0500
Received: (qmail 20401 invoked by uid 109); 11 Nov 2016 08:41:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 08:41:50 +0000
Received: (qmail 12150 invoked by uid 111); 11 Nov 2016 08:42:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 03:42:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2016 03:41:48 -0500
Date:   Fri, 11 Nov 2016 03:41:48 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] t6026: ensure that long-running script really is
Message-ID: <20161111084148.tgtsijn74z2pdylq@sigill.intra.peff.net>
References: <16dc9f159b214997f7501006a8d1d8be2ef858e8.1478699463.git.johannes.schindelin@gmx.de>
 <xmqqfumy51tk.fsf@gitster.mtv.corp.google.com>
 <fbf517ad-7341-eb6d-ab38-4fe91410e57c@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbf517ad-7341-eb6d-ab38-4fe91410e57c@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 07:50:14AM +0100, Johannes Sixt wrote:

> Shouldn't we then move the 'kill' out of test_when_finished and make
> it a proper condition of the test? Like this?
> 
> diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
> index 348d78b205..6ad8bd098a 100755
> --- a/t/t6026-merge-attr.sh
> +++ b/t/t6026-merge-attr.sh
> @@ -187,13 +187,19 @@ test_expect_success 'custom merge does not lock index' '
>  		sleep 3600 &
>  		echo $! >sleep.pid
>  	EOF
> -	test_when_finished "kill \$(cat sleep.pid)" &&
>  
>  	test_write_lines >.gitattributes \
>  		"* merge=ours" "text merge=sleep-an-hour" &&
>  	test_config merge.ours.driver true &&
>  	test_config merge.sleep-an-hour.driver ./sleep-an-hour.sh &&
> -	git merge master
> +	git merge master &&
> +
> +	# We are testing that the custom merge driver does not block
> +	# index.lock on Windows due to an inherited file handle.
> +	# To ensure that this test checks this condition, the process
> +	# must still be running at this point (and must have started
> +	# in the first place), hence, this kill must not fail:
> +	kill "$(cat sleep.pid)"
>  '

That makes it more obvious that the return value of "kill" is important,
which is good.

But the other thing the "kill" is doing is make sure we clean up after
ourselves, even if another part of the test fails. What happens if
"merge" unexpectedly fails after starting the sleep process?

I think the best compromise is a comment like the one you have here, but
around the test_when_finished call (and possibly bumping the call down
to right before "git merge master", which is where we expect the process
to start).

-Peff
