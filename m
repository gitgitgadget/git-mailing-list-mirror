Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8329FC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26282206E0
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oIdwfxbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgKXVOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:14:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59040 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgKXVOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 16:14:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB9419679C;
        Tue, 24 Nov 2020 16:13:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zXCZ2+ekKd4rO5gee5p+Ko4M4ks=; b=oIdwfx
        bLKZgpB4StTyxtWI/Gh1pGvxy4cux7dEkrN0YKWajrzjYkhc5w6BtSMQsaLVOLo7
        IeoWN0IgBlco2Yra6dyYBINWD1tYitjSvz0Dir5scvryWQdoo32VCMIepHL3xsB/
        Lo+XOmEzH4vtdQatqIZJuSVK8Ev8YfxhHAee0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wPO2Vzs+ttNJv5QxbsNxHiJJ5wKH1fy1
        c7epuYZCluLLuSwmUS3J/m861xLyUmzJj6TsTVarrn3C+cgT7XRtRmBahtO+1bBW
        +lT+dEIElouV54cT3j0Y6QgBYH8XeHdLe2pbCl4CpoTe3GiULYRL8w4cZvwtbzDa
        12rLDsL9vZQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E43D39679B;
        Tue, 24 Nov 2020 16:13:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72BA59679A;
        Tue, 24 Nov 2020 16:13:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] submodule: fix fetch_in_submodule logic
References: <X7zM/d1CVuyCstZo@coredump.intra.peff.net>
Date:   Tue, 24 Nov 2020 13:13:55 -0800
In-Reply-To: <X7zM/d1CVuyCstZo@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 24 Nov 2020 04:06:05 -0500")
Message-ID: <xmqqzh36ihkc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6779EC0-2E99-11EB-B813-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is a fix on top of ab/retire-parse-remote, which is now in next. I
> think submodule fetching is pretty broken, so we should do this or
> something like it soon.
>
> -- >8 --
> Commit 1c1518071c (submodule: use "fetch" logic instead of custom remote
> discovery, 2020-11-14) rewrote the logic in fetch_in_submodule to do:
>
>   elif test "$2" -ne ""
>
> But this is nonsense in shell: -ne is for numeric comparisons. This
> should be "=" or more idiomatically:
>
>   elif test -n "$2"
>
> But once we fix that, many tests start failing. Because that commit
> introduced another problem. The caller that passes 3 arguments looks
> like this:
>
>     fetch_in_submodule "$sm_path" $depth "$sha1"
>
> Note the unquoted $depth parameter. When it isn't set, the function will
> see only 2 arguments, and the function has no idea if what it sees in $2
> is an option to go on the command line, or a refspec to pass on stdin.
> In the old code before that commit:
>
>    fetch_in_submodule () (
>         sanitize_submodule_env &&
>         cd "$1" &&
>   -     case "$2" in
>   -     '')
>   -             git fetch ;;
>   -     *)
>   -             shift
>   -             git fetch $(get_default_remote) "$@" ;;
>   -     esac
>
> we treated those the same, so it didn't matter. But in the new logic
> (with my fix above):
>
>   +     if test $# -eq 3
>   +     then
>   +             echo "$3" | git fetch --stdin "$2"
>   +     elif test -n "$n"
>   +     then
>   +             git fetch "$2"
>   +     else
>   +             git fetch
>   +     fi
>
> we use the number of parameters to distinguish the two. Let's insist
> that the caller pass an empty string for positional parameter two if
> they want to have a third parameter after it.

Thanks for catching.  I thought we stared at this part long enough
to be updated between the rounds; it is embarrassing that we've
missed it.

>   - it probably wouldn't hurt to beef up the tests, especially around
>     fetching an unreachable sha1, but after getting lost for an hour in
>     the spaghetti of the submodule code and its tests, I gave up. I do
>     at least feel this code is being exercised (because once the initial
>     problem is fixed, tons of things fail).

True.

> +# usage: fetch_in_submodule <module_path> [<depth>] [<sha1>]
> +# Because arguments are positional, use an empty string to omit <depth>
> +# but include <sha1>.
>  fetch_in_submodule () (
>  	sanitize_submodule_env &&
>  	cd "$1" &&
>  	if test $# -eq 3
>  	then
> -		echo "$3" | git fetch --stdin "$2"
> -	elif test "$2" -ne ""
> -	then
> -		git fetch "$2"
> +		echo "$3" | git fetch --stdin ${2:+"$2"}
>  	else
> -		git fetch
> +		git fetch ${2:+"$2"}
>  	fi
>  )

Makes sense.  Thanks.

> @@ -603,7 +603,7 @@ cmd_update()
>  				# Now we tried the usual fetch, but $sha1 may
>  				# not be reachable from any of the refs
>  				is_tip_reachable "$sm_path" "$sha1" ||
> -				fetch_in_submodule "$sm_path" $depth "$sha1" ||
> +				fetch_in_submodule "$sm_path" "$depth" "$sha1" ||
>  				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
>  			fi
