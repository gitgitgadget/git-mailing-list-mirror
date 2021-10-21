Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A395C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4970561037
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhJUXe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:34:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63773 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUXe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 19:34:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45712EDCA3;
        Thu, 21 Oct 2021 19:32:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=F2IOSSu4UV7p
        TshY9QZykbiPik+Gr0F5qXduRH4gFPQ=; b=YmpGXB6mLi+ML0QwBxQeMZENIlE+
        WGySN6nafEUkgYXDakZ0DfteCW32Fu0xa2oJj44yjNFhiJB1ghTqqS86i15hxkn7
        /TQ1toWoWoZMVQtT7OxGr9BxIbrA1ApuJ9ViTZvAUDPCqneqcMCJCpjoWVLvS+kf
        TXfLsBqz+M6BZBk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C2C2EDCA2;
        Thu, 21 Oct 2021 19:32:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A57C9EDCA1;
        Thu, 21 Oct 2021 19:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 3/3] config.c: free(expanded) before die(), work
 around GCC oddity
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
        <patch-v2-3.3-d812358e331-20211021T195133Z-avarab@gmail.com>
Date:   Thu, 21 Oct 2021 16:32:07 -0700
In-Reply-To: <patch-v2-3.3-d812358e331-20211021T195133Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Oct
 2021 21:54:15
        +0200")
Message-ID: <xmqqilxqgdjc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1BBDE40A-32C7-11EC-BA47-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  cleanup:
>  	strbuf_release(&buf);
>  	free(expanded);
> -	return ret;
> +	if (!die_depth)
> +		return ret;
> +	die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
> +	    !cf ? "<unknown>" : cf->name ? cf->name : "the command line");
>  }

Yuck.  With or without compiler bugs, this code is too ugly to live,
isn't it?
