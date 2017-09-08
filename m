Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67AAB202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 07:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbdIHHCI (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 03:02:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:60528 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932319AbdIHHCH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 03:02:07 -0400
Received: (qmail 21516 invoked by uid 109); 8 Sep 2017 07:02:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 07:02:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6281 invoked by uid 111); 8 Sep 2017 07:02:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 03:02:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 03:02:05 -0400
Date:   Fri, 8 Sep 2017 03:02:05 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 02/10] struct ref_transaction: add a place for backends
 to store data
Message-ID: <20170908070205.3hwa7tjgok7kgknc@sigill.intra.peff.net>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <5b8c8f9ab0ccd5f85eb43a7a1535af89b0af85e3.1503993268.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b8c8f9ab0ccd5f85eb43a7a1535af89b0af85e3.1503993268.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 10:20:26AM +0200, Michael Haggerty wrote:

> `packed_ref_store` is going to want to store some transaction-wide
> data, so make a place for it.

That makes sense, although...

> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index b02dc5a7e3..d7d344de73 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -242,6 +242,7 @@ struct ref_transaction {
>  	size_t alloc;
>  	size_t nr;
>  	enum ref_transaction_state state;
> +	void *backend_data;
>  };

This is just one pointer. Once we start layering ref backends (and
already we're moving towards a "files" layer which sits atop loose and
packed backends, right?), how do we avoid backends stomping on each
other (or worse, dereferencing somebody else's data as their own
struct)?

I don't know that we necessarily need to answer that question right now,
but I'm worried that this pattern might need adjustment eventually.

I guess the hand-wavy answer is that whatever is doing the layering
would need to manage the pointers. So if you imagine that we had a
"union" backend that took two other arbitrary backends, it would
probably have something like:

  struct union_backend_data {
	void *data_a;
	void *data_b;
  }

and when it forwarded calls to the separate backends, it would give them
a view of the transaction with only their data. Something like:

  void union_backend_foo(void *be, struct ref_transaction *transaction)
  {
	struct union_backend *me = be;
	struct union_backend_data *my_data = transaction->backend_data;

        /* "a" sees only it's data, and we remember any modifications */
	transaction->backend_data = my_data->data_a;
	me->backend_a->foo(me->backend_a, transaction);
	my_data->data_a = transaction->backend_data;

        /* ditto for "b" */
	transaction->backend_data = my_data->data_b;
	me->backend_b->foo(me->backend_b, transaction);
	my_data->data_b = transaction->backend_data;

	/* and then we restore our own view */
	transaction->backend_data = my_data;
  }

-Peff
