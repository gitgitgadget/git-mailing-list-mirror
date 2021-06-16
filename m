Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125D2C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABBE61351
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhFPIbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 04:31:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:57230 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhFPIbV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 04:31:21 -0400
Received: (qmail 12027 invoked by uid 109); 16 Jun 2021 08:29:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jun 2021 08:29:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24470 invoked by uid 111); 16 Jun 2021 08:29:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jun 2021 04:29:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Jun 2021 04:29:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] range expressions in GIT_SKIP_TESTS are broken in master
 (was [BUG] question mark in GIT_SKIP_TESTS is broken in master)
Message-ID: <YMm2Wlb+eJDL7+ua@coredump.intra.peff.net>
References: <1d003cac-83fa-0b63-f60e-55513ac45cf9@gmail.com>
 <6980e906-8076-1436-ecdb-6775eff55d39@gmail.com>
 <xmqqa6nqsd2i.fsf@gitster.g>
 <xmqq4kdysb1i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kdysb1i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 01:12:09PM +0900, Junio C Hamano wrote:

> The variable $GIT_SKIP_TESTS on this line:
> 
>     if match_pattern_list "$this_test" $GIT_SKIP_TESTS
> 
> globs to t5000.  We don't quote the variable because we want them
> separated at $IFS boundaries, but we didn't want the glob specials
> in its value to take any effect.  Sigh.

Good find.

It's surprisingly hard to do field-splitting without pathname globbing
in pure shell. I couldn't find a way without using "set -f". That's in
POSIX, but it feels funny tweaking a global that can effect how other
code runs. We can at least constraint it to a subshell close to the
point of use:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 54938c6427..093104d04f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -732,14 +732,15 @@ match_pattern_list () {
 	arg="$1"
 	shift
 	test -z "$*" && return 1
-	for pattern_
+	(set -f
+	for pattern_ in $*
 	do
 		case "$arg" in
 		$pattern_)
-			return 0
+			exit 0
 		esac
 	done
-	return 1
+	exit 1)
 }
 
 match_test_selector_list () {
@@ -848,7 +849,7 @@ maybe_teardown_verbose () {
 last_verbose=t
 maybe_setup_verbose () {
 	test -z "$verbose_only" && return
-	if match_pattern_list $test_count $verbose_only
+	if match_pattern_list $test_count "$verbose_only"
 	then
 		exec 4>&2 3>&1
 		# Emit a delimiting blank line when going from
@@ -878,7 +879,7 @@ maybe_setup_valgrind () {
 		return
 	fi
 	GIT_VALGRIND_ENABLED=
-	if match_pattern_list $test_count $valgrind_only
+	if match_pattern_list $test_count "$valgrind_only"
 	then
 		GIT_VALGRIND_ENABLED=t
 	fi
@@ -1006,7 +1007,7 @@ test_finish_ () {
 test_skip () {
 	to_skip=
 	skipped_reason=
-	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
+	if match_pattern_list $this_test.$test_count "$GIT_SKIP_TESTS"
 	then
 		to_skip=t
 		skipped_reason="GIT_SKIP_TESTS"
@@ -1346,7 +1347,7 @@ fi
 remove_trash=
 this_test=${0##*/}
 this_test=${this_test%%-*}
-if match_pattern_list "$this_test" $GIT_SKIP_TESTS
+if match_pattern_list "$this_test" "$GIT_SKIP_TESTS"
 then
 	say_color info >&3 "skipping test $this_test altogether"
 	skip_all="skip all tests in $this_test"

If that isn't portable for some reason, I think we could fall back on
splitting with an external tool. You can't feed the result as a function
argument (you run into the same problem!) but you can use "read" to
split on newlines, like:

  echo "$GIT_SKIP_TESTS" |
  tr ' ' '\n' |
  while read pattern
  do
    echo "got $pattern"
  done

That does put the shell code on the right-hand side of a pipe, which
means it's constrained in terms of setting variables, etc. But that
would be acceptable for our use here.

I dunno. Maybe somebody else can come up with something more clever (or
maybe I am just missing something obvious).

-Peff
