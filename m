Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4601F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 00:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfJLAFE (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 20:05:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52339 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJLAFD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 20:05:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB3AD2D3A8;
        Fri, 11 Oct 2019 20:05:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xizHWtd3cvRlw8n3OOiA5lGmphk=; b=F/7oQd
        tF5XJtZU+JvQnToU9bCL8dAQIq7dCeIA6ayQxvuwpptWeHF1cInOazse4ivhwvyL
        sjdo7EvpJoFGLPA+wCKIeUHjB6IJJ/FhMSCrFK+jtaMCOlD994c6t59FQ1ED31U/
        3DnaW9woAkw+Sms1k8yNaza/vFA9k26z0rq6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OkCf0Wdqt57EI8Cl0FkpxU9XCbPhf2QT
        9rL3V5ALpRhinfRo54gsDMfgzAvBFtVriKapsz/ysWqiAwkViCYBze6LM6p+zQo8
        UB92GPvQ12xAUBq/4P9qB8LqJvltBz65j1lsGDGrOtVzgCBiD9atrm3PiBC46JP1
        Kfchf0e+l0w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F8122D3A6;
        Fri, 11 Oct 2019 20:05:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9F762D3A5;
        Fri, 11 Oct 2019 20:04:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, git@vger.kernel.org,
        chriscool@tuxfamily.org, ramsay@ramsayjones.plus.com
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
References: <20190913130226.7449-11-chriscool@tuxfamily.org>
        <20191010235952.174426-1-jonathantanmy@google.com>
        <20191011180125.GA20601@sigill.intra.peff.net>
Date:   Sat, 12 Oct 2019 09:04:58 +0900
In-Reply-To: <20191011180125.GA20601@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 11 Oct 2019 14:01:25 -0400")
Message-ID: <xmqqsgnyg76d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE8081A4-EC83-11E9-8525-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The current code does so by creating a new entry in the reused_chunks
> array. In the worst case that can grow to have the same number of
> entries as we have objects. So this code was an attempt to pad the
> header of a shrunken entry to keep it the same size. I don't remember
> all the problems we ran into with that, but in the end we found that it
> didn't actually help much, because in practice we don't end up with a
> lot of chunks anyway.

Hmm, I am kind of surprised that the decoding side allowed such a
padding.

> For instance, packing torvalds/linux on our servers just now reused 6.5M
> objects, but only needed ~50k chunks.

OK, that's a good argument for not trying to optimize.

> I think the original code may simply have been buggy and nobody noticed.
> Here's what I wrote when this line was added in our fork:
>
>       pack-objects: check reused pack bitmap for duplicate objects
>   
>       If a client both asks for a tag by sha1 and specifies
>       "include-tag", we may end up including the tag in the reuse
>       bitmap (due to the first thing), and then later adding it to
>       the packlist (due to the second). This results in duplicate
>       objects in the pack, which git chokes on. We should notice
>       that we are already including it when doing the include-tag
>       portion, and avoid adding it to the packlist.
>   
>       The simplest place to fix this is right in add_ref_tag,
>       where we could avoid peeling the tag at all if we know that
>       we are already including it. However, I've pushed the check
>       instead into have_duplicate_entry. This fixes not only this
>       case, but also means that we cannot have any similar
>       problems lurking in other code.
>   
>       No tests, because git does not actually exhibit this "ask
>       for it and also include-tag" behavior. We do one or the
>       other on clone, depending on whether --single-branch is set.
>       However, libgit2 does both.
>
> I'm not sure why we didn't notice it with the older reuse code. It may
> simply have been that it hardly ever triggered on our servers.

Impressed by the careful thinking here.

Thanks.
