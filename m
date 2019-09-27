Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704411F463
	for <e@80x24.org>; Fri, 27 Sep 2019 00:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfI0AcZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 20:32:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:33488 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725808AbfI0AcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 20:32:25 -0400
Received: (qmail 22009 invoked by uid 109); 27 Sep 2019 00:32:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Sep 2019 00:32:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5351 invoked by uid 111); 27 Sep 2019 00:34:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2019 20:34:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Sep 2019 20:32:24 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] promisor-remote: skip move_to_tail when no-op
Message-ID: <20190927003223.GA22473@sigill.intra.peff.net>
References: <20190925213718.231231-1-emilyshaffer@google.com>
 <20190926213156.88185-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926213156.88185-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 02:31:56PM -0700, Emily Shaffer wrote:

> ---
> Thanks Peff for pointing out this bug occurs any time the tail is being
> moved to tail in the promisors list. Modified patch to check just for
> "already at tail" condition.
> 
> Added a test case based on Peff's reproduction steps (thanks!) and
> confirmed it failed before the patch, exiting gracelessly with a
> SIGABRT, and now fails gracefully (and passes test_must_fail condition).

Thanks, this is looking good, though I have a few nits.

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Helped-by: Jeff King <peff@peff.net>

The trailers are supposed to be chronological. It probably doesn't
matter a lot here, but it's more important for something like a signoff
chain. I suppose you could also argue that you signed off and then I
helped but I think you signed off again after. :)

> diff --git a/promisor-remote.c b/promisor-remote.c
> index 9bc296cdde..9bd5b79d59 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -89,6 +89,9 @@ static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
>  static void promisor_remote_move_to_tail(struct promisor_remote *r,
>  					 struct promisor_remote *previous)
>  {
> +	if (r->next == NULL)
> +		return;
> +
>  	if (previous)
>  		previous->next = r->next;
>  	else

Yeah, I think of all the discussed options, this one is pretty easy to
understand.

> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -429,6 +429,18 @@ test_expect_success 'rev-list dies for missing objects on cmd line' '
>  	done
>  '
>  
> +test_expect_success 'single promisor remote can be re-initialized gracefully' '
> +	# ensure one promisor is in the promisors list
> +	rm -rf repo &&
> +	test_create_repo repo &&
> +	git -C repo remote add foo /wherever &&
> +	git -C repo config remote.foo.promisor true &&
> +	git -C repo config extensions.partialclone foo &&
> +
> +	# reinitialize the promisors list; this must fail gracefully
> +	test_must_fail git -C repo fetch --filter=blob:none foo 2>fetch_err
> +'

Could we make this a little more robust by using a real repo instead of
"/wherever", and confirming that the command actually succeeds?

As a side note, if we're not going to check the content of fetch_err, I
think we're better off not redirecting it (it goes to /dev/null by
default, or the user or log if running with "-v" or "--verbose-log").

-Peff
