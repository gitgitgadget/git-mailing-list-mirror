Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD528C433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 22:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3C62245C
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 22:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbgLCWoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 17:44:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50766 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgLCWoI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 17:44:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B62D610EFB9;
        Thu,  3 Dec 2020 17:43:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r4C/397SKhWKaZ2uQ+z17BAExh8=; b=Wvxrut
        9GJn5mNqP5r2n0ZNiPHz5jMBr1x3jpRjt4iNlALfGpv40ElBi3Xez9/v6xrqdaTM
        o+P0XQtkwqiRlEWegkqwaT4R7zaHU9d3OEq676jf/7GC+A5cJqIBQXbEo4jxlJ36
        Fj3jCoqgC7+hP0c1y0Lpbn2Kl8bU2Qlu3Ioh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kQPDUrHWYLQUbpa++lr8tcGyClitSM34
        scZ6weX571lj/0XfFzdkrGBmZnzlPem+Z1f5uTIW42MJiRVIBtxP3wGkpk73o1YH
        DQnwDoscW5FweisgcKmAA9jNqfxZQPsvacs9bVj9uaD3JFZwZHBWYuriiC9RtNNB
        RjHrrbo7Xmk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B9A610EFB8;
        Thu,  3 Dec 2020 17:43:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C1A1710EFB7;
        Thu,  3 Dec 2020 17:43:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 13/15] chunk-format: create chunk reading API
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
        <6801e231f7414444a272f2ea87dcc6f60f29e25a.1607012215.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 14:43:21 -0800
In-Reply-To: <6801e231f7414444a272f2ea87dcc6f60f29e25a.1607012215.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 03 Dec 2020
        16:16:52 +0000")
Message-ID: <xmqq1rg6h5o6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2C33098-35B8-11EB-B334-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
> ...
> -		case GRAPH_CHUNKID_DATA:
> -			if (graph->chunk_commit_data)
> -				chunk_repeated = 1;
> -			else
> -				graph->chunk_commit_data = data + chunk_offset;
> -			break;
> +	/* limit the chunk-format list if we are ignoring Bloom filters */
> +	if (!r->settings.commit_graph_read_changed_paths)
> +		chunks_nr = 5;

I presume that this magic number 5 is directly connected to ...

> +static struct read_chunk_info read_chunks[] = {
> +	[0] = {
> +		GRAPH_CHUNKID_OIDFANOUT,
> +		graph_read_oid_fanout
> +	},
> +	[1] = {
> +		GRAPH_CHUNKID_OIDLOOKUP,
> +		graph_read_oid_lookup
> +	},
> +	[2] = {
> +		GRAPH_CHUNKID_DATA,
> +		graph_read_data
> +	},
> +	[3] = {
> +		GRAPH_CHUNKID_EXTRAEDGES,
> +		graph_read_extra_edges
> +	},
> +	[4] = {
> +		GRAPH_CHUNKID_BASE,
> +		graph_read_base_graphs
> +	},
> +	[5] = {
> +		GRAPH_CHUNKID_BLOOMINDEXES,
> +		graph_read_bloom_indices
> +	},
> +	[6] = {
> +		GRAPH_CHUNKID_BLOOMDATA,
> +		graph_read_bloom_data
> +	}
> +};

... the index of these entries in the table.

I find this arrangement brittle.  For one thing, it means that new
chunks cannot be added at an arbitrary place, and BLOOMDATA must be
at the end for the "limit the list when ignoring" logic to work
correctly (even when the developer who is adding a new chunk type
realizes that new one must be inserted before [5], and the magic
number 5 above must be updated), and it won't work at all if a
similar "we can optionally ignore reading the data" treatment needs
to be made for new chunk types, since two or more things cannot be
at the end of the list at the same time X-<.

Would it be a cleaner way to implement this "when member X in the
settings structure is not set, ignore BLOOMINDEXES and BLOOMDATA"
feature to let these graph_read_*() functions have access to the
settings structure, so that bloom_indices and bloom_data callback
functions can make decisions for themselves?

Once we do that, as far as I can tell, there is no longer any reason
to initialize read_chunks[] array with designated initializer.  The
implementation of read_table_of_contents() does not tolerate if this
array is sparsely populated anyway, and except for the "do we ignore
bloom?" hack, nothing really depends on the order of entries in the
array, right?

Thanks.
