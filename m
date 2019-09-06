Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8FFE1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 16:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391035AbfIFQ5d (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 12:57:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51401 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfIFQ5d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 12:57:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3695632839;
        Fri,  6 Sep 2019 12:57:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Aa3wAOFavolWRo3h7UcsrHtUMsA=; b=VQ4CNq
        GjgASuxZknJDmntCaUpcF0wxZFB8XuaPvLpNPhlcdoVKqgv9TGjiBTdR9oEhLEtI
        uC+kH1YvV/+VyJwyApUa5i9CyCgzgYld6+Urjpu6gV+gDmM2ztK+KsNMiomp+/+w
        0m7TgST1b23JYW+3dratvdCpsIYBs/dS0Dz9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AbU4PweFhjeVBb8Y4nQzsojrEfLM8puG
        aTCQQ1F/xKoLZ5VUATc6umAi/F4Lbbz06rprp1+Dujj3J21mj2wMHoV+YL6AQiWM
        cyAGvU7SL+tmEpxU2JsEx1PBORwGQRKphyk436MD+kDodfTwip3RSWH/bVguMPm/
        t8jJAI7u1KM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DD8032838;
        Fri,  6 Sep 2019 12:57:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8834132837;
        Fri,  6 Sep 2019 12:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: [PATCH 3/3] commit-graph.c: handle corrupt/missing trees
References: <cover.1567720960.git.me@ttaylorr.com>
        <9fbd965e3892307bb5bb78952f017624fcc0b73a.1567720960.git.me@ttaylorr.com>
        <20190906061919.GA5122@sigill.intra.peff.net>
Date:   Fri, 06 Sep 2019 09:57:29 -0700
In-Reply-To: <20190906061919.GA5122@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 6 Sep 2019 02:19:20 -0400")
Message-ID: <xmqqo8zxnz0m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69EE0F4C-D0C7-11E9-A276-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is sort-of attributable to my 834876630b (get_commit_tree(): return
> NULL for broken tree, 2019-04-09). Before then it was a BUG(). However,
> that state was relatively short-lived. Before 7b8a21dba1 (commit-graph:
> lazy-load trees for commits, 2018-04-06), we'd have similarly returned
> NULL (and anyway, BUG() is clearly wrong since it's a data error).
>
> None of which argues against your patches, but it's kind of sad that the
> issue is present in so many code paths. I wonder if we could be handling
> this in a more central way, but I don't see how short of dying.

Well, either we explicitly die in here, or let the caller segfault.
Is there even a single caller that is prepared to react to NULL?

    Answer. There is a single hit inside fsck.c that wants to report
    an error without killing ourselves in fsck_commit_buffer().  I
    however doubt its use of get_commit_tree() is correct in the
    first place.  The function is about validating the commit object
    payload manually, without trusting the result of parse_commit(),
    and it does read the object name of the tree object; the call to
    get_commit_tree() used for reporting the error there should
    probably become has_object() on the tree_oid.

So, after fixing the above, we may safely be able to die inside
get_commit_tree() instead of returning NULL.

By the way, I think get_commit_tree() and parse_commit() in fsck
should always use the value obtained from the underlying object and
bypass any caches like commit graph---if they pay attention to the
caches, they should be fixed.  Secondary caches like commit graph
should of course be validated against what are recorded in the
underlying object, but that should be done separately.
