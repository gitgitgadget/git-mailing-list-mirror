Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCADC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 16:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiBPQyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:54:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiBPQyV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 11:54:21 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F46293B72
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:54:08 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37DC317AFDA;
        Wed, 16 Feb 2022 11:54:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dJkXmWYI6AnUkLJD63+ppKcKKyejQO5VQU4NQ8
        8pDBM=; b=psn3yPeLP2fywH1IarWhJKoPKmtG//x2bMDxrWccrjIajjazqe64UO
        fO8qXzARc2+xDyjIE4j7tY969hEGqHHTEOSODSHpQXjNsdBJTLvAheOHYPhUB/Q1
        n2oWd2fW5D1G8mZbOmk8eq86itbm/SwQBanq3I90TNrhLksImmCcE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30D5817AFD9;
        Wed, 16 Feb 2022 11:54:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8656317AFD7;
        Wed, 16 Feb 2022 11:54:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Erlend Egeberg Aasland via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Erlend Egeberg Aasland <erlend.aasland@innova.no>
Subject: Re: [PATCH] branch: delete now accepts '-' as branch name
References: <pull.1217.git.git.1645020495014.gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 08:54:04 -0800
In-Reply-To: <pull.1217.git.git.1645020495014.gitgitgadget@gmail.com> (Erlend
        Egeberg Aasland via GitGitGadget's message of "Wed, 16 Feb 2022
        14:08:14 +0000")
Message-ID: <xmqqbkz6vjkj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D08119A-8F49-11EC-9D33-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: "Erlend E. Aasland" <erlend.aasland@innova.no>
>
> This makes it easy to get rid of short-lived branches:
>
> $ git switch -c experiment
> $ git switch -
> $ git branch -D -

Or you can use @{-1} directly.  Or short-lived experiment can
directly be done on HEAD without any branch ;-)

In any case, the above is sufficient demonstration.  I do not think
you'd need a second one that is identical---having two may help you
demonstrate there are multiple ways to start a short-lived branch
that you want to get rid of quickly, but it does not help convince
others how useful "branch -" is in such situations.

> $ gh pr checkout nnn
> $ make && make test
> $ git switch -
> $ git branch -D -
>
> Signed-off-by: Erlend E. Aasland <erlend.aasland@innova.no>
> ---


> diff --git a/builtin/branch.c b/builtin/branch.c
> index 4ce2a247542..f6c876c09d2 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -236,7 +236,11 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  		char *target = NULL;
>  		int flags = 0;
>  
> -		strbuf_branchname(&bname, argv[i], allowed_interpret);
> +		if (!strcmp(argv[i], "-")) {
> +			strbuf_branchname(&bname, "@{-1}", allowed_interpret);
> +		} else {
> +			strbuf_branchname(&bname, argv[i], allowed_interpret);
> +		}
>  		free(name);
>  		name = mkpathdup(fmt, bname.buf);

You do not need if/else here.

+	if (!strcmp(argv[i], "-"))
+		argv[i] = "@{-1}";
	strbuf_branchname(&bname, argv[i], allowed_interpret);

should be sufficient.  If you want to avoid assigning to argv[i],
if/else is OK, but then lose the unnecessary {pair of braces} around
single-statement blocks.

> +test_expect_success 'git branch -D - should delete branch @{-1}' '
> +	git switch -c j &&
> +	git switch - &&
> +	git branch -D - &&
> +	test_path_is_missing .git/refs/heads/j &&

These days we try hard *NOT* to assume how refs are stored in the
system.  Please don't peek into .git/ at filesystem level, when you
can achieve what you want to in some other way.

    test_must_fail git show-ref --verify refs/heads/j

would be a more direct way.

> +	test_must_fail git reflog exists refs/heads/j

We should try not to assume that reflog for ref X is lost when ref X
itself goes away in newer tests and update such assumptions in older
tests.  Ideally we would want to be able to say "at time X, branch
'j' was removed, and at time X+Y, branch 'j' was recreated", and
adding more of these will make such an improvement harder to make.

This script is riddled with instances of these existing problems.
Please don't make it even worse by adding on top of them.

The added ones is a positive test.  A new feature works as expected
in a situation where it should kick in.  There needs an accompanying
negative test or two, making sure it fails sensibly in a situation
where it should fail.  Off the top of my head, negative tests that
are appropriate for this new feature are:

    * In a freshly created repository, possibly creating a few
      commits on the initial branch without ever switching to a
      different branch, what should happen when you use the new
      "branch -d -" feature?  What error message, if any, should
      the user see?  Do we show that expected message?

    * Switch to a new branch, create a commit on top, switch back to
      the original branch and run "branch -d -".  This should fail
      because you'd be losing the commit created on the branch.
      What error message should the user see?  Do we show the name
      of the branch correctly?  Do we show "@{-1}", or "-"?

    * After running "branch -D -" to successfully remove the
      previous branch, run "branch -D -" again.  This should fail
      because the branch you are trying to remove no longer exists.
      What error message should the user see?

Thanks for trying to make Git better.

