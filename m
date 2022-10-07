Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887D3C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 01:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiJGBRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 21:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJGBRC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 21:17:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ED3B8C0C
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 18:17:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5199913F7CE;
        Thu,  6 Oct 2022 21:16:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JgZ3s6P7RxOU
        tE+qgjYqqH8T2/ayO3LSCAar8NEGQgs=; b=V7O6kMnbzY5yhLFYpvKNqZpSCUoh
        alqFhW2RyJpHnJnEIUQdOGOjTkA3JoVhn5ztwVms6xbb4anKU7vQ/kd1ElDnX6xI
        HeVrF1LlomdGt3kMZPA9a6Zn/LLli3tQ01DufGS5hKmKnA/QHsyQS+HCmtvg7uM+
        8+shC444yPjmrBI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48F4E13F7CD;
        Thu,  6 Oct 2022 21:16:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B532F13F7CB;
        Thu,  6 Oct 2022 21:16:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [RFC PATCH] trace2 API: don't save a copy of constant
 "thread_name"
In-Reply-To: <RFC-patch-1.1-8563d017137-20221007T010829Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 7 Oct
 2022 03:10:06
        +0200")
References: <xmqqr0zkipva.fsf@gitster.g>
        <RFC-patch-1.1-8563d017137-20221007T010829Z-avarab@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
Date:   Thu, 06 Oct 2022 18:16:55 -0700
Message-ID: <xmqqo7uoh1q0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BC4C8A14-45DD-11ED-8834-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A cleaned up version of the test code I had on top of "master", RFC
> because I may still be missing some context here. E.g. maybe there's a
> plan to dynamically construct these thread names?

That's nice to learn, indeed.

> +void jw_object_string_thread(struct json_writer *jw, const char *threa=
d_name,
> +			     int thread_id)
> +{
> +	object_common(jw, "thread");
> +	strbuf_addch(&jw->json, '"');
> +	jw_strbuf_add_thread_name(&jw->json, thread_name, thread_id);
> +	strbuf_addch(&jw->json, '"');
> +}

...

> @@ -107,9 +109,11 @@ static void perf_fmt_prepare(const char *event_nam=
e,
>  	}
> =20
>  	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
> -	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
> -		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
> -		    event_name);
> +	oldlen =3D buf->len;
> +	jw_strbuf_add_thread_name(buf, ctx->thread_name, ctx->thread_id);
> +	padlen =3D TR2_MAX_THREAD_NAME - (buf->len - oldlen);;
> +	strbuf_addf(buf, "%-*s | %-*s | ", padlen, "",
> +		    TR2FMT_PERF_MAX_EVENT_NAME, event_name);

Having to do strbuf_addf() many times may negatively affect perf_*
stuff, if this code is invoked in the hot path.  I however tend to
treat anything that involves an I/O not performance critical, and
this certainly falls into that category.

