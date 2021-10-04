Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E20DC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B31611F0
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhJDHpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 03:45:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:60206 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhJDHph (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 03:45:37 -0400
Received: (qmail 8278 invoked by uid 109); 4 Oct 2021 07:43:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Oct 2021 07:43:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11895 invoked by uid 111); 4 Oct 2021 07:43:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Oct 2021 03:43:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Oct 2021 03:43:47 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] p5311: handle spaces in wc(1) output
Message-ID: <YVqws1lZMD+l1MfK@coredump.intra.peff.net>
References: <a682e2c8-fecc-906e-0ff6-93de2b311d14@web.de>
 <YVk8SeuDIWwsrdO0@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVk8SeuDIWwsrdO0@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 03, 2021 at 01:14:49AM -0400, Taylor Blau wrote:

> On Sat, Oct 02, 2021 at 10:33:18PM +0200, René Scharfe wrote:
> > Some implementations of wc(1) align their output with leading spaces,
> > even when just a single number is requested, e.g. with "wc -c".  p5311
> > runs all tests successfully on such a platform, but fails to aggregate
> > their results and reports:
> 
> This makes sense, and makes me think that wc's platform-specific
> implementations are too tricky to use when we are being picky about
> leading spaces.
> 
> In other words, I think that your fix is absolutely correct, but I
> wonder if test_size should be friendlier in what it accepts, and to
> chomp off any leading space. So perhaps something like the below would
> work without any modification to p5311.

I do like this direction, because by centralizing, it's one less thing
for perf-script writers to mess up. And not only does it fix "wc -c",
but it is more friendly to any other tools (since test_size can really
be used with any scalar magnitude measurement we like; our current tests
just happen to use wc).

But...

> Subject: [PATCH] t/perf/aggregate.perl: tolerate leading spaces
> 
> When using `test_size` with `wc -c`, users on certain platforms can run
> into issues when `wc` emits leading space characters in its output,
> which confuses get_times.
> 
> Callers could switch to use test_file_size instead of `wc -c` (the
> former never prints leading space characters, so will always work with
> test_size regardless of platform), but this is an easy enough spot to
> miss that we should teach get_times to be more tolerant of the input it
> accepts.
> 
> Teach get_times to do just that by stripping any leading space
> characters.

This leaves the extra whitespace inside the test-results/foo.results
file, which is a bit unfortunate, just because anything else besides
aggregate.perl will have to do the same workaround. So we've traded one
gotcha for another. ;)

I don't have a strong opinion on which is worse. The ideal would be for
test_size() itself to handle it, though it's a bit awkward because it is
literally just redirecting the output of the test snippet into the
result file. It's probably not worth spending a ton of effort on that.

> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> index 82c0df4553..575d2000cc 100755
> --- a/t/perf/aggregate.perl
> +++ b/t/perf/aggregate.perl
> @@ -17,8 +17,8 @@ sub get_times {
>  		my $rt = ((defined $1 ? $1 : 0.0)*60+$2)*60+$3;
>  		return ($rt, $4, $5);
>  	# size
> -	} elsif ($line =~ /^\d+$/) {
> -		return $&;
> +	} elsif ($line =~ /^\s*(\d+)$/) {
> +		return $1;

If we do go this route, it might be nice to ignore trailing whitespace,
too (I don't think it matters for wc, but just for general
friendliness). I'm tempted even to say that it should just drop the
anchors and match "\d+" anywhere, but perhaps that is a recipe for
mistakes (if somebody writes "foo 1234" we probably want to detect and
complain).

-Peff
