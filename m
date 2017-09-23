Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F29720281
	for <e@80x24.org>; Sat, 23 Sep 2017 19:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbdIWT4H (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 15:56:07 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:59946
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751521AbdIWTz6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Sep 2017 15:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1506196556;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=dNrithBP9+GFNjmHX/Kgv7fwPay3rS2Xcglns0ZfOfQ=;
        b=J94PATPTR4kHYv70S8WAlJHyd0yyr0RHodUCXfweKMS/OPSf6dPPssAj4iacd1SJ
        DXp4qoe7p6KBuyIZnuqQNcAGuLlraw5naafhGgUyIASsdPl40xFG5FXgKJtiiimgIbx
        z3M1AIO2uSRxk7gLxXSb2qX4bhoeSq6EBfI9m9JM=
From:   Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Message-ID: <0102015eb04f8a13-870eb283-049e-4d29-a3ef-b03205a21f26-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
References: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 9/9] perf: store subsection results in
 "test-results/$GIT_PERF_SUBSECTION/"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Sep 2017 19:55:56 +0000
X-SES-Outgoing: 2017.09.23-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When tests are run for a subsection defined in a config file, it is
better if the results for the current subsection are not overwritting
the results of a previous subsection.

So let's store the results for a subsection in a subdirectory of
"test-results/" with the subsection name.

The aggregate.perl, when it is run for a subsection, should then
aggregate the results found in "test-results/$GIT_PERF_SUBSECTION/".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 11 ++++++++---
 t/perf/perf-lib.sh    |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 1dbc85b21407d..e40120848837c 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -69,12 +69,17 @@ sub format_times {
 	@tests = glob "p????-*.sh";
 }
 
+my $resultsdir = "test-results";
+if ($ENV{GIT_PERF_SUBSECTION} ne "") {
+	$resultsdir .= "/" . $ENV{GIT_PERF_SUBSECTION};
+}
+
 my @subtests;
 my %shorttests;
 for my $t (@tests) {
 	$t =~ s{(?:.*/)?(p(\d+)-[^/]+)\.sh$}{$1} or die "bad test name: $t";
 	my $n = $2;
-	my $fname = "test-results/$t.subtests";
+	my $fname = "$resultsdir/$t.subtests";
 	open my $fp, "<", $fname or die "cannot open $fname: $!";
 	for (<$fp>) {
 		chomp;
@@ -98,7 +103,7 @@ sub read_descr {
 my %descrs;
 my $descrlen = 4; # "Test"
 for my $t (@subtests) {
-	$descrs{$t} = $shorttests{$t}.": ".read_descr("test-results/$t.descr");
+	$descrs{$t} = $shorttests{$t}.": ".read_descr("$resultsdir/$t.descr");
 	$descrlen = length $descrs{$t} if length $descrs{$t}>$descrlen;
 }
 
@@ -138,7 +143,7 @@ sub have_slash {
 	my $firstr;
 	for my $i (0..$#dirs) {
 		my $d = $dirs[$i];
-		$times{$prefixes{$d}.$t} = [get_times("test-results/$prefixes{$d}$t.times")];
+		$times{$prefixes{$d}.$t} = [get_times("$resultsdir/$prefixes{$d}$t.times")];
 		my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
 		my $w = length format_times($r,$u,$s,$firstr);
 		$colwidth[$i] = $w if $w > $colwidth[$i];
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 2f88fc12a9b5c..e4c343a6b795b 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -56,6 +56,7 @@ MODERN_GIT=$GIT_BUILD_DIR/bin-wrappers/git
 export MODERN_GIT
 
 perf_results_dir=$TEST_OUTPUT_DIRECTORY/test-results
+test -n "$GIT_PERF_SUBSECTION" && perf_results_dir="$perf_results_dir/$GIT_PERF_SUBSECTION"
 mkdir -p "$perf_results_dir"
 rm -f "$perf_results_dir"/$(basename "$0" .sh).subtests
 

--
https://github.com/git/git/pull/408
