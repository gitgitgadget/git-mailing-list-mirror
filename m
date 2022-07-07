Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A2EC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 18:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiGGSKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 14:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiGGSKK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 14:10:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD532B618
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 11:10:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A27A1145A54;
        Thu,  7 Jul 2022 14:10:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LAZiVYDDVuXr
        tyaEqtqIa9C1Q38ihyXMzIM1JzE4uyw=; b=bQGXsBrA5JhF9cxJQHeI7lH2S7NS
        4Jh5eqoEJL1epsEtaJSrt90+YJda5k8mSuLCFe32Zi7TrGVVhabEqN0rSd73ounJ
        uVm7X33RlccSm1WE3WA/I1vjPNB5OXVVPgpjmZdtkRoyXs7ydDroa1D97gbINeGN
        DqATGK707z4DfHQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BA81145A52;
        Thu,  7 Jul 2022 14:10:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64C67145A51;
        Thu,  7 Jul 2022 14:10:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] builtin/mv.c: use correct type to compute size of an
 array element
References: <xmqq8rp54r4l.fsf@gitster.g>
        <220707.86y1x585wy.gmgdl@evledraar.gmail.com>
Date:   Thu, 07 Jul 2022 11:10:03 -0700
In-Reply-To: <220707.86y1x585wy.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 07 Jul 2022 14:11:22 +0200")
Message-ID: <xmqq1quw23r8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 072EA306-FE20-11EC-9850-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jul 06 2022, Junio C Hamano wrote:
>
>> The variables 'source', 'destination', and 'submodule_gitfile' are
>> all of type "const char **", and an element of such an array is of
>> "type const char *".
>>
>> Noticed while running "make contrib/coccinelle/array.cocci.patch".
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>>  * There is this rule in the array.cocci file:
>>
>>         @@
>>         type T;
>>         T *dst;
>>         T *src;
>>         expression n;
>>         @@
>>         (
>>         - memmove(dst, src, (n) * sizeof(*dst));
>>         + MOVE_ARRAY(dst, src, n);
>>         |
>>         - memmove(dst, src, (n) * sizeof(*src));
>>         + MOVE_ARRAY(dst, src, n);
>>         |
>>         - memmove(dst, src, (n) * sizeof(T));
>>         + MOVE_ARRAY(dst, src, n);
>>         )
>>
>>    but it triggered only for modes[] array among the four parallel
>>    arrays that are being moved here.
>>
> This seems to be the same sort case as noted in 7bd97d6dff3 (git: use
> COPY_ARRAY and MOVE_ARRAY in handle_alias(), 2019-09-19).

"This" here means "sizeof(const T) and sizeof(T) are the same and
our Cocci rules do not trigger when a wrong one is used", and I
agree that is exactly the same issue as fixed by 7bd97d6dff3.

> I tried (going aginst the warnings in that commit about the
> non-generality) updating the rules to catch these cases, which yielded
> the below.

> I wonder if we should apply some version of it. I.e. one-off
> fix these, and perhaps have the cocci rule BUG() if we see this sort of
> code again (the form technically could be used, but it seems all our
> uses of it are ones we could convert to the simpler one...).

One off rewrite using an ultra-loose rule, with human vetting the
result, may be a good idea---after all, we are encouraging our
developers to use MOVE_ARRAY() when appropriate, so it does not
exactly matter how you discovered a memmove() can be rewritten
safely to MOVE_ARRAY() as long as the resulting patch is correct.

It is a different story to add a loose automation that is designed
to produce incorrect rewrite, and expects that humans always vet the
outcome.  Given that we run these rules at CI (doesn't it block GGG
submitters?), it is a bad idea.

> diff --git a/add-patch.c b/add-patch.c
> index 509ca04456b..eff338d3901 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -915,10 +915,9 @@ static int split_hunk(struct add_p_state *s, struc=
t file_diff *file_diff,
>  	file_diff->hunk_nr +=3D splittable_into - 1;
>  	ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr, file_diff->hunk_alloc=
);
>  	if (hunk_index + splittable_into < file_diff->hunk_nr)
> -		memmove(file_diff->hunk + hunk_index + splittable_into,
> -			file_diff->hunk + hunk_index + 1,
> -			(file_diff->hunk_nr - hunk_index - splittable_into)
> -			* sizeof(*hunk));
> +		MOVE_ARRAY(file_diff->hunk + hunk_index + splittable_into,
> +			   file_diff->hunk + hunk_index + 1,
> +			   file_diff->hunk_nr - hunk_index - splittable_into);

