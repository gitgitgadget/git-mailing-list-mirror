Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272A61F404
	for <e@80x24.org>; Fri,  9 Feb 2018 18:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbeBIS5N (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 13:57:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:47100 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750810AbeBIS5M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 13:57:12 -0500
Received: (qmail 3874 invoked by uid 109); 9 Feb 2018 18:57:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Feb 2018 18:57:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23795 invoked by uid 111); 9 Feb 2018 18:57:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Feb 2018 13:57:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Feb 2018 13:57:10 -0500
Date:   Fri, 9 Feb 2018 13:57:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] t: teach 'test_must_fail' to save the command's
 stderr to a file
Message-ID: <20180209185710.GA23403@sigill.intra.peff.net>
References: <20180209024235.3431-1-szeder.dev@gmail.com>
 <20180209024235.3431-3-szeder.dev@gmail.com>
 <20180209142131.GA18701@sigill.intra.peff.net>
 <xmqqd11exb6k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd11exb6k.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 09, 2018 at 10:36:19AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   2. The "-x" problems aren't specific to test_must_fail at all. They're
> >      a general issue with shell functions.
> >
> > I'm not entirely happy with saying "if you want to use -x, please use
> > bash". But given that it actually solves the problems everywhere with no
> > further effort, is it really that bad a solution?
> >
> > For the error messages from test_must_fail, could we go in the same
> > direction, and send them to descriptor 4 rather than 2? We've already
> > staked out descriptor 4 as something magical that must be left alone
> > (see 9be795fb). If we can rely on that, then it becomes a convenient way
> > for functions to make sure their output is going to the script's stderr.
> 
> That sounds clever and rather attractive.  It isn't that much of an
> layering violation for test-lib-functions.sh::test_must_fail to have
> such an intimate knowledge on how test_-lib.sh::test_eval_ sets up
> the file descriptors, either.

Here's what it looks like as a patch.

-- >8 --
Subject: [PATCH] t: send verbose test-helper output to fd 4

Test helper functions like test_must_fail may write messages
to stderr when they see a problem. When the tests are run
with "--verbose", this ends up on the test script's stderr,
and the user can read it.

But there's a problem. Some tests record stderr as part of
the test, like:

  test_must_fail git foo 2>output &&
  test_i18ngrep expected.message output

In this case any message from test_must_fail goes into
"output", making the --verbose output less useful. It also
means we might accidentally match it in the second line,
though in practice we tend to produce these messages only on
error. So we'd abort the test when the first command fails.

Let's send this user-facing output directly to descriptor 4,
which always points to the original stderr (or /dev/null in
non-verbose mode). It's already forbidden to redirect
descriptor 4, since we use it for BASH_XTRACEFD, as
explained in 9be795fbce (t5615: avoid re-using descriptor 4,
2017-12-08).

Signed-off-by: Jeff King <peff@peff.net>
---
I've considered a patch to teach "make test-lint" to complain if it sees
" 4>" in any shell script, to try to enforce that rule automatically.
But maybe that's overkill (and also it felt funny to put it in
check-non-portable-shell.pl, but we can always change the name ;) ).

 t/test-lib-functions.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1701fe2a06..a156b81aa5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -625,22 +625,22 @@ test_must_fail () {
 	exit_code=$?
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
 	then
-		echo >&2 "test_must_fail: command succeeded: $*"
+		echo >&4 "test_must_fail: command succeeded: $*"
 		return 1
 	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
 	then
 		return 0
 	elif test $exit_code -gt 129 && test $exit_code -le 192
 	then
-		echo >&2 "test_must_fail: died by signal $(($exit_code - 128)): $*"
+		echo >&4 "test_must_fail: died by signal $(($exit_code - 128)): $*"
 		return 1
 	elif test $exit_code -eq 127
 	then
-		echo >&2 "test_must_fail: command not found: $*"
+		echo >&4 "test_must_fail: command not found: $*"
 		return 1
 	elif test $exit_code -eq 126
 	then
-		echo >&2 "test_must_fail: valgrind error: $*"
+		echo >&4 "test_must_fail: valgrind error: $*"
 		return 1
 	fi
 	return 0
@@ -678,7 +678,7 @@ test_expect_code () {
 		return 0
 	fi
 
-	echo >&2 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
+	echo >&4 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
 	return 1
 }
 
@@ -710,7 +710,7 @@ test_cmp_bin() {
 # not output anything when they fail.
 verbose () {
 	"$@" && return 0
-	echo >&2 "command failed: $(git rev-parse --sq-quote "$@")"
+	echo >&4 "command failed: $(git rev-parse --sq-quote "$@")"
 	return 1
 }
 
-- 
2.16.1.464.gc4bae515b7

