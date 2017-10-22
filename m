Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F1D1FF72
	for <e@80x24.org>; Sun, 22 Oct 2017 00:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbdJVArA (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 20:47:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57715 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932266AbdJVAq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 20:46:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 502259B862;
        Sat, 21 Oct 2017 20:46:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Goaj2j9SRRFdCHX53quntXhkbQ=; b=YPmFng
        w1UIHNDXlbvLsuacJWlYw83Buy7aX38eWy+QbhrAvqMDk6bF4Ew7+k1JoupjV9N2
        4xTjLCCYTVw992lIJyat4Xf7hA0DbfMbz8NCIbNWXKRRGhlKcCgUIARntc49NRaR
        UfYBpI/T/mImze7KKjQVMUDxIYSMcAD2RjhSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rkPAzihYMwVw7aAKtWl+ATO+0y7hMQrL
        eOwwFbhQe9rrBsXKNGzsu8oyF/2f020aSaixqyQTFjVb6O02xcoXh417NjKOhQAV
        f6UiUGqRMaQwuB00ZGU0qTZZxTFPwfxoYFao3q5YkZCBaW8P1KCNq+5qmNQ220EA
        2mFc+S51+WI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48DF79B861;
        Sat, 21 Oct 2017 20:46:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0F719B860;
        Sat, 21 Oct 2017 20:46:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrey Okoshkin <a.okoshkin@samsung.com>, git@vger.kernel.org,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: Re: [PATCH v4] commit: check result of resolve_ref_unsafe
References: <CGME20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3@epcas2p4.samsung.com>
        <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
        <5fa1f5c6-249e-2aa9-5e9f-c00ebe2c0d9d@samsung.com>
        <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
        <c5f72436-df4e-5c51-d58b-8699dfcfd70c@samsung.com>
        <a9cce39c-e432-d5a7-d9ad-6b67d9e04d23@samsung.com>
        <20171021061921.xtocfdfik6ehhwzw@sigill.intra.peff.net>
Date:   Sun, 22 Oct 2017 09:46:52 +0900
In-Reply-To: <20171021061921.xtocfdfik6ehhwzw@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 21 Oct 2017 02:19:21 -0400")
Message-ID: <xmqq8tg4f1qb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F8E8762-B6C2-11E7-B7C0-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Hello,
>> I think this way is better for user experience:
>> * git doesn't crash;
>> * warning is shown;
>> * commit has been successfully created then it's safe to show a summary message
>> with already known information and without resolved HEAD.
>
> I'm on the fence between this and the die_errno() version. Given that
> this would basically never happen in practice, I don't think it matters
> too much. And that makes me want to just err on the side of simplicity.
> But it's not like this is all that complex, either.

True.  I've queued v3 for now.

Thanks, both.
