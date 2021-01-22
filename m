Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE16C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 20:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42B423B06
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 20:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbhAVUt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 15:49:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62219 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbhAVU2E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 15:28:04 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38858943C9;
        Fri, 22 Jan 2021 15:27:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BsWCjobrzaV0peOrwrfOUWJX4LI=; b=fkYJhD
        S/e69AerqcxTcU9CtVPM1VUFNuN1MLXE/BdO1l3suIiQrylBfAZK0elEc6SlFSdV
        bNLDrQXf+6t5bUh+FJffAOd3I7EdmeG+o5S+IkJg6QitD29Netjy5SZ35rHMB9pU
        mY1TBGy9/qSqVIQd8PW5tIsQ/xWDqpIU7sZiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VfWtvGXhvYMCAH0ocZ5ZJ+UK/uJCYMN/
        sIzqqu/UPtMLYa5hPyDg1WrW7uGl5mCK5vq18Uyk+xTuTVkvMhT7Oak4QpfcTh1C
        GRXs4G9Tg6wDgZeknrk3iX88yoqjQQ0Bik/9tNNk4ef/SjseNN37zwTmIns72hoc
        si2mUUy9liw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30A99943C8;
        Fri, 22 Jan 2021 15:27:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF28E943C6;
        Fri, 22 Jan 2021 15:27:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] range-diff/format-patch: refactor check for
 commit range
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
        <3f21e10f919eead049dc2440a29bb2bed6c99d0d.1611339373.git.gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 12:27:10 -0800
In-Reply-To: <3f21e10f919eead049dc2440a29bb2bed6c99d0d.1611339373.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 22 Jan 2021
        18:16:10 +0000")
Message-ID: <xmqqzh107m5d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3513ED26-5CF0-11EB-9C9D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Currently, when called with exactly two arguments, `git range-diff`
> tests for a literal `..` in each of the two. Likewise, the argument
> provided via `--range-diff` to `git format-patch` is checked in the same
> manner.
>
> However, `<commit>^!` is a perfectly valid commit range, equivalent to
> `<commit>^..<commit>` according to the `SPECIFYING RANGES` section of
> gitrevisions[7].
>
> In preparation for allowing more sophisticated ways to specify commit
> ranges, let's refactor the check into its own function.

I think the sharing between the two makes sense, but the helper
function should make it clear in its name that this is "the kind of
commit range range-diff wants to take".  Among the commit range "git
log" and friends can take, range-diff can take only a subset of it,
and only a subset of it is meaningful to range-diff (e.g. HEAD^@ is
still a commit range you can give to "git log", but it would not
make much sense to give it to range-diff).

Perhaps

    s/specifies_commit_range/is_range_diff_range/

or something.

> diff --git a/revision.h b/revision.h

Move this to range-diff.h, not revision.h which is about true commit
ranges.

> index 086ff10280d..66777c8e60f 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -457,4 +457,11 @@ int rewrite_parents(struct rev_info *revs,
>   */
>  struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
>  
> +/*
> + * Determine whether the given argument defines a commit range, e.g. A..B.
> + * Note that this only validates the format but does _not_ parse it, i.e.
> + * it does _not_ look up the specified commits in the local repository.
> + */

And s/defines a commit range/is usable as a range to range-diff/

Thanks.

> +int specifies_commit_range(const char *range);
> +
>  #endif
