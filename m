Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76FEC41535
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940AD61059
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbhIITkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:40:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58547 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343755AbhIITkG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 15:40:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F278C155BAE;
        Thu,  9 Sep 2021 15:38:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KVB7XRiMK9Ws
        8LyjLryBqG7AGhjoVY5AlaA69dgKW34=; b=Nuq1AgKtOjdwji6n0/7bAQmPZjB6
        XldMT5/Vmbj85kW+xeD3Q1DPsdQxBnxMcMMkixRgAxUHmkTl6vorzZSC2WN7tO4J
        OxmTC3QUnnic1vMlMDcs0hlykURM4G8QNNIVm48i476ySUL226CLU6nUbqRT5jE5
        BDhgwfR98t2WTuc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC093155BAD;
        Thu,  9 Sep 2021 15:38:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 41660155BAB;
        Thu,  9 Sep 2021 15:38:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 5/9] builtin/repack.c: move `.idx` files into place last
References: <cover.1630461918.git.me@ttaylorr.com>
        <cover.1631157880.git.me@ttaylorr.com>
        <3b10a97ec0e7c9e672904e6415909a1b8cea872e.1631157880.git.me@ttaylorr.com>
Date:   Thu, 09 Sep 2021 12:38:52 -0700
In-Reply-To: <3b10a97ec0e7c9e672904e6415909a1b8cea872e.1631157880.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 8 Sep 2021 23:25:03 -0400")
Message-ID: <xmqqa6klzghf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91120544-11A5-11EC-90E7-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In a similar spirit as the previous patch, fix the identical problem
> from `git repack` (which invokes `pack-objects` with a temporary
> location for output, and then moves the files into their final location=
s
> itself).

OK.  This array is used in cmd_repack() to call rename() in the
order in which its elements appear, so moving the entry to the last
means it will be renamed the last.

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/repack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 5f9bc74adc..c3e4771609 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -208,10 +208,10 @@ static struct {
>  	unsigned optional:1;
>  } exts[] =3D {
>  	{".pack"},
> -	{".idx"},
>  	{".rev", 1},
>  	{".bitmap", 1},
>  	{".promisor", 1},
> +	{".idx"},
>  };

And the .idx entry MUST stay the last.  I wonder if dropping the
trailing comma and replace it with a "/* must be at the end */"
comment would be an effective way to ensure that.
