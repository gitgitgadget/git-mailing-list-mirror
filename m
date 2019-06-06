Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416F01F462
	for <e@80x24.org>; Thu,  6 Jun 2019 21:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfFFV2M (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 17:28:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52309 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfFFV2M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 17:28:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A87A61427AA;
        Thu,  6 Jun 2019 17:28:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hTiP+xwUjFVkVq4rvvLk44ixNUo=; b=R1dUu6
        G+nRR5BtqQcsH0qw3V8ArtSzl7O80nODGp3vV521fKOJUZIFmShW1GoBBFCMjZQ+
        jCUKTFco4jtsh3CoYd9icODCQV/KoURZ40uTjbq0Z3WqidNzLvu1lWxSP5l0exbE
        uo6IfVjM9a9VWd1EekOOdtlyek5a6DvNGJSeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pvoU92ODKKCOdjgmyS7p6WcG298UC4NT
        BPDy0eLHIyJYajuZQwZz1NG8TYxe+TWJlbCmKoB4yTwzNiWoGqj16NCN1Qmzushi
        mPhVaLV2RsC9oWNmbX/kaz8TSpHA0qmVNmta7zFDGRIY/JnaL7mp84Q4cOxrcR4P
        Mn+YLWtuWg8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FDAC1427A9;
        Thu,  6 Jun 2019 17:28:07 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 174961427A7;
        Thu,  6 Jun 2019 17:28:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 02/14] commit-graph: prepare for commit-graph chains
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
        <d0dc154a27c80a8113ff47eb60a6b6f98fbeec91.1559830527.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Jun 2019 14:28:06 -0700
In-Reply-To: <d0dc154a27c80a8113ff47eb60a6b6f98fbeec91.1559830527.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 06 Jun 2019
        07:15:30 -0700 (PDT)")
Message-ID: <xmqqd0jqqu8p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9A74B08-88A1-11E9-91CE-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void load_oid_from_graph(struct commit_graph *g, int pos, struct object_id *oid)
> +{
> +	uint32_t lex_index;
> +
> +	if (!g)
> +		BUG("NULL commit-graph");
> +
> +	while (pos < g->num_commits_in_base)
> +		g = g->base_graph;

If a rogue caller calls this function with pos < 0, this loop would
eventually exhaust the chain and make g==NULL, I think.  Shouldn't a
similar assert exist upfront for "if (pos < 0)" or perhaps make pos
unsigned int instead?

> +	if (pos >= g->num_commits + g->num_commits_in_base)
> +		BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
> +		    pos, g->num_commits, g->num_commits_in_base);

Where does 'pos' typically come from?  Taken from a parent commit
field of a commit-graph file or something like that?

As this is a "BUG()" and not a "die()", the callers of this function
are responsible for making sure that, even if they are fed a set of
corrupt commit-graph files, they never feed 'pos' that is out of
bounds to this function.  The same is true for the other BUG() in
fill_commit_in_graph().

I am wondering if they have already sufficient protection, or if we
are better off having die() instead saying "corrupted commit graph
file" or something.  I dunno.

