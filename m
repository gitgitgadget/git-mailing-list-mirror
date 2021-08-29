Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD501C432BE
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 23:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9251B60F12
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 23:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhH2Xzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 19:55:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63364 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhH2Xzn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 19:55:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8DAEED134;
        Sun, 29 Aug 2021 19:54:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z/O31za1RK+p
        CidxROiNlBJgik8b3DoAcpyddipn+dE=; b=Wlg1TLuu+yxq63U0F/omH8GyhECl
        6/qCU8dTnXgx4a3IuWARsPkqRQJ531AFiFETFbWdS7WQljskTMp3XTrc4UKYJHjO
        Z8Ht/5xdwFxP7QDYxjX8BAwfLDqmf3RNdHrsIYtMoIHVrB33ll93LIkeFjToK5LX
        XhZhh/5tFkyqufk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FF37ED133;
        Sun, 29 Aug 2021 19:54:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D91AED132;
        Sun, 29 Aug 2021 19:54:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 2/5] strvec: add a strvec_pushvec()
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
        <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
        <patch-v3-2.5-321b8ba3f0e-20210826T140414Z-avarab@gmail.com>
        <xmqq8s0m9xbl.fsf@gitster.g> <xmqq4kba9x1h.fsf@gitster.g>
        <YSm3ofxlRB1ViBf5@coredump.intra.peff.net>
Date:   Sun, 29 Aug 2021 16:54:49 -0700
In-Reply-To: <YSm3ofxlRB1ViBf5@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 28 Aug 2021 00:12:17 -0400")
Message-ID: <xmqqzgsz7qnq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F5ECBFE-0924-11EC-8B00-D601C7D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we'd want the patch below. It can be applied independently
> (though if we do take the index-iterating version of =C3=86var's patch,=
 I
> think it should switch to size_t).

Yeah, I do not see a strong need for _pushvec(), especially the
variant that does not preallocate, when we have _pushv().  But the
type fix below does make sense.

> -- >8 --
> Subject: [PATCH] strvec: use size_t to store nr and alloc
>
> We converted argv_array (which later became strvec) to use size_t in
> 819f0e76b1 (argv-array: use size_t for count and alloc, 2020-07-28) in
> order to avoid the possibility of integer overflow. But later, commit
> d70a9eb611 (strvec: rename struct fields, 2020-07-28) accidentally
> converted these back to ints!
>
> Those two commits were part of the same patch series. I'm pretty sure
> what happened is that they were originally written in the opposite orde=
r
> and then cleaned up and re-ordered during an interactive rebase. And
> when resolving the inevitable conflict, I mistakenly took the "rename"
> patch completely, accidentally dropping the type change.
>
> We can correct it now; better late than never.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  strvec.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/strvec.h b/strvec.h
> index fdcad75b45..6b3cbd6758 100644
> --- a/strvec.h
> +++ b/strvec.h
> @@ -29,8 +29,8 @@ extern const char *empty_strvec[];
>   */
>  struct strvec {
>  	const char **v;
> -	int nr;
> -	int alloc;
> +	size_t nr;
> +	size_t alloc;
>  };
> =20
>  #define STRVEC_INIT { empty_strvec, 0, 0 }
