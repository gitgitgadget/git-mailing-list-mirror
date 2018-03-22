Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFD6D1F42D
	for <e@80x24.org>; Thu, 22 Mar 2018 10:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeCVK7g (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 06:59:36 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:13649 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbeCVK7f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 06:59:35 -0400
Received: from [192.168.2.201] ([92.28.134.107])
        by smtp.talktalk.net with SMTP
        id yxwRetfapC0WbyxwSevrUC; Thu, 22 Mar 2018 10:59:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521716373;
        bh=cwthwHQ2yJTrRQbTluhGA0ucFq0nXtN6OL3KF6xoVS4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DMWGB1nKrXatzHZ/lEe1mDkDI6fZy3cH87EUzjAxso4jangRbRTdP2sRzBM75YRRC
         PrIcCZXmCmwf2Qdebon6u+GEHs0KBv8gjPI2lcNvDyYHrVkFsHcN/MstGqXhMVNtup
         RR6TYRERqYiZ9dxfLVBFOf2t+0hCMyBCxVog8BUw=
X-Originating-IP: [92.28.134.107]
X-Spam: 0
X-OAuthority: v=2.3 cv=Q+T8Hb+a c=1 sm=1 tr=0 a=AcBs9/+9F4N0T7Brpc/17w==:117
 a=AcBs9/+9F4N0T7Brpc/17w==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=PKzvZo6CAAAA:8 a=jkCEnXeehNBkB9E6udUA:9 a=BkZ2_0qgCiOAbp5I:21
 a=wiLr2H6UTcBoISZr:21 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
 a=q92HNjYiIAC_jH7JDaYf:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/7] diff-highlight: detect --graph by indent
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     Brian Henderson <henderson.bj@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180321054718.GA13936@sigill.intra.peff.net>
 <20180321055900.GB15674@sigill.intra.peff.net>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <0e2317fc-cfec-ba7f-8ded-59cc6b7f9a63@talktalk.net>
Date:   Thu, 22 Mar 2018 10:59:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321055900.GB15674@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKkwV+hnJDlFerX64NEP1N8OORw0lDA1dnDawtC9S9GHd8HaHyFfx/eWah74tQuIQrjEe1fONDSPrMAt8HOnm7paBJj0UXrsevi1MxFpEpk01inH2glU
 u3vH/XP587dDZ1jl91J5S53PulZBmZphmPsz2ZQ3bb9IeTwGGEhl1ZhXxLdvaRQNN7G1wV6QJEfbp8WHcWC8TgvOHLMBGXv/gAamF7Poujj9QpqQCtvo6uxD
 ab+d+gR55E+Hc5vQgKjjg/zN1xK90rrTRYo/gAL66BfMrPg0HLMWdU0y5wGxJFyi+9e/QRcbG0w6qZcoZqatBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/03/18 05:59, Jeff King wrote:
