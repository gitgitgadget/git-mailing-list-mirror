Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE32220756
	for <e@80x24.org>; Mon,  9 Jan 2017 11:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965762AbdAIL14 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 06:27:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:36959 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935896AbdAIL1K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 06:27:10 -0500
Received: (qmail 5632 invoked by uid 109); 9 Jan 2017 11:27:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 11:27:09 +0000
Received: (qmail 3476 invoked by uid 111); 9 Jan 2017 11:28:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 06:28:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jan 2017 06:27:06 -0500
Date:   Mon, 9 Jan 2017 06:27:06 -0500
From:   Jeff King <peff@peff.net>
To:     "A. Wilcox" <awilfox@adelielinux.org>
Cc:     git@vger.kernel.org
Subject: Re: Test failures when Git is built with libpcre and grep is built
 without it
Message-ID: <20170109112706.zezc2kt44u3652jm@sigill.intra.peff.net>
References: <58688C9F.4000605@adelielinux.org>
 <20170102065351.7ymrm77asjbghgdg@sigill.intra.peff.net>
 <58736B2A.40003@adelielinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58736B2A.40003@adelielinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 09, 2017 at 04:51:22AM -0600, A. Wilcox wrote:

> Interestingly enough, you seem to be right.  The failure is very
> bizarre and has nothing to do with system /bin/grep:
> 
> test_must_fail: command succeeded: git grep -G -F -P -E a\x{2b}b\x{2a}c ab
> not ok 142 - grep -G -F -P -E pattern
> #
> #               >empty &&
> #               test_must_fail git grep -G -F -P -E "a\x{2b}b\x{2a}c"
> ab >actual &&
> #               test_cmp empty actual
> #
> 
> However:
> 
> elaine trash directory.t7810-grep # git grep -G -F -P -E
> a\x{2b}b\x{2a}c ab >actual
> fatal: command line, 'ax{2b}bx{2a}c': Invalid contents of {}

Hrm, it looks like your shell eats the backslashes in a double-quoted
string.

What does:

  printf '%s\n' "a\x{2b}b\x{2a}c"

show?

I'm not sure if that's related or not. And as you said your shell is
bash, that seems weird. Lots of other people run bash, and we haven't
gotten a report (and your version isn't bleeding edge).

That said, the "invalid contents" error message is expected. What's
confusing is that the command returned success. The error comes from
compile_regexp(), which sees that regcomp() failed. It calls
compile_regexp_failed(), which calls die(), which should end in
exit(128). But the shell sees the exit code as 0. Weird.

Your example run after shows that the correct exit code comes out of
git. What does:

  ./t7810-grep.sh -x --verbose-only=142

say? That should enable "set -x" in the shell just for that test.

-Peff

PS In my repo, the test that is failing for you is actually 145. Are you
   trying with a version of git older than v2.7.x? If so, you might
   double-check that the problem persists on the latest "master". I
   don't know of any particular fixes, but it's worth a shot.

-Peff
