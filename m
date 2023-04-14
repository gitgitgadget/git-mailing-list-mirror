Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78956C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 21:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDNVYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDNVYG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 17:24:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849E192
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 14:24:05 -0700 (PDT)
Received: (qmail 22340 invoked by uid 109); 14 Apr 2023 21:24:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Apr 2023 21:24:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31646 invoked by uid 111); 14 Apr 2023 21:24:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Apr 2023 17:24:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Apr 2023 17:24:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH v3 0/7] v0 multiple-symref infinite loop fix and test cleanup
Message-ID: <20230414212404.GA639653@coredump.intra.peff.net>
References: <20230412062300.GA838367@coredump.intra.peff.net>
 <20230412063118.GC1681312@coredump.intra.peff.net>
 <20230412090423.GA2187240@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412090423.GA2187240@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 05:04:23AM -0400, Jeff King wrote:

> I'll squash that in and update the commit message before I do the next
> re-roll (but will still hold off a bit to get further comments).

Nobody said anything, so I assume the rest of the series is perfect. ;)

Junio, I see that you picked up this fix as a "squash", along with my
other "v2" update. Here's a v3 that does the actual squash along with a
commit message update. That ties up all loose ends from my perspective,
but of course if anybody has review comments, please send them.

The range-diff against what you have in jk/protocol-cap-parse-fix
(after squashing) is below.

  [1/7]: v0 protocol: fix infinite loop when parsing multi-valued capabilities
  [2/7]: t5512: stop referring to "v1" protocol
  [3/7]: v0 protocol: fix sha1/sha256 confusion for capabilities^{}
  [4/7]: t5512: add v2 support for "ls-remote --symref" test
  [5/7]: t5512: allow any protocol version for filtered symref test
  [6/7]: t5512: test "ls-remote --heads --symref" filtering with v0 and v2
  [7/7]: v0 protocol: use size_t for capability length/offset

 builtin/receive-pack.c |   2 +-
 connect.c              |  30 ++++----
 connect.h              |   4 +-
 fetch-pack.c           |   4 +-
 send-pack.c            |   2 +-
 t/t5512-ls-remote.sh   | 156 +++++++++++++++++++++++------------------
 transport.c            |   2 +-
 upload-pack.c          |   2 +-
 8 files changed, 112 insertions(+), 90 deletions(-)

1:  5471cf388b = 1:  117f371be1 v0 protocol: fix infinite loop when parsing multi-valued capabilities
2:  eb3e6e6d1c = 2:  de695291b0 t5512: stop referring to "v1" protocol
3:  c77b8ae4a0 ! 3:  515149d67a t5512: stop using jgit for capabilities^{} test
    @@ Metadata
     Author: Jeff King <peff@peff.net>
     
      ## Commit message ##
    -    t5512: stop using jgit for capabilities^{} test
    +    v0 protocol: fix sha1/sha256 confusion for capabilities^{}
     
         Commit eb398797cd (connect: advertized capability is not a ref,
         2016-09-09) added support for an upload-pack server responding with:
     
           0000000000000000000000000000000000000000        capabilities^{}
     
    -    followed by a NUL and capabilities. This is not something Git itself has
    -    ever produced for upload-pack, but JGit does. And hence the test used
    -    JGit to reproduce the real-world situation. That was good for verifying
    -    that the incompatibility was fixed, but it's a lousy regression test for
    -    a few reasons:
    +    followed by a NUL and the actual capabilities. We correctly parse the
    +    oid using the packet_reader's hash_algo field, but then we compare it to
    +    null_oid(), which will instead use our current repo's default algorithm.
    +    If we're defaulting to sha256 locally but the other side is sha1, they
    +    won't match and we'll fail to parse the line (and thus die()).
     
    -      - hardly anybody runs it, because you have to have jgit installed
    +    This can cause a test failure when the suite is run with
    +    GIT_TEST_DEFAULT_HASH=sha256, and we even do so regularly via the
    +    linux-sha256 CI job. But since the test requires JGit to run, it's
    +    usually just skipped, and nobody noticed the problem.
    +
    +    The reason the original patch used JGit is that Git itself does not ever
    +    produce such a line via upload-pack; the feature was added to fix a
    +    real-world problem when interacting with JGit. That was good for
    +    verifying that the incompatibility was fixed, but it's not a good
    +    regression test:
    +
    +      - hardly anybody runs it, because you have to have jgit installed;
    +        hence this bug going unnoticed
     
           - we're depending on jgit's behavior for the test to do anything
             useful. In particular, this behavior is only relevant to the v0
    @@ Commit message
             script.
     
         Instead, let's just hard-code the response that's of interest to us.
    -    That will test exactly what we want for every run.
    +    That will test exactly what we want for every run, and reveals the bug
    +    when run in sha256 mode. And of course we'll fix the actual bug by using
    +    the correct hash_algo struct.
     
         Signed-off-by: Jeff King <peff@peff.net>
     
4:  8db5b3c3bf = 4:  152d904a4a t5512: add v2 support for "ls-remote --symref" test
5:  f1cd63e16e = 5:  87053ab90b t5512: allow any protocol version for filtered symref test
6:  b6b9d1ad44 = 6:  37d300d244 t5512: test "ls-remote --heads --symref" filtering with v0 and v2
7:  870d6e0a3b = 7:  4db6853ea2 v0 protocol: use size_t for capability length/offset
