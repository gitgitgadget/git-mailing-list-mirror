Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6442AC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BC62335A
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgLPWZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 17:25:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56755 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730173AbgLPWZN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 17:25:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50712FFC3C;
        Wed, 16 Dec 2020 17:24:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=MPdQ/oAKv0ELE/4JWT26rsOXysQ=; b=RSL88E9dq0krnacImFQ0
        tnRdUYTgdDd8po0Ex/M0Hda2TNfCBzCuGrToW1ONVvBv4sW9aN7HcXcK/1C2K1lO
        aokLdoAcTxKwelRehQ2Vu/m8rks7Wk5r/qhu3ULmlZiIlTKxkmHwbWDUblMUcCKf
        F5o1qbkDMbhN4zfTiXgfYrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=GCCn7WdV1+wMAbUhv7UPny+CEOlJ2bnX0YrMUesICfAZCB
        +o7tsbV2peqb/JDWMBXmNmPzRK2bzIGeewSbHmUmZauI1bsoaYiLDKuikfzfk0w6
        KyMGnUgjOJ8qo8ysgVUSN0UrgULFJQFp0HYFlRuKsMZoFljP9dxi6aZwToHrM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47BABFFC3B;
        Wed, 16 Dec 2020 17:24:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 76E90FFC3A;
        Wed, 16 Dec 2020 17:24:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
Date:   Wed, 16 Dec 2020 14:24:23 -0800
Message-ID: <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 743FA2BC-3FED-11EB-83A6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It doesn't make sense to display already-resolved conflicts in the
> different views of all mergetools.
>
> We already have the best version in MERGED, with annotations that can
> be used to extract a pruned version of LOCAL and REMOTE. If we are using
> the diff3 conflict-style, we can even extract BASE.
>
> Let's use these annotations instead of using the original files before
> the conflict resolution.
>
> TODO: There may be a better way to extract these files that doesn't rely
> on the user's conflict-style configuration.
>
> See Seth House's blog post [1] for the idea and the rationale.
>
> [1] https://www.eseth.org/2020/mergetools.html
>
> Cc: Seth House <seth@eseth.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Hmph, I got what Seth showed, but I do not quite see how the ideas
in the post relate to what this patch does.  The patch just avoids
grabbing the contents of each stage out to a file for three stages
using "git checkout-index" and instead does the same by munging the
diff3 output, which ought to have the same information at least for
text files, using "sed", or is there something I am not seeing?

If there is none, then what is the benefit of doing the same thing
without running 3 checkout-index?  Performance?

Also using checkout-index to grab the raw contents without relying
on the textual context marker would mean that a custom mergetool
backend could be used to merge non-text files.  So if this
optimization (I am still assuming this is "doing the same without
running three checkout-index to gain performance" I read out of the
patch text) is worth doing, there needs a knob to allow users to opt
out of it somehow to avoid regressing on the feature front.

If the mergetool were in control to (re)start the merge process that
would result in the conflicted state, we could override the end-user
preference on the conflict style (either 'GNU merge'-style or
'diff3'-style) and conflict-marker-length to be used in showing
textual conflicts, but as I understand "mergetool" is handed an
already conflicted state and asked to resolve it, it would not be
possible without at least looking at the stage #1 to recover the
base for folks who do not use diff3 style.

> ---
>  git-mergetool.sh | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index e3f6d543fb..4759433d46 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -227,18 +227,6 @@ stage_submodule () {
>  	git update-index --add --replace --cacheinfo 160000 "$submodule_sha1" "${work_rel_path%/}" || die
>  }
>  
> -checkout_staged_file () {
> -	tmpfile="$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" &&
> -	tmpfile=${tmpfile%%'	'*}
> -
> -	if test $? -eq 0 && test -n "$tmpfile"
> -	then
> -		mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
> -	else
> -		>"$3"
> -	fi
> -}
> -
>  merge_file () {
>  	MERGED="$1"
>  
> @@ -318,9 +306,10 @@ merge_file () {
>  	# where the base's directory no longer exists.
>  	mkdir -p "$(dirname "$MERGED")"
>  
> -	checkout_staged_file 1 "$MERGED" "$BASE"
> -	checkout_staged_file 2 "$MERGED" "$LOCAL"
> -	checkout_staged_file 3 "$MERGED" "$REMOTE"
> +	# TODO: How do we get $MERGED always with diff3?
> +	sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======$/,/^>>>>>>> /d' "$MERGED" > "$BASE"
> +	sed -e '/^<<<<<<< /,/^=======$/d' -e '/^>>>>>>> /d' "$MERGED" > "$LOCAL"
> +	sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$MERGED" > "$REMOTE"
>  

Style (lose SP after '>' redirection; I looked at the existing code
and spotted one existing violation but that is not an excuse to make
things even less consistent).

Also, conflict-marker-size=<N> attributes can change the length, so
hardcoding these patterns would not work for everybody.

>  	if test -z "$local_mode" || test -z "$remote_mode"
>  	then

Thanks.
