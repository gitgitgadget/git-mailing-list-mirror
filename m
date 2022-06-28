Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715DCC433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 02:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243233AbiF1CDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 22:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbiF1CDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 22:03:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B13BE3A
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 19:03:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o18so9791633plg.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 19:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSpYlCLym3T3lvojCIGCmgYMVz1JXxVO2+oeTGsnUgk=;
        b=LWmvSpDpBg/YjzEYp47TZUIwGDXfWt8jsmDJLLq1BOwJ2nstqKQUbWRsBHyXPVqT8B
         dIxDsPLAbFVMV6y0pWKwUfnUIw1hKbIa3vi9sWfl+YdLeaOsX4R4c/KPkJNHElHrMTex
         6b8b9sMg49RjD9+yAx/GzK1yvnwbh1hjggd1qcof6i51J1pHehwwgs9khIA4XE0bYdn6
         2ZKHllf4HO4DCMnezfPJfhLLWdGP4WQj3D0DYTYgF8M+Zs9dLHW42CRmFSt6RN1rKo5i
         h1edKGBP4klzE5QD4V8nXnV87mVfT5+5wI8nNCppodgt/f/ueOQEGvZunHqx7fHcOVSr
         vHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSpYlCLym3T3lvojCIGCmgYMVz1JXxVO2+oeTGsnUgk=;
        b=iKwF0jYsdzFG+yQlOkiw1GxztDeR0Efvf/Uww3m01ggCdwYnpekluvW3rBqwy3yOsQ
         A36MrA3U/rYU99g2zsl0BzHoU+8y+X0q9lpxbCkFE3I79R1DL7hQqfrPVCcIlGA5agrh
         2+9GWJJQwnqV0Dd5+54qkIER+z3DCiYuMobHh36lV3LvJf3+yKjOnkj7WTmlOM/0zl9w
         19G5u1bqWnqNjWrFLvwaNkZCuizXeydD42Hja7lVZHzjPZ1tUSmQopQBdeh9en+DFTA2
         20aDtJFnLd/rStAZ6o6IHoED4xHJjU8n8WJ3GkGVaKPPH17eVw3fcgH56YscC9nXpkqa
         D1nw==
X-Gm-Message-State: AJIora8OiUkdz2ikz62bq1/FnvFXCC2Jif+F9KC659HvCZW3+zacmHl2
        u+XEc61cGqswPgPuZbmR4PZAlg==
X-Google-Smtp-Source: AGRyM1uZ1D6eIY5TLZJ5MNJmJ7LTrgW3MjpE9lVB20FhC+52EQtjncipToekitc3zYvUpkP/HzMdDw==
X-Received: by 2002:a17:902:e483:b0:16a:6113:c1d with SMTP id i3-20020a170902e48300b0016a61130c1dmr1188022ple.62.1656381785033;
        Mon, 27 Jun 2022 19:03:05 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id n18-20020a63f812000000b0040c33cb0ccasm7823744pgh.42.2022.06.27.19.03.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jun 2022 19:03:04 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     hanxin.hx@bytedance.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: [PATCH v3 0/2] no lazy fetch in lookup_commit_in_graph()
Date:   Tue, 28 Jun 2022 10:02:50 +0800
Message-Id: <cover.1656381667.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656044659.git.hanxin.hx@bytedance.com>
References: <cover.1656044659.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch fixes the following issue:
When we found the commit in the graph in lookup_commit_in_graph(), but
the commit is missing from the repository, we will try
promisor_remote_get_direct() and then enter another loop.

Then we will go into an endless loop:
  git fetch -> deref_without_lazy_fetch() ->
    lookup_commit_in_graph() -> repo_has_object_file() ->
      promisor_remote_get_direct() -> fetch_objects() ->
        git fetch (a new loop round)

Changes since v2:

* Remove test_have_prereq() from ULIMIT_PROCESSES as
  "run_with_limited_processses true" is enough.

* Teach run_with_limited_processses() to support dash and zsh.

* Skip the whole test file if ulimit is not avaliable.

* Minor grammar/comment etc. fixes throughout.

Han Xin (2):
  test-lib.sh: add limited processes to test-lib
  commit-graph.c: no lazy fetch in lookup_commit_in_graph()

 commit-graph.c                             |  2 +-
 t/t5329-no-lazy-fetch-with-commit-graph.sh | 53 ++++++++++++++++++++++
 t/test-lib.sh                              | 16 +++++++
 3 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100755 t/t5329-no-lazy-fetch-with-commit-graph.sh

