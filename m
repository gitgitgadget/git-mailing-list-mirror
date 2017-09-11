Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A691FAD6
	for <e@80x24.org>; Mon, 11 Sep 2017 17:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbdIKRrO (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 13:47:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:34646 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750782AbdIKRrO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 13:47:14 -0400
Received: (qmail 22186 invoked by uid 109); 11 Sep 2017 17:47:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Sep 2017 17:47:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29502 invoked by uid 111); 11 Sep 2017 17:47:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Sep 2017 13:47:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Sep 2017 13:47:11 -0400
Date:   Mon, 11 Sep 2017 13:47:11 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Unexpected pass for t6120-describe.sh on cygwin
Message-ID: <20170911174711.j7ela4feg43gw34b@sigill.intra.peff.net>
References: <7c3db153-2a56-f27d-af71-e4b61f1252a1@ramsayjones.plus.com>
 <947699e6-c206-7818-3780-c4367e0996f0@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <947699e6-c206-7818-3780-c4367e0996f0@grubix.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2017 at 02:27:47PM +0200, Michael J Gruber wrote:

> This apparantly expects "ulimit -s" to fail on platforms that don't
> support it, so set the prereq accordingly. I moved the following to
> t/test-lib.sh:
> 
> run_with_limited_stack () {
>         (ulimit -s 128 && "$@")
> }
> 
> test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
> 
> Same things as above. Two things to note:
> - Those requisites could be the same, also they are used in different ways.
> - "ulimit -s" returning success without doing anything means that, all
> along, we ran the existing tests when we didn't mean to (on Win), and
> they succeeded for the wrong reason, which we did not notice.

Right, if ulimit doesn't actually limit, then the test isn't really
accomplishing anything. But we likely have several tests in our suite
that do that. As long as they do something on _some_ platforms, they're
still useful. And as long as their failure mode is a false-pass, they
don't bother people on the other platforms.

So I think one option is to just leave it.

> So, I guess, short of testing the effect of "ulimit -s" with another
> expensive test, it's best to simply set these prerequisites based on
> "uname -s".

You can make a cheap test that uses a lot of stack. E.g., this program
runs in about 3ms on my machine, and you can reliably run "ulimit -s 128
&& ./a.out >/dev/null" to detect it segfaulting:

-- >8 --
#include <stdio.h>

/*
 * Our goal is to use a lot of stack space relatively cheaply. To do that,
 * allocate a big stack buffer and recurse. But we take a few precautions to
 * avoid a clever compiler optimizing away our stack:
 *
 *   - we need to use the buffer so that it can't be eliminated
 *
 *   - we recurse after touching the buffer but before printing it,
 *     which makes it hard to do tail-recursion.
 */
static void foo(unsigned x)
{
	size_t i;
	unsigned char buf[1024];

	if (!x)
		return;

	for (i = 0; i < sizeof(buf); i++)
		buf[x] = x & 0xff;

	foo(x - 1);

	fwrite(buf, 1, sizeof(buf), stdout);
}

int main(void)
{
	foo(128);
	return 0;
}
-- 8< --

One downside is that it means git's test suite would (on a successful
run) stimulate segfaults, which are sometimes tracked and logged by the
kernel (or may even generate coredumps outside of the test suite area).

-Peff
