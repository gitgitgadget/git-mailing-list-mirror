Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19E9C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbiAFWKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:10:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53236 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244458AbiAFWKT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:10:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1ACE5165977;
        Thu,  6 Jan 2022 17:10:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mYG3kRpyxAj3Zpnky8vJFie1ynFsBpsNsZ/9YG
        Bk/fs=; b=nsEvCnW6fjViMATAnXp0Esij0IjBZMz2M7pw5M6YB+cF7m1WUSkNoh
        sYVxHTlL/0IeYFAE0NGmz2/5otee7bFMrDAwLL12X5qelAk585AKU7kFKLGAybK5
        zDmHvwytSnQ1XV46jXitx9UqhXchoiqjdLvtiNEb/t/+fdTwzg89Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 13D29165975;
        Thu,  6 Jan 2022 17:10:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7EFCF165974;
        Thu,  6 Jan 2022 17:10:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH V3] git-rev-list: add --first-parent-not flag
References: <20220105232755.23523-1-jerry@skydio.com>
Date:   Thu, 06 Jan 2022 14:10:09 -0800
In-Reply-To: <20220105232755.23523-1-jerry@skydio.com> (Jerry Zhang's message
        of "Wed, 5 Jan 2022 15:27:55 -0800")
Message-ID: <xmqqpmp4bjni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A190D98-6F3D-11EC-8CFE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Add the --path-first-parent-not flag, which
> causes the traversal of any "not" commits
> to visit only the first parent upon encountering
> a merge commit.
>
>    -A-----E-F-G--main
>      \   / /
>       B-C-D--topic
>
> In this example, the goal is to return the
> set {B, C, D} which represents a topic
> branch that has been merged into main branch.
> `git rev-list topic ^main` will end up returning
> no commits since excluding main will end up
> traversing the commits on topic as well.
> `git rev-list --first-parent-not topic ^main`
> however will return {B, C, D} as desired.

It may be true for _this_ particular topology, but it is unclear
what "the goal" is, and if the "ignore side branches that got
merged" is the right way to achieve that goal.  Perhaps shuffling
the order of explanation to state what you want to achieve first may
help clarify.

Is the goal "I have a commit that I know is at the tip of a topic
branch, but the topic may or may not have been merged to the primary
integration branch.  I want to know what commits were on the topic
branch"?

Even if we disregard a fast-forward merges from side branches, which
will screw up any algorithm that takes advantage of the assumption
that the first-parent chain is special, I am not quite convinced how
"propagate UNINTERESTING only along the first parent chain" is
necessary and sufficient for the purpose of solving that problem.
Care to elaborate on the correctness of the logic a bit more?

Please do not talk back with "give me a topology that the algorithm
would not work on, then".  The onus is on to whoever proposes a
change to show how it produces correct result.

> Add docs for the new flag, and clarify the
> doc for --first-parent to indicate that it
> applies to traversing the set of included
> commits only. The semantics of existing flags
> however have not changed.

This is a tangent.  Even though 45 is certainly less than 80, can we
use a bit wider lines?  What you used in the documentation patch
(around 60-65?) may be more readable.

>  --first-parent::
> -	Follow only the first parent commit upon seeing a merge
> -	commit.  This option can give a better overview when
> -	viewing the evolution of a particular topic branch,
> -	because merges into a topic branch tend to be only about
> -	adjusting to updated upstream from time to time, and
> -	this option allows you to ignore the individual commits
> -	brought in to your history by such a merge.
> +	When finding commits to include, follow only the first
> +	parent commit upon seeing a merge commit.  This option
> +	can give a better overview when viewing the evolution of
> +	a particular topic branch, because merges into a topic
> +	branch tend to be only about adjusting to updated upstream
> +	from time to time, and this option allows you to ignore
> +	the individual commits brought in to your history by such
> +	a merge.

The only change is to clarify that the first-parent traversal is
done only on the positive side; what is implied but probably is lost
to most readers is that propagation of UNINTERESTING bit is not
affected by this option.  I made sure that "This option can ..."
and everything after it are identical to save other reviewers' time,
as the above hunk have unnecessary rewrapping of the text.

> +--first-parent-not::
> +	When finding commits to exclude, follow only the first
> +	parent commit upon seeing a merge commit.  This causes
> +	"not" commits to exclude only commits on that branch itself
> +	and not those brought in by a merge.

Are there places we use a term '"not" commit'?  What you are trying
to refer to is a subset of "UNINTERESTING commits"; it is the
initial set of UNINTERESTING commits the traversal starts with.  I
know we use the word "negative" (or sometimes "bottom") in the
context of discussing revision ranges on this list, but I do not
think we used either in end-user facing documentation pages.

Let's read the beginning of the description of "git log --help" to
see if we can find a good phrase our readers should already be
familiar with.  This is how we describe the command:

    List commits that are reachable by following the `parent` links
    from the given commit(s), but exclude commits that are reachable
    from the one(s) given with a '{caret}' in front of them.  The
    output is given in reverse chronological order by default.

Assuming that propagating the UNINTERESTING bit only along the first
parent chain is a way to achieve some meaningful result (which, as I
said, I am not convinced about), I probably would call this option
"--exclude-first-parent-only" and explain it perhaps like so

	Follow only the first-parent chain from commits given with a
	{caret} in front of them, to find commits to exclude.

        This prevents commits merged from the side branches from
	becoming uninteresting and instead be shown if they are
	reachable from the positive end of the range.

I am debating myself if the second paragraph is necessary, though.
I suspect that the first two-line paragraph may be sufficient.
