Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED29C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 16:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiFXQ4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiFXQ4U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 12:56:20 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07751473AF
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 09:56:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E4DF146E6F;
        Fri, 24 Jun 2022 12:56:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=srAmsKhgYiAy
        M0JuRDeEAAKEkDfMxa1mw1MljudYPaQ=; b=Auw8bsE9rrnjSh/Tb7snAkamJtL1
        YhSrn/a4BgJoz+tu8tBPw4Hkh3EgOC8eTSaXu77ejmfbGrUWZMKsBbZp+ylMVzrc
        FTRytqn3VIl5JtsLpxahenLmmPC/14bSTs+qV43zlx13oBCiHhuqAKVOLT6MBgKC
        knU85snXIzmrkrU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02E5C146E6E;
        Fri, 24 Jun 2022 12:56:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4EE74146E6D;
        Fri, 24 Jun 2022 12:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com, ps@pks.im
Subject: Re: [PATCH v2 2/2] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
References: <20220618030130.36419-1-hanxin.hx@bytedance.com>
        <cover.1656044659.git.hanxin.hx@bytedance.com>
        <d3a99a5c5ae538b626e04d7069dd2fc316605dfc.1656044659.git.hanxin.hx@bytedance.com>
Date:   Fri, 24 Jun 2022 09:56:16 -0700
In-Reply-To: <d3a99a5c5ae538b626e04d7069dd2fc316605dfc.1656044659.git.hanxin.hx@bytedance.com>
        (Han Xin's message of "Fri, 24 Jun 2022 13:27:57 +0800")
Message-ID: <xmqqpmiyuhjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 90743E42-F3DE-11EC-8695-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <hanxin.hx@bytedance.com> writes:

> If a commit is in the commit graph, we would expect the commit to also
> be present.

Hmph, is that a fundamental requirement, or is that a limitation of
the current implementation?  Na=C3=AFvely, I do not quite see why we
cannot first partially clone from a remote, access objects that
locally do not exist and lazily fetch them from the promissor, and
then build a reachability graph.  I expect that the resulting commit
graph records the lazily fetched objects at that point.  And then we
should be able to "lose" the lazily fetched objects that we know we
can fetch from the promissor again when we need them in the future.
And we would be in a situation where commits are pruned away, not
locally available in our object store, but can be (re)fetched from
the promisor, no?

> So we should use has_object() instead of
> repo_has_object_file(), which will help us avoid getting into an endles=
s
> loop of lazy fetch.

It all depends on the reason we call lookup_commit_in_graph(), I
think.  Is there an easy way to remember the fact that we are
checking if object X is here with repo_has_object_file(X), so that
an on-demand fetch that happens when X does not locally exist would
not bother checking with lookup_commit_in_graph()?  IOW, temporarily
disable the use of commit-graph when we are lazily fetching?

> When we found the commit in the graph in lookup_commit_in_graph(),
> but the commit is missing from the repository, we will try
> promisor_remote_get_direct() and then enter another loop.  While
> sometimes it will finally succeed because it cannot fork
> subprocess,

Is that a mode of "succeed"-ing?  Or merely a way to exit an endless
loop that does not make any progress with a failure?

> it has exhausted the local process resources and can be harmful to the
> remote service.
>
> Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
> ---

I think the single-liner change in the patch is a good one, but I am
having a hard time to agree with the reasoning above that explains
why it is a good change.

Here is an attempt to express a reasoning I can understand, can
agree with, and (I think) better describes why the change is a good
one.  Does my understanding of the problem and the solution totally
misses the mark?

	The commit-graph is used to opportunistically optimize
	accesses to certain pieces of information on commit objects,
	and lookup_commit_in_graph() tries to say "no" when the
	requested commit does not locally exist by returning NULL,
	in which case the caller can ask for (which may result in
	on-demand fetching from a promisor remote) and parse the
	commit object itself.

	However, it uses a wrong helper, repo_has_object_file(), to
	do so.  This helper not only checks if an object is
	immediately available in the local object store, but also
	tries to fetch from a promisor remote.  But the fetch
	machinery calls lookup_commit_in_graph(), thus causing an
	infinite loop.

	We should make lookup_commit_in_graph() expect that a commit
	given to it can be legitimately missing from the local
	object store, by using the has_object_file() helper instead.
=09
> diff --git a/t/t5329-no-lazy-fetch-with-commit-graph.sh b/t/t5329-no-la=
zy-fetch-with-commit-graph.sh
> new file mode 100755
> index 0000000000..4d25d2c950
> --- /dev/null
> +++ b/t/t5329-no-lazy-fetch-with-commit-graph.sh

Hmph, does this short-test need a completely new file?

> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +
> +test_description=3D'test for no lazy fetch with the commit-graph'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup: prepare a repository with a commit' '
> +	git init with-commit &&
> +	test_commit -C with-commit the-commit &&
> +	oid=3D$(git -C with-commit rev-parse HEAD)
> +'
> +
> +test_expect_success 'setup: prepare a repository with commit-graph con=
tains the commit' '
> +	git init with-commit-graph &&
> +	echo "$(pwd)/with-commit/.git/objects" \
> +		>with-commit-graph/.git/objects/info/alternates &&
> +	# create a ref that points to the commit in alternates
> +	git -C with-commit-graph update-ref refs/ref_to_the_commit "$oid" &&
> +	# prepare some other objects to commit-graph
> +	test_commit -C with-commit-graph somthing &&

somthing? something?

> +	git -c gc.writeCommitGraph=3Dtrue -C with-commit-graph gc &&
> +	test_path_is_file with-commit-graph/.git/objects/info/commit-graph
> +'
> +
> +test_expect_success 'setup: change the alternates to what without the =
commit' '
> +	git init --bare without-commit &&
> +	echo "$(pwd)/without-commit/objects" \
> +		>with-commit-graph/.git/objects/info/alternates &&

Doesn't this deliberately _corrupt_ the with-commit-graph repository
that depended on the object whose name is $oid in with-commit
repository?  Do we require a corrupt repository to trigger the "bug"?

> +	test_must_fail git -C with-commit-graph cat-file -e $oid
> +'
> +
> +test_expect_success 'setup: prepare another commit to fetch' '
> +	test_commit -C with-commit another-commit &&
> +	anycommit=3D$(git -C with-commit rev-parse HEAD)

anycommit?  another_commit?  Be consistent in naming.

> +'
> +
> +test_expect_success ULIMIT_PROCESSES 'fetch any commit from promisor w=
ith the usage of the commit graph' '

So we did all of the above set-up sequences only to skip the most
interesting test, if we were testing with "dash"?  I suspect that it
may be cleaner to put the prerequisite to the whole file with the
"early test_done" trick like t0051 and t3008.

> +	git -C with-commit-graph remote add origin "$(pwd)/with-commit" &&
> +	git -C with-commit-graph config remote.origin.promisor true &&
> +	git -C with-commit-graph config remote.origin.partialclonefilter blob=
:none &&
> +	GIT_TRACE=3D"$(pwd)/trace" run_with_limited_processses \
> +		git -C with-commit-graph fetch origin $anycommit 2>err &&
> +	test_i18ngrep ! "fatal: promisor-remote: unable to fork off fetch sub=
process" err &&
> +	test $(grep "fetch origin" trace | wc -l) -eq 1
> +'
> +
> +test_done

Thanks.
