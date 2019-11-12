Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9BF61F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 05:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfKLFVL (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 00:21:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56608 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfKLFVK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 00:21:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA2CB214E2;
        Tue, 12 Nov 2019 00:21:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JiIkH58rr7aVMaVBMcObZusXsVY=; b=fUp8XI
        J/sYrwSd1WWIbZITKkse38ttkCVa4H6yMsKkUGTO7vRJjDZp4Jhmpi7Mb/Q8vIV2
        ZHqDA2yd9pEb+Q8yaZfD/eP36QaHrfdjYcjLa5HZaO3SnYkbvK35xgi+K0cJ+SDu
        tsEaKAhTA5sFlrhS03WZYEtbuqGvZYCav+SBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d0RJ848w1ZYDwoqW0a5zQ0NGi7jhn4ce
        Wz9QfdUzxf9yigouWCWfxByZFwmHxNUenPSUTvZitpH9hv28DyTxIkX2GfTtiZUR
        X71+kFJcwYTJ9anBqVwP7equm4l2VcqLMO2y28aIUhOSruVH7A1jKjfpvmsEILHm
        94Ao/ytZrXk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1F9D214E1;
        Tue, 12 Nov 2019 00:21:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C2CB214DF;
        Tue, 12 Nov 2019 00:21:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Grzegorz Rajchman <rayman17@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] git stash pop --quiet deletes files in git 2.24.0
References: <CAMcnqp22tEFva4vYHYLzY83JqDHGzDbDGoUod21Dhtnvv=h_Pg@mail.gmail.com>
        <20191107184912.GA3115@cat>
        <xmqq7e4bp06l.fsf@gitster-ct.c.googlers.com>
        <20191108165929.GB3115@cat>
        <xmqqk188l0pn.fsf@gitster-ct.c.googlers.com>
        <20191111195641.GC3115@cat>
Date:   Tue, 12 Nov 2019 14:21:01 +0900
In-Reply-To: <20191111195641.GC3115@cat> (Thomas Gummerer's message of "Mon,
        11 Nov 2019 19:56:41 +0000")
Message-ID: <xmqqftitfz5u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37C08260-050C-11EA-8687-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> > From what you are saying above, and from my testing I think this
>> > refresh is actually unnecessary, and we could just remove it outright.
>> 
>> Perhaps.  But later it will bite us when somebody wants to rewrite
>> the "status at the end" part in C.
>
> Hmm, wouldn't the not re-reading the index part bite us there, rather
> than the not refreshing the index?

Yes.  Just removing the refresh-and-write that caused us to write
out incorrect data would "fix" the bug, while leaving the bug of not
re-reading to bite us later.

> Below is the patch that I believe has the least chances of biting us
> in the future, with the appropriate updated tests.  I had considered
> leaving the 'refresh_and_write_cache()' call there, but as I was
> writing the commit message I had a harder and harder time justifying
> that, so it's gone now, which I think is the right thing to do.
> Leaving it there would be okay as well, however I don't think it would
> have any benefit.
>
> --- >8 ---
> Subject: [PATCH] stash: make sure we have a valid index before writing it
>
> In 'do_apply_stash()' we refresh the index in the end.  Since
> 34933d0eff ("stash: make sure to write refreshed cache", 2019-09-11),
> we also write that refreshed index when --quiet is given to 'git stash
> apply'.
>
> However if '--index' is not given to 'git stash apply', we also
> discard the index in the else clause just before.  This leads to
> writing the discarded index, which means we essentially write an empty
> index file.  This is obviously not correct, or the behaviour the user
> wanted.  We should not modify the users index without being asked to
> do so.
>
> Make sure to re-read the index after discarding the current in-core
> index, to avoid dealing with outdated information.

Yup.  The "!has_index" codepath calls update_index() that turns the
on-disk index into the desired shape (would it help explaining that
in the previous paragraph, by the way?) so all we need to do is to
read it back into core.  Makes sense.

> We can drop the 'refresh_and_write_cache' completely in the quiet
> case.  Previously in legacy stash we relied on 'git status' to refresh
> the index after calling 'git read-tree' when '--index' was passed to
> 'git apply'.  However the 'reset_tree()' call that replaced 'git
> read-tree' always passes options that are equivalent to '-m', making
> the refresh of the index unnecessary.

OK.

> We could also drop the 'discard_cache()' + 'read_cache()', however
> that would make it easy to fall into the same trap as 34933d0eff did,
> so it's better to avoid that.

This is the discarded alternative of the main fix we saw earlier.
Perhaps it may make the flow of thought easier to follow if we moved
it up before talking about "refresh-and-write can be thrown away"?

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/stash.c  | 6 ++----
>  t/t3903-stash.sh | 5 ++++-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index ab30d1e920..d00567285f 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -482,12 +482,10 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  			return -1;
>  
>  		discard_cache();
> +		read_cache();

A comment

    /* read back the result of update_index() back from the disk */

before discard_cache() may be warranted?

>  	}
>  
> -	if (quiet) {
> -		if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
> -			warning("could not refresh index");
> -	} else {

OK.

> +	if (!quiet) {
>  		struct child_process cp = CHILD_PROCESS_INIT;
>  
>  		/*
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 392954d6dd..b1c973e3d9 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -232,8 +232,9 @@ test_expect_success 'save -q is quiet' '
>  	test_must_be_empty output.out
>  '
>  
> -test_expect_success 'pop -q is quiet' '
> +test_expect_success 'pop -q works and is quiet' '
>  	git stash pop -q >output.out 2>&1 &&
> +	test bar = "$(git show :file)" &&

Ah, this is to ensure that we didn't lose the "file" from the index?

Denton is on the quest of removing "$(git command substitution)"
used in a way that might hide the error from git invocation in a
separate thread [*1*].  This may want to become

	git rev-parse --verify :file &&

or

	git show :file >actual && echo bar >expect &&
	test_cmp expect actual &&

perhaps?

>  	test_must_be_empty output.out
>  '
>  
> @@ -242,6 +243,8 @@ test_expect_success 'pop -q --index works and is quiet' '
>  	git add file &&
>  	git stash save --quiet &&
>  	git stash pop -q --index >output.out 2>&1 &&
> +	git diff-files file2 >file2.diff &&
> +	test_must_be_empty file2.diff &&
>  	test foo = "$(git show :file)" &&
>  	test_must_be_empty output.out
>  '

Dittto.

Thanks.


[Reference]

*1* <2f9052fd94ebb6fe93ea6fe2e7cd3c717635c822.1573517561.git.liu.denton@gmail.com>

Note that "var=$(git subcmd)" is special and will signal us a failure
of the git invocation.
