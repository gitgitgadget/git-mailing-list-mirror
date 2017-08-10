Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2576C208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 20:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753286AbdHJUtf (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 16:49:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54390 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753139AbdHJUte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 16:49:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CC2B9DFD6;
        Thu, 10 Aug 2017 16:49:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=seVjstAMqkOmurxzS7JlTinPmmI=; b=JN4bF2
        FEY3YlL7Bn7dDgsyelr03WWItKUTlPo3/+tfUOxn9gzfPaMW6z9sxILVCpilLGpj
        m3XnaPISeLOnvl9uur/aiaVj/EFAnPeTtnRW6zUDE5AjuyPNI/QTl7l+DwWSsM7a
        Z7i5sjU43IQYVuM8UBw/KVwzE4msTNVs1IBEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H0e36mZhxeGBu4O7KzGuSlHm1uW3Zwlx
        xLf6g3daipBcMZhvCH89Lvq7KCJQbSWmvER4XV7vq7bPwGO3UqqCQw4Q349mEF2Z
        x1mVosagXHwzclsxdnlxvWqnoPoLovAqY1E0NHuUGq6jloS+PY1PbX2PdGu3hXUo
        cD4lejh9qZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4131B9DFD5;
        Thu, 10 Aug 2017 16:49:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68B759DFD1;
        Thu, 10 Aug 2017 16:49:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 4/4] Fix delta offset overflow
References: <1502388789-5775-1-git-send-email-martin@mail.zuhause>
        <1502388789-5775-2-git-send-email-martin@mail.zuhause>
Date:   Thu, 10 Aug 2017 13:49:24 -0700
In-Reply-To: <1502388789-5775-2-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Thu, 10 Aug 2017 20:13:09 +0200")
Message-ID: <xmqqbmnn2lnv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65218D90-7E0D-11E7-8D89-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> From: Martin Koegler <martin.koegler@chello.at>
>
> Prevent generating delta offsets beyond 4G.
>
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---
>  diff-delta.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/diff-delta.c b/diff-delta.c
> index 3d5e1ef..633883e 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -454,6 +454,9 @@ create_delta(const struct delta_index *index,
>  			moff += msize;
>  			msize = left;
>  
> +			if (moff > 0xffffffff)
> +				msize = 0;
> +

The lower 4-byte of moff (before incrementing it with msize) were
already encoded to the output stream before this hunk.  Shouldn't
we be checking if moff would fit in uint32_t _before_ that happens?

IOW, in a much earlier part of that "while (data < top)" loop, there
is a code that tries to find a match that gives us a large msize by
iterating over index->hash[], and it sets msize and moff as a potential
location that we may want to use.  If moff is already big there, then
we shouldn't consider it a match because we cannot encode its location
using 4-byte anyway, no?

Cutting it off at here by resetting msize to 0 might help the next
iteration (I didn't check, but is the effect of it is to corrupt the
"val" rolling checksum and make it unlikely that the hash
computation would not find a correct match?) but it somehow feels
like closing the barn door after the horse has already bolted...

>  			if (msize < 4096) {
>  				int j;
>  				val = 0;
