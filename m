Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC06C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1C36103D
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhJLURX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:17:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55580 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhJLURV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 16:17:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E6E114B9ED;
        Tue, 12 Oct 2021 16:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QSkvf8m6wB/q
        HLCMLFWYlhxTks8OkX/Z8+dmXzsRK3E=; b=lOtlSqeX6IZIbCYs19XB9ZWon9kY
        xfdhKOw4D4zzc+UhuhG2PjsaLl18PST3C0/K/OGz+s+zl95gi/uRpBaqQgrDCc4v
        W7xFQ1B7U/3W7N7IBGm8X11h6c85bNax4hFBOD2i+HnvkUQHBvcFmOStLDSro0sI
        hlbhR1XRsByusGU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0807114B9EC;
        Tue, 12 Oct 2021 16:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8ACA014B9EA;
        Tue, 12 Oct 2021 16:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git.mexon@spamgourmet.com, git@vger.kernel.org
Subject: Re: [PATCH] add: don't write objects with --dry-run
References: <a2c0deed-fff3-6c1c-633f-af9dffea1e02@exon.name>
        <0131d21f-dabd-3da5-34bd-a570e990f9e0@web.de>
Date:   Tue, 12 Oct 2021 13:15:15 -0700
In-Reply-To: <0131d21f-dabd-3da5-34bd-a570e990f9e0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 12 Oct 2021 21:15:50 +0200")
Message-ID: <xmqqr1cq2e5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1D74D3BA-2B99-11EC-8DAC-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> When the option --dry-run/-n is given, "git add" doesn't change the
> index, but still writes out new object files.  Only hash the latter
> without writing instead to make the run as dry as possible.
>
> Use this opportunity to also make the hash_flags variable unsigned,
> to match the index_path() parameter it is used as.
>
> Reported-by: git.mexon@spamgourmet.com
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Am I missing something?  Do we sometimes rely on the written objects
> within the "git add --dry-run" command?

Good question.  I do not think of anything offhand, but this obvious
"omission" makes me suspect that we may be forgetting something.

Thanks.


>  read-cache.c          | 2 +-
>  t/t2200-add-update.sh | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index a78b88a41b..7fcc948077 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -738,7 +738,7 @@ int add_to_index(struct index_state *istate, const =
char *path, struct stat *st,
>  	int intent_only =3D flags & ADD_CACHE_INTENT;
>  	int add_option =3D (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
>  			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
> -	int hash_flags =3D HASH_WRITE_OBJECT;
> +	unsigned hash_flags =3D pretend ? 0 : HASH_WRITE_OBJECT;
>  	struct object_id oid;
>
>  	if (flags & ADD_CACHE_RENORMALIZE)
> diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
> index 45ca35d60a..94c4cb0672 100755
> --- a/t/t2200-add-update.sh
> +++ b/t/t2200-add-update.sh
> @@ -129,12 +129,15 @@ test_expect_success 'add -n -u should not add but=
 just report' '
>  		echo "remove '\''top'\''"
>  	) >expect &&
>  	before=3D$(git ls-files -s check top) &&
> +	git count-objects -v >objects_before &&
>  	echo changed >>check &&
>  	rm -f top &&
>  	git add -n -u >actual &&
>  	after=3D$(git ls-files -s check top) &&
> +	git count-objects -v >objects_after &&
>
>  	test "$before" =3D "$after" &&
> +	test_cmp objects_before objects_after &&
>  	test_cmp expect actual
>
>  '
> --
> 2.33.0
