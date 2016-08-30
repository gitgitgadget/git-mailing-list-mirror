Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06F892018E
	for <e@80x24.org>; Tue, 30 Aug 2016 08:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754525AbcH3IoG (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 04:44:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:35276 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751629AbcH3IoC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 04:44:02 -0400
Received: (qmail 24341 invoked by uid 109); 30 Aug 2016 08:44:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Aug 2016 08:44:00 +0000
Received: (qmail 27870 invoked by uid 111); 30 Aug 2016 08:44:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Aug 2016 04:44:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2016 04:43:57 -0400
Date:   Tue, 30 Aug 2016 04:43:57 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed
 tests
Message-ID: <20160830084357.rdmt2ehngrz6rqaq@sigill.intra.peff.net>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
 <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 03:46:05PM +0200, Johannes Schindelin wrote:

> Note that we need to be careful to inspect only the *newest* entries in
> test-results/: this directory contains files of the form
> tNNNN-<name>-<pid>.counts and is only removed wholesale when running the
> *entire* test suite, not when running individual tests. We ensure that
> with a little sed magic on `ls -t`'s output that simply skips lines
> when the file name was seen earlier.

Hmm, interesting. Your approach seems reasonable, but I have to wonder
if writing the pid in the first place is sane.

I started to write up my reasoning in this email, but realized it was
rapidly becoming the content of a commit message. So here is that
commit.

-- >8 --
Subject: [PATCH] test-lib: drop PID from test-results/*.count

Each test run generates a "count" file in t/test-results
that stores the number of successful, failed, etc tests.
If you run "t1234-foo.sh", that file is named as
"t/test-results/t1234-foo-$$.count"

The addition of the PID there is serving no purpose, and
makes analysis of the count files harder.

The presence of the PID dates back to 2d84e9f (Modify
test-lib.sh to output stats to t/test-results/*,
2008-06-08), but no reasoning is given there. Looking at the
current code, we can see that other files we write to
test-results (like *.exit and *.out) do _not_ have the PID
included. So the presence of the PID does not meaningfully
allow one to store the results from multiple runs anyway.

Moreover, anybody wishing to read the *.count files to
aggregate results has to deal with the presence of multiple
files for a given test (and figure out which one is the most
recent based on their timestamps!). The only consumer of
these files is the aggregate.sh script, which arguably gets
this wrong. If a test is run multiple times, its counts will
appear multiple times in the total (I say arguably only
because the desired semantics aren't documented anywhere,
but I have trouble seeing how this behavior could be
useful).

So let's just drop the PID, which fixes aggregate.sh, and
will make new features based around the count files easier
to write.

Note that since the count-file may already exist (when
re-running a test), we also switch the "cat" from appending
to truncating. The use of append here was pointless in the
first place, as we expected to always write to a unique file.

Signed-off-by: Jeff King <peff@peff.net>
---
The presence of the append, combined with the way aggregate.sh is
written makes me wonder if the intent was to store multiple run results
for each test in a single file (and aggregate would just report the last
one). Which _still_ makes the use of the PID wrong. But again, I don't
see much use for it.

 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d731d66..eada492 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -687,9 +687,9 @@ test_done () {
 		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
 		mkdir -p "$test_results_dir"
 		base=${0##*/}
-		test_results_path="$test_results_dir/${base%.sh}-$$.counts"
+		test_results_path="$test_results_dir/${base%.sh}.counts"
 
-		cat >>"$test_results_path" <<-EOF
+		cat >"$test_results_path" <<-EOF
 		total $test_count
 		success $test_success
 		fixed $test_fixed
-- 
2.10.0.rc2.123.ga991f9e

