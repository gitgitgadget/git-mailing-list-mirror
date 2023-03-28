Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874F7C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC1UWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC1UWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:22:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941F026AA
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:22:08 -0700 (PDT)
Received: (qmail 1941 invoked by uid 109); 28 Mar 2023 20:22:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:22:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1708 invoked by uid 111); 28 Mar 2023 20:22:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:22:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:22:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH 1/4] tests: run internal chain-linter under "make test"
Message-ID: <20230328202207.GA1241631@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328202043.GA1241391@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 69b9924b875 (t/Makefile: teach `make test` and `make prove` to run
chainlint.pl, 2022-09-01), we run a single chainlint.pl process for all
scripts, and then instruct each individual script to run with the
equivalent of --no-chain-lint, which tells them not to redundantly run
the chainlint script themselves.

However, this also disables the internal linter run within the shell by
eval-ing "(exit 117) && $1" and confirming we get code 117. In theory
the external linter produces a superset of complaints, and we don't need
the internal one anymore. However, we know there is at least one case
where they differ. A test like:

	test_expect_success 'should fail linter' '
		false &&
		sleep 2 &
		pid=$! &&
		kill $pid
	'

is buggy (it ignores the failure from "false", because it is
backgrounded along with the sleep). The internal linter catches this,
but the external one doesn't (and teaching it to do so is complicated[1]).
So not only does "make test" miss this problem, but it's doubly
confusing because running the script standalone does complain.

Let's teach the suppression in the Makefile to only turn off the
external linter (which we know is redundant, as it was already run) and
leave the internal one intact.

I've used a new environment variable to do this here, and intentionally
did not add a "--no-ext-chain-lint" option. This is an internal
optimization used by the Makefile, and not something that ordinary users
would need to tweak.

[1] For discussion of chainlint.pl and this case, see:
    https://lore.kernel.org/git/CAPig+cQtLFX4PgXyyK_AAkCvg4Aw2RAC5MmLbib-aHHgTBcDuw@mail.gmail.com/

Signed-off-by: Jeff King <peff@peff.net>
---
 t/Makefile    | 2 +-
 t/test-lib.sh | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 88fa5049573..10881affdd0 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -45,7 +45,7 @@ CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
 # scripts not to "chainlint" themselves
-CHAINLINTSUPPRESS = GIT_TEST_CHAIN_LINT=0 && export GIT_TEST_CHAIN_LINT &&
+CHAINLINTSUPPRESS = GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT &&
 
 all: $(DEFAULT_TEST_TARGET)
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 62136caee5a..09789566374 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1593,7 +1593,8 @@ then
 	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_SANITIZE_LEAK_LOG=true"
 fi
 
-if test "${GIT_TEST_CHAIN_LINT:-1}" != 0
+if test "${GIT_TEST_CHAIN_LINT:-1}" != 0 &&
+   test "${GIT_TEST_EXT_CHAIN_LINT:-1}" != 0
 then
 	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0" ||
 		BUG "lint error (see '?!...!? annotations above)"
-- 
2.40.0.616.gf524ec75088