Range-diff against v2:
1:  442a4c351d ! 1:  ad0a539759 test-lib.sh: add limited processes to test-lib
    @@ t/test-lib.sh: test_lazy_prereq ULIMIT_FILE_DESCRIPTORS '
      '
      
     +run_with_limited_processses () {
    -+	(ulimit -u 512 && "$@")
    ++	# bash and ksh use "ulimit -u", dash uses "ulimit -p"
    ++	if test -n "$BASH_VERSION"
    ++	then
    ++		ulimit_max_process="-u"
    ++	elif test -n "$KSH_VERSION"
    ++	then
    ++		ulimit_max_process="-u"
    ++	fi
    ++	(ulimit ${ulimit_max_process-"-p"} 512 && "$@")
     +}
     +
     +test_lazy_prereq ULIMIT_PROCESSES '
    -+	test_have_prereq !HPPA,!MINGW,!CYGWIN &&
     +	run_with_limited_processses true
     +'
     +
2:  a7d456db9b ! 2:  3cdb1abd43 commit-graph.c: no lazy fetch in lookup_commit_in_graph()
    @@ Metadata
      ## Commit message ##
         commit-graph.c: no lazy fetch in lookup_commit_in_graph()
     
    -    If a commit is in the commit graph, we would expect the commit to also
    -    be present. So we should use has_object() instead of
    -    repo_has_object_file(), which will help us avoid getting into an endless
    -    loop of lazy fetch.
    +    The commit-graph is used to opportunistically optimize accesses to
    +    certain pieces of information on commit objects, and
    +    lookup_commit_in_graph() tries to say "no" when the requested commit
    +    does not locally exist by returning NULL, in which case the caller
    +    can ask for (which may result in on-demand fetching from a promisor
    +    remote) and parse the commit object itself.
     
    -    When we found the commit in the graph in lookup_commit_in_graph(), but
    -    the commit is missing from the repository, we will try
    -    promisor_remote_get_direct() and then enter another loop. While
    -    sometimes it will finally succeed because it cannot fork subprocess,
    -    it has exhausted the local process resources and can be harmful to the
    -    remote service.
    +    However, it uses a wrong helper, repo_has_object_file(), to do so.
    +    This helper not only checks if an object is mmediately available in
    +    the local object store, but also tries to fetch from a promisor remote.
    +    But the fetch machinery calls lookup_commit_in_graph(), thus causing an
    +    infinite loop.
    +
    +    We should make lookup_commit_in_graph() expect that a commit given to it
    +    can be legitimately missing from the local object store, by using the
    +    has_object_file() helper instead.
     
         Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
     
    @@ t/t5329-no-lazy-fetch-with-commit-graph.sh (new)
     +
     +. ./test-lib.sh
     +
    ++if ! test_have_prereq ULIMIT_PROCESSES
    ++then
    ++	skip_all='skipping tests for no lazy fetch with the commit-graph, ulimit processes not available'
    ++	test_done
    ++fi
    ++
     +test_expect_success 'setup: prepare a repository with a commit' '
     +	git init with-commit &&
     +	test_commit -C with-commit the-commit &&
    @@ t/t5329-no-lazy-fetch-with-commit-graph.sh (new)
     +	# create a ref that points to the commit in alternates
     +	git -C with-commit-graph update-ref refs/ref_to_the_commit "$oid" &&
     +	# prepare some other objects to commit-graph
    -+	test_commit -C with-commit-graph somthing &&
    ++	test_commit -C with-commit-graph something &&
     +	git -c gc.writeCommitGraph=true -C with-commit-graph gc &&
     +	test_path_is_file with-commit-graph/.git/objects/info/commit-graph
     +'
    @@ t/t5329-no-lazy-fetch-with-commit-graph.sh (new)
     +	test_must_fail git -C with-commit-graph cat-file -e $oid
     +'
     +
    -+test_expect_success 'setup: prepare another commit to fetch' '
    -+	test_commit -C with-commit another-commit &&
    ++test_expect_success 'setup: prepare any commit to fetch' '
    ++	test_commit -C with-commit any-commit &&
     +	anycommit=$(git -C with-commit rev-parse HEAD)
     +'
     +
    -+test_expect_success ULIMIT_PROCESSES 'fetch any commit from promisor with the usage of the commit graph' '
    ++test_expect_success 'fetch any commit from promisor with the usage of the commit graph' '
     +	git -C with-commit-graph remote add origin "$(pwd)/with-commit" &&
     +	git -C with-commit-graph config remote.origin.promisor true &&
     +	git -C with-commit-graph config remote.origin.partialclonefilter blob:none &&
-- 
2.36.1

