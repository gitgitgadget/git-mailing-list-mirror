Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277561F462
	for <e@80x24.org>; Wed, 29 May 2019 19:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfE2TsY (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 15:48:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60458 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfE2TsY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 15:48:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1C537779F;
        Wed, 29 May 2019 15:48:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H3bgYh8AEgEJ2Xc7cZp7dFLFEDM=; b=CaWsbh
        fNo9RqAN240DsosPQ3Z+KZDL8rcidqlrLLV3lufsiYe/F8dg4DiDx7Lfl6ucVqaI
        Tqyd9Nb7F1xLdhxnaFASK/1fgSDL9HEqERZ9CculfI8zzkHs6bCL0AO+YSWRD6PB
        mWymEJ4uQxfl/RVptAZR+mJ4XXBZl2YysdwdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F38ezd3mrsuenKVQM/BhpVuOg1QuHYYj
        HOCtBOLLAVnT1y4ipZgY/QnfpfQ4Gc6kMdexWcjlw05rp/ayRY+n3S8LB6BFAKMQ
        FpYc+tpn1Ngr+CM6ntPzBZYCQGPUuMJ5aW91dUbMk8/pWhjGzcWCNoJ5tLlw/7rV
        dyv6q7Gc/PU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E90B57779E;
        Wed, 29 May 2019 15:48:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4869B7779C;
        Wed, 29 May 2019 15:48:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH] list-objects-filter: merge filter data structs
References: <cover.1558484115.git.matvore@google.com>
        <341bc55d4a3f5438b1523525cf683f96d75e8c3e.1558484115.git.matvore@google.com>
        <20190524004938.GB46998@google.com>
        <20190528184801.GA4556@comcast.net>
        <20190528224010.GA4700@comcast.net>
Date:   Wed, 29 May 2019 12:48:17 -0700
In-Reply-To: <20190528224010.GA4700@comcast.net> (Matthew DeVore's message of
        "Tue, 28 May 2019 15:40:10 -0700")
Message-ID: <xmqq4l5dyrcu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5579474-824A-11E9-BE15-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@comcast.net> writes:

> Simplify the filter execution data logic and structs by putting all
> execution data for all filter types in a single struct. This results in
> a tiny overhead for each filter instance, and in exchange, invoking
> filters is not only easier but the list-objects-filter public API is
> simpler and more opaque.

Hmmm...

> +struct filter_data {
> +	/* Used by all filter types. */
>  	struct oidset *omits;
> +
> +	enum list_objects_filter_result (*filter_object_fn)(
> +		struct repository *r,
> +		enum list_objects_filter_situation filter_situation,
> +		struct object *obj,
> +		const char *pathname,
> +		const char *filename,
> +		struct filter_data *filter_data);
> +
> +	/* BEGIN tree:<depth> filter data */
> +
> +	/*
> +	 * Maps trees to the minimum depth at which they were seen. It is not
> +	 * necessary to re-traverse a tree at deeper or equal depths than it has
> +	 * already been traversed.
> +	 *
> +	 * We can't use LOFR_MARK_SEEN for tree objects since this will prevent
> +	 * it from being traversed at shallower depths.
> +	 */
> +	struct oidmap seen_at_depth;
> +
> +	unsigned long exclude_depth;
> +	unsigned long current_depth;
> +
> +	/* BEGIN blobs:limit=<limit> filter data */
> +
> +	unsigned long max_bytes;
> +
> +	/* BEGIN sparse:... filter data */
> +
> +	struct exclude_list el;
> +
> +	size_t nr, alloc;
> +	struct frame *array_frame;
>  };

I am hoping that I am not misreading the intention but you do not
plan to use the above so that you can say "apply 'tree:depth=4' and
'blobs:limit=1G' at the same time" by filling the fields in a single
struct, do you?  For combined filter, you'll still have multiple
instances of filter_data struct, strung together in a list that says
"all of these must be satisfied" or something like that, right?

And if that is the case, I am not sure why the above "struct with
all these fields" is a good idea.  If these three (and probably we
will have more as the system evolves) sets of fields in this outer
struct for different filters were enclosed in a union, that would be
a different story, though.

