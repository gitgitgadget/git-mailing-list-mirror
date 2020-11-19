Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEC9C56201
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 571B42224A
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgKSP60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:58:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:35692 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgKSP6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 10:58:25 -0500
Received: (qmail 31051 invoked by uid 109); 19 Nov 2020 15:58:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Nov 2020 15:58:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29602 invoked by uid 111); 19 Nov 2020 15:58:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Nov 2020 10:58:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Nov 2020 10:58:24 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] tests: make sure nested lazy prereqs work reliably
Message-ID: <20201119155824.GB25426@coredump.intra.peff.net>
References: <20201118190414.32616-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201118190414.32616-1-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 18, 2020 at 08:04:13PM +0100, SZEDER Gábor wrote:

> So to prevent nested prereqs from interfering with each other let's
> evaluate each prereq in its own dedicated directory by appending the
> prereq's name to the directory name, e.g. 'prereq-test-dir-SYMLINKS'.
> In the test we check not only that the prereq test dir is still there,
> but also that the inner prereq can't mess with the outer prereq's
> files.

That sounds reasonable. I do wonder, though, whether simply creating the
prereq directory in the _current_ directory would be sufficient. Then
you'd get prereq-test-dir/prereq-test-dir for a nested invocation. But
the prereqs aren't supposed to care about which specific directory
they're in.

I.e., your test passes equally well with just:

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 59bbf75e83..f5dc6801d9 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -474,15 +474,15 @@ test_lazy_prereq () {
 
 test_run_lazy_prereq_ () {
 	script='
-mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
+mkdir -p "prereq-test-dir" &&
 (
-	cd "$TRASH_DIRECTORY/prereq-test-dir" &&'"$2"'
+	cd "prereq-test-dir" &&'"$2"'
 )'
 	say >&3 "checking prerequisite: $1"
 	say >&3 "$script"
 	test_eval_ "$script"
 	eval_ret=$?
-	rm -rf "$TRASH_DIRECTORY/prereq-test-dir"
+	rm -rf "prereq-test-dir"
 	if test "$eval_ret" = 0; then
 		say >&3 "prerequisite $1 ok"
 	else

though I guess it is not really much simpler (it avoids the funky
quoting around $1 in the embedded script, but we already have that for
$2). And perhaps debugging is easier with a more predictable and
descriptive directory name.

> +test_lazy_prereq NESTED_INNER '
> +	>inner &&
> +	rm -f outer
> +'
> +test_lazy_prereq NESTED_PREREQ '
> +	>outer &&
> +	test_have_prereq NESTED_INNER &&
> +	echo "can create new file in cwd" >file &&
> +	test -f outer &&
> +	test ! -f inner
> +'
> +test_expect_success NESTED_PREREQ 'evaluating nested lazy prereqs dont interfere with each other' '
> +	nestedworks=yes
> +'
> +
> +if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" && test "$nestedworks" != yes
> +then
> +	say 'bug in test framework: nested lazy prerequisites do not work'
> +	exit 1
> +fi

I was surprised to see this bare exit, because I know we have some
functions (run_sub_test_*) to help with testing the framework itself. It
looks like the other prereq tests don't use it either, though. I wonder
if there is a technical reason, or if they were simply added at a
different time. (Either way, I am OK for your new test to match the
surrounding ones like you have here).

-Peff
