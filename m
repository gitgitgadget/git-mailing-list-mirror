Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A792018F
	for <e@80x24.org>; Mon, 18 Jul 2016 13:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbcGRNEN (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 09:04:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:46369 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751400AbcGRNEM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 09:04:12 -0400
Received: (qmail 11939 invoked by uid 102); 18 Jul 2016 13:04:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jul 2016 09:04:11 -0400
Received: (qmail 3489 invoked by uid 107); 18 Jul 2016 13:04:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jul 2016 09:04:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2016 07:04:05 -0600
Date:	Mon, 18 Jul 2016 07:04:05 -0600
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
Message-ID: <20160718130405.GA19751@sigill.intra.peff.net>
References: <20160718064431.GA10819@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160718064431.GA10819@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 06:44:31AM +0000, Eric Wong wrote:

> On FreeBSD 10.3 (but presumably any FreeBSD 8+), /usr/bin/unzip
> exists, but is insufficient for t5003 due to its non-standard
> handling of the -a option[1].  This version of unzip exits
> with "1" when given the "-v" flag.
> 
> However, the common Info-ZIP version may be installed at
> /usr/local/bin/unzip (via "pkg install unzip") to pass t5003.
> This Info-ZIP version exits with "0" when given "-v",
> so limit the prereq to only versions which return 0 on "-v".

I guess I am cc'd because of f838ce5 (test-lib: factor out $GIT_UNZIP
setup, 2013-03-10). But really this check for 127 dates all the way back
to Johannes's 3a86f36 (t5000: skip ZIP tests if unzip was not found,
2007-06-06), and was just pulled along as it got refactored into a
various incarnations of prerequisite by me and René.

It's possible that there is some version of unzip that does not like
"-v" but otherwise is OK with our tests, but we would skip tests using
this patch. Even with the FreeBSD version you mention, I'd expect you
could run all of the tests except for the single "-a" test.

So I wonder if we could more directly test the two levels we care about:

  - do you appear to have a working "unzip" at all?

  - does your unzip support "-a"?

My Debian version of unzip (which is derived from Info-zip) seems to
give return code 0 for just "unzip". So for the first check, we could
possibly drop "-v"; we don't care about "-v", but just wanted some way
to say "does unzip exist on the path?". Another option would just be
checking whether "unzip" returns something besides 127 (so what we have
now, minus "-v").

To test for "-a", I think we'd have to actually feed it a sample zip
file, though. My unzip returns "10", which its manpage explains as
"invalid command line options" (presumably because of the missing
zipfile argument). But that seems like it probably isn't portable.  And
it's also what I might expect another unzip to return if it doesn't
support "-a".

So while this patch does solve the immediate problem, I think it does so
by overly skipping tests that we _could_ run.

If we do go with this patch, though:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 11201e9..938f788 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1103,7 +1103,7 @@ test_lazy_prereq SANITY '
>  GIT_UNZIP=${GIT_UNZIP:-unzip}
>  test_lazy_prereq UNZIP '
>  	"$GIT_UNZIP" -v
> -	test $? -ne 127
> +	test $? -eq 0
>  '

...you can simply drop the "test" line, as testing $? against 0 is
essentially a noop. If it is 0, then test will return 0; if it is not,
then test will return non-zero. You can just return the value directly
instead.

-Peff
