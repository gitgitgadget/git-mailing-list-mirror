Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E793D1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 07:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfKHHkJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 02:40:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60203 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfKHHkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 02:40:09 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 774C2986F4;
        Fri,  8 Nov 2019 02:40:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Eob6J33B9EAPPiMBhoJnu5fc0Pk=; b=XDSCNs
        j1mWtNpyBgPC4V6sQlpJXA1mmuC9IQOmREQ7okJneQcioKjzs/A3DjNt1RWh/Hfm
        uaimOntDqW4QxCx+BRAOlOz9VUkijbv3M1hCozKe2epO+uxMh+zMavxhZ7ODtqJF
        +PeBaRv5QCcPccKB+agwy0z2UzG3lwQGs2TNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H7Bw3UchCKxkn/hz5jGvOreCinDjHz3u
        ZDQOCoOgfKx0FYHP4xvKhySoKeh5ZfXCqeeHiXfQ9fsU4Uv+xjHnp9EMOdaO9c3M
        1KsjxQlyOhJgYhMxXy8BuTs2BolVXCQIgnLz1Qs7U/G0KhzBlOzH1MDql7Z1P1rB
        6jFk5eYUvBo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6ED1F986F3;
        Fri,  8 Nov 2019 02:40:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 76D83986F2;
        Fri,  8 Nov 2019 02:40:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2] fetch: remove fetch_if_missing=0
References: <20191101203830.231676-1-jonathantanmy@google.com>
        <20191105185619.207173-1-jonathantanmy@google.com>
        <xmqqr22inagr.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 08 Nov 2019 16:40:02 +0900
In-Reply-To: <xmqqr22inagr.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 08 Nov 2019 15:33:40 +0900")
Message-ID: <xmqqmud6n7e5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB2279E4-01FA-11EA-B2AB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> An interesting thing is that c32ca691c2^2 that moved the assignment
> to this big red switch variable around causes 3-way merge to fail in
> a miserable way.  The "moving around" would involve removing from
> the same location as the rebased patch below removes, plus adding
> the assignment elsewhere, so "both sides removed the assignment from
> this hunk, so take that" would correctly leave the original assignment
> we see in the second hunk above removed, but fails to notice that
> the assignment made elsewhere (the result of "moving around" patch)
> is no longer needed, because "c32ca691c2^2 added one and this change
> does not do anything there, so take the addition" cleanly resolves
> to an incorrect merge result.

Total tangent.  One frustrating thing is that we do this a bit
better at the tree level merge.  After read-tree does three-way
merge at the tree level, what is passed to the merge-recursive
machinery has "side A added" and "side A removed" left unresolved,
so that the post-processing phase could try to match them up and say
"aha, side A moved that path elsewhere while side B just removed,
which is a conflict".  

I wish if xdiff/xmerge.c could learn a similar trick, but the
necessary change feels quite involved, error prone and too magical.



