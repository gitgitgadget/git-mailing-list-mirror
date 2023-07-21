Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACE1EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 15:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjGUPQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 11:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjGUPQe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 11:16:34 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385C33AA4
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 08:16:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C5B231957A;
        Fri, 21 Jul 2023 11:16:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MHpfpy/0gkK5SqCgxEfWyiTrxgjHbkDg8zKIa1
        eIz9c=; b=ohhtyxRALpNtIJVzMDzJCflNxtXK09oBnfJaPv4L6T2WZmWs7txOOb
        z3uJR993CThI5d5TAT8TXTB2nXvCen1HYwG53PDGR6xz21JWxdQLhXLbpe62ICk9
        5RJurRJpkSbI1qHwQHJMYdgbvB/6ytDWULnD/MXyzKs+vgGESZlR4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF98819579;
        Fri, 21 Jul 2023 11:16:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9FF7F19574;
        Fri, 21 Jul 2023 11:16:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/3] t2400: rewrite regex to avoid unintentional PCRE
References: <20230715025512.7574-1-jacobabel@nullpo.dev>
        <20230716033743.18200-1-jacobabel@nullpo.dev>
        <20230721044012.24360-1-jacobabel@nullpo.dev>
        <20230721044012.24360-4-jacobabel@nullpo.dev>
Date:   Fri, 21 Jul 2023 08:16:11 -0700
In-Reply-To: <20230721044012.24360-4-jacobabel@nullpo.dev> (Jacob Abel's
        message of "Fri, 21 Jul 2023 04:40:56 +0000")
Message-ID: <xmqqv8edwb0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87515766-27D9-11EE-8B55-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> Replace all cases of `\s` with ` ` as it is not part of POSIX BRE or ERE
> and therefore not all versions of grep handle it without PCRE support.

Good point.  But the patch replaces them with "[ ]" instead, which
probably is not a good idea for readability.

Technically speaking, there is no regular expression library that
supports PCRE per-se; treating \S, \s, \d and the like the same way
as PCRE is a GNU extension in the glibc land, and a simlar "enhanced
mode" can be requested by passing REG_ENHANCED bit to regcomp(3) at
runtime in the BSD land including macOS.  I would suggest just
dropping "without PCRE support" for brevity, as "not all versions of
grep handle it" is sufficient here.

> For the same reason all cases of `\S` are replaced with `[^ ]`.
> It's not an exact replacement but it is close enough for this
> use case.

Good.

> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> ---
>  t/t2400-worktree-add.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index e106540c6d..eafecdf7ce 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -417,9 +417,9 @@ test_wt_add_orphan_hint () {
>  		grep "hint: If you meant to create a worktree containing a new orphan branch" actual &&
>  		if [ $use_branch -eq 1 ]
>  		then
> -			grep -E "^hint:\s+git worktree add --orphan -b \S+ \S+\s*$" actual
> +			grep -E "^hint:[ ]+git worktree add --orphan -b [^ ]+ [^ ]+$" actual
>  		else
> -			grep -E "^hint:\s+git worktree add --orphan \S+\s*$" actual
> +			grep -E "^hint:[ ]+git worktree add --orphan [^ ]+$" actual
>  		fi

Just a single space would be fine without [bracket].  I think older
tests use (literally) HT and SP inside [], many of them may still
survive.

> @@ -709,7 +709,7 @@ test_dwim_orphan () {
>  	local info_text="No possible source branch, inferring '--orphan'" &&
>  	local fetch_error_text="fatal: No local or remote refs exist despite at least one remote" &&
>  	local orphan_hint="hint: If you meant to create a worktree containing a new orphan branch" &&
> -	local invalid_ref_regex="^fatal: invalid reference:\s\+.*" &&
> +	local invalid_ref_regex="^fatal: invalid reference: .*" &&

Feeding "<something>\+" to BRE (this pattern is later used with
'grep' but not with 'egrep' or 'grep -E') and expecting it to mean 1
or more is a GNU extension, and in this case "there must be a SP
after colon" is much easier to see, which is what the updated one
uses.  Good.

By the way, you can drop the ".*" at the end of the pattern, because
the match is not anchored at the tail end.

>  	local bad_combo_regex="^fatal: '[a-z-]\+' and '[a-z-]\+' cannot be used together" &&

This should also be corrected, I think.

	"fatal: '[a-z-]\{1,\}' and '[a-z-]\{1,\}' cannot be used together"

or even simpler,

	"fatal: '[a-z-]*' and '[a-z-]*' cannot be used together"

to avoid \+ in BRE (see above).  "[-a-z]" (to show '-' at the
beginning) may make it easier to read by letting the hyphen-minus
stand out more, as we know we are giving two command line option
names and in a command line option name, the first letter is always
hyphen-minus.  But that is more of personal taste, not correctness.

> @@ -998,8 +998,8 @@ test_dwim_orphan () {
>  					headpath=$(git $dashc_args rev-parse --path-format=absolute --git-path HEAD) &&
>  					headcontents=$(cat "$headpath") &&
>  					grep "HEAD points to an invalid (or orphaned) reference" actual &&
> -					grep "HEAD path:\s*.$headpath." actual &&
> -					grep "HEAD contents:\s*.$headcontents." actual &&
> +					grep "HEAD path: .$headpath." actual &&
> +					grep "HEAD contents: .$headcontents." actual &&
>  					grep "$orphan_hint" actual &&
>  					! grep "$info_text" actual
>  				fi &&

Thanks.