> This patch fixes a corner case where diff-highlight may
> scramble some diffs when combined with --graph.
> 
> Commit 7e4ffb4c17 (diff-highlight: add support for --graph
> output, 2016-08-29) taught diff-highlight to skip past the
> graph characters at the start of each line with this regex:
> 
>   ($COLOR?\|$COLOR?\s+)*
> 
> I.e., any series of pipes separated by and followed by
> arbitrary whitespace.  We need to match more than just a
> single space because the commit in question may be indented
> to accommodate other parts of the graph drawing. E.g.:
> 
>  * commit 1234abcd
>  | ...
>  | diff --git ...
> 
> has only a single space, but for the last commit before a
> fork:
> 
>  | | |
>  | * | commit 1234abcd
>  | |/  ...
>  | |   diff --git
> 
> the diff lines have more spaces between the pipes and the
> start of the diff.
> 
> However, when we soak up all of those spaces with the
> $GRAPH regex, we may accidentally include the leading space
> for a context line. That means we may consider the actual
> contents of a context line as part of the diff syntax. In
> other words, something like this:
> 
>    normal context line
>   -old line
>   +new line
>    -this is a context line with a leading dash
> 
> would cause us to see that final context line as a removal
> line, and we'd end up showing the hunk in the wrong order:
> 
>   normal context line
>   -old line
>    -this is a context line with a leading dash
>   +new line
> 
> Instead, let's a be a little more clever about parsing the
> graph. We'll look for the actual "*" line that marks the
> start of a commit, and record the indentation we see there.
> Then we can skip past that indentation when checking whether
> the line is a hunk header, removal, addition, etc.
> 
> There is one tricky thing: the indentation in bytes may be
> different for various lines of the graph due to coloring.
> E.g., the "*" on a commit line is generally shown without
> color, but on the actual diff lines, it will be replaced
> with a colorized "|" character, adding several bytes. We
> work around this here by counting "visible" bytes. This is
> unfortunately a bit more expensive, making us about twice as
> slow to handle --graph output. But since this is meant to be
> used interactively anyway, it's tolerably fast (and the
> non-graph case is unaffected).
> 
> One alternative would be to search for hunk header lines and
> use their indentation (since they'd have the same colors as
> the diff lines which follow). But that just opens up
> different corner cases. If we see:
> 
>   | |    @@ 1,2 1,3 @@
> 
> we cannot know if this is a real diff that has been
> indented due to the graph, or if it's a context line that
> happens to look like a diff header. We can only be sure of
> the indent on the "*" lines, since we know those don't
> contain arbitrary data (technically the user could include a
> bunch of extra indentation via --format, but that's rare
> enough to disregard).
> 
> Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  contrib/diff-highlight/DiffHighlight.pm       | 78 +++++++++++++++----
>  .../diff-highlight/t/t9400-diff-highlight.sh  | 28 +++++++
>  2 files changed, 91 insertions(+), 15 deletions(-)
> 
> diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
> index e07cd5931d..536754583b 100644
> --- a/contrib/diff-highlight/DiffHighlight.pm
> +++ b/contrib/diff-highlight/DiffHighlight.pm
> @@ -21,34 +21,82 @@ my $RESET = "\x1b[m";
>  my $COLOR = qr/\x1b\[[0-9;]*m/;
>  my $BORING = qr/$COLOR|\s/;
>  
> -# The patch portion of git log -p --graph should only ever have preceding | and
> -# not / or \ as merge history only shows up on the commit line.
> -my $GRAPH = qr/$COLOR?\|$COLOR?\s+/;
> -
>  my @removed;
>  my @added;
>  my $in_hunk;
> +my $graph_indent = 0;
>  
>  our $line_cb = sub { print @_ };
>  our $flush_cb = sub { local $| = 1 };
>  
> -sub handle_line {
> +# Count the visible width of a string, excluding any terminal color sequences.
> +sub visible_width {
>  	local $_ = shift;
> +	my $ret = 0;
> +	while (length) {
> +		if (s/^$COLOR//) {
> +			# skip colors
> +		} elsif (s/^.//) {
> +			$ret++;
> +		}
> +	}
> +	return $ret;
> +}
> +
> +# Return a substring of $str, omitting $len visible characters from the
> +# beginning, where terminal color sequences do not count as visible.
> +sub visible_substr {
> +	my ($str, $len) = @_;
> +	while ($len > 0) {
> +		if ($str =~ s/^$COLOR//) {
> +			next
> +		}
> +		$str =~ s/^.//;
> +		$len--;
> +	}
> +	return $str;
> +}
> +
> +sub handle_line {
> +	my $orig = shift;
> +	local $_ = $orig;
> +
> +	# match a graph line that begins a commit
> +	if (/^(?:$COLOR?\|$COLOR?[ ])* # zero or more leading "|" with space
> +	         $COLOR?\*$COLOR?[ ]   # a "*" with its trailing space
> +	      (?:$COLOR?\|$COLOR?[ ])* # zero or more trailing "|"
> +	                         [ ]*  # trailing whitespace for merges

Hi Peff, thanks for looking at this. I've only had a quick look through
but I wonder if this will be confused by commit messages that contain
  * bullet points
  * like this

Best Wishes

Phillip

> +	    /x) {
> +	        my $graph_prefix = $&;
> +
> +		# We must flush before setting graph indent, since the
> +		# new commit may be indented differently from what we
> +		# queued.
> +		flush();
> +		$graph_indent = visible_width($graph_prefix);
> +
> +	} elsif ($graph_indent) {
> +		if (length($_) < $graph_indent) {
> +			$graph_indent = 0;
> +		} else {
> +			$_ = visible_substr($_, $graph_indent);
> +		}
> +	}
>  
>  	if (!$in_hunk) {
> -		$line_cb->($_);
> -		$in_hunk = /^$GRAPH*$COLOR*\@\@ /;
> +		$line_cb->($orig);
> +		$in_hunk = /^$COLOR*\@\@ /;
>  	}
> -	elsif (/^$GRAPH*$COLOR*-/) {
> -		push @removed, $_;
> +	elsif (/^$COLOR*-/) {
> +		push @removed, $orig;
>  	}
> -	elsif (/^$GRAPH*$COLOR*\+/) {
> -		push @added, $_;
> +	elsif (/^$COLOR*\+/) {
> +		push @added, $orig;
>  	}
>  	else {
>  		flush();
> -		$line_cb->($_);
> -		$in_hunk = /^$GRAPH*$COLOR*[\@ ]/;
> +		$line_cb->($orig);
> +		$in_hunk = /^$COLOR*[\@ ]/;
>  	}
>  
>  	# Most of the time there is enough output to keep things streaming,
> @@ -225,8 +273,8 @@ sub is_pair_interesting {
>  	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
>  	my $suffix_b = join('', @$b[($sb+1)..$#$b]);
>  
> -	return $prefix_a !~ /^$GRAPH*$COLOR*-$BORING*$/ ||
> -	       $prefix_b !~ /^$GRAPH*$COLOR*\+$BORING*$/ ||
> +	return visible_substr($prefix_a, $graph_indent) !~ /^$COLOR*-$BORING*$/ ||
> +	       visible_substr($prefix_b, $graph_indent) !~ /^$COLOR*\+$BORING*$/ ||
>  	       $suffix_a !~ /^$BORING*$/ ||
>  	       $suffix_b !~ /^$BORING*$/;
>  }
> diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> index bf0c270d60..f6f5195d00 100755
> --- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
> +++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> @@ -310,4 +310,32 @@ test_expect_success 'diff-highlight ignores combined diffs' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'diff-highlight handles --graph with leading dash' '
> +	cat >file <<-\EOF &&
> +	before
> +	the old line
> +	-leading dash
> +	EOF
> +	git add file &&
> +	git commit -m before &&
> +
> +	sed s/old/new/ <file >file.tmp &&
> +	mv file.tmp file &&
> +	git add file &&
> +	git commit -m after &&
> +
> +	cat >expect <<-EOF &&
> +	--- a/file
> +	+++ b/file
> +	@@ -1,3 +1,3 @@
> +	 before
> +	-the ${CW}old${CR} line
> +	+the ${CW}new${CR} line
> +	 -leading dash
> +	EOF
> +	git log --graph -p -1 | "$DIFF_HIGHLIGHT" >actual.raw &&
> +	trim_graph <actual.raw | sed -n "/^---/,\$p" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> 

