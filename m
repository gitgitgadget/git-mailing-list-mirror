Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E17C433EF
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 12:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGIMXw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 9 Jul 2022 08:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIMXw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 08:23:52 -0400
Received: from mailproxy03.manitu.net (mailproxy03.manitu.net [217.11.48.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7939101D2
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 05:23:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a5b:4900:ae4b:436c:5d11:c712])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id EB4F212A01D4;
        Sat,  9 Jul 2022 14:23:45 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <96d4bb71505d87ed501c058bbd89bfc13d08b24a.1656593279.git.hanxin.hx@bytedance.com>
References: <cover.1656381667.git.hanxin.hx@bytedance.com> <cover.1656593279.git.hanxin.hx@bytedance.com> <96d4bb71505d87ed501c058bbd89bfc13d08b24a.1656593279.git.hanxin.hx@bytedance.com>
Subject: Re: [PATCH v4 1/1] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>, ps@pks.im
To:     hanxin.hx@bytedance.com
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <165736941632.704481.18414237954289110814.git@grubix.eu>
Date:   Sat, 09 Jul 2022 14:23:36 +0200
User-Agent: alot/0.10
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin venit, vidit, dixit 2022-07-01 03:34:30:
> The commit-graph is used to opportunistically optimize accesses to
> certain pieces of information on commit objects, and
> lookup_commit_in_graph() tries to say "no" when the requested commit
> does not locally exist by returning NULL, in which case the caller
> can ask for (which may result in on-demand fetching from a promisor
> remote) and parse the commit object itself.
> 
> However, it uses a wrong helper, repo_has_object_file(), to do so.
> This helper not only checks if an object is mmediately available in
> the local object store, but also tries to fetch from a promisor remote.
> But the fetch machinery calls lookup_commit_in_graph(), thus causing an
> infinite loop.
> 
> We should make lookup_commit_in_graph() expect that a commit given to it
> can be legitimately missing from the local object store, by using the
> has_object_file() helper instead.
> 
> Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
> ---
>  commit-graph.c                             |  2 +-
>  t/t5330-no-lazy-fetch-with-commit-graph.sh | 70 ++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 1 deletion(-)
>  create mode 100755 t/t5330-no-lazy-fetch-with-commit-graph.sh
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 92d4503336..2b04ef072d 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -898,7 +898,7 @@ struct commit *lookup_commit_in_graph(struct repository *repo, const struct obje
>                 return NULL;
>         if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
>                 return NULL;
> -       if (!repo_has_object_file(repo, id))
> +       if (!has_object(repo, id, 0))
>                 return NULL;
>  
>         commit = lookup_commit(repo, id);
> diff --git a/t/t5330-no-lazy-fetch-with-commit-graph.sh b/t/t5330-no-lazy-fetch-with-commit-graph.sh
> new file mode 100755
> index 0000000000..be33334229
> --- /dev/null
> +++ b/t/t5330-no-lazy-fetch-with-commit-graph.sh
> @@ -0,0 +1,70 @@
> +#!/bin/sh
> +
> +test_description='test for no lazy fetch with the commit-graph'
> +
> +. ./test-lib.sh
> +
> +run_with_limited_processses () {
> +       # bash and ksh use "ulimit -u", dash uses "ulimit -p"
> +       if test -n "$BASH_VERSION"
> +       then
> +               ulimit_max_process="-u"
> +       elif test -n "$KSH_VERSION"
> +       then
> +               ulimit_max_process="-u"
> +       fi
> +       (ulimit ${ulimit_max_process-"-p"} 512 && "$@")
> +}

This new test fails for me unless I increase max_processes. 1024 works.

I haven't bisected the number of prcesses ... This is higly system
dependent. I even run a slim environment (i3wm) but having chrome or
such running probably makes quite a difference.

512 is probably OK in CI in an isolated environment but is too low on a
typical "What you mean I'm not working? I'm waiting for the test run!"
developper workstation.

Conversely, which number would be too high to catch what the test is
supposed to catch? Does it incur a big performance penalty to go as high
as possible?

> +
> +test_lazy_prereq ULIMIT_PROCESSES '
> +       run_with_limited_processses true
> +'
> +
> +if ! test_have_prereq ULIMIT_PROCESSES
> +then
> +       skip_all='skipping tests for no lazy fetch with the commit-graph, ulimit processes not available'
> +       test_done
> +fi
> +
> +test_expect_success 'setup: prepare a repository with a commit' '
> +       git init with-commit &&
> +       test_commit -C with-commit the-commit &&
> +       oid=$(git -C with-commit rev-parse HEAD)
> +'
> +
> +test_expect_success 'setup: prepare a repository with commit-graph contains the commit' '
> +       git init with-commit-graph &&
> +       echo "$(pwd)/with-commit/.git/objects" \
> +               >with-commit-graph/.git/objects/info/alternates &&
> +       # create a ref that points to the commit in alternates
> +       git -C with-commit-graph update-ref refs/ref_to_the_commit "$oid" &&
> +       # prepare some other objects to commit-graph
> +       test_commit -C with-commit-graph something &&
> +       git -c gc.writeCommitGraph=true -C with-commit-graph gc &&
> +       test_path_is_file with-commit-graph/.git/objects/info/commit-graph
> +'
> +
> +test_expect_success 'setup: change the alternates to what without the commit' '
> +       git init --bare without-commit &&
> +       git -C with-commit-graph cat-file -e $oid &&
> +       echo "$(pwd)/without-commit/objects" \
> +               >with-commit-graph/.git/objects/info/alternates &&
> +       test_must_fail git -C with-commit-graph cat-file -e $oid
> +'
> +
> +test_expect_success 'fetch any commit from promisor with the usage of the commit graph' '
> +       # setup promisor and prepare any commit to fetch
> +       git -C with-commit-graph remote add origin "$(pwd)/with-commit" &&
> +       git -C with-commit-graph config remote.origin.promisor true &&
> +       git -C with-commit-graph config remote.origin.partialclonefilter blob:none &&
> +       test_commit -C with-commit any-commit &&
> +       anycommit=$(git -C with-commit rev-parse HEAD) &&
> +
> +       run_with_limited_processses env GIT_TRACE="$(pwd)/trace.txt" \
> +               git -C with-commit-graph fetch origin $anycommit 2>err &&

That empty line abobe makes me nervous, especially when a test fails for
very unclear reasons like here. Is it necessary?

If the answer is "to separate setup and test" then the solution is to
separate setup and test ...

> +       ! grep "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
> +       grep "git fetch origin" trace.txt >actual &&
> +       test_line_count = 1 actual
> +'
> +
> +test_done
> -- 
> 2.36.1
> 
>
