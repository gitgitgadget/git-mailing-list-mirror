Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D601C678D4
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjALQxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241993AbjALQwC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:52:02 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B761669BF
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:40:20 -0800 (PST)
Received: (qmail 5650 invoked by uid 109); 12 Jan 2023 16:39:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Jan 2023 16:39:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16901 invoked by uid 111); 12 Jan 2023 16:39:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Jan 2023 11:39:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Jan 2023 11:39:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] env-helper: move this built-in to to "test-tool
 env-helper"
Message-ID: <Y8A3yGeJl0TCDNqe@coredump.intra.peff.net>
References: <Y71qiCs+oAS2OegH@coredump.intra.peff.net>
 <patch-1.1-e662c570f1d-20230112T155226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-e662c570f1d-20230112T155226Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2023 at 05:03:21PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Arguably "git env--helper" should be "test-tool", which wouldn't run
> > into this problem, but it's probably not worth refactoring it for the
> > sake of these tests.
> 
> I think it's worth doing that, i.e. to take this alternate
> approach. When I removed the GIT_TEST_GETTEXT_POISON facility I didn't
> want to make that series any larger, and keeping it a built-in seemed
> harmless, as there wasn't any practical difference between an
> undocumented built-in and a test-tool.
> 
> But as your patch shows there is, I think we should just pay down that
> technical debt, rather than adding to it by accumulating workarounds
> (however small those are...).

Yeah, I am totally fine with this direction. My reservations were:

  1. It was work somebody had to do. But now you've done it.

  2. It's _possible_ that some script somewhere is depending on it. But
     I think the "--" in the name plus the lack of documentation means
     that it's unlikely, and that we're morally absolved if somebody's
     script does break.

>  .gitignore                                    |  1 -
>  Makefile                                      |  2 +-
>  git.c                                         |  1 -
>  .../helper/test-env-helper.c                  | 24 +++----
>  t/helper/test-tool.c                          |  1 +
>  t/helper/test-tool.h                          |  1 +
>  t/t0017-env-helper.sh                         | 62 +++++++++----------
>  t/test-lib-functions.sh                       |  2 +-
>  t/test-lib.sh                                 |  6 +-
>  9 files changed, 50 insertions(+), 50 deletions(-)
>  rename builtin/env--helper.c => t/helper/test-env-helper.c (71%)

The patch itself looks obviously correct to me.

> -	test_must_fail git env--helper --type=bool --default=false --exit-code MISSING >actual.out 2>actual.err &&
> +	test_must_fail test-tool env-helper --type=bool --default=false --exit-code MISSING >actual.out 2>actual.err &&

Long lines like these made me wonder if it should simply be "test-tool
env", which is shorter. We do not need "helper" to avoid polluting the
main git-command namespace, and everything in test-tool is a helper
anyway. But it probably doesn't matter much either way. It's not like
that line wasn't already overly long. :)

If we do take this, then my t/interop patch can be dropped, though we
might want to salvage the error message bit:

-- >8 --
Subject: [PATCH] t/interop: report which vanilla git command failed

The interop test library sets up wrappers "git.a" and "git.b" to
represent the two versions to be tested. It also wraps vanilla "git" to
report an error, with the goal of catching tests which accidentally fail
to use one of the version-specific wrappers (which could invalidate the
tests in a very subtle way).

But when it catches an invocation of vanilla git, it doesn't give any
details, which makes it very hard to debug exactly which invocation is
responsible (especially if it's buried in a function invocation, etc).
Let's report the arguments passed to git, which helps narrow it down.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/interop/interop-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/interop/interop-lib.sh b/t/interop/interop-lib.sh
index 3e0a2911d4..62f4481b6e 100644
--- a/t/interop/interop-lib.sh
+++ b/t/interop/interop-lib.sh
@@ -68,7 +68,7 @@ generate_wrappers () {
 	wrap_git .bin/git.a "$DIR_A" &&
 	wrap_git .bin/git.b "$DIR_B" &&
 	write_script .bin/git <<-\EOF &&
-	echo >&2 fatal: test tried to run generic git
+	echo >&2 fatal: test tried to run generic git: $*
 	exit 1
 	EOF
 	PATH=$(pwd)/.bin:$PATH
-- 
2.39.0.508.g93b13bde48