This does not look all that more readable, unfortunately.

> diff --git a/builtin/mv.c b/builtin/mv.c
> index 83a465ba831..f6187d1264a 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -282,14 +282,11 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
>  remove_entry:
>  		if (--argc > 0) {
>  			int n =3D argc - i;
> -			memmove(source + i, source + i + 1,
> -				n * sizeof(char *));
> -			memmove(destination + i, destination + i + 1,
> -				n * sizeof(char *));
> -			memmove(modes + i, modes + i + 1,
> -				n * sizeof(enum update_mode));
> -			memmove(submodule_gitfile + i, submodule_gitfile + i + 1,
> -				n * sizeof(char *));
> +			MOVE_ARRAY(source + i, source + i + 1, n);
> +			MOVE_ARRAY(destination + i, destination + i + 1, n);
> +			MOVE_ARRAY(modes + i, modes + i + 1, n);
> +			MOVE_ARRAY(submodule_gitfile + i,
> +				   submodule_gitfile + i + 1, n);

This is exactly what I sent.  I guess the change in this hunk is not
all that different from add-patch.c but somehow it makes it much
easier to read.  Perhaps that is only because these moves are much
simpler (i.e. shift by 1).

> diff --git a/commit.c b/commit.c
> index 1fb1b2ea90c..c23d3e3678f 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -151,10 +151,9 @@ int register_commit_graft(struct repository *r, st=
ruct commit_graft *graft,
>  		   r->parsed_objects->grafts_alloc);
>  	r->parsed_objects->grafts_nr++;
>  	if (pos < r->parsed_objects->grafts_nr)
> -		memmove(r->parsed_objects->grafts + pos + 1,
> -			r->parsed_objects->grafts + pos,
> -			(r->parsed_objects->grafts_nr - pos - 1) *
> -			sizeof(*r->parsed_objects->grafts));
> +		MOVE_ARRAY(r->parsed_objects->grafts + pos + 1,
> +			   r->parsed_objects->grafts + pos,
> +			   r->parsed_objects->grafts_nr - pos - 1);

Likewise.

> diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.=
cocci
> index 9a4f00cb1bd..988ff9a3fda 100644
> --- a/contrib/coccinelle/array.cocci
> +++ b/contrib/coccinelle/array.cocci
> @@ -73,6 +73,15 @@ expression n;
>  + MOVE_ARRAY(dst, src, n);
>  )
> =20
> +@@
> +expression D;
> +expression S;
> +expression N;
> +expression Z;
> +@@
> +- memmove(D, S, (N) * Z);
> ++ MOVE_ARRAY(D, S, N);

This is definitely unwelcome, as there is nothing that ensures Z has
the same value as sizeof(D[0]).

While our eyes are on array.cocci, I have a few observations on it.

This is not meant specifically to you, =C3=86var, but comments by those
more familiar with Coccinelle (and I am sure the bar to pass is
fairly low, as I am not all that familiar) are very much
appreciated.

    @@
    expression dst, src, n, E;
    @@
      memcpy(dst, src, n * sizeof(
    - E[...]
    + *(E)
      ))

This seems to force us prefer sizeof(*(E)) over sizeof(E[i]), when
it is used to compute the byte size of memcpy() operation.  There is
no reason to prefer one over the other, but I presume it is there
only for convenience for the other rules in this file (I recall
vaguely reading somewhere that these rules do not "execute" from top
to bottom, so I wonder how effective it is?).

    @@
    type T;
    T *ptr;
    T[] arr;
    expression E, n;
    @@
    (
      memcpy(ptr, E,
    - n * sizeof(*(ptr))
    + n * sizeof(T)
      )
    |
      memcpy(arr, E,
    - n * sizeof(*(arr))
    + n * sizeof(T)
      )
    |
      memcpy(E, ptr,
    - n * sizeof(*(ptr))
    + n * sizeof(T)
      )
    |
      memcpy(E, arr,
    - n * sizeof(*(arr))
    + n * sizeof(T)
      )
    )

Likewise, but this one is a lot worse.

