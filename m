Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A48C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 00:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhLRAJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 19:09:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63173 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhLRAJe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 19:09:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F7BA1504FA;
        Fri, 17 Dec 2021 19:09:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RMZNrWzMDoah
        3RRrHfVAkxXg49bT+rpkCOz2ZrhjK2w=; b=dGMd/YpqTEtayQuCcl4d42ccBWmR
        78T8MmbDZTmX+wd3JkBfcQm4UOdAIbMggp1d8jGHG3LcW8fX32uFQyEWoKgpBhsX
        mh96lodjfYp1B56AvRcIpHY+8fEpOVzPAuLVxXGCrb2U9ZXoJ3o982GRB/IYLd6h
        D6fVcplIOqe6BX8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43B991504F8;
        Fri, 17 Dec 2021 19:09:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F0FF1504F7;
        Fri, 17 Dec 2021 19:09:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v6 1/6] object-file.c: release strbuf in
 write_loose_object()
References: <20211210103435.83656-1-chiyutianyi@gmail.com>
        <20211217112629.12334-2-chiyutianyi@gmail.com>
        <c860c56f-ce25-4391-7f65-50c9d5d80c2c@web.de>
Date:   Fri, 17 Dec 2021 16:09:29 -0800
In-Reply-To: <c860c56f-ce25-4391-7f65-50c9d5d80c2c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 17 Dec 2021 20:28:55 +0100")
Message-ID: <xmqqa6gy22py.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C591A18C-5F96-11EC-9F3D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> There was no leak before.  Both strbufs are static and both functions
> they are passed to (loose_object_path() and create_tmpfile()) reset
> them first.  So while the allocated memory was not released before,
> it was reused.
>
> Not sure if making write_loose_object() allocate and release these
> buffers on every call has much of a performance impact.  The only
> reason I can think of for wanting such a change is to get rid of the
> static buffers, to allow the function to be used by concurrent
> threads.
>
> So I think either keeping the code as-is or also making the strbufs
> non-static would be better (but then discussing a possible
> performance impact in the commit message would be nice).

Makes sense.
