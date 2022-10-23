Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DCBC3A59D
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 17:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJWRAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Oct 2022 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJWRAs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2022 13:00:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F7263873
        for <git@vger.kernel.org>; Sun, 23 Oct 2022 10:00:46 -0700 (PDT)
Received: (qmail 25281 invoked by uid 109); 23 Oct 2022 17:00:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 23 Oct 2022 17:00:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18779 invoked by uid 111); 23 Oct 2022 17:00:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Oct 2022 13:00:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Oct 2022 13:00:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/5] repack: use tempfiles for signal cleanup
Message-ID: <Y1VzPY4zQyZbVAsm@coredump.intra.peff.net>
References: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
 <Y1M3oie5dPrRaOni@coredump.intra.peff.net>
 <Y1RUI8ny2mexxwKm@coredump.intra.peff.net>
 <xmqqtu3vflau.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtu3vflau.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 22, 2022 at 05:14:33PM -0700, Junio C Hamano wrote:

> > Some options:
> >
> >   - find a different way to convince repack to die. The most likely is
> >     probably corrupting the cruft objects in some way such that
> >     pack-objects dies, but not until it starts doing real work.
> >
> >   - mark the test_must_fail with ok=sigpipe. In most case this is a
> >     band-aid, but here we still test what we want. The .tmp cleanup
> >     should kick in from a die() or from a signal death, so either is
> >     sufficient for our purposes.
> >
> >   - teach git-repack to ignore sigpipe. We don't actually check the
> >     writes to pack-objects (since they're done by fprintf), but we'd
> >     notice its failing exit code. And arguably this is improving the
> >     user experience. Saying "pack-objects died with an error" is more
> >     useful than a sigpipe.
> >
> > Thoughts?
> 
> I agree that for this particular one the second one is a reasonable
> thing to do in the context of the test.  The third one may actually
> be a better fix, exactly for the reason you state here.

Here's a patch on top of of jk/repack-tempfile-cleanup that adjusts the
test (and should make the immediate racy CI pain go away). It gives some
explanation why the third option isn't as interesting as you'd think. If
somebody later wants to add such a "pack-objects died" error, we can
adjust sigpipe handling there.

-- >8 --
Subject: [PATCH] t7700: annotate cruft-pack failure with ok=sigpipe

One of our tests intentionally causes the cruft-pack generation phase of
repack to fail, in order to stimulate an exit from repack at the desired
moment. It does so by feeding a bogus option argument to pack-objects.
This is a simple and reliable way to get pack-objects to fail, but it
has one downside: pack-objects will die before reading its stdin, which
means the caller repack may racily get SIGPIPE writing to it.

For the purposes of this test, that's OK. We are checking whether repack
cleans up already-created .tmp files, and it will do so whether it exits
or dies by signal (because the tempfile API hooks both).

But we have to tell test_must_fail that either outcome is OK, or it
complains about the signal. Arguably this is a workaround (compared to
fixing repack), as repack dying to SIGPIPE means that it loses the
opportunity to give a more detailed message. But we don't actually write
such a message anyway; we rely on pack-objects to have written something
useful to stderr, and it does. In either case (signal or exit), that is
the main thing the user will see.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7700-repack.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index edcda849b9..9164acbe02 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -433,7 +433,7 @@ test_expect_success TTY '--quiet disables progress' '
 '
 
 test_expect_success 'clean up .tmp-* packs on error' '
-	test_must_fail git \
+	test_must_fail ok=sigpipe git \
 		-c repack.cruftwindow=bogus \
 		repack -ad --cruft &&
 	find $objdir/pack -name '.tmp-*' >tmpfiles &&
-- 
2.38.1.500.ge50734af7a

