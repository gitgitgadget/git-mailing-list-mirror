Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4195C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 00:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29076054E
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 00:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJVAYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 20:24:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51815 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbhJVAYs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 20:24:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BB46164214;
        Thu, 21 Oct 2021 20:22:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=U680B1Xemrmd
        O99sI3bj9PoLd8cEqKRxEbQBDXsxP+8=; b=D6Zfxa0AEsd8GZVvdmBd3sdOGUMO
        K8P5cbnSUx8bv2bEEd1ersCqG3AY/kiCMV0mtow0fW6veOwBOvZsyS7W0a0eJHKt
        TZH1SvZ/5X+R85z8l1pZNbgvk5ALul165rQKbNGn9EoIGbd2E5fouzK2UB2pzxjQ
        ow2kJxn18OlrqRg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 141B1164213;
        Thu, 21 Oct 2021 20:22:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F85A164212;
        Thu, 21 Oct 2021 20:22:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 6/6] repack: stop leaking a "struct child_process"
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
        <patch-6.6-526d5649156-20211021T155529Z-avarab@gmail.com>
Date:   Thu, 21 Oct 2021 17:22:28 -0700
In-Reply-To: <patch-6.6-526d5649156-20211021T155529Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Oct
 2021 17:57:37 +0200")
Message-ID: <xmqqa6j1gb7f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 244390BE-32CE-11EC-ADD3-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/repack.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 0b2d1e5d82b..50730517c7b 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -258,9 +258,11 @@ static void repack_promisor_objects(const struct p=
ack_objects_args *args,
>  	for_each_packed_object(write_oid, &cmd,
>  			       FOR_EACH_OBJECT_PROMISOR_ONLY);
> =20
> -	if (cmd.in =3D=3D -1)
> +	if (cmd.in =3D=3D -1) {
> +		child_process_clear(&cmd);
>  		/* No packed objects; cmd was never started */
>  		return;
> +	}
> =20
>  	close(cmd.in);

Not wrong per-se, but let's take the one that is part of Taylor's
"plug pack bitmap leaks" series that plugs the same leak.
