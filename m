Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376971F462
	for <e@80x24.org>; Thu, 30 May 2019 16:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfE3QML (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 12:12:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52190 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfE3QML (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 12:12:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5964159731;
        Thu, 30 May 2019 12:12:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hr7I3VFrwzjnMzwIMVSIOjs+P5w=; b=n61YWZ
        rATksCdI51nXh7Y1coGegBQoeH1DMhmtJhwnSzXTqohuODtLYRgU28MB2me+qwzC
        25xCKaP2PCNJQc0rZTd6ekKW1S2t8dxev13oiV442/8rlhZt2mhGErJ68Gqyv53A
        VLEZLSwP2y8T1kJ1H8bCCFbGex4aLoZkog2MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IzFxyFjtePrvLLEQ/5KhmCvq/3qGykL7
        50TjWZoOEY22g/M5FB6zErble4G+rFP0pMCeTRN/05tLB+H/tEB1hIUrirsnkfYK
        21CT/tGXnQA4dibkilVvfDd4VpRD9Fyw92Ii+ZQvwnRoYJiRVZVyMEhySBr1HPkB
        ZylDs4vSB8o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD86F159730;
        Thu, 30 May 2019 12:12:08 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FD7E15972F;
        Thu, 30 May 2019 12:12:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     jeffhost@microsoft.com, git@vger.kernel.org,
        emilyshaffer@google.com, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [RFC PATCH v2] list-objects-filter: merge filter data structs
References: <e9147614-80f9-4c18-b431-539e2376295d@jeffhostetler.com>
        <20190530015658.GA4313@comcast.net>
Date:   Thu, 30 May 2019 09:12:06 -0700
In-Reply-To: <20190530015658.GA4313@comcast.net> (Matthew DeVore's message of
        "Wed, 29 May 2019 18:56:58 -0700")
Message-ID: <xmqqef4fyl9l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC03EDE0-82F5-11E9-9500-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

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
> +	void (*filter_clear_fn)(struct filter_data *filter_data);
> +
> +	union {
> +		struct {
> +			/*
> +			 * Maps trees to the minimum depth at which they were
> +			 * seen. It is not necessary to re-traverse a tree at
> +			 * deeper or equal depths than it has already been
> +			 * traversed.
> +			 *
> +			 * We can't use LOFR_MARK_SEEN for tree objects since
> +			 * this will prevent it from being traversed at
> +			 * shallower depths.
> +			 */
> +			struct oidmap seen_at_depth;
> +
> +			unsigned long exclude_depth;
> +			unsigned long current_depth;
> +		};

Name this, and the ohter two union members, and the union itself as
one member inside the outer struct; some compilers would be unhappy
with the GCC extension that allows you to refer to the member in
this struct as ((struct filter_data *)p)->seen_at_depth, no?

> +		struct {
> +			unsigned long max_bytes;
> +		};
> +
> +		struct {
> +			struct exclude_list el;
> +
> +			size_t nr, alloc;
> +			struct frame *array_frame;
> +		};
> +	};
>  };

