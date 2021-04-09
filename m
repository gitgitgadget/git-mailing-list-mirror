Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F20C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF64610A7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhDIW2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:28:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:47240 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234954AbhDIW2d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:28:33 -0400
Received: (qmail 3331 invoked by uid 109); 9 Apr 2021 22:28:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 22:28:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17415 invoked by uid 111); 9 Apr 2021 22:28:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 18:28:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 18:28:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <YHDVAxxKDzfTlq3h@coredump.intra.peff.net>
References: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most test snippets are wrapped in single quotes, like:

  test_expect_success 'some description' '
          do_something
  '

This sometimes makes the snippets awkward to write, because you can't
easily use single quotes. We sometimes work around this with $SQ, or by
loosening regexes to use "." instead of a literal quote, or by using
double quotes when we'd prefer to use single-quotes (and just adding
extra backslash-escapes to avoid interpolation).

This commit adds another option: feeding the snippet on the function's
stdin. This doesn't conflict with anything the snippet would want to do,
because we always redirect its stdin from /dev/null anyway (which we'll
continue to do).

A few notes on the implementation:

  - it would be nice to push this down into test_run_, but we can't, as
    test_expect_success and test_expect_failure want to see the actual
    script content to report it for verbose-mode. A helper function
    limits the amount of duplication in those callers here.

  - The helper function is a little awkward to call, as you feed it the
    name of the variable you want to set. The more natural thing in
    shell would be command substitution like:

      body=$(body_or_stdin "$2")

    but that loses trailing whitespace. There are tricks around this,
    like:

      body=$(body_or_stdin "$2"; printf '.)
      body=${body%.}

    but we'd prefer to keep such tricks in the helper, not in each
    caller.

  - I implemented the helper using a sequence of "read" calls. Together
    with "-r" and unsetting the IFS, this preserves incoming whitespace.
    An alternative is to use "cat" (which then requires the gross "."
    trick above). But this saves us a process, which is probably a good
    thing. The "read" builtin does use more read() syscalls than
    necessary (one per byte), but that is almost certainly a win over a
    separate process.

    Both are probably slower than passing a single-quoted string, but
    the difference is lost in the noise for a script that I converted as
    an experiment.

  - I handle test_expect_success and test_expect_failure here. If we
    like this style, we could easily extend it to other spots (e.g.,
    lazy_prereq bodies) on top of this patch.

  - even though we are using "local", we have to be careful about our
    variable names. Within test_expect_success, any variable we declare
    with local will be seen by the test snippets themselves (so it won't
    persist between tests like normal variables would).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/README                |  8 ++++++++
 t/test-lib-functions.sh | 30 ++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index fd9375b146..a234c87792 100644
--- a/t/README
+++ b/t/README
@@ -755,6 +755,14 @@ library for your script to use.
 	    'git-write-tree should be able to write an empty tree.' \
 	    'tree=$(git-write-tree)'
 
+   If <script> is `-` (a single dash), then the script to run is read
+   from stdin. This lets you more easily use single quotes within the
+   script by using a here-doc. For example:
+
+        test_expect_success 'output contains expected string' <<-\EOT
+	        grep "this string has 'quotes' in it" output
+	EOT
+
    If you supply three parameters the first will be taken to be a
    prerequisite; see the test_set_prereq and test_have_prereq
    documentation below:
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d733..3c8081b256 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -602,6 +602,24 @@ test_verify_prereq () {
 	BUG "'$test_prereq' does not look like a prereq"
 }
 
+# assign the variable named by "$1" with the contents of "$2";
+# if "$2" is "-", then read stdin into "$1" instead
+test_body_or_stdin () {
+	if test "$2" != "-"
+	then
+		eval "$1=\$2"
+		return
+	fi
+
+	# start with a newline, to match hanging newline from open-quote style
+	eval "$1=\$LF"
+	local test_line
+	while IFS= read -r test_line
+	do
+		eval "$1=\${$1}\${test_line}\${LF}"
+	done
+}
+
 test_expect_failure () {
 	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
@@ -611,8 +629,10 @@ test_expect_failure () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
-		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $2"
-		if test_run_ "$2" expecting_failure
+		local test_body
+		test_body_or_stdin test_body "$2"
+		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $test_body"
+		if test_run_ "$test_body" expecting_failure
 		then
 			test_known_broken_ok_ "$1"
 		else
@@ -631,8 +651,10 @@ test_expect_success () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
-		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
-		if test_run_ "$2"
+		local test_body
+		test_body_or_stdin test_body "$2"
+		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $test_body"
+		if test_run_ "$test_body"
 		then
 			test_ok_ "$1"
 		else
-- 
2.31.1.629.gb61be4ec8d

