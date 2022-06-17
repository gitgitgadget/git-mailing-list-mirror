Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17D8C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 17:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382500AbiFQRBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiFQRBu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 13:01:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6503054F
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 10:01:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 085CD18F900;
        Fri, 17 Jun 2022 13:01:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wTosYLOMXZK2HKiX9yBnMTVJZ3O3EBtspu6cLc
        s34YQ=; b=nY9nEOq9YFVe81wcfilGGGN3ez64hN17j/Hf9IpMrurqd4lYRsRBLv
        AgHI9L+Qzxac3fjlEDyrJRbNGLVqFXbNL+q1vbUHmYgNcukzN9gJUdH7J3x/72oY
        HbBwXxF+K7/vVN3/oWqTy8uEI8uLcgNIBuxNFLUc88/A/QUa1+fhw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3C0518F8FE;
        Fri, 17 Jun 2022 13:01:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95BA418F8FD;
        Fri, 17 Jun 2022 13:01:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, kylezhao <kylezhao@tencent.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] send-pack.c: add config push.useBitmaps
References: <pull.1263.v2.git.1655350617442.gitgitgadget@gmail.com>
        <pull.1263.v3.git.1655438361228.gitgitgadget@gmail.com>
Date:   Fri, 17 Jun 2022 10:01:43 -0700
In-Reply-To: <pull.1263.v3.git.1655438361228.gitgitgadget@gmail.com> (Kyle
        Zhao via GitGitGadget's message of "Fri, 17 Jun 2022 03:59:20 +0000")
Message-ID: <xmqqtu8jns08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AA328D2-EE5F-11EC-8B55-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  Documentation/config/push.txt |  6 ++++++
>  send-pack.c                   |  6 ++++++
>  send-pack.h                   |  3 ++-
>  t/t5516-fetch-push.sh         | 21 +++++++++++++++++++++
>  4 files changed, 35 insertions(+), 1 deletion(-)

Thanks.  This round looks more or less OK.

> diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> index e32801e6c91..f16ac9311db 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -137,3 +137,9 @@ push.negotiate::
>  	server attempt to find commits in common. If "false", Git will
>  	rely solely on the server's ref advertisement to find commits
>  	in common.
> +
> +push.useBitmaps::
> +	If this config and `pack.useBitmaps` are both `true`, then Git will
> +	use reachability bitmaps during `git push`, if available. If set to
> +	`false`, may improve push performance without affecting use of the
> +	reachability bitmaps for other operations. Default is true.

While nothing in the description is incorrect per-se, I somehow find
it hard to follow.  "git push" uses reachability bitmaps when three
conditions hold true at the same time (pack.useBitmaps that is by
default true, push.useBitmaps that is by default true, and there
exist reachability bitmaps to be used).  It is left unsaid why the
user needs to know about this configuration variable in order to
tweak "without affecting other operations".

I tried to come up with a version that I find easier to read (at
least to me).  I am not sure how successfull I was.

    While git can be told to use reachability bitmaps in general
    with "pack.useBitmaps" configuration, this variable can be used
    to disable use of bitmaps only for "git push" by setting it to
    false, without preventing other git operations from using
    bitmaps.

> diff --git a/send-pack.c b/send-pack.c
> index bc0fcdbb000..d18cde850ef 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -84,6 +84,8 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
>  		strvec_push(&po.args, "--progress");
>  	if (is_repository_shallow(the_repository))
>  		strvec_push(&po.args, "--shallow");
> +	if (args->no_use_bitmaps)
> +		strvec_push(&po.args, "--no-use-bitmap-index");

"disable_bitmaps" might be a better name for the struct member, but OK.

> @@ -498,6 +501,9 @@ int send_pack(struct send_pack_args *args,
>  	if (push_negotiate)
>  		get_commons_through_negotiation(args->url, remote_refs, &commons);
>  
> +	if (!git_config_get_bool("push.usebitmaps", &use_bitmaps))
> +		args->no_use_bitmaps = !use_bitmaps;

Because the "--no-use-bitmap-index" is explicitly given only when
the ".no_use_bitmaps" member is true and we do not pass
"--use-bitmap-index" merely because the member is false, the
configuration can only disable, which matches the documented
design.  Good.

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index dedca106a7a..ffda830ba22 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1865,4 +1865,25 @@ test_expect_success 'push warns or fails when using username:password' '
>  	test_line_count = 1 warnings
>  '
>  
> +test_expect_success 'push with config push.useBitmaps' '
> +	mk_test testrepo heads/main &&
> +	git checkout main &&
> +	GIT_TRACE2_EVENT="$PWD/default" \
> +	git push testrepo main:test &&
> +	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
> +		--thin --delta-base-offset -q <default &&

We do not pass "--no-use-bitmap-index" without configuration.
Good. 

How do we know this is the "default" state, by the way?  Because we
read the tests before this, all 1860 lines?

Perhaps

	test_unconfig push.useBitmaps &&

at the very beginning of the test would help future readers.  That
way, they can immediately tell that the first test piece is without
the variable.

> +	git config push.useBitmaps true &&
> +	GIT_TRACE2_EVENT="$PWD/true" \
> +	git push testrepo main:test2 &&

Perhaps use

	test_config push.useBitmaps true

instead?  That way, after this test-expect-success finishes,
push.useBitmaps variable will be wiped from the configuration
variable.  That is a good hygiene to follow to help future
developers who may need to add more tests after this one.

> +	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
> +		--thin --delta-base-offset -q <true &&
> +
> +	git config push.useBitmaps false &&

Likewise.

> +	GIT_TRACE2_EVENT="$PWD/false" \
> +	git push testrepo main:test3 &&
> +	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
> +		--thin --delta-base-offset -q --no-use-bitmap-index <false
> +'
> +
>  test_done


Lastly, some critique on the proposed log message.

> This allows you to disable bitmaps for "git push". Default is true.

I find it more confusing to have this line at the beginning than
without.  What the configuration variable does is explained later
anyway, and our convention is not to start from such a "conclusion"
but ease the readers into the reasoning by starting with the
explanation of the status quo, which leads readers to realize why
the current system is lacking.

> Reachability bitmaps are designed to speed up the "counting objects"
> phase of generating a pack during a clone or fetch. They are not
> optimized for Git clients sending a small topic branch via "git push".
> In some cases (see [1]), using reachability bitmaps during "git push"
> can cause significant performance regressions.

And this paragraph brilliantly does its job.  A reader who did not
even know what the reachability bitmaps are for is now prepared to
follow your logic why it is a good idea to special case "git push"
because you explain that it is good for some things and not
necessarily good for others like "git push".

> Add a new "push.useBitmaps" config option to disable reachability
> bitmaps during "git push". This allows reachability bitmaps to still
> be used in other areas, such as "git rev-list --use-bitmap-index".

I had the same problem with this paragraph as the one in the
documentation part of the patch.  Nothing in it is incorrect per-se,
but is roundabout way of saying what it wants to say.

Here is my attempted rewrite.

    Add a new "push.useBitmaps" configuration variable to allow users to
    tell "git push" not to use bitmaps.  We already have "pack.bitmaps"
    that controls the use of bitmaps, but a separate configuration
    variable allows the reachability bitmaps to still be used in other
    areas, such as "git rev-list --use-bitmap-index", while disabling it
    only for "git push".

Thanks.
