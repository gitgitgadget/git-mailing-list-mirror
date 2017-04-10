Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D3420966
	for <e@80x24.org>; Mon, 10 Apr 2017 16:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755483AbdDJQ5c (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 12:57:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:59273 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753457AbdDJQ5a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 12:57:30 -0400
Received: (qmail 10220 invoked by uid 109); 10 Apr 2017 16:57:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 16:57:29 +0000
Received: (qmail 26661 invoked by uid 111); 10 Apr 2017 16:57:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 12:57:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 12:57:27 -0400
Date:   Mon, 10 Apr 2017 12:57:27 -0400
From:   Jeff King <peff@peff.net>
To:     Joachim Durchholz <jo@durchholz.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] test-lib: exhaustively insert non-alnum ASCII into
 the TRASH_DIRECTORY name
Message-ID: <20170410165727.4lqtit5hkcxh32ew@sigill.intra.peff.net>
References: <20170409191117.25175-3-avarab@gmail.com>
 <20170410014712.26716-1-szeder.dev@gmail.com>
 <CACBZZX6M2YnbOT6btqLf2RacNT0Th3Hx2jf5QR7g+KFS_DKtVQ@mail.gmail.com>
 <CAM0VKjnwbCgCjEBr895068k4veoSGZMf8Cu7neoH=oofgWS2Cw@mail.gmail.com>
 <CACBZZX7kMcTgKFkFN3OvVKVHU693PYhRFe6gyO4AirihNsUYmg@mail.gmail.com>
 <20170410133856.qbmcif2it2gc6kdw@sigill.intra.peff.net>
 <64121361-6f91-5988-b5e2-9278cc84067f@durchholz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64121361-6f91-5988-b5e2-9278cc84067f@durchholz.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 04:59:57PM +0200, Joachim Durchholz wrote:

> Am 10.04.2017 um 15:38 schrieb Jeff King:
> > Are those bugs? Maybe. Certainly they are limitations. But are they ones
> > anybody _cares_ about?  I think this may fall under "if it hurts, don't
> > do it".
> 
> It's not always possible to avoid that.

Sort of. I don't find anything wrong with saying "your local filesystem
path for a repository cannot contain newlines; if it does, some features
may be unavailable".

> URLs, for example, may contain "funny characters", including multi-byte
> characters of which the second byte is 0x0a. If they are guaranteed to
> always be URL-encoded this isn't a problem, but then we still need to make
> sure that URL-encoding does happen.

Sure, but URLs have a way of encoding. And if we're not encoding when we
should, then that's a bug. But the arguments that are fed to things like
git-clone _aren't_ URLs. They're a specifier that uses some heuristics
to decide between the various cases (URLs, host:path specifiers, local
paths). If you feed syntactic garbage, aborting the operation (and
failing the test!) may be the right thing for git to do.

> > If there are security bugs where a malicious input can cause us
> > to do something bad, that's something to care about. But that's very
> > different than asking "do these tests run to completion with a funny
> > input".
> 
> If the tests do not complete, git is doing something unexpected.

I very much disagree with that. Git's test operate under a set of
assumptions, and if you violate those assumptions, then the failures are
not meaningful.

Take alternates, for instance. The on-disk storage format cannot
represent paths with newlines in them. If a test does:

  git clone -s "$(pwd)" parent.git child &&
  test -d child

then that test is going to fail if the test directory has a newline in
it. But that doesn't tell us anything meaningful. Maybe there is a bug
and maybe there isn't, but we cannot know because the thing being tested
cannot possibly work under the test environment given.

You can rewrite all the tests to say "skip this test if there's a
newline in the test directory". But to what end? It's work to write and
to maintain, and we haven't gained new information.

> That in itself is not a security hole, but there's a pretty good chance that
> at least one of these ~230 unexpected things can be turned into one, given
> enough time and motivation. The risk multiplies as this is shell scripting,
> where the path from "string is misinterpreted" to "string is run as a
> command" is considerably shorter than in other languages.

Sure, and I'd encourage people who are interested to dig through the
results and see if they can find a real problem. I looked at several and
didn't find anything that wasn't an example of the "test assumptions"
thing above.

I'll actually be surprised if there are shell injection problems in Git,
because our scripts are usually pretty meticulous about quoting
variables and not doing crazy things with eval. I think the issues are
much more likely to be like the "submodule--helper --list" thing I
pointed out, where we get phantom records in lists.

But again, I'm happy to be proven wrong. If there's a shell injection in
Git it's clearly a bug and should be fixed. I just don't think
plastering control characters into the test directory names all the time
is a good way of finding those problems (and doesn't balance out the
cost). Fuzzing the directory names and digging into specific cases _is_
a reasonable way to do it.

-Peff
