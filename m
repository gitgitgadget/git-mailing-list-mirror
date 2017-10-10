Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB752036B
	for <e@80x24.org>; Tue, 10 Oct 2017 14:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932237AbdJJO3e (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 10:29:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:48440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932075AbdJJO3d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 10:29:33 -0400
Received: (qmail 14337 invoked by uid 109); 10 Oct 2017 14:29:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 14:29:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27091 invoked by uid 111); 10 Oct 2017 14:29:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 10:29:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Oct 2017 10:29:30 -0400
Date:   Tue, 10 Oct 2017 10:29:30 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [RFC] column: show auto columns when pager is active
Message-ID: <20171010142930.vao2nqg4pv7f2znk@sigill.intra.peff.net>
References: <20171009214543.12986-1-me@ikke.info>
 <20171010141019.3vfowj4fvxdvvl3c@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171010141019.3vfowj4fvxdvvl3c@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 10:10:19AM -0400, Jeff King wrote:

> That said, I'm still puzzled why it would return zero output. Strace
> shows that the read from stdin is getting no input. I suspect this may
> have to do with how we redirect stdin in test-terminal.perl.
> 
> See 18d8c26930 (test_terminal: redirect child process' stdin to a pty,
> 2015-08-04), which claims there's some raciness with closing the
> descriptor.

Ah, yeah, I think that is it. Try:

  echo input | test_terminal sed s/^/foo:/

it will randomly succeed or fail, depending on whether sed manages to
read the input before the stdin terminal is closed.

I'm not sure of an easy way to fix test-terminal, but we could work
around it like this (which also uses "-p" to actually invoke the pager,
and uses a pager that makes it clear when it's being run):

diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index 9441145bf0..d322c3b745 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -180,14 +180,14 @@ EOF
 
 test_expect_success TTY '20 columns, mode auto, pager' '
 	cat >expected <<\EOF &&
-one    seven
-two    eight
-three  nine
-four   ten
-five   eleven
-six
+paged:one    seven
+paged:two    eight
+paged:three  nine
+paged:four   ten
+paged:five   eleven
+paged:six
 EOF
-	test_terminal env PAGER="cat|cat" git column --mode=auto <lista >actual &&
+	test_terminal env PAGER="sed s/^/paged:/" sh -c "git -p column --mode=auto <lista" >actual &&
 	test_cmp expected actual
 '
 test_done

All that said, I think I'd just as soon test a real command like "git
tag", which doesn't care about reading from stdin.

-Peff
