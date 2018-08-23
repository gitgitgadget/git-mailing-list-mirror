Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD061F954
	for <e@80x24.org>; Thu, 23 Aug 2018 16:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeHWUCC (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 16:02:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:53478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725909AbeHWUCB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 16:02:01 -0400
Received: (qmail 14645 invoked by uid 109); 23 Aug 2018 16:31:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 16:31:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12845 invoked by uid 111); 23 Aug 2018 16:31:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 Aug 2018 12:31:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2018 12:31:30 -0400
Date:   Thu, 23 Aug 2018 12:31:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: wide t/perf output, was Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180823163130.GC29579@sigill.intra.peff.net>
References: <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823022756.GF92374@aiede.svl.corp.google.com>
 <20180823050224.GA318@sigill.intra.peff.net>
 <xmqqa7pdkyn9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7pdkyn9.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 06:20:26AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here are numbers for p0001.2 run against linux.git on a few
> > versions. This is using -O2 with gcc 8.2.0.
> >
> >   Test     v2.18.0             v2.19.0-rc0               HEAD
> >   ------------------------------------------------------------------------------
> >   0001.2:  34.24(33.81+0.43)   34.83(34.42+0.40) +1.7%   33.90(33.47+0.42) -1.0%
> 
> I see what you did to the formatting here, which is a topic of
> another thread ;-).

Do you happen to have a link? I missed that one, and digging turned up
nothing.

A while ago I wrote the patch below. I don't recall why I never sent it
in (and it doesn't apply cleanly these days, though I'm sure it could be
forward-ported).

-- >8 --
Date: Wed, 20 Jan 2016 23:54:14 -0500
Subject: [PATCH] t/perf: add "tall" output format

When aggregating results, we usually show a list of tests,
one per line, with the tested revisions in columns across.
Like:

    $ ./aggregate.perl 348d4f2^ 348d4f2 p7000-filter-branch.sh
    Test                  348d4f2^               348d4f2
    -------------------------------------------------------------------
    7000.2: noop filter   295.32(269.61+14.36)   7.92(0.85+0.72) -97.3%

This is useful if you have a lot of tests to show, but few
revisions; you're effectively comparing the two items on
each line. But sometimes you have the opposite: few tests,
but a large number of revisions. In this case, the lines
get very long, and it's hard to compare values.

This patch introduces a "tall" format that shows the same
data in a more vertical manner:

    $ ./aggregate.perl --tall \
        348d4f2^ 348d4f2 \
        jk/filter-branch-empty^ \
        jk/filter-branch-empty \
        p7000-filter-branch.sh
    Test: p7000-filter-branch.2
    348d4f2^                  295.32(269.61+14.36)
    348d4f2                        7.92(0.85+0.72) -97.3%
    jk/filter-branch-empty^        9.37(0.87+0.80) -96.8%
    jk/filter-branch-empty         7.71(0.92+0.62) -97.4%

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/aggregate.perl | 124 ++++++++++++++++++++++++++++++------------
 1 file changed, 88 insertions(+), 36 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index e401208488..d108a02ccd 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -17,29 +17,41 @@ sub get_times {
 	return ($rt, $4, $5);
 }
 
-sub format_times {
+sub format_times_list {
 	my ($r, $u, $s, $firstr) = @_;
 	if (!defined $r) {
 		return "<missing>";
 	}
 	my $out = sprintf "%.2f(%.2f+%.2f)", $r, $u, $s;
+	my $pct;
 	if (defined $firstr) {
 		if ($firstr > 0) {
-			$out .= sprintf " %+.1f%%", 100.0*($r-$firstr)/$firstr;
+			$pct = sprintf "%+.1f%%", 100.0*($r-$firstr)/$firstr;
 		} elsif ($r == 0) {
-			$out .= " =";
+			$pct = "=";
 		} else {
-			$out .= " +inf";
+			$pct = "+inf";
 		}
 	}
-	return $out;
+	return ($out, $pct);
+}
+
+sub format_times {
+	my ($times, $pct) = format_times_list(@_);
+	return defined $pct ? "$times $pct" : $times;
 }
 
 my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests);
