Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A9B1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 13:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeJKVWT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 17:22:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:37164 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727080AbeJKVWT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 17:22:19 -0400
Received: (qmail 18945 invoked by uid 109); 11 Oct 2018 13:55:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 13:55:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29734 invoked by uid 111); 11 Oct 2018 13:54:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Oct 2018 09:54:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Oct 2018 09:54:59 -0400
Date:   Thu, 11 Oct 2018 09:54:59 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/7] prio-queue: add 'peek' operation
Message-ID: <20181011135459.GA27312@sigill.intra.peff.net>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <cc1ec4c2702d8ba35873600d321015bb0430d92e.1537551564.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc1ec4c2702d8ba35873600d321015bb0430d92e.1537551564.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 10:39:27AM -0700, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When consuming a priority queue, it can be convenient to inspect
> the next object that will be dequeued without actually dequeueing
> it. Our existing library did not have such a 'peek' operation, so
> add it as prio_queue_peek().

Makes sense.

> +void *prio_queue_peek(struct prio_queue *queue)
> +{
> +	if (!queue->nr)
> +		return NULL;
> +	if (!queue->compare)
> +		return queue->array[queue->nr - 1].data;
> +	return queue->array[0].data;

The non-compare version of get() treats this like a LIFO, and you do the
same here. Looks good.

In theory get() could be implemented in terms of peek(), but the result
is not actually shorter because we have to check those same conditions
to decide how to remove the item anyway.

> diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
> index 9807b649b1..e817bbf464 100644
> --- a/t/helper/test-prio-queue.c
> +++ b/t/helper/test-prio-queue.c
> @@ -22,9 +22,13 @@ int cmd__prio_queue(int argc, const char **argv)
>  	struct prio_queue pq = { intcmp };
>  
>  	while (*++argv) {
> -		if (!strcmp(*argv, "get"))
> -			show(prio_queue_get(&pq));
> -		else if (!strcmp(*argv, "dump")) {
> +		if (!strcmp(*argv, "get")) {
> +			void *peek = prio_queue_peek(&pq);
> +			void *get = prio_queue_get(&pq);
> +			if (peek != get)
> +				BUG("peek and get results do not match");
> +			show(get);
> +		} else if (!strcmp(*argv, "dump")) {

This is a nice cheap way of piggy-backing on the existing get tests.

-Peff
