Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C30C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 06:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDLGXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDLGXW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 02:23:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE8059E0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 23:23:01 -0700 (PDT)
Received: (qmail 17776 invoked by uid 109); 12 Apr 2023 06:23:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 06:23:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17038 invoked by uid 111); 12 Apr 2023 06:23:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 02:23:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 02:23:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH 0/7] v0 multiple-symref infinite loop fix and test cleanup
Message-ID: <20230412062300.GA838367@coredump.intra.peff.net>
References: <39035D34-8548-44B0-BBBB-5C36B3876C4A@lophus.org>
 <20230411210633.GA626331@coredump.intra.peff.net>
 <20230411211604.GB626331@coredump.intra.peff.net>
 <ZDXPemH0d3YWnpjL@nand.local>
 <20230411215845.GA678138@coredump.intra.peff.net>
 <xmqqa5ze9glg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5ze9glg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 03:52:43PM -0700, Junio C Hamano wrote:

> > +test_expect_success 'v0 clients can handle multiple symrefs' '
> > +	# Git will not generate multiple symref entries for v0 these days, but it
> > +	# is technically allowed, and we did so until d007dbf7d6 (Revert
> > +	# "upload-pack: send non-HEAD symbolic refs", 2013-11-18). Test the
> > +	# client handling here by faking that older behavior.
> 
> Yeah, I remember that fix where somebody had tons of symbolic refs
> and busted the protocol limit.  Is "multiple symref" used here
> because it is the easiest to reproduce the issue, or have we saw
> such a potentially broken server in the wild?

Both. :) It was what we saw in the wild, but it's also one of only two
capabilities that can cause the problem, because it requires passing an
offset parameter, which we only do for capabilities we expect to see
multiple times. The other is "object-format", but we only ever print it
once. More details in the commit message to follow.

> > +	# Note that our oid is hard-coded to always be sha1, and not using
> > +	# test_oid. Since our fake capabilities line does not have an
> > +	# object-format entry, the client will always use sha1 mode.
> 
> It probably is OK to run the test in that "undeclared - assume
> SHA-1" mode, even though I think we give an explicit "object-format"
> capability even when talking from the SHA-1 repository these days.

We do, but I think it is OK to ignore that. The test will continue to
work even in a world where sha256 becomes the default. If we eventually
remove all vestiges of backwards-compatible sha1 support, it will have
to be updated, but I'm OK with that (keep in mind that the test is also
v0-only, as the v2 parser is totally different).

> > I also wondered if we tested this multiple-symref case for protocol v2
> > (where it works fine), but it looks like we may not. There are earlier
> > tests which _would_ trigger it, but we force them into v0 mode, due to
> > b2f73b70b2 (t5512: compensate for v0 only sending HEAD symrefs,
> > 2019-02-25). I think we really should be letting ls-remote use the
> > protocol it prefers (v2 by default, and v0 if the suite is run in that
> > mode), and the expected output should be adjusted based on the mode.
> > I'll see if I can do that as well, to make this a two-patch series.
> 
> Thanks.  I really appreciate your being almost always thorough and
> wish more contributors took inspirations.

Well, no good deed goes unpunished. :) These tests have not aged well,
so there were a number of fixes to make. Here's the series I came up
with.

The first one is the bug fix; I put it at the front because it's
obviously the most urgent. Patches 2-6 are test cleanups, and as such
should not be very risky, but I didn't want to hold up the fix. But they
do depend on the helper script introduced by patch 1, so they can't be
applied separately.

Patch 7 is a cleanup in the code which should have no behavior change.
It could be applied separately (or even dropped if you don't like it).

  [1/7]: v0 protocol: fix infinite loop when parsing multi-valued capabilities
  [2/7]: t5512: stop referring to "v1" protocol
  [3/7]: t5512: stop using jgit for capabilities^{} test
  [4/7]: t5512: add v2 support for "ls-remote --symref" test
  [5/7]: t5512: allow any protocol version for filtered symref test
  [6/7]: t5512: test "ls-remote --heads --symref" filtering with v0 and v2
  [7/7]: v0 protocol: use size_t for capability length/offset

 builtin/receive-pack.c |   2 +-
 connect.c              |  26 ++++----
 connect.h              |   4 +-
 fetch-pack.c           |   4 +-
 send-pack.c            |   2 +-
 t/t5512-ls-remote.sh   | 148 ++++++++++++++++++++++-------------------
 transport.c            |   2 +-
 upload-pack.c          |   2 +-
 8 files changed, 101 insertions(+), 89 deletions(-)

-Peff
