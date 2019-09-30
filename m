Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C54C31F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfI3V17 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:27:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:35876 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726504AbfI3V17 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:27:59 -0400
Received: (qmail 2574 invoked by uid 109); 30 Sep 2019 21:27:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Sep 2019 21:27:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5050 invoked by uid 111); 30 Sep 2019 21:30:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Sep 2019 17:30:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Sep 2019 17:27:58 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3] promisor-remote: skip move_to_tail when no-op
Message-ID: <20190930212758.GA18708@sigill.intra.peff.net>
References: <20190926213156.88185-1-emilyshaffer@google.com>
 <20190930202818.2172-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190930202818.2172-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 30, 2019 at 01:28:18PM -0700, Emily Shaffer wrote:

> Previously, when promisor_remote_move_to_tail() is called for a
> promisor_remote which is currently the final element in promisors, a
> cycle is created in the promisors linked list. This cycle leads to a
> double free later on in promisor_remote_clear() when the final element
> of the promisors list is removed: promisors is set to promisors->next (a
> no-op, as promisors->next == promisors); the previous value of promisors
> is free()'d; then the new value of promisors (which is equal to the
> previous value of promisors) is also free()'d. This double-free error
> was unrecoverable for the user without removing the filter or re-cloning
> the repo and hoping to miss this edge case.
> 
> Now, when promisor_remote_move_to_tail() would be a no-op, just do a
> no-op. In cases of promisor_remote_move_to_tail() where r is not already
> at the tail of the list, it works as before.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> Fixed up some nits from Peff in v2. Thanks especially for the catch on
> capturing the output of the fetch - I had been grepping it before I
> realized that test_must_fail accounted for unexpected signal exits, and
> forgot to remove the redirect.

Thanks, this looks pretty good, except one little thing:

> +test_expect_success 'single promisor remote can be re-initialized gracefully' '
> +	# ensure one promisor is in the promisors list
> +	rm -rf repo &&
> +	test_create_repo repo &&
> +	test_create_repo other &&
> +	git -C repo remote add foo "file://$(pwd)/other" &&
> +	git -C repo config remote.foo.promisor true &&
> +	git -C repo config extensions.partialclone foo &&
> +
> +	# reinitialize the promisors list; this must fail gracefully
> +	git -C repo fetch --filter=blob:none foo
> +'

We expect this to succeed now, so "this must fail gracefully" no longer
applies, right?

-Peff
