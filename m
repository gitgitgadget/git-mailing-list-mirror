Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027E1C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D191760FD9
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhJUXyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:54:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60920 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUXye (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 19:54:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF76D163F31;
        Thu, 21 Oct 2021 19:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nUMAjxZ/GYzF
        o4fM/rNJFy+Gddrgk3YshV0L0HHRDzA=; b=t/0wxFDgViURzNtvoRX1YXw8VgWb
        OmWb9S/S7/qHnYnFzQq8knMdJKG5B6Sk2/ovyqW5bIhgU6lzCyObYTvjHMVoWacF
        oh5kTqk5o2kBxHUkUodi5RETQ9c6ojmpy3dwVTwRyxUBbAMfB9HIFs0C6CaHyGem
        TFBI83z6AGgDs2Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B914C163F30;
        Thu, 21 Oct 2021 19:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 27DBD163F2F;
        Thu, 21 Oct 2021 19:52:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/6] grep: prefer "struct grep_opt" over its "void *"
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
        <patch-1.6-2bdd21e4e59-20211021T155529Z-avarab@gmail.com>
Date:   Thu, 21 Oct 2021 16:52:14 -0700
In-Reply-To: <patch-1.6-2bdd21e4e59-20211021T155529Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Oct
 2021 17:57:32 +0200")
Message-ID: <xmqqv91qey1d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EADCCB3C-32C9-11EC-9E78-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Subject: Re: [PATCH 1/6] grep: prefer "struct grep_opt" over its "void =
*"

I sense an incomplete sentence.  "counterpart" or "equivalent" is
missing at the tail, perhaps?

> Stylistically fix up code added in bfac23d9534 (grep: Fix two memory
> leaks, 2010-01-30). We usually don't use the "arg" at all once we've
> unpacked it into the struct we want, let's not do that here when we're

As we do not unpack and instead take it as a whole and cast, "we've
unpacked it into" -> "we've casted it to".




> freeing it. Perhaps it was thought that a cast to "void *" would
> otherwise be needed?
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/grep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 8af5249a7bb..fd184c182a3 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -199,8 +199,8 @@ static void *run(void *arg)
>  		grep_source_clear_data(&w->source);
>  		work_done(w);
>  	}
> -	free_grep_patterns(arg);
> -	free(arg);
> +	free_grep_patterns(opt);
> +	free(opt);
> =20
>  	return (void*) (intptr_t) hit;
>  }
