Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98FEC2D0DB
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 18:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C422465A
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 18:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BkWhsYUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAVSP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:15:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52539 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVSP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 13:15:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6C963971A;
        Wed, 22 Jan 2020 13:15:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5dZ1df3+r4GBSXYSMLiK61Mhr0c=; b=BkWhsY
        UFCOFAepNKVqoZkAnY70C5flH9s/nrGRZr+rk5cdRaOcA2wpAvKf/fOD8zN9Jq5x
        3y7Z2m1nXGp89pqrkhtpZ1rgzMo9zi3L7OXiXZnUz71olz4OxWWQXy8nQt2IhRyj
        FRCj6VyP5TSnt0b8VA8ZV6QwZk7D/N9SDSebQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TZNHKCrVTm9vkjP2TGSr/17VjN6bb8Rj
        vYKe3bRgBsU5KGW3BgygVqdSGAL17n/bAx06AlOB9F8Y6pbu/BpN2UGp/2qUqIhX
        fMN1dMf6kSHxjjpjzvpxSvHxDcCLg7Bk+aVMY/sNITxjvme9eqzfeBahIAzdMWJ9
        1S/+KyQadV0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA23A39719;
        Wed, 22 Jan 2020 13:15:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 037DE39718;
        Wed, 22 Jan 2020 13:15:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH v2 2/3] rebase -i: re-fix short SHA-1 collision
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
        <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
        <102fa568dc09c1faa2d36903ccb7e1b285dd50b2.1579304283.git.gitgitgadget@gmail.com>
        <CAPig+cT8t39UvnF2i6CDoHW4kfEGr-CRFxZKOCstCTU0YzrCgQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2001202103221.46@tvgsbejvaqbjf.bet>
        <CAPig+cR2T26nJ1G5n82r_Xi8Y84k211n6bhBxG4Ku27vaW1pWA@mail.gmail.com>
        <xmqqpnfc8o39.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2001221508180.46@tvgsbejvaqbjf.bet>
Date:   Wed, 22 Jan 2020 10:15:18 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001221508180.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 22 Jan 2020 15:10:15 +0100 (CET)")
Message-ID: <xmqqr1zr73yh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2625E346-3D43-11EA-965C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> True.  Doesn't rev-parse have an appropriate option for this kind of
>> thing that gets rid of the need for "cut" in the first place?
>
> You mean `git rev-parse --short=4`? That does something _sligthly_
> different: it tries to shorten the OID to 4 characters _unless that would
> be ambiguous_. In our case, it _will_ be ambiguous. That's why I use
> `cut`.

Ah, yes of course; we want ambiguous prefix.  I think a more
thorough test would be to see that the output with --short=$n (where
n is the length of the abbreviated object name in $colliding_sha1)
is longer than $colliding_sha1 and the output prefix-matches
$colliding_sha1 iow, something like

	abbreviated=$(git rev-parse --short=7 HEAD) &&
	case "$abbreviated" in
	"$colliding_sha1"?*) : happy ;;
	*) false ;;
	esac &&
	...

which would make sure that we are testing colliding case.


> As to the crash in `rev-parse` _after_ printing out the OID: yes, there is
> a possibility for that. But that regression test is not about `rev-parse`,
> so it is actually a good thing that it would not trigger on such a bug ;-)

No, I do not think this test should be about rev-parse working
correctly---just that if it is easy enough to make the test robust
enough against such a breakage, it would be nice to do so, that's
all.

I'm not Eric but I suspect his primary point was not about worrying
about rev-parse crashing but more about avoiding to add a pattern
less experienced developers can copy&paste without thinking enough
to realize why it would be OK here and not OK in the context of the
tests they are adding.  That would be what I would worry about more
than rev-parse crashing in the part of the test under discussion.

Thanks.

