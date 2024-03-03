Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CAB79DBF
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709506672; cv=none; b=AaUrfkofEZQ3ef1rAHDFYeFnshQP1yETCZ+RULHAI1+iKIegRGSv7+VMNMPDqugYn45WoqEd+jprgtvvr5uh4nfqiYe9Ijb83/ZjQWbe8j/ov0IVs9xkaUU8iF8sPo5sLKltcGMcvuj9TP8sjuRjCuoTq7lmnOd8ubyzYDRlyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709506672; c=relaxed/simple;
	bh=0QnX028U/hdnKQxoh7RFs4LDkjUyaWaLHXU1sOnaSJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A11uAkkE55LGgUpFEnoxlcLYRH4gDaUxR2vHClPtEG5HQ54dvlVQDy2yeeCbcHzDUWTEzfxITHGOhj5yqQgOT0wIrwwdG1Fi4bdVSayIk8G1jIHvdn+0qCuTrXwQfHxoQcmZo4zmIXqwxqgvAhVhb5ILRvpM2XNOYwsMLwpyYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=n3zgpmcV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n3zgpmcV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 389A130685;
	Sun,  3 Mar 2024 17:57:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0QnX028U/hdnKQxoh7RFs4LDkjUyaWaLHXU1sO
	naSJA=; b=n3zgpmcV8D8n7fU3aGvKQmpI1NB1JlYvtl4VjRXOgX+qOODpMnKi4x
	e5o10ijWK5UlJCyVlnoSs+helM+36hR2tP2k51jSxCXNa2/1e3rdtkWkziTKXKoO
	TmleXl+S5d6StWkXhvHXUsZTYiEPfKbdnfxRjb0Q6zl0fCXX7v60s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 30F3930684;
	Sun,  3 Mar 2024 17:57:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C2AB530683;
	Sun,  3 Mar 2024 17:57:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
In-Reply-To: <pull.1682.git.1709396291693.gitgitgadget@gmail.com> (Philippe
	Blain via GitGitGadget's message of "Sat, 02 Mar 2024 16:18:11 +0000")
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
Date: Sun, 03 Mar 2024 14:57:45 -0800
Message-ID: <xmqqwmqiudna.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 73ABC590-D9B1-11EE-BB97-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	if (msg) {
> -		advise("%s\n", msg);
> +		advise_if_enabled(ADVICE_SEQUENCER_CONFLICT, "%s\n", msg);
>  		/*
>  		 * A conflict has occurred but the porcelain
>  		 * (typically rebase --interactive) wants to take care

This hunk is good.  The block removes the CHERRY_PICK_HEAD after
giving this advice and then returns.

> @@ -480,22 +480,25 @@ static void print_advice(struct repository *r, int show_hint,
>  
>  	if (show_hint) {
>  		if (opts->no_commit)
> -			advise(_("after resolving the conflicts, mark the corrected paths\n"
> -				 "with 'git add <paths>' or 'git rm <paths>'"));
> +			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
> +					  _("after resolving the conflicts, mark the corrected paths\n"
> +					    "with 'git add <paths>' or 'git rm <paths>'"));
>  		else if (opts->action == REPLAY_PICK)
> -			advise(_("After resolving the conflicts, mark them with\n"
> -				 "\"git add/rm <pathspec>\", then run\n"
> -				 "\"git cherry-pick --continue\".\n"
> -				 "You can instead skip this commit with \"git cherry-pick --skip\".\n"
> -				 "To abort and get back to the state before \"git cherry-pick\",\n"
> -				 "run \"git cherry-pick --abort\"."));
> +			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
> +					  _("After resolving the conflicts, mark them with\n"
> +					    "\"git add/rm <pathspec>\", then run\n"
> +					    "\"git cherry-pick --continue\".\n"
> +					    "You can instead skip this commit with \"git cherry-pick --skip\".\n"
> +					    "To abort and get back to the state before \"git cherry-pick\",\n"
> +					    "run \"git cherry-pick --abort\"."));
>  		else if (opts->action == REPLAY_REVERT)
> -			advise(_("After resolving the conflicts, mark them with\n"
> -				 "\"git add/rm <pathspec>\", then run\n"
> -				 "\"git revert --continue\".\n"
> -				 "You can instead skip this commit with \"git revert --skip\".\n"
> -				 "To abort and get back to the state before \"git revert\",\n"
> -				 "run \"git revert --abort\"."));
> +			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
> +					  _("After resolving the conflicts, mark them with\n"
> +					    "\"git add/rm <pathspec>\", then run\n"
> +					    "\"git revert --continue\".\n"
> +					    "You can instead skip this commit with \"git revert --skip\".\n"
> +					    "To abort and get back to the state before \"git revert\",\n"
> +					    "run \"git revert --abort\"."));
>  		else
>  			BUG("unexpected pick action in print_advice()");
>  	}

This hunk can be improved.  If I were doing this patch, I probably
would have just done

-	if (show_hint) {
+	if (show_hint && advice_enabled(ADVICE_SEQUENCER_CONFLICT)) {

and nothing else, and doing so would keep the block easier to extend
and maintain in the future.

Because the block is all about "show_hint", we have code to print
advice messages and nothing else in it currently, and more
importantly, we will not add anything other than code to print
advice messages in it.  Because of that, skipping everything when
ADVICE_SEQUENCER_CONFLICT is not enabled will not cause problems
(unlike the earlier hunk---which will break if we added "&&
advice_enabled()" to "if (msg)").  That way, when somebody teaches
this code a new kind of opts->action, they do not have to say
"advice_if_enabled(ADVICE_SEQUENCER_CONFLICT()"; they can just use
"advise()".

> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index aeab689a98d..bc7c878b236 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh

All changes to the file look good.
