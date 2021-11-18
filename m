Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16ACC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 06:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1C461B2B
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 06:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbhKRGsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 01:48:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50490 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbhKRGsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 01:48:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C772E161E6A;
        Thu, 18 Nov 2021 01:45:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eiTd6V3xgcjDQdVv7/ONWus7yoZQWC7dIxZSrL
        qKNpQ=; b=EklSIMRqdC8G2NSO6aPzMVkOdErX+59ySDkXMiKruZAocB5/8ehwGd
        ti7mp+X+y/y9s3MKWHrAm+vPYaIESGoYhJJJy98fa32hDJjNUOVsajmE6zrEHDYz
        zdH7FjnVhRZt2p1zIW9h4GjoRv0Ke8joplF9qJZA/5rWMIOKlKN68=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF238161E69;
        Thu, 18 Nov 2021 01:45:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2B42F161E68;
        Thu, 18 Nov 2021 01:45:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v2 1/6] object-file: refactor write_loose_object() to
 support inputstream
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
        <20211112094010.73468-1-chiyutianyi@gmail.com>
        <CANYiYbHiTnhpzyWLakVZ6tfmG0pKO=qHdZsgaocX6eJ=PN_06g@mail.gmail.com>
Date:   Wed, 17 Nov 2021 22:45:14 -0800
In-Reply-To: <CANYiYbHiTnhpzyWLakVZ6tfmG0pKO=qHdZsgaocX6eJ=PN_06g@mail.gmail.com>
        (Jiang Xin's message of "Thu, 18 Nov 2021 12:59:04 +0800")
Message-ID: <xmqq7dd6ynb9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16A6CBD8-483B-11EC-99ED-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> On Fri, Nov 12, 2021 at 5:43 PM Han Xin <chiyutianyi@gmail.com> wrote:
>>
>> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> It would be better to provide a cover letter describing changes in v2, such as:
>
> * Make "write_loose_object()" a public method, so we can
>    reuse it in "unpack_non_delta_entry()".
>    (But I doubt we can use "write_object_file_flags()" public
>      function, without make this change.)
>
> * Add an new interface "input_stream" as an argument for
>    "write_loose_object()", so that we can feed data to
>    "write_loose_object()" from buffer or from zlib stream.
>
>> Refactor write_loose_object() to support inputstream, in the same way
>> that zlib reading is chunked.
>
> In the beginning of your commit log, you should describe the problem, such as:
>
> We used to read the full content of a blob into buffer in
> "unpack_non_delta_entry()" by calling:
>
>     void *buf = get_data(size);
>
> This will consume lots of memory for a very big blob object.

I was not sure where "in_stream" came from---"use X insteads of Y",
when X is what these patches invent and introduce, does not make a
good explanation without explaining what X is, what problem X is
attempting to solve and how.

Thanks for helping to clarify the proposed log message.  