+my ($tall_format);
 while (scalar @ARGV) {
 	my $arg = $ARGV[0];
 	my $dir;
 	last if -f $arg or $arg eq "--";
+	if ($arg eq "--tall") {
+		$tall_format = 1;
+		shift @ARGV;
+		next;
+	}
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
 		$dir = "build/".$rev;
@@ -122,6 +134,11 @@ sub have_slash {
 	return 0;
 }
 
+sub printable_dir {
+	my ($d) = @_;
+	return exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d};
+}
+
 my %newdirabbrevs = %dirabbrevs;
 while (!have_duplicate(values %newdirabbrevs)) {
 	%dirabbrevs = %newdirabbrevs;
@@ -132,44 +149,79 @@ sub have_slash {
 	}
 }
 
-my %times;
-my @colwidth = ((0)x@dirs);
-for my $i (0..$#dirs) {
-	my $d = $dirs[$i];
-	my $w = length (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
-	$colwidth[$i] = $w if $w > $colwidth[$i];
-}
-for my $t (@subtests) {
-	my $firstr;
+binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
+
+if (!$tall_format) {
+	my %times;
+	my @colwidth = ((0)x@dirs);
 	for my $i (0..$#dirs) {
 		my $d = $dirs[$i];
-		$times{$prefixes{$d}.$t} = [get_times("$resultsdir/$prefixes{$d}$t.times")];
-		my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
-		my $w = length format_times($r,$u,$s,$firstr);
+		my $w = length(printable_dir($d));
 		$colwidth[$i] = $w if $w > $colwidth[$i];
-		$firstr = $r unless defined $firstr;
 	}
-}
-my $totalwidth = 3*@dirs+$descrlen;
-$totalwidth += $_ for (@colwidth);
-
-binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
+	for my $t (@subtests) {
+		my $firstr;
+		for my $i (0..$#dirs) {
+			my $d = $dirs[$i];
+			$times{$prefixes{$d}.$t} = [get_times("$resultsdir/$prefixes{$d}$t.times")];
+			my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
+			my $w = length format_times($r,$u,$s,$firstr);
+			$colwidth[$i] = $w if $w > $colwidth[$i];
+			$firstr = $r unless defined $firstr;
+		}
+	}
+	my $totalwidth = 3*@dirs+$descrlen;
+	$totalwidth += $_ for (@colwidth);
 
-printf "%-${descrlen}s", "Test";
-for my $i (0..$#dirs) {
-	my $d = $dirs[$i];
-	printf "   %-$colwidth[$i]s", (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
-}
-print "\n";
-print "-"x$totalwidth, "\n";
-for my $t (@subtests) {
-	printf "%-${descrlen}s", $descrs{$t};
-	my $firstr;
+	printf "%-${descrlen}s", "Test";
 	for my $i (0..$#dirs) {
 		my $d = $dirs[$i];
-		my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
-		printf "   %-$colwidth[$i]s", format_times($r,$u,$s,$firstr);
-		$firstr = $r unless defined $firstr;
+		printf "   %-$colwidth[$i]s", printable_dir($d);
 	}
 	print "\n";
+	print "-"x$totalwidth, "\n";
+	for my $t (@subtests) {
+		printf "%-${descrlen}s", $descrs{$t};
+		my $firstr;
+		for my $i (0..$#dirs) {
+			my $d = $dirs[$i];
+			my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
+			printf "   %-$colwidth[$i]s", format_times($r,$u,$s,$firstr);
+			$firstr = $r unless defined $firstr;
+		}
+		print "\n";
+	}
+} else {
+	my $shown = 0;
+	for my $t (@subtests) {
+		print "\n" if $shown++;
+		print "Test: $t\n";
+
+		my %times;
+		my $firstr;
+		for my $d (@dirs) {
+			my ($r, $u, $s) = get_times("test-results/$prefixes{$d}$t.times");
+			$times{$d} = [format_times_list($r, $u, $s, $firstr)];
+			$firstr = $r unless defined $firstr;
+		}
+
+		my $maxdirlen = 0;
+		my $maxtimelen = 0;
+		for my $d (@dirs) {
+			if (length($d) > $maxdirlen) {
+				$maxdirlen = length(printable_dir($d));
+			}
+			if (length($times{$d}->[0]) > $maxtimelen) {
+				$maxtimelen = length($times{$d}->[0]);
+			}
+		}
+		$maxdirlen++;
+
+		for my $d (@dirs) {
+			printf "%-${maxdirlen}s", printable_dir($d);
+			printf "   %${maxtimelen}s", $times{$d}->[0];
+			print " $times{$d}->[1]" if defined $times{$d}->[1];
+			print "\n";
+		}
+	}
 }
-- 
2.19.0.rc0.412.g7005db4e88

