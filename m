Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05E5CA0ECD
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348977AbjIKVcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244288AbjIKTzh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 15:55:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392AA1A2
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 12:55:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B76E1C26F0;
        Mon, 11 Sep 2023 15:55:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=If1oUKDUxSrn
        sC7dKv1DeNF3MdBOCqWM/h91qKDBkMI=; b=EEHiJzCIRxolLvydpmwQJRyLxh92
        FEKbYQ7MS+n6nh79atTtgZT4Pvp2E9MxK/1UG0dpR1Y4LZfeRbwQo0si8iBfIzFv
        YUu1+IowJ/bKUvmqQh6WYoWJoyw7pMfVIdJNs9kUR5hU6WAfiZz5hn/pG5Pm/lj5
        Q5Nu2r08N3Tprp4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 631631C26EF;
        Mon, 11 Sep 2023 15:55:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCC961C26EE;
        Mon, 11 Sep 2023 15:55:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/1] range-diff: treat notes like `log`
In-Reply-To: <a37dfb3748e23b4f5081bc9a3c80a5c546101f1d.1694383248.git.code@khaugsbakk.name>
        (Kristoffer Haugsbakk's message of "Mon, 11 Sep 2023 00:06:23 +0200")
References: <cover.1693584310.git.code@khaugsbakk.name>
        <cover.1694383247.git.code@khaugsbakk.name>
        <a37dfb3748e23b4f5081bc9a3c80a5c546101f1d.1694383248.git.code@khaugsbakk.name>
Date:   Mon, 11 Sep 2023 12:55:26 -0700
Message-ID: <xmqqzg1strgx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 27AAE2DC-50DD-11EE-A896-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

>> To fix this explicitly set the output format of the internally execute=
d
>> `git log` with `--pretty=3Dmedium`. Because that cancels `--notes`, ad=
d
>> explicitly `--notes` at the end.
>
> =C2=A7 Authors
>
> =E2=80=A2 Fix by Johannes
> =E2=80=A2 Tests by Kristoffer
>
> =E2=80=A0 1: See e.g. 66b2ed09c2 (Fix "log" family not to be too agress=
ive about
>     showing notes, 2010-01-20).
>
> Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---

OK, Dscho, does this round look acceptable to you?

It feels UGLY to iterate over args _without_ actually parsing them,
at least to me.  Such a non-parsing look breaks at least in two ways
over time. (1) a mechanism may be introduced laster, similar to
"--", that allows other_arg->v[] array to mark "here is where the
dashed options end".  Now the existing loop keeps reading to the end
and finds "--notes" that is not a dashed option but is part of the
normal command line arguments in "other arg".  (2) Among the dashed
options passed in the other_arg->v[], there may be an option that
takes a string value, and a value that happens to be "--notes" is
mistaken as asking for "notes" (iow "git log -G --notes" is looking
for commits with changes that contain "double dash followed by en oh
tee ee es").

I think "git range-diff -G --notes" (or "-S --notes") shows that
this new non-parsing loop is already broken.  It looks for a change
that has "--notes" correctly, but at the same time, triggers that
"ah, we have an explicit --notes so drop the implicit_notes_arg
flag" logic.

>  range-diff.c          | 13 +++++++++++--
>  t/t3206-range-diff.sh | 28 ++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/range-diff.c b/range-diff.c
> index 2e86063491..fbb81a92cc 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -41,12 +41,20 @@ static int read_patches(const char *range, struct s=
tring_list *list,
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>  	struct strbuf buf =3D STRBUF_INIT, contents =3D STRBUF_INIT;
>  	struct patch_util *util =3D NULL;
> -	int in_header =3D 1;
> +	int i, implicit_notes_arg =3D 1, in_header =3D 1;
>  	char *line, *current_filename =3D NULL;
>  	ssize_t len;
>  	size_t size;
>  	int ret =3D -1;
> =20
> +	for (i =3D 0; other_arg && i < other_arg->nr; i++)
> +		if (!strcmp(other_arg->v[i], "--notes") ||
> +		    starts_with(other_arg->v[i], "--notes=3D") ||
> +		    !strcmp(other_arg->v[i], "--no-notes")) {
> +			implicit_notes_arg =3D 0;
> +			break;
> +		}
> +
>  	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
>  		     "--reverse", "--date-order", "--decorate=3Dno",
>  		     "--no-prefix", "--submodule=3Dshort",
> @@ -60,8 +68,9 @@ static int read_patches(const char *range, struct str=
ing_list *list,
>  		     "--output-indicator-context=3D#",
>  		     "--no-abbrev-commit",
>  		     "--pretty=3Dmedium",
> -		     "--notes",
>  		     NULL);
> +	if (implicit_notes_arg)
> +		     strvec_push(&cp.args, "--notes");
>  	strvec_push(&cp.args, range);
>  	if (other_arg)
>  		strvec_pushv(&cp.args, other_arg->v);
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index b5f4d6a653..b33afa1c6a 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -662,6 +662,20 @@ test_expect_success 'range-diff with multiple --no=
tes' '
>  	test_cmp expect actual
>  '
> =20
> +# `range-diff` should act like `log` with regards to notes
> +test_expect_success 'range-diff with --notes=3Dcustom does not show de=
fault notes' '
> +	git notes add -m "topic note" topic &&
> +	git notes add -m "unmodified note" unmodified &&
> +	git notes --ref=3Dcustom add -m "topic note" topic &&
> +	git notes --ref=3Dcustom add -m "unmodified note" unmodified &&
> +	test_when_finished git notes remove topic unmodified &&
> +	test_when_finished git notes --ref=3Dcustom remove topic unmodified &=
&
> +	git range-diff --notes=3Dcustom main..topic main..unmodified \
> +		>actual &&
> +	! grep "## Notes ##" actual &&
> +	grep "## Notes (custom) ##" actual
> +'
> +
>  test_expect_success 'format-patch --range-diff does not compare notes =
by default' '
>  	git notes add -m "topic note" topic &&
>  	git notes add -m "unmodified note" unmodified &&
> @@ -679,6 +693,20 @@ test_expect_success 'format-patch --range-diff doe=
s not compare notes by default
>  	! grep "note" 0000-*
>  '
> =20
> +test_expect_success 'format-patch --notes=3Dcustom --range-diff only c=
ompares custom notes' '
> +	git notes add -m "topic note" topic &&
> +	git notes --ref=3Dcustom add -m "topic note (custom)" topic &&
> +	git notes add -m "unmodified note" unmodified &&
> +	git notes --ref=3Dcustom add -m "unmodified note (custom)" unmodified=
 &&
> +	test_when_finished git notes remove topic unmodified &&
> +	test_when_finished git notes --ref=3Dcustom remove topic unmodified &=
&
> +	git format-patch --notes=3Dcustom --cover-letter --range-diff=3D$prev=
 \
> +		main..unmodified >actual &&
> +	test_when_finished "rm 000?-*" &&
> +	grep "## Notes (custom) ##" 0000-* &&
> +	! grep "## Notes ##" 0000-*
> +'
> +
>  test_expect_success 'format-patch --range-diff with --no-notes' '
>  	git notes add -m "topic note" topic &&
>  	git notes add -m "unmodified note" unmodified &&
