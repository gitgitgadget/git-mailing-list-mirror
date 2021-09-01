Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEA8C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4D260462
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhIAJ5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:57:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:36192 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhIAJ53 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 05:57:29 -0400
Received: (qmail 16397 invoked by uid 109); 1 Sep 2021 09:56:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Sep 2021 09:56:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5447 invoked by uid 111); 1 Sep 2021 09:56:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Sep 2021 05:56:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Sep 2021 05:56:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/8] add a test mode for SANITIZE=leak, run it in CI
Message-ID: <YS9OT/pn5rRK9cGB@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 03:35:34PM +0200, Ævar Arnfjörð Bjarmason wrote:

>  * In v2 compiling with SANITIZE=leak would change things so only
>    known-good passing tests were run by default, everything else would
>    pass as a dummy. Now the default running of tests is unchanged, but
>    if we run with GIT_TEST_PASSING_SANITIZE_LEAK=true only those tests
>    are run which set and export TEST_PASSES_SANITIZE_LEAK=true.
> 
>  * The facility for declaring known-good tests in test-lib.sh based on
>    wildcards is gone, instead individual tests need to declare if
>    they're OK under SANITIZE=leak.[...]

Hmm. This still seems more complicated than we need. If we just want a
flag in each script, then test-lib.sh can use that flag to tweak
LSAN_OPTIONS. See the patch below.

That has two drawbacks:

  - it doesn't have any way to switch the flag per-test. But IMHO it is
    a mistake to go in that direction. This is all temporary scaffolding
    while we have leaks, and the script-level of granularity is fine.

  - it runs the tests not marked as LSAN-OK, just without leak checking,
    which is redundant in CI where we're already running them. But we
    could still be collecting leak stats (and just not failing the
    tests). See the patch below.

    If we do care about not running them, then I think it makes more
    sense to extend the run/skip mechanisms and build on that.

    (I also think I prefer the central list of "mark these scripts as OK
    for leak-checking", rather than annotating individuals. Because
    again, this is temporary, and it's nice to keep it in a sandbox that
    only people working on leak-checking would look at or touch).

I realize this is kind-of bikeshedding, and I'm not vehemently opposed
to what you have here. It just seems like fewer moving parts would be
less likely to confuse folks who want to poke at it.

>    This is done via "export
>    TEST_PASSES_SANITIZE_LEAK=true", there's a handy import of
>    "./test-pragma-SANITIZE=leak-ok.sh" before sourcing "./test-lib.sh"
>    itself to set this.

I found the extra level of indirection added by this pragma confusing.
We just need to set a variable, which is also a one-liner, and one that
is more obvious about what it's doing. In your code you also export it,
but that's not necessary for something that test-lib.sh is going to look
at. Or if it's really necessary at some point, then test-lib.sh can do
the export itself.

> Ævar Arnfjörð Bjarmason (8):
>   Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
>   CI: refactor "if" to "case" statement
>   tests: add a test mode for SANITIZE=leak, run it in CI
>   tests: annotate t000*.sh with TEST_PASSES_SANITIZE_LEAK=true
>   tests: annotate t001*.sh with TEST_PASSES_SANITIZE_LEAK=true
>   tests: annotate t002*.sh with TEST_PASSES_SANITIZE_LEAK=true
>   tests: annotate select t0*.sh with TEST_PASSES_SANITIZE_LEAK=true
>   tests: annotate select t*.sh with TEST_PASSES_SANITIZE_LEAK=true

Sort of a meta-question, but what's the plan for folks who add a new
test to say t0000, and it reveals a leak in code they didn't touch?

They'll get a CI failure (as will Junio if he picks up the patch), so
somebody is going to have to deal with it. Do they fix it? Do they unset
the "this script is OK" flag? Do they mark the individual test as
non-lsan-ok?

I do like the idea of finding real regressions. But while the state of
leak-checking is still so immature, I'm worried about this adding extra
friction for developers. Especially if they get some spooky action at a
distance caused by a leak in far-away code.

Anyway, here's LSAN_OPTIONS thing I was thinking of.

---
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index df544bb321..b1da18955d 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -2,6 +2,7 @@
 
 test_description='git init'
 
+TEST_LSAN_OK=1
 . ./test-lib.sh
 
 check_config () {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index abcfbed6d6..62627afeaf 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -44,9 +44,30 @@ GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 : ${ASAN_OPTIONS=detect_leaks=0:abort_on_error=1}
 export ASAN_OPTIONS
 
-# If LSAN is in effect we _do_ want leak checking, but we still
-# want to abort so that we notice the problems.
-: ${LSAN_OPTIONS=abort_on_error=1}
+if test -n "$LSAN_OPTIONS"
+then
+	# Leave user-provided options alone.
+	:
+elif test -n "$TEST_LSAN_OK"
+then
+	# The test script has declared itself as LSAN-clean; turn on full leak
+	# checking.
+	LSAN_OPTIONS=abort_on_error=1
+else
+	# The test script has possible LSAN failures. Just disable
+	# leak-checking entirely. Another option would be to log the failures
+	# with:
+	#
+	#   LSAN_OPTIONS=exitcode=0:log_path=$TEST_DIRECTORY/lsan/out
+	#
+	# The results are rather confusing, though, as the logs are
+	# per-process; you have no idea which one came from which test script.
+	# Ideally we'd send them to descriptor 4 along with the rest of the
+	# script log, but there's no LSAN_OPTION for that (recent versions of
+	# libsanitizer do have a public function to do so, so we could hook it
+	# ourselves via common-main).
+	LSAN_OPTIONS=detect_leaks=0
+fi
 export LSAN_OPTIONS
 
 if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
