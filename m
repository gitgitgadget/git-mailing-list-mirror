Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1796CCF9E2
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 23:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbjIEXVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 19:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjIEXVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 19:21:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3BA3
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 16:20:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80AA225B0B;
        Tue,  5 Sep 2023 19:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=kgVTa/hmxJgaCPDpKlXlkwp76nVJokHFrmgEnn
        Yxx3Q=; b=m4jGJ+Sga7Q/uMR2Wh14xHIodeTLb1j7293oGZNE8yZ08hJNA+VGV5
        D1MZoPdKc2JWzdVX+I1pfPAl+AjCi3nYTPCr/t+yrWYmNQl5LWDa/oOh9Y4CF/+w
        8ZUfZpxRdXJPREoFdzrE4VlHQ05X7Kg5dORwhpV5LbzYE3C3w/wfk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77B1C25B0A;
        Tue,  5 Sep 2023 19:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A789325B06;
        Tue,  5 Sep 2023 19:20:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Konstantin Pereiaslov via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Konstantin Pereiaslov <perk11@perk11.info>
Subject: Re: [PATCH] advice: improve hint for diverging branches.
In-Reply-To: <pull.1570.git.git.1693861162353.gitgitgadget@gmail.com>
        (Konstantin Pereiaslov via GitGitGadget's message of "Mon, 04 Sep 2023
        20:59:22 +0000")
References: <pull.1570.git.git.1693861162353.gitgitgadget@gmail.com>
Date:   Tue, 05 Sep 2023 16:20:54 -0700
Message-ID: <xmqqh6o8p5pl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD280D64-4C42-11EE-947A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Konstantin Pereiaslov via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Konstantin Pereiaslov <perk11@perk11.info>
>
> Added a description of what the offered options will do and for pull
> also offered a 3rd option during a pull - a hard reset.
> This option should be helpful for the new users that accidentally
> committed into the wrong branch which is a scenario I saw very
> often.

cf. Documentation/SubmittingPatches:[[describe-changes]]

> The resulting tooltip looks like this for pull:
>
> hint: Diverging branches can't be fast-forwarded.
> Consider the following options:

We do not give "hint:" prefix to this line???

> hint:
> hint: To merge remote changes into your branch:
> hint:   git merge --no-ff
> hint:
> hint: To apply your changes on top of remote changes:
> hint:   git rebase

Hmph, "apply" -> "replay" perhaps?

> hint: To discard your local changes and apply the remote changes:

Here "apply" is definitely a misnomer.  Nothing is applied; you just
discard your work and adopt (or "accept") the state of the remote as
a whole.

> hint:   git reset --hard refs/remotes/upstream/branch-name
> hint:
> hint: Disable this message with "git config advice.diverging false"

OK.

Overall, "... looks like this" should be shown a bit indented so
that the example stands out from the text that explains the example.

> There is some danger because it's semi-destructive, but so are
> other options offered if user doesn't know the commands to
> revert back.

Sorry, but I do not quite understand what you want to say here.

> @@ -1112,8 +1126,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  
>  	/* ff-only takes precedence over rebase */
>  	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
> -		if (divergent)
> -			die_ff_impossible();
> +		if (divergent) {
> +			const char* pull_branch_spec = get_pull_branch(repo, *refspecs);

In this codebase, asterisk sticks to the variable/function
identifier, not types.

But more importantly, what guarantees your recomputation using
'*refspecs' here will match the result of the logic that computed
'divergent', which certainly would have already known what commit we
tried to fast-forward our branch to, and where that commit came
from?  We shouldn't be computing the same thing twice, and in
different ways; that is a sure way to introduce inconsistent
results.

> +			die_ff_impossible_during_pull(pull_branch_spec);
> +		}
>  		opt_rebase = REBASE_FALSE;
>  	}
>  	/* If no action specified and we can't fast forward, then warn. */
>
> base-commit: d814540bb75bbd2257f9a6bf59661a84fe8cf3cf

Thanks.
