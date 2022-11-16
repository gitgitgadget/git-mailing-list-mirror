Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28594C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 22:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiKPWEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKPWEN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 17:04:13 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E755AE
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 14:04:12 -0800 (PST)
Received: (qmail 22501 invoked by uid 109); 16 Nov 2022 22:04:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Nov 2022 22:04:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5317 invoked by uid 111); 16 Nov 2022 22:04:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Nov 2022 17:04:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Nov 2022 17:04:10 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 0/7] receive-pack: only use visible refs for
 connectivity check
Message-ID: <Y3VeWvj6bTw1C3jP@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
 <Y27KL0Yg7nzdQ+HC@nand.local>
 <Y3PLwW7krP0eJS6+@coredump.intra.peff.net>
 <Y3VUkKoKd8j7IW6T@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3VUkKoKd8j7IW6T@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2022 at 04:22:24PM -0500, Taylor Blau wrote:

> > This looks good to me, too. There's a typo (s/seciton/section/) in the
> > commit message of patch 6, but definitely not worth a re-roll. :)
> 
> Hmm. It looks like this is broken in CI when the default initial branch
> name is something other than "master":
> 
>     $ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main ./t6021-rev-list-exclude-hidden.sh -i --verbose-only=12 -x
>     [...]
>     expecting success of 6021.12 'receive: excluded hidden refs can be used with multiple pseudo-refs':
>         git -c transfer.hideRefs=refs/ rev-list --exclude-hidden=$section --all --exclude-hidden=$section --all >out &&
>         test_must_be_empty out
> 
>     + git -c transfer.hideRefs=refs/ rev-list --exclude-hidden=receive --all --exclude-hidden=receive --all
>     + test_must_be_empty out
>     + test 1 -ne 1
>     + test_path_is_file out
>     + test 1 -ne 1
>     + test -f out
>     + test -s out
>     + echo 'out' is not empty, it contains:
>     'out' is not empty, it contains:
>     + cat out
>     d2e88f5a45c63e4ec7e1fd303542944487abe89a
>     + return 1
>     error: last command exited with $?=1
>     not ok 12 - receive: excluded hidden refs can be used with multiple pseudo-refs
>     #
>     #			git -c transfer.hideRefs=refs/ rev-list --exclude-hidden=$section --all --exclude-hidden=$section --all >out &&
>     #			test_must_be_empty out
>     #
>     1..12
> 
> I haven't looked too deeply at what is going on here, but let's make
> sure to resolve this before graduating the topic down (which I would
> otherwise like to do in the next push-out, probably tomorrow or the next
> day).

The issue is that some of the tests assume that hiding "refs/" should
produce no output from "--exclude-hidden=receive --all". But it will
also show HEAD, even if it points to a hidden ref (which I think is OK,
and matches what receive-pack would do).

But because the setup uses "main" as one of the sample refs, HEAD may or
may not be valid, depending on what it points to (without setting
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME it points to master, which is
unborn).

So the fix is just:

diff --git a/t/t6021-rev-list-exclude-hidden.sh b/t/t6021-rev-list-exclude-hidden.sh
index 018796d41c..1543a93fe0 100755
--- a/t/t6021-rev-list-exclude-hidden.sh
+++ b/t/t6021-rev-list-exclude-hidden.sh
@@ -5,8 +5,8 @@ test_description='git rev-list --exclude-hidden test'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	test_commit_bulk --id=commit --ref=refs/heads/main 1 &&
-	COMMIT=$(git rev-parse refs/heads/main) &&
+	test_commit_bulk --id=commit --ref=refs/heads/foo 1 &&
+	COMMIT=$(git rev-parse refs/heads/foo) &&
 	test_commit_bulk --id=tag --ref=refs/tags/lightweight 1 &&
 	TAG=$(git rev-parse refs/tags/lightweight) &&
 	test_commit_bulk --id=hidden --ref=refs/hidden/commit 1 &&

but Patrick may want to select a more meaningful name. :)

Notably I don't think we want to do the usual

  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

at the top of the script. We really don't mean to depend on having a
specific branch that HEAD points to here.

-Peff
