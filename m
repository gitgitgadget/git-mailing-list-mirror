Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21DB51F731
	for <e@80x24.org>; Wed, 31 Jul 2019 18:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfGaSjl (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 14:39:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55485 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfGaSjl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 14:39:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A967A16E374;
        Wed, 31 Jul 2019 14:39:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=StynU7Y35tcwLqn99MfCh/gVHg0=; b=Ok8Bqi
        R0S0CXGNNQvLwtHywOwaXeXtxIhp/HOJO2gtObBH3DaSTAueCI8vfzNLxwFpEFhW
        imQCYJoKfpa5Ft6qI/j1kRcKOsEdJ6vrEmDjbtZAzOC/4QpJjoLJPX6Z1L6boz+K
        77ddgfEvYpVINhjsBUxri9QFO3P1y5to8egyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f96cd3dAvCHSFzjBmx/TY/rh5AOm2qLK
        lotXODSUXGYtpPJiGGCnTHE+asGKcUTcjP4QJBjfTguswIJfXC11Vi1l0+V1lSG2
        0EYcSp+EjdA/xT3uq3ZsG/KaO8uigR/fx4qjuu19+AsTLtbIo3sGqCZ6BwDdb9ML
        atC94LT9nhQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A02EE16E372;
        Wed, 31 Jul 2019 14:39:38 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17F6716E370;
        Wed, 31 Jul 2019 14:39:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH v3 07/11] Add a function to determine unique prefixes for a list of strings
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
        <3000d7d08dfb64511b4ebf9d05617897dd7252f7.1563289115.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Jul 2019 11:39:36 -0700
In-Reply-To: <3000d7d08dfb64511b4ebf9d05617897dd7252f7.1563289115.git.gitgitgadget@gmail.com>
        (Slavica Djukic via GitGitGadget's message of "Tue, 16 Jul 2019
        07:58:42 -0700 (PDT)")
Message-ID: <xmqqk1byoxp3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CF10070-B3C2-11E9-A6EE-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The idea: for each item that we add, we generate prefixes starting with
> the first letter, then the first two letters, then three, etc, until we
> find a prefix that is unique (or until the prefix length would be
> longer than we want). If we encounter a previously-unique prefix on the
> way, we adjust that item's prefix to make it unique again (or we mark it
> as having no unique prefix if we failed to find one). These partial
> prefixes are stored in a hash map (for quick lookup times).

OK.  I suppose such a machinery that accepts a set of strings and
then give us back a set of unique prefix length for each element of
the set would be useful in general, even outside the "and choose"
part of "list and choose".  Nice design.

> To make sure that this function works as expected, we add a test using a
> special-purpose test helper that was added for that purpose.

Somehow the above repeatedly says how special purpose it is
redundantly ;-)

> diff --git a/prefix-map.h b/prefix-map.h
> new file mode 100644
> index 0000000000..ce3b8a4a32
> --- /dev/null
> +++ b/prefix-map.h
> @@ -0,0 +1,40 @@
> +#ifndef PREFIX_MAP_H
> +#define PREFIX_MAP_H
> +
> +#include "hashmap.h"
> +
> +struct prefix_item {
> +	const char *name;
> +	size_t prefix_length;
> +};
> +
> +struct prefix_map_entry {
> +	struct hashmap_entry e;
> +	const char *name;
> +	size_t prefix_length;
> +	/* if item is NULL, the prefix is not unique */
> +	struct prefix_item *item;
> +};
> +
> +struct prefix_map {
> +	struct hashmap map;
> +	int min_length, max_length;
> +};
> +
> +/*
> + * Find unique prefixes in a given list of strings.
> + *
> + * Typically, the `struct prefix_item` information will be but a field in the
> + * actual item struct; For this reason, the `list` parameter is specified as a
> + * list of pointers to the items.
> + *
> + * The `min_length`/`max_length` parameters define what length the unique
> + * prefixes should have.
> + *
> + * If no unique prefix could be found for a given item, its `prefix_length`
> + * will be set to 0.
> + */
> +void find_unique_prefixes(struct prefix_item **list, size_t nr,
> +			  int min_length, int max_length);
> +
> +#endif

Looks like a quite sane interface to me.

Thanks.
