Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0047C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8638B20836
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfKYOJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:09:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:59920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727716AbfKYOJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 09:09:27 -0500
Received: (qmail 26330 invoked by uid 109); 25 Nov 2019 14:09:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Nov 2019 14:09:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18847 invoked by uid 111); 25 Nov 2019 14:13:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2019 09:13:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Nov 2019 09:09:25 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perf-lib: remove old result files before running tests
Message-ID: <20191125140925.GC494@sigill.intra.peff.net>
References: <20191119185047.8550-1-t.gummerer@gmail.com>
 <20191121102042.GA2611@sigill.intra.peff.net>
 <20191122081108.GA38815@cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191122081108.GA38815@cat>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22, 2019 at 08:11:08AM +0000, Thomas Gummerer wrote:

> On 11/21, Jeff King wrote:
> > But I wonder if it would be simpler to just always use the same file for
> > the test result, overwriting it each time, and let the reader figure out
> > the type. The aggregate script's get_times() already uses a regex to
> > distinguish the two. That's enough for the two types we have, and we
> > could later add a header line if it becomes necessary.
> > 
> > Something like the patch below. That removes any confusion about cruft
> > files being left behind, or which file should be preferred, etc.
> 
> Yeah, I like what you have below much more than what I had, thanks!
> 
> > The diff would be even smaller if we just kept calling it "times", but
> > that's probably unnecessarily confusing.
> 
> Yup, I prefer a more readable end result to a small diff :)

OK, here it is wrapped up in a commit message. I wasn't sure how to
attribute it, since you really did most of the interesting work and I
just swooped in with an alternative. I'm happy to make you the author,
but I didn't want you to get blamed for my bugs. ;)

Junio, this would replace tg/perf-remove-stale-result.

-- >8 --
Subject: [PATCH] perf-lib: use a single filename for all measurement types

The perf tests write files recording the results of tests.  These
results are later aggregated by 'aggregate.perl'.  If the tests are run
multiple times, those results are overwritten by the new results.  This
works just fine as long as there are only perf tests measuring the
times, whose results are stored in "$base".times files.

However 22bec79d1a ("t/perf: add infrastructure for measuring sizes",
2018-08-17) introduced a new type of test for measuring the size of
something.  The results of this are written to "$base".size files.

"$base" is essentially made up of the basename of the script plus the
test number.  So if test numbers shift because a new test was
introduced earlier in the script we might end up with both a ".times"
and a ".size" file for the same test.  In the aggregation script the
".times" file is preferred over the ".size" file, so some size tests
might end with performance numbers from a previous run of the test.

This is mainly relevant when writing perf tests that check both
performance and sizes, and can get quite confusing during
developement.

We could fix this by doing a more thorough job of cleaning out old
".times" and ".size" files before running each test. However, an even
easier solution is to just use the same filename for both types of
measurement, meaning we'll always overwrite the previous result. We
don't even need to change the file format to distinguish the two;
aggregate.perl already decides which is which based on a regex of the
content (this may become ambiguous if we add new types in the future,
but we could easily add a header field to the file at that point).

Based on an initial patch from Thomas Gummerer, who discovered the
problem and did all of the analysis (which I stole for the commit
message above):

  https://public-inbox.org/git/20191119185047.8550-1-t.gummerer@gmail.com/

Helped-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/aggregate.perl | 12 +++---------
 t/perf/perf-lib.sh    |  4 ++--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 66554d2161..112fc23dbe 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -219,13 +219,7 @@ sub print_default_results {
 		for my $i (0..$#dirs) {
 			my $d = $dirs[$i];
 			my $base = "$resultsdir/$prefixes{$d}$t";
-			$times{$prefixes{$d}.$t} = [];
-			foreach my $type (qw(times size)) {
-				if (-e "$base.$type") {
-					$times{$prefixes{$d}.$t} = [get_times("$base.$type")];
-					last;
-				}
-			}
+			$times{$prefixes{$d}.$t} = [get_times("$base.result")];
 			my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
 			my $w = length format_times($r,$u,$s,$firstr);
 			$colwidth[$i] = $w if $w > $colwidth[$i];
@@ -267,7 +261,7 @@ sub print_sorted_results {
 		my ($prevr, $prevu, $prevs, $prevrev);
 		for my $i (0..$#dirs) {
 			my $d = $dirs[$i];
-			my ($r, $u, $s) = get_times("$resultsdir/$prefixes{$d}$t.times");
+			my ($r, $u, $s) = get_times("$resultsdir/$prefixes{$d}$t.result");
 			if ($i > 0 and defined $r and defined $prevr and $prevr > 0) {
 				my $percent = 100.0 * ($r - $prevr) / $prevr;
 				push @evolutions, { "percent"  => $percent,
@@ -327,7 +321,7 @@ sub print_codespeed_results {
 			my $commitid = $prefixes{$d};
 			$commitid =~ s/^build_//;
 			$commitid =~ s/\.$//;
-			my ($result_value, $u, $s) = get_times("$resultsdir/$prefixes{$d}$t.times");
+			my ($result_value, $u, $s) = get_times("$resultsdir/$prefixes{$d}$t.result");
 
 			my %vals = (
 				"commitid" => $commitid,
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index b58a43ea43..13e389367a 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -214,7 +214,7 @@ test_perf_ () {
 	else
 		test_ok_ "$1"
 	fi
-	"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".times
+	"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".result
 }
 
 test_perf () {
@@ -223,7 +223,7 @@ test_perf () {
 
 test_size_ () {
 	say >&3 "running: $2"
-	if test_eval_ "$2" 3>"$base".size; then
+	if test_eval_ "$2" 3>"$base".result; then
 		test_ok_ "$1"
 	else
 		test_failure_ "$@"
-- 
2.24.0.716.g722aff65ed

