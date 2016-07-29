Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E2FA1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 16:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbcG2Qjm (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 12:39:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:51119 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751808AbcG2Qjl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 12:39:41 -0400
Received: (qmail 796 invoked by uid 102); 29 Jul 2016 16:39:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 12:39:41 -0400
Received: (qmail 2839 invoked by uid 107); 29 Jul 2016 16:40:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 12:40:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 12:39:38 -0400
Date:	Fri, 29 Jul 2016 12:39:38 -0400
From:	Jeff King <peff@peff.net>
To:	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
Cc:	Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
Subject: Re: [PATCH] Fix failing test t3700-add.sh
Message-ID: <20160729163937.GD29773@sigill.intra.peff.net>
References: <579b4ca1.18da2703.bm000@wupperonline.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <579b4ca1.18da2703.bm000@wupperonline.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[+cc Ed, who wrote 4e55ed3 (add: add --chmod=+x / --chmod=-x options,
2016-05-31)]

On Fri, Jul 29, 2016 at 02:31:28PM +0200, Ingo Brückl wrote:

> At the time of the test xfoo1 already exists and is a link.
> As a result, the check for file mode 100644 fails.
> 
> Create not yet existing file xfoo instead.

Hrm. So in the original code:

>  test_expect_success 'git add --chmod=-x stages an executable file with -x' '
> -	echo foo >xfoo1 &&
> -	chmod 755 xfoo1 &&
> -	git add --chmod=-x xfoo1 &&
> -	case "$(git ls-files --stage xfoo1)" in
> -	100644" "*xfoo1) echo pass;;
> -	*) echo fail; git ls-files --stage xfoo1; (exit 1);;

I would have expected "git add --chmod" to drop the "-x" bit in addition
to actually overwriting the file contents (and switching a symlink to a
file). And it does. The culprit is actually the "echo foo >xfoo1" line.
If "xfoo1" is a symlink, then it silently writes to the symlink
destination, and xfoo1 remains a symlink (and thus tweaking its execute
bit is a noop).

I was also puzzled why the test fails for you; it does not for me.
Running the test script as root does make it fail. There are some
earlier tests which are skipped in this case, which run "git reset
--hard" with xfoo1 in the index, which cleans it up.

> +	echo foo >xfoo &&
> +	chmod 755 xfoo &&
> +	git add --chmod=-x xfoo &&
> +	case "$(git ls-files --stage xfoo)" in
> +	100644" "*xfoo) echo pass;;
> +	*) echo fail; git ls-files --stage xfoo; (exit 1);;

Here you just pick another name, "xfoo", which does happen to work. But
it seems like that has the same potential for flakiness if earlier tests
get adjusted or skipped, since they also use that name.

How about just:

  rm -f xfoo1

at the top of the test, which explicitly documents the state we are
looking for?

I also wondered if this test, which calls "chmod 755 xfoo1", should be
marked with the POSIXPERM prerequisite. But I guess since its goal is to
strip the executable bit, it "works" even on systems where that chmod is
a noop (the "git add --chmod" doesn't do anything, but one way or the
other we end up at the end state we expect).

-Peff
