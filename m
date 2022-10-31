Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3F7ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 23:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJaXUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaXUO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 19:20:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F16BC35
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:20:12 -0700 (PDT)
Received: (qmail 3426 invoked by uid 109); 31 Oct 2022 23:20:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 31 Oct 2022 23:20:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16514 invoked by uid 111); 31 Oct 2022 23:20:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Oct 2022 19:20:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 Oct 2022 19:20:11 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t5516/t5601: avoid using `localhost` for failing
 HTTPS requests
Message-ID: <Y2BYKxxkG57XAV/1@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <25cc0f6d91a9d23eb1b755e1463d672e4958a4e9.1667245639.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25cc0f6d91a9d23eb1b755e1463d672e4958a4e9.1667245639.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 07:47:17PM +0000, Johannes Schindelin via GitGitGadget wrote:

> In 6dcbdc0d6616 (remote: create fetch.credentialsInUrl config,
> 2022-06-06), we added four test cases that validate various behavior
> around passing credentials as part of the URL (which is considered
> unsafe in general).
> 
> These tests do not _actually_ try to connect anywhere, but have to use
> the https:// protocol in order to validate the intended code paths.

By "actually" here, I assume you mean "they do not expect to succeed".
But I think the first one (with credentialsInUrl=allow), does try to
make a connection.

> However, using `localhost` for such a connection causes several
> problems:
> 
> - There might be a web server running on localhost, and we do not
>   actually want to connect to that.
> 
> - The DNS resolver, or the local firewall, might take a substantial
>   amount of time (or forever, whichever comes first) to fail to connect,
>   slowing down the test cases unnecessarily.

Right. I think we assume that DNS resolution of localhost is fast-ish,
as we use it in other https tests. But I could certainly imagine a local
firewall causing issues (especially as this is real port 443, whereas
our other tests are usually high ports).

> Let's instead use an IPv4 address that is guaranteed never to offer a
> web server: 224.0.0.1 (which is part of the IP multicast range).

This feels pretty magical. I think it would be pretty unlikely for it to
have a web server, but I wouldn't be surprised if there are systems
where we get similar IP-routing hangs.

Is there a reason not to move all of these tests into t5550 or t5551,
where we have a real http server? That would be less magical, and then
this first test:

>  test_expect_success LIBCURL 'fetch warns or fails when using username:password' '
> -	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
> -	test_must_fail git -c transfer.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
> +	message="URL '\''https://username:<redacted>@224.0.0.1/'\'' uses plaintext credentials" &&
> +	test_must_fail git -c transfer.credentialsInUrl=allow fetch https://username:password@224.0.0.1 2>err &&
>  	! grep "$message" err &&

could be more robust. It would actually check that we succeeded in using
the URL.

-Peff