Taken alone, sizeof(*(ptr)) is far more preferrable than sizeof(T),
because the code will be more maintainable.

    Side Note.  I know builtin/mv.c had this type mismatch between
    the variable and sizeof() from the beginning when 11be42a4 (Make
    git-mv a builtin, 2006-07-26) introduced both the variable
    declaration "const char **source" and memmove() on it, but a
    code that starts out with "char **src" with memmove() that moves
    part of src[] and uses sizeof(char *) to compute the byte size
    of the move would become broken the same way when a later
    developer tightens the declaration to use "const char **src"
    without realizing that they have to update the type used in
    sizeof().

So even though I am guessing that this is to allow the later rules
to worry only about sizeof(T), I am a bit unhappy to see the rule.
If an existing code matched this rule and get rewritten to use
sizeof(T), not sizeof(*(ptr)), but did not match the other rules to
be rewritten to use COPY_ARRAY(), the overall effect would be that
the automation made the code worse.

    @@
    type T;
    T *dst_ptr;
    T *src_ptr;
    T[] dst_arr;
    T[] src_arr;
    expression n;
    @@
    (
    - memcpy(dst_ptr, src_ptr, (n) * sizeof(T))
    + COPY_ARRAY(dst_ptr, src_ptr, n)
    |
    - memcpy(dst_ptr, src_arr, (n) * sizeof(T))
    + COPY_ARRAY(dst_ptr, src_arr, n)
    |
    - memcpy(dst_arr, src_ptr, (n) * sizeof(T))
    + COPY_ARRAY(dst_arr, src_ptr, n)
    |
    - memcpy(dst_arr, src_arr, (n) * sizeof(T))
    + COPY_ARRAY(dst_arr, src_arr, n)
    )

I take it that thanks to the earlier "meh -- between sizeof(*p) and
sizeof(p[0]) there is no reason to prefer one over the other" and
"oh, no, we should prefer sizeof(*p) not sizeof(typeof(*p)) but this
one is the other way around" rules, this one only has to deal with
sizeof(T).

Am I reading it correctly?

    @@
    type T;
    T *dst;
    T *src;
    expression n;
    @@
    (
    - memmove(dst, src, (n) * sizeof(*dst));
    + MOVE_ARRAY(dst, src, n);
    |
    - memmove(dst, src, (n) * sizeof(*src));
    + MOVE_ARRAY(dst, src, n);
    |
    - memmove(dst, src, (n) * sizeof(T));
    + MOVE_ARRAY(dst, src, n);
    )

What I find interesting is that this one seems to be able to do the
necessary rewrite without having to do the "turn everything into
sizeof(T) first" trick.  If this approach works well, I'd rather see
the COPY_ARRAY() done without the first two preliminary rewrite
rules.

I wonder if the pattern in the first rule catches sizeof(dst[0])
instead of sizeof(*dst), though.

    @@
    type T;
    T *ptr;
    expression n;
    @@
    - ptr =3D xmalloc((n) * sizeof(*ptr));
    + ALLOC_ARRAY(ptr, n);

    @@
    type T;
    T *ptr;
    expression n;
    @@
    - ptr =3D xmalloc((n) * sizeof(T));
    + ALLOC_ARRAY(ptr, n);

Is it a no-op rewrite if we replace the above two rules with
something like:

.   @@
.   type T;
.   T *ptr;
.   expression n;
.   @@
.   (
.   - ptr =3D xmalloc((n) * sizeof(*ptr));
.   + ALLOC_ARRAY(ptr, n);
.   |
.   - ptr =3D xmalloc((n) * sizeof(T));
.   + ALLOC_ARRAY(ptr, n);
.   )

or even following the pattern of the next one ...

.   @@
.   type T;
.   T *ptr;
.   expression n;
.   @@
.   - ptr =3D xmalloc((n) * \( sizeof(*ptr) \| sizeof(T) \))
.   + ALLOC_ARRAY(ptr, n);

... I have to wonder?  I like the simplicity of this pattern.

    @@
    type T;
    T *ptr;
    expression n !=3D 1;
    @@
    - ptr =3D xcalloc(n, \( sizeof(*ptr) \| sizeof(T) \) )
    + CALLOC_ARRAY(ptr, n)

And this leaves xcalloc(1, ...) alone because it is a way to get a
cleared block of memory that may not be an array at all.  Shouldn't
we have "n !=3D 1" for xmalloc rule as well, I wonder, if only for
consistency?
