Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD82E20899
	for <e@80x24.org>; Wed, 23 Aug 2017 21:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbdHWVEd (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 17:04:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63448 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751728AbdHWVEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 17:04:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17311AA499;
        Wed, 23 Aug 2017 17:04:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l8/ewfcCsIuQBHGzH+OM40/uqzA=; b=hwEsCK
        cbmMMOVv3tYB1xJbBQI4dp6V0BXB+MuaY1Q2k5hEdnuBsGybgWstTx7vk9hJ/7mk
        iCXYon5oMahfflvtiUX3ZMBG+Lh19XFfcOJ7+MCPVKleO0n6jozCgrzukQGCejiO
        4kXqzsOzPPgvjdtv5bz8elgj9ODKtSbmZYjww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W2fqBBqjD987xAIWhPRuzuuPYI06+nMW
        2bB7I2MarYWKlNgyl1Uy9pe3WrF2KJkt6ajWJhhDlWlrSqgCnPPuphVsXetHq15o
        XHXBZ9wxMUOlO3O7eQoiGV2afHgnEYBC+98RU7ItfGUPDyuwhglGBcfvOWROePaH
        G08CxLOKbyY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E418AA498;
        Wed, 23 Aug 2017 17:04:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61E63AA496;
        Wed, 23 Aug 2017 17:04:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Casey <drafnel@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
References: <cover.1502780343.git.martin.agren@gmail.com>
        <cover.1503323390.git.martin.agren@gmail.com>
        <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
        <CA+sFfMdXv+nqpXmwfLTHtkRLuGkAEAwWXZCvOryVZ=aLb_UmbA@mail.gmail.com>
Date:   Wed, 23 Aug 2017 14:04:30 -0700
In-Reply-To: <CA+sFfMdXv+nqpXmwfLTHtkRLuGkAEAwWXZCvOryVZ=aLb_UmbA@mail.gmail.com>
        (Brandon Casey's message of "Wed, 23 Aug 2017 13:37:12 -0700")
Message-ID: <xmqqh8wyxag1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A88059B6-8846-11E7-B3A8-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Casey <drafnel@gmail.com> writes:

> So is there any reason why didn't do something like the following in
> the first place?

My guess is that we didn't bother; if we cared, we would have used a
single instance of const char in a read-only segment, instead of
such a macro.

> diff --git a/strbuf.h b/strbuf.h
> index e705b94..fcca618 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -67,7 +67,7 @@ struct strbuf {
>         char *buf;
>  };
>
> -extern char strbuf_slopbuf[];
> +#define strbuf_slopbuf ""
>  #define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
>
>  /**
> @@ -147,7 +147,9 @@ static inline void strbuf_setlen(struct strbuf
> *sb, size_t len)
>         if (len > (sb->alloc ? sb->alloc - 1 : 0))
>                 die("BUG: strbuf_setlen() beyond buffer");
>         sb->len = len;
> -       sb->buf[len] = '\0';
> +       if (sb->alloc) {
> +               sb->buf[len] = '\0';
> +       }
>  }
>
> -Brandon
