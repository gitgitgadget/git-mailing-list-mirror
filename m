Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AA9C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 00:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiA0AuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 19:50:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59531 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiA0AuL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 19:50:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD8B816CED9;
        Wed, 26 Jan 2022 19:50:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5rRCLBvthyob
        91mZ5Aiu5dOvev57Id50FFDkgKNpJuw=; b=l5zh4sATzcPAlysqNi3gn0y/gcmC
        SiDaIrxv3/Aeffenz/UB65q2p4i1YL7SB1dVsttF7beaiCo/6S5gGMvwbhb/n/Bf
        MbROldFNasixxy9CVm3ZteWblWh/F/N3xkVAiJJtvqI5HZMJ9tDhcyaMIC9s1yLY
        n3mSCwt2BHRpznU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D61BD16CED8;
        Wed, 26 Jan 2022 19:50:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 51E4F16CED6;
        Wed, 26 Jan 2022 19:50:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http API: fix dangling pointer issue noted by GCC 12.0
References: <patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com>
Date:   Wed, 26 Jan 2022 16:50:07 -0800
In-Reply-To: <patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 26 Jan
 2022 22:30:40 +0100")
Message-ID: <xmqqczkengsg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 131A569A-7F0B-11EC-8240-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The pre-release GCC 12.0 development branch has a new warning about
> dangling pointers in -Wall:
>
>     http.c: In function =E2=80=98run_active_slot=E2=80=99:
>     http.c:1332:24: error: storing the address of local variable =E2=80=
=98finished=E2=80=99 in =E2=80=98*slot.finished=E2=80=99 [-Werror=3Ddangl=
ing-pointer=3D]
>      1332 |         slot->finished =3D &finished;
>           |         ~~~~~~~~~~~~~~~^~~~~~~~~~~
>     http.c:1330:13: note: =E2=80=98finished=E2=80=99 declared here
>      1330 |         int finished =3D 0;
>           |             ^~~~~~~~
>
> This is on a locally built "gcc (GCC) 12.0.1 20220120 (experimental)",
> built from gcc.git's 8bc700f4c3f (Enhance vec_pack_trunc for integral
> mode mask., 2022-01-17).

I am puzzled by this error.  The assignment is the only one that
assigns a real pointer to the .finished member, and until
finish_active_slot() is called on the slot, the loop would not
leave.  I would understand the error if slot->finished is used after
the function returns to the caller, but I do not think it is the
case.

The original code is also curious in that finished is a pointer to
somewhere else other than a member that records a yes/no itself.

> But we can instead amend the code added in baa7b67d091 (HTTP slot
> reuse fixes, 2006-03-10) to get rid of "int *finished" entirely. I
> instrumented the code to add this after every use of slot->finished or
> slot->in_use:
>
>     if (slot->finished && slot->in_use =3D=3D *slot->finished) BUG("in-=
use =3D %d and finished =3D %d disconnect", slot->in_use, *slot->finished=
);
>     if (!slot->finished && !slot->in_use) BUG("have !in-use and no fini=
shed pointer");
>
> Which never fires, but we would get occurrences of:
>
>     if (!slot->finished && slot->in_use) BUG("have in-use and no finish=
ed pointer");
>
> I.e. we can simply drop the field and rely on "slot->in_use" in cases
> where we used "finished" before. The two fields were mirror images of
> each other, and the tri-state nature of "finished" wasn't something we
> relied upon.

Sorry, but "instrument and ran test" does not give much confidence.

What was the original problem the "finished" member wanted to solve,
and why was the problem unsolveable by simply looking at the in_use
member that already existed back then?  Isn't the issue very much
timing dependent, influenced by the way the HTTP server we are
interacting with behaves?  Before baa7b67d091acf, the loop in
run_active_slot() checked _exactly_ the same "slot->in_use" field,
which the above analysis claims to be the mirror image of "finished",
so I find that ...

> @@ -1327,10 +1323,8 @@ void run_active_slot(struct active_request_slot =
*slot)
>  	fd_set excfds;
>  	int max_fd;
>  	struct timeval select_timeout;
> -	int finished =3D 0;
> =20
> -	slot->finished =3D &finished;
> -	while (!finished) {
> +	while (slot->in_use) {
>  		step_active_slots();
> =20
>  		if (slot->in_use) {

... this reversion of baa7b67d091acf is not very well explained.

The only way the separation could make a difference is while
step_active_slots(), the current slot is completed, our local
"finished" gets marked as such thanks to the pointer-ness of the
finished member, and then another pending request is started reusing
the same slot object (properly initialized for that new request).
In such a case, the while loop we want to see exit will see that
slot->in_use member is _still_ true, even though it is true only
because it is now about a separate and unrelated request that is
still waiting for completion, and the original request the caller is
waiting for has already finished.

And if that is the kind of racy interaction between requests the
original code wanted to fix, then I am not sure how this updated
code deals with the issue in a different way.  Can we safely tell if
the original request, held in slot when this function was entered,
has completed by looking at slot->in_use member?  When the while()
loop sees that slot->in_use member is true, how do we know if it is
true because nothing has been done to the request yet, or we've
completed the original request but another request in queue has
replacd the same slot object and the slot is now in-use again?

> diff --git a/http.h b/http.h
> index df1590e53a4..81418d5fd8b 100644
> --- a/http.h
> +++ b/http.h
> @@ -24,7 +24,6 @@ struct active_request_slot {
>  	int in_use;
>  	CURLcode curl_result;
>  	long http_code;
> -	int *finished;
>  	struct slot_results *results;
>  	void *callback_data;
>  	void (*callback_func)(void *data);
