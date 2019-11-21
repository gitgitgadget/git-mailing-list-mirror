Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C92C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 10:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B907B206CB
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 10:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfKUKUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:20:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:56870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726197AbfKUKUo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 05:20:44 -0500
Received: (qmail 11807 invoked by uid 109); 21 Nov 2019 10:20:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Nov 2019 10:20:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9779 invoked by uid 111); 21 Nov 2019 10:24:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Nov 2019 05:24:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Nov 2019 05:20:42 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] perf-lib: remove old result files before running tests
Message-ID: <20191121102042.GA2611@sigill.intra.peff.net>
References: <20191119185047.8550-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191119185047.8550-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 19, 2019 at 06:50:47PM +0000, Thomas Gummerer wrote:

> The perf tests write files recording the results of tests.  These
> results are later aggregated by 'aggregate.perl'.  If the tests are
> run multiple times, those results are overwritten by the new results.
> This works just fine as long as there are only perf tests measuring
> the times, whose results are stored in "$base".times files.
> 
> However 22bec79d1a ("t/perf: add infrastructure for measuring sizes",
> 2018-08-17) introduced a new type of test for measuring the size of
> something.  The results of this are written to "$base".size files.
> 
> "$base" is essentially made up of the basename of the script plus the
> test number.  So if test numbers shift because a new test was
> introduced earlier in the script we might end up with both a ".times"
> and a ".size" file for the same test.  In the aggregation script the
> ".times" file is preferred over the ".size" file, so some size tests
> might end with performance numbers from a previous run of the test.
> 
> This is mainly relevant when writing perf tests that check both
> performance and sizes, and can get quite confusing during
> developement.

The problem description makes sense to me.

> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index b58a43ea43..7e80251889 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -178,10 +178,11 @@ test_wrapper_ () {
>  	export test_prereq
>  	if ! test_skip "$@"
>  	then
> -		base=$(basename "$0" .sh)
> -		echo "$test_count" >>"$perf_results_dir"/$base.subtests
> -		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
>  		base="$perf_results_dir"/"$PERF_RESULTS_PREFIX$(basename "$0" .sh)"."$test_count"
> +		rm -f "$base".*
> +		no_prefix_base="$perf_results_dir"/$(basename "$0" .sh)
> +		echo "$test_count" >>$no_prefix_base.subtests
> +		echo "$1" >$no_prefix_base.$test_count.descr
>  		"$test_wrapper_func_" "$@"

I had a little trouble following the patch because of a few things:

  - the reordering of earlier lines. We don't care about subtests at
    all, and that line could stay the same. But we do have to reorder
    the "descr" one because of the broad wildcard in the "rm". That
    could be narrowed, but I guess you wanted to future-proof it against
    new types.

  - the $no_prefix_base variable differs from $base not just in lacking
    the prefix, but also in lacking $test_count at the end.

So I think it's doing the right thing overall, though there is one bug:
$no_prefix_base is not quoted, but could contain spaces due to
$perf_results_dir. I think that would cause bash to complain if there's
a space in your path.

But I wonder if it would be simpler to just always use the same file for
the test result, overwriting it each time, and let the reader figure out
the type. The aggregate script's get_times() already uses a regex to
distinguish the two. That's enough for the two types we have, and we
could later add a header line if it becomes necessary.

Something like the patch below. That removes any confusion about cruft
files being left behind, or which file should be preferred, etc.

The diff would be even smaller if we just kept calling it "times", but
that's probably unnecessarily confusing.

-Peff

---
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
