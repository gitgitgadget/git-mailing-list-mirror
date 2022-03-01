Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7135AC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiCAUI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiCAUIy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:08:54 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA9515A0C
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:08:11 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A0D01106F9;
        Tue,  1 Mar 2022 15:08:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gy9nCC+mYtVbw1Q3kj6BNoDZEF53f5sy6i5vuo
        2naeo=; b=aOIzq8kKgsOE+1TIitCniLRu+tYYldjbI7opmRW1UwQg1U4JUhPpm7
        mftt81EslZHmk5BQRwYUHFY7FP0r8wqrpsQkwTr/bKQdBnGDdzeTf1ooUR+n1UPU
        AXp4z1dg4Nn20BEC+2pr9M4vAsDbOFITphd87tNQy0Q2QkROdqIM0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92E171106F8;
        Tue,  1 Mar 2022 15:08:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A7991106F7;
        Tue,  1 Mar 2022 15:08:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git <git@vger.kernel.org>
Subject: [PATCH] parse-options: make parse_options_check() test-only
References: <xmqqtuck3yv2.fsf@gitster.g>
        <20220228073908.20553-1-chakrabortyabhradeep79@gmail.com>
        <xmqqzgma287n.fsf@gitster.g>
Date:   Tue, 01 Mar 2022 12:08:08 -0800
In-Reply-To: <xmqqzgma287n.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        28 Feb 2022 09:48:28 -0800")
Message-ID: <xmqqr17lphav.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 510F92F8-999B-11EC-99B3-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The array of options given to the parse-options API is sanity
checked for reuse of a single-letter option for multiple entries and
other programmer mistakes by calling parse_options_check() from
parse_options_start().  This allows our developers to catch silly
mistakes early, but all callers of parse-options API pays this cost.
Once the set of options in an array is validated and passes this
check, until a programmer modifies the array, there is no way for it
to fail the check, which is wasteful.

Introduce the GIT_TEST_PARSE_OPTIONS_CHECK environment variable and
make the sanity check only when it is set to true.  Set it in
t/test-lib.sh so that our tests will continue to catch buggy options
arrays.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    >  (2) Rethink if parse_options_check() can be made optional at
    >      runtime, which would (a) allow our test to enable it, and allow
    >      us to test all code paths that use parse_options() centrally,
    >      and (b) allow us to bypass the check while the end-user runs
    >      "git", to avoid overhead of checking the same option[] array,
    >      which does not change between invocations of "git", over and
    >      over again all over the world.
    >
    >      We may add the check back to parse_options_check() after doing
    >      the above.  There are already tons of "check sanity of what is
    >      inside option[]" in there, and it would be beneficial if we can
    >      separate out from parse_options_start() the sanity checking
    >      code, regardless of this topic.

    This looked too easy and there may be some pitfalls, but I am
    hoping that we will know soon enough by floating a weather
    balloon like this.

 parse-options.c | 12 +++++++++++-
 t/README        |  5 +++++
 t/test-lib.sh   |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 6e57744fd2..02cfe3f2cd 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -439,6 +439,14 @@ static void check_typos(const char *arg, const struct option *options)
 	}
 }
 
+/*
+ * Check the sanity of contents of opts[] array to find programmer
+ * mistakes (like duplicated short options).
+ *
+ * This function is supposed to be no-op when it returns without
+ * dying, making a call from parse_options_start_1() to it optional
+ * in end-user builds.
+ */
 static void parse_options_check(const struct option *opts)
 {
 	int err = 0;
@@ -523,7 +531,9 @@ static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
 	if ((flags & PARSE_OPT_ONE_SHOT) &&
 	    (flags & PARSE_OPT_KEEP_ARGV0))
 		BUG("Can't keep argv0 if you don't have it");
-	parse_options_check(options);
+
+	if (git_env_bool("GIT_TEST_PARSE_OPTIONS_CHECK", 0))
+		parse_options_check(options);
 }
 
 void parse_options_start(struct parse_opt_ctx_t *ctx,
diff --git a/t/README b/t/README
index f48e0542cd..b7285531f2 100644
--- a/t/README
+++ b/t/README
@@ -472,6 +472,11 @@ a test and then fails then the whole test run will abort. This can help to make
 sure the expected tests are executed and not silently skipped when their
 dependency breaks or is simply not present in a new environment.
 
+GIT_TEST_PARSE_OPTIONS_CHECK=<boolean>, when true, makes all options
+array passed to the parse-options API to be sanity checked.  This
+environment variable is set to true by test-lib.sh unless it is set.
+
+
 Naming Tests
 ------------
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e4716b0b86..805f495fd4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -474,6 +474,9 @@ export GIT_DEFAULT_HASH
 GIT_TEST_MERGE_ALGORITHM="${GIT_TEST_MERGE_ALGORITHM:-ort}"
 export GIT_TEST_MERGE_ALGORITHM
 
+: ${GIT_TEST_PARSE_OPTIONS_CHECK:=1}
+export GIT_TEST_PARSE_OPTIONS_CHECK
+
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
 GIT_TRACE_BARE=1
 export GIT_TRACE_BARE
-- 
2.35.1-354-g715d08a9e5

