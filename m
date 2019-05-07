Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E124B1F45F
	for <e@80x24.org>; Tue,  7 May 2019 07:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfEGHQc (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 03:16:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:49846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726297AbfEGHQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 03:16:32 -0400
Received: (qmail 17795 invoked by uid 109); 7 May 2019 07:16:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 07:16:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8858 invoked by uid 111); 7 May 2019 07:17:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 07 May 2019 03:17:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2019 03:16:30 -0400
Date:   Tue, 7 May 2019 03:16:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 2/2] perf-lib.sh: remove GIT_TEST_INSTALLED from
 perf-lib.sh
Message-ID: <20190507071630.GB28060@sigill.intra.peff.net>
References: <20190506202451.GA19850@sigill.intra.peff.net>
 <20190506232309.28538-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506232309.28538-3-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 01:23:09AM +0200, Ævar Arnfjörð Bjarmason wrote:

> @@ -79,7 +95,16 @@ run_dirs_helper () {
>  	if test $# -gt 0 -a "$1" = --; then
>  		shift
>  	fi
> -	if [ ! -d "$mydir" ]; then
> +
> +	PERF_RESULTS_PREFIX=
> +	if test "$mydir" = "."
> +	then
> +		unset GIT_TEST_INSTALLED
> +	elif test -d "$mydir"
> +	then
> +		PERF_RESULTS_PREFIX=$(cd $mydir && printf "%s" "$(pwd)" | tr -c "[a-zA-Z0-9]" "_").
> +		set_git_test_installed "$mydir"
> +	else
>  		rev=$(git rev-parse --verify "$mydir" 2>/dev/null) ||
>  		die "'$mydir' is neither a directory nor a valid revision"
>  		if [ ! -d build/$rev ]; then

OK, so this is basically the same cleanup I came up with. The big
difference is that you pushed the shared code into a function, rather
than the funky double-conditional in the original. I'm OK with that.

> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> index 494907a892..c8f4a78903 100755
> --- a/t/perf/aggregate.perl
> +++ b/t/perf/aggregate.perl
> @@ -6,6 +6,7 @@
>  use JSON;
>  use Getopt::Long;
>  use Git;
> +use Cwd qw(realpath);
>  
>  sub get_times {
>  	my $name = shift;
> @@ -103,13 +104,14 @@ sub format_size {
>  	if (! -d $arg) {
>  		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
>  		$dir = "build/".$rev;
> +	} elsif ($arg eq '.') {
> +		$dir = '.';
>  	} else {
> -		$arg =~ s{/*$}{};
> -		$dir = $arg;
> -		$dirabbrevs{$dir} = $dir;
> +		$dir = realpath($arg);
> +		$dirnames{$dir} = $dir;
>  	}
>  	push @dirs, $dir;
> -	$dirnames{$dir} = $arg;
> +	$dirnames{$dir} ||= $arg;

I'm not sure I get what's going on here. Why do we need the realpath in
aggregate.perl? We'd want to generate the same filename that "run"
decided to store things in, which we'd generate from the command-line
arguments (either passed on to us by "run", or direct from the user if
they're printing a previous run).

> @@ -312,9 +314,6 @@ sub print_codespeed_results {
>  		$environment = $reponame;
>  	} elsif (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} ne "") {
>  		$environment = $ENV{GIT_PERF_REPO_NAME};
> -	} elsif (exists $ENV{GIT_TEST_INSTALLED} and $ENV{GIT_TEST_INSTALLED} ne "") {
> -		$environment = $ENV{GIT_TEST_INSTALLED};
> -		$environment =~ s|/bin-wrappers$||;
>  	} else {
>  		$environment = `uname -r`;
>  		chomp $environment;

Is this codespeed thing a totally separate bug? Should it go into its
own patch?

-Peff
