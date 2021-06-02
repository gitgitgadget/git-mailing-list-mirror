Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A1CC47092
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 19:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E1E613EE
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 19:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFBTvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 15:51:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:44362 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFBTvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 15:51:17 -0400
Received: (qmail 2048 invoked by uid 109); 2 Jun 2021 19:49:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Jun 2021 19:49:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20493 invoked by uid 111); 2 Jun 2021 19:49:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Jun 2021 15:49:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Jun 2021 15:49:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
Message-ID: <YLfgy94sbmStC0mR@coredump.intra.peff.net>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
 <YLfc2+Te7Y3UY+Sm@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLfc2+Te7Y3UY+Sm@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 03:32:43PM -0400, Taylor Blau wrote:

> On Wed, Jun 02, 2021 at 01:52:44PM -0400, Randall S. Becker wrote:
> > I'm happy to help figure this out but need some direction. I don't
> > know the pack-object code.
> 
> Is the failure consistent, i.e., that it occurs every time you run the
> test? Not knowing much about your platform, it would be helpful to have
> a bisection showing where this breakage first occurs.

I suspect the symptom comes from the test Randall noted, but that the
actual issue has been there all along. The test uses "--progress"
explicitly, so we'll be sending SIGALRM (whereas most tests will disable
the progress mechanism because their output isn't going to a tty).

And so when he gets this error:

  fatal: fsync error on '.git/objects/pack/tmp_pack_NkPgqN': Interrupted system call

presumably we were in fsync() when the signal arrived, and unlike most
other platforms, the call needs to be restarted manually (even though we
set up the signal with SA_RESTART). I'm not sure if this violates POSIX
or not (I couldn't find a definitive answer to the set of interruptible
functions in the standard). But either way, the workaround is probably
something like:


  #ifdef FSYNC_NEEDS_RESTART
  #undef fsync /* we'd define to git_fsync() in a header file */
  static int git_fsync(int fd)
  {
	int ret;
	while ((ret = fsync(fd)) < 0 && errno == EINTR)
		; /* try again */
	return ret;
  }
  #endif

-Peff
