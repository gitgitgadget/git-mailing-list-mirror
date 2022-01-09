Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B7FC433EF
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 19:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiAITyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Jan 2022 14:54:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62562 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiAITyI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jan 2022 14:54:08 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 753B817A34D;
        Sun,  9 Jan 2022 14:54:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vlEAr9lslGGl
        4yEMuM8Lm1zkI+YDo8fMkPqBR/5HyFE=; b=KPValDaT5j/+8/HmHkVei91K+ikz
        k/5kYJQOUkcaKk5D5ld1O9V0mWKbNbJQ5/e5R0kCQiibbY8ccefBV+GhFfYgYwOh
        DFXSEGYfxPhAKxwbF3tDWjC46p1w2GqUoRomEofGGxn4zeZzT/ZYaoZt4rEInzbR
        neqjjN/aKhlu28A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D7D017A34C;
        Sun,  9 Jan 2022 14:54:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DA7E317A349;
        Sun,  9 Jan 2022 14:54:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ramkumar Ramachandra" <r@artagnon.com>
Cc:     "Git List" <git@vger.kernel.org>
Subject: Re: git bisect bad @
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
Date:   Sun, 09 Jan 2022 11:54:04 -0800
In-Reply-To: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com> (Ramkumar
        Ramachandra's message of "Sun, 09 Jan 2022 20:29:39 +0100")
Message-ID: <xmqqilus3ctf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E6D75746-7185-11EC-9654-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ramkumar Ramachandra" <r@artagnon.com> writes:

> I bumped my head thrice (yes, thrice!) by using `git bisect bad
> @`. The error displayed to me at the end of one run was the
> following:
>
>   Cela signifie que le bogue =C3=A9t=C3=A9 corrig=C3=A9 entre ea3595845=
f5013359b2ba4402f948e454350a74c et=20
>   [2e100906d5d0c276335665ffefedb906d21165ca ea3595845f5013359b2ba4402f9=
48e454350a74c].
>   error: la bissection a =C3=A9chou=C3=A9 : 'git bisect--helper --bisec=
t-state (null)' a retourn=C3=A9 le code erreur -3
>
> After the third attempt, I realized: ah yes, computers aren't magic; gi=
t-bisect.sh is basically a stupid shell script (no offense!).
>
> Perhaps git-bisect.sh can ref-parse the arguments before starting its w=
ork? Agreed, none of the refs are expected to change during its operation=
, with the exception of the sneaky `@`.

As far as I know, the first thing it does to the command line is to
turn them into concrete object names.  I do not doubt that you had
some problem, and I do not doubt that it was with "git bisect bad"
with arguments, but I somehow doubt your diagnosis is correct.

In git-bisect.sh, we see:

        case "$#" in
        0)
                usage ;;
        *)
                cmd=3D"$1"
                get_terms
                shift
                case "$cmd" in
                help)
                        git bisect -h ;;
                start)
                        git bisect--helper --bisect-start "$@" ;;
                bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
                        git bisect--helper --bisect-state "$cmd" "$@" ;;

So "git bisect--helper --bisect-state bad HEAD" is run in your case.
Now in builtin/bisect--helper.c::bisect_state(), here is what
happpens:

 * argc is checked to make sure at least one arg is there to give
   the 'state' (i.e. good or bad)

 * if there is no arg, the revision that is marked as the given
   'state' defaults to "HEAD"

 * each remaining arg is first passed to get_oid(), turned into a
   commit object.

All of the above should happen way before bisect_next_all() calls
check_good_are_ancestors_of_bad(), that eventually calls
handle_bad_merge_base() where your "The merge base X is bad" error
message comes from.

So, perhaps there is something you are not quite telling us,
e.g. your problem happens during a replay an old bisect session
after HEAD has moved---if we had a bug that records symbolic object
names in the replay log, it may produce a nonsense result in such a
case (but I doubt that is the case---I am reasonably sure that the
log also records concrete object names)?

Perhaps you can try again with a better minimum reproducible
example?

Thanks.

