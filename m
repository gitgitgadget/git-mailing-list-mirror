Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F901F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfFGSP5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:15:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51736 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfFGSP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:15:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84D2D14D0D0;
        Fri,  7 Jun 2019 14:15:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l9SR4UlOHLnrOKbDM5bpS2Wux4U=; b=PFf0Zp
        B3ntBvNNK+8pQJbvMMv3HtYLZ4BSDtb/Y5gCmBgCGX618StbgCY6cKfr7zi1CUWj
        vn4MlCnRMsNtSXGvROIiN3Ov7HjvGAT+79eoDEBGN3W/zw5i8/AZXsAXRNigpeeB
        NR71niMoTJbs4JXL6RqN14enRftE0iVxw06qQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qzxmDqP+/FPqADsmbyJYMYu5FSBduZjl
        ZwzTbac+nEmGv8biMDuiXJpJwK+AyIQz7FrtcTT54D4a6Ach3QW/l9J3bZ7yu9ff
        0r1hiId+M62xbAmOGF6byGsUc+qZvIoWnGPx6bkPjWz4BBZWiHnyTHrhg3oQU2pQ
        760bHP+vY0g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6433414D0CF;
        Fri,  7 Jun 2019 14:15:51 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B55EB14D0CB;
        Fri,  7 Jun 2019 14:15:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 05/14] commit-graph: add base graphs chunk
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
        <df44cbc1bf6e18c3682652c2de69de7a9caf5fc2.1559830527.git.gitgitgadget@gmail.com>
Date:   Fri, 07 Jun 2019 11:15:49 -0700
In-Reply-To: <df44cbc1bf6e18c3682652c2de69de7a9caf5fc2.1559830527.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 06 Jun 2019
        07:15:33 -0700 (PDT)")
Message-ID: <xmqqmuitp8h6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47DD181C-8950-11E9-B252-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -  1-byte (reserved for later use)
> -     Current clients should ignore this value.
> +  1-byte number (B) of base commit-graphs
> +      We infer the length (H*B) of the Base Graphs chunk
> +      from this value.
>  
>  CHUNK LOOKUP:
>  
> @@ -92,6 +93,12 @@ CHUNK DATA:
>        positions for the parents until reaching a value with the most-significant
>        bit on. The other bits correspond to the position of the last parent.
>  
> +  Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
> +      This list of H-byte hashes describe a set of B commit-graph files that
> +      form a commit-graph chain. The graph position for the ith commit in this
> +      file's OID Lookup chunk is equal to i plus the number of commits in all
> +      base graphs.  If B is non-zero, this chunk must exist.

Hmph, an obvious alternative design would be to make the base list
self describing without using the "reserved for future use" byte,
which would allow more than 256 bases (not that being able to use
300 bases is necessarily a useful feature) and also leave the
reserved byte unused.

It's not like being able to detect discrepancy (e.g. B!=0 but BASE
chunk is missing, and/or BASE chunk appears but B==0) adds value by
offering more protection against file corruption, so I am wondering
why it is a good idea to consume the reserved byte for this.

> +	if (n && !g->chunk_base_graphs) {
> +		warning(_("commit-graph has no base graphs chunk"));
> +		return 0;
> +	}
> +
n>  	while (n) {
>  		n--;
> +
> +		if (!oideq(&oids[n], &cur_g->oid) ||
> +		    !hasheq(oids[n].hash, g->chunk_base_graphs + g->hash_len * n)) {

Here, load_commit_graph_chain() that goes over the on-disk chain
file that lists graph files called us with 'n', which can run up to
the number of graph files listed in that file---and that number can
be more than what is recorded in the graph-list chunk, in which case
we are over-reading with this hasheq(), right?

It seems that parse_commit_graph() only cares about the beginning of
each chunk, and a crafted graph file can record two chunks with a
gap in between, or two chunks that overlap, and nobody would notice.
Is that true?

Wasted space in the file between two chunks (i.e. a gap) is not
necessarily bad and may not be a warning-worthy thing, but two
chunks that overlap is probably not a good idea and worth noticing.
The only sanity check it seems to do is to forbid chunks of the same
kind from appearing twice.
