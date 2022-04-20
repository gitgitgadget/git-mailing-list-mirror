Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4DFC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355547AbiDTUtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbiDTUtT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:49:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFB11039
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:46:32 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68A781857E5;
        Wed, 20 Apr 2022 16:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GyUGaMmp8kAOQrqX0xYdeUtkD4aCrQyT+m5+6W
        Yy5wY=; b=RuzM91RM3f3K+zeYRJj553qXb0/y4R7E+98oBe34AKGxse7QewwwaY
        c9Gb11SpPCDZN+piuav9AHxndPJFo0cfvTtfj1On6VQZynQKVxsR9dsC1o3gBG04
        m+QaNyG6s99VpMNgWGR4+c5FHMsA78Xam8LFhkTIDdbrB4PsqxIw0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6098D1857E4;
        Wed, 20 Apr 2022 16:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E1D801857E2;
        Wed, 20 Apr 2022 16:46:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, liu.denton@gmail.com, sunshine@sunshineco.com,
        avarab@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] rebase: use correct base for --keep-base when a branch
 is given
References: <20220418012716.2683624-1-alexhenrie24@gmail.com>
Date:   Wed, 20 Apr 2022 13:46:26 -0700
In-Reply-To: <20220418012716.2683624-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Sun, 17 Apr 2022 19:27:16 -0600")
Message-ID: <xmqqh76no53x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F35BADFA-C0EA-11EC-91B0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> -	/* Make sure the branch to rebase onto is valid. */

So, we used to ...

> -	if (keep_base) {
> -		strbuf_reset(&buf);
> -		strbuf_addstr(&buf, options.upstream_name);
> -		strbuf_addstr(&buf, "...");
> -		options.onto_name = xstrdup(buf.buf);

... store "<upstream>..." in onto_name ...

> -	} else if (!options.onto_name)
> -		options.onto_name = options.upstream_name;

... or used <upstream> as onto_name, and then ...

> -	if (strstr(options.onto_name, "...")) {

... immediately used the "..." as a cue to compute the merge base
and ...

> -		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
> -			if (keep_base)
> -				die(_("'%s': need exactly one merge base with branch"),
> -				    options.upstream_name);
> -			else
> -				die(_("'%s': need exactly one merge base"),
> -				    options.onto_name);
> -		}
> -		options.onto = lookup_commit_or_die(&merge_base,
> -						    options.onto_name);

... used the "<upstream>..." as a label, and the merge base as the
"onto" commit.

> -	} else {
> -		options.onto =
> -			lookup_commit_reference_by_name(options.onto_name);
> -		if (!options.onto)
> -			die(_("Does not point to a valid commit '%s'"),
> -				options.onto_name);
> -	}
> -

But that was done before we even examined the optinal "this one, not
the current branch, is to be rebased" argument.  So it all works by
assuming the current branch is what is being rebase, which clearly
is wrong.

It is surprising that a basic and trivial bug was with us forever.
I wonder if the addition of --keep-base was faulty and the feature
was broken from the beginning, or there was an unrelated change that
broke the interaction between --keep-base and branch-to-be-rebased?

    ... goes and looks ...
    
    Between 640f9cd5 (Merge branch 'dl/rebase-i-keep-base',
    2019-09-30) which was where "--keep-base" was introduced, and
    today's codebase, there are many unrelated changes to
    builtin/rebase.c but this part is essentially unchanged.  Before
    the option was introduced, it didn't matter if the computation
    of "onto" came before or after the next part that is not shown
    in this patch, because "..." could have come only from the
    end-user input and there the end-user must have given the branch
    to be rebased on the right hand side of "..." if that is what
    they meant.  So, the feature was broken from the moment the
    "--keep-base" option was introduced.

Now we got rid of all the above, so we need to be careful that we do
not depend on options.onto_name and options.onto in the part that
you did not touch, from here to the precontext of the next hunk.

And I looked for onto and onto_name, these strings do not appear
from this point until the next hunk where we see an added line, so
we are not breaking that part of the code by removing this block of
code from here and moving it down.

>  	/*
>  	 * If the branch to rebase is given, that is the branch we will rebase
>  	 * branch_name -- branch/commit being rebased, or
> @@ -1659,6 +1632,34 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	} else
>  		BUG("unexpected number of arguments left to parse");
>  
> +	/* Make sure the branch to rebase onto is valid. */

And now we do what the removed block wanted to do here, but we do so
in a different context.  We know know which branch gets rebased in
the branch_name variable, so we do not use "<upstream>..." notation
to imply "the current branch" on the RHS; we can be explicit.

> +	if (keep_base) {
> +		strbuf_reset(&buf);
> +		strbuf_addstr(&buf, options.upstream_name);
> +		strbuf_addstr(&buf, "...");
> +		strbuf_addstr(&buf, branch_name);

... and that is what happens here, which is good.

The rest of this new block is a literal copy from the old code
removed above, which is as expected.

> +		options.onto_name = xstrdup(buf.buf);
> +	} else if (!options.onto_name)
> +		options.onto_name = options.upstream_name;
> +	if (strstr(options.onto_name, "...")) {
> +		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
> +			if (keep_base)
> +				die(_("'%s': need exactly one merge base with branch"),
> +				    options.upstream_name);
> +			else
> +				die(_("'%s': need exactly one merge base"),
> +				    options.onto_name);
> +		}
> +		options.onto = lookup_commit_or_die(&merge_base,
> +						    options.onto_name);
> +	} else {
> +		options.onto =
> +			lookup_commit_reference_by_name(options.onto_name);
> +		if (!options.onto)
> +			die(_("Does not point to a valid commit '%s'"),
> +				options.onto_name);
> +	}
> +
>  	if (options.fork_point > 0) {
>  		struct commit *head =
>  			lookup_commit_reference(the_repository,



> diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
> index 3716a42e81..d1db528e25 100755
> --- a/t/t3416-rebase-onto-threedots.sh
> +++ b/t/t3416-rebase-onto-threedots.sh
> @@ -129,6 +129,22 @@ test_expect_success 'rebase --keep-base main from topic' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'rebase --keep-base main topic from main' '
> +	git reset --hard &&

Clearing whatever cruft the last test left is good, but ...

> +	git checkout topic &&
> +	git reset --hard G &&
> +	git checkout main &&

it would be more efficient to just do

	git checkout main &&
	git branch -f topic G &&

no?  Instead of rewriting the working tree three times, you only
need to do so once here.

