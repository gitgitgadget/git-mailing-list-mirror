Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341F4C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA5B61263
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhKPVls (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 16:41:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:60552 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhKPVls (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 16:41:48 -0500
Received: (qmail 21363 invoked by uid 109); 16 Nov 2021 21:38:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Nov 2021 21:38:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3285 invoked by uid 111); 16 Nov 2021 21:38:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 16:38:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 16:38:50 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: [PATCH] t5319: corrupt more bytes of the midx checksum
Message-ID: <YZQk6t1veegeAlYh@coredump.intra.peff.net>
References: <cover.1624473543.git.me@ttaylorr.com>
 <94e9de44e3b52513c5ab48aecd74f809dc34cbe3.1624473543.git.me@ttaylorr.com>
 <20211110231132.GB5811@szeder.dev>
 <YYzq0uBr+uoVvkbC@coredump.intra.peff.net>
 <YZQeMjjtxS2LU2Tk@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZQeMjjtxS2LU2Tk@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 04:10:10PM -0500, Taylor Blau wrote:

> I agree that it's annoyingly cumbersome to write back the last byte
> incremented mod-256. So I'm content to just make it astronomically
> unlikely to run into a collision in practice. (As a matter of fact, I'm
> surprised that the current implementation hasn't produced failures for
> us more often).

It's quite deterministic in practice. The randomness is driven by the
mtimes of the packfiles, so there are only a handful of combinations
you'd see in practice (though I'm still curious why one of Gábor's
machines sees it so frequently).

> Peff: do you want me to turn this into a patch or were you planning on
> it?

I hadn't thought that far ahead. ;)

One thing I did wonder is whether other corruption tests might have the
same problem. But if they're not triggering in practice, I don't think
it's worth spending a bunch of time looking at them.

So here's this fix wrapped up with a commit message.

-- >8 --
Subject: [PATCH] t5319: corrupt more bytes of the midx checksum

One of the tests in t5319 corrupts the checksum of the midx file by
writing a single 0xff over the final byte, and then confirms that we
detect the problem. This usually works fine, but would break if the
actual checksum ended with that same byte already.

It seems like this should happen in 1 out of 256 test runs, but it turns
out to be less often in practice. The contents of the midx are mostly
deterministic because it's based on the objects, and we remove most
sources of randomness by setting GIT_COMMITTER_DATE, etc.  However,
there's still some randomness: some objects are duplicated between
packs, and the midx must decide which to use, which can be based on
timing.

So very occasionally we can end up with a real 0xff byte, and the test
fails. The most robust fix would be to read out the final byte and then
change it to something else (e.g., adding 1 mod 256). But that's awkward
to do in shell. Let's just blindly corrupt 10 bytes instead of 1, which
reduces our chances of an accidental noop to 1 in 2^80.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5319-multi-pack-index.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 3f69e43178..a612e44547 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -482,8 +482,10 @@ test_expect_success 'corrupt MIDX is not reused' '
 '
 
 test_expect_success 'verify incorrect checksum' '
-	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 1)) &&
-	corrupt_midx_and_verify $pos "\377" $objdir "incorrect checksum"
+	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 10)) &&
+	corrupt_midx_and_verify $pos \
+		"\377\377\377\377\377\377\377\377\377\377" \
+		$objdir "incorrect checksum"
 '
 
 test_expect_success 'repack progress off for redirected stderr' '
-- 
2.34.0.633.g181affe237

