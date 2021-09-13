Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0316AC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 05:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD49960FF2
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 05:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhIMFjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 01:39:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55173 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhIMFj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 01:39:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E8A5E2630;
        Mon, 13 Sep 2021 01:38:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=RL3mQaxsJG9AfD7f92hGU8Cry
        K/aTm/Wc9vAdGE4rFc=; b=oAncVkrbbSSIHrnCxAlvKhQCsARERSqydC8HvkxyU
        3bULXp/YktPJzqtAOcmRdPfjNGwKMSOelV6S7I4HG458KVlMfJ2UdWX4nVSNY23p
        9RccOcfbElx2VlND0hrWA048PfFrwrKBYEIirLuZx/wX/MUkwPDN0UrnvLF6Pmgp
        pU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87F99E262F;
        Mon, 13 Sep 2021 01:38:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F048BE262E;
        Mon, 13 Sep 2021 01:38:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 0/7] strvec: use size_t to store nr and alloc
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
        <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
        <YT586/CO7QsTb3TK@coredump.intra.peff.net>
Date:   Sun, 12 Sep 2021 22:38:11 -0700
Message-ID: <xmqqlf41ghmk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C8C7ED30-1454-11EC-97B7-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm a little "meh" on some of these, for a few reasons:
>
>  - anything calling into setup_revisions() eventually is just kicking
>    the can anyway. And these are generally not buggy in the first place=
,
>    since they're bounded argv creations.
>
>  - passing a strvec instead of the broken-down pair is a less flexible
>    interface. It's one thing if the callee benefits from seeing the
>    strvec (say, because they may push more items onto it). But I think
>    with strbufs, we have a general guideline that if a function _can_
>    take the bare pointer, then it should. (Sorry, I don't have a
>    succinct reference to CodingGuidelines or anything like that; I feel
>    like this is wisdom we came up with on the list in the early days of
>    strbufs).
>
>  - if we are going to pass a strvec, it should almost certainly be
>    const, to make it clear how we intend to use it.

All true.

> These cases are largely stupid things that real people would never come
> across. The real goal is making sure we don't get hit with a memory
> safety bug (under-allocation, converting a big size_t to a negative int=
,
> etc).

Yes. =20

=C3=86var, I do not mean any disrespect to you, but I have to say that
topics like this one are starting to wear my concentration and
patience down really thin and making me really slow down.

Perhaps I am biased by not yet having seen what you eventually want
to build on top, and because of that I do not understood why and how
these "clean ups" are so valuable to have right now (as opposed to
just letting the sleeping dog lie), which you would of course have a
much better chance to know than I do.

But with that "bias", many of the recent patches from you look more
like pointless churn, mixed with fixes to theoretical problems, than
clean-ups with real benefits.

What makes it worse is that there are occasional real gems among
these "meh" patches, which means I have to read all of them anyway
to sift wheat from chaff X-<.
