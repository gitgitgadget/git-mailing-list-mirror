Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B387C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 15:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C5D61375
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 15:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245436AbhGSOik (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 10:38:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55170 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244851AbhGSOgw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 10:36:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 88F50147099;
        Mon, 19 Jul 2021 11:17:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pxKv55g3RXWX
        PMtKkpRsNK82GBgtL/MmVC1T7119+5Q=; b=WXJS6GIILo20mLZTCF37Wk3gcjad
        t6WcSaR+iqGDBMI6Fj5/MzXMbAp92kXbH/+BYPxUk9+oNP+oW4+X9emxonjouxC/
        nOMsS09aWV/z2giOaNFEJVtcLKSwOgPP+uF1eVoTyebtFYgE9NrtgxI6vFMTQI2R
        DX3ov7Y4k9p7kHM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 80A96147098;
        Mon, 19 Jul 2021 11:17:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 360F4147096;
        Mon, 19 Jul 2021 11:17:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Clemens Fruhwirth <clemens@endorphin.org>,
        Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Subject: Re: [PATCH] pull, fetch: fix segfault in --set-upstream option
References: <8636b96be256b47d207e543995abbecde9ca5055.camel@fnusa.cz>
        <patch-1.1-2d8f3e59e1f-20210719T142808Z-avarab@gmail.com>
Date:   Mon, 19 Jul 2021 08:17:26 -0700
In-Reply-To: <patch-1.1-2d8f3e59e1f-20210719T142808Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 19 Jul
 2021 16:30:51 +0200")
Message-ID: <xmqqsg0anxix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6DFAFE1E-E8A4-11EB-8E2C-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a segfault in the --set-upstream option added in
> 24bc1a12926 (pull, fetch: add --set-upstream option, 2019-08-19) added
> in v2.24.0.
>
> The code added there did not do the same checking we do for "git
> branch" itself since 8efb8899cfe (branch: segfault fixes and
> validation, 2013-02-23), which in turn fixed the same sort of segfault
> I'm fixing now in "git branch --set-upstream-to", see
> 6183d826ba6 (branch: introduce --set-upstream-to, 2012-08-20).
>
> The error message I'm adding here is an amalgamation of the error
> added for "git branch" in 8efb8899cfe, and the error output
> install_branch_config() itself emits, i.e. it trims "refs/heads/" from
> the name and says "branch X on remote", not "branch refs/heads/X on
> remote".
>
> Reported-by: Clemens Fruhwirth <clemens@endorphin.org>
> Reported-by: Jan Pokorn=C3=BD <poki@fnusa.cz>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>

Hmph, there is 5e0fa8cb (fetch: fix segfault on --set-upstream while
on a detached HEAD, 2021-07-06) from Clemens, which warns and skips
instead of dies.  Given that a handful of other conditions in this
function results in warnings "not setting upstream due to X", it
might be more in line with the spirit of the current system (it is
debatable if we should stress the fact that we did not set the
configuration with hard dying, though).


> ---
>
> On Mon, Jul 19 2021, Jan Pokorn=C3=BD wrote:
>
>> Hello,
>>
>> Clemens Fruhwirth p=C3=AD=C5=A1e v Po 05. 07. 2021 v 17:46 +0200:
>>> What did you do before the bug happened? (Steps to reproduce your
>>> issue)
>>>=20
>>> Run "git pull origin nixos-unstable --rebase --set-upstream"
>>> on a repo that had no branch set, e.g. when running "git branch" gave
>>> "* (no branch)"
>>>=20
>
> Thanks for the report both & sorry that this fell through the cracks
> for so long.
>
> The bug itself seems rather obvious given the benefit of that
> reproduction scenario & backtrace, as noted above we've been playing
> whack-a-mole with a related segfault since 2012.
>
> It would be nice if you could test this patch and confirm, but given
> the trivality of the segfault it shouldn't be necessary, I'm confident
> that this fixes the bug you two reported. Thanks both!
>
>  builtin/fetch.c         | 11 +++++++++++
>  t/t5553-set-upstream.sh | 22 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 9191620e50c..c2eac8f15e5 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1623,6 +1623,17 @@ static int do_fetch(struct transport *transport,
>  			}
>  		}
>  		if (source_ref) {
> +			if (!branch) {
> +				const char *shortname =3D NULL;
> +				if (!skip_prefix(source_ref->name,
> +						 "refs/heads/", &shortname))
> +					shortname =3D source_ref->name;
> +				   =20
> +				die(_("could not set upstream of HEAD to '%s' from '%s' when "
> +				      "it does not point to any branch."),
> +				    shortname, transport->remote->name);
> +			}
> +
>  			if (!strcmp(source_ref->name, "HEAD") ||
>  			    starts_with(source_ref->name, "refs/heads/"))
>  				install_branch_config(0,
> diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
> index b1d614ce18c..ae90554645e 100755
> --- a/t/t5553-set-upstream.sh
> +++ b/t/t5553-set-upstream.sh
> @@ -91,6 +91,17 @@ test_expect_success 'fetch --set-upstream with valid=
 URL sets upstream to URL' '
>  	check_config_missing other2
>  '
> =20
> +test_expect_success 'fetch --set-upstream with a detached HEAD' '
> +	git checkout HEAD^0 &&
> +	test_when_finished "git checkout -" &&
> +	cat >expect <<-\EOF &&
> +	fatal: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'ups=
tream'"'"' when it does not point to any branch.
> +	EOF
> +	test_must_fail git fetch --set-upstream upstream main 2>actual.raw &&
> +	grep ^fatal: actual.raw >actual &&
> +	test_cmp expect actual
> +'
> +
>  # tests for pull --set-upstream
> =20
>  test_expect_success 'setup bare parent pull' '
> @@ -178,4 +189,15 @@ test_expect_success 'pull --set-upstream with vali=
d URL and branch sets branch'
>  	check_config_missing other2
>  '
> =20
> +test_expect_success 'pull --set-upstream with a detached HEAD' '
> +	git checkout HEAD^0 &&
> +	test_when_finished "git checkout -" &&
> +	cat >expect <<-\EOF &&
> +	fatal: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'ups=
tream'"'"' when it does not point to any branch.
> +	EOF
> +	test_must_fail git pull --set-upstream upstream main 2>actual.raw &&
> +	grep ^fatal: actual.raw >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
