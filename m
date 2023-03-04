Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E04C64EC4
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 10:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCDKWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 05:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCDKWn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 05:22:43 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C300210256
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 02:22:41 -0800 (PST)
Received: (qmail 16704 invoked by uid 109); 4 Mar 2023 10:22:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Mar 2023 10:22:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3683 invoked by uid 111); 4 Mar 2023 10:22:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Mar 2023 05:22:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Mar 2023 05:22:40 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: [PATCH 0/5] handling "-" as stdin/stdout in git bundle
Message-ID: <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
 <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
 <xmqqv8jhcvrq.fsf@gitster.g>
 <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
 <xmqqpm9pcu6t.fsf@gitster.g>
 <ZAKexHiit5vOmv7M@coredump.intra.peff.net>
 <ZAKi8MzGWk5PZUJk@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAKi8MzGWk5PZUJk@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2023 at 08:46:24PM -0500, Jeff King wrote:

> > I wasn't thinking of changing the behavior for input, but just focusing
> > the docs in the right spot (the "create" option), like:
> 
> Oh, hmph. I didn't realize that both my patch and yours are touching a
> shared options-parser that affects both reading and writing. So the
> patch by itself is fixing "git bundle create -" but breaking "git bundle
> verify -". We either need to teach the reading side to handle "-", or we
> have to teach parse_options_cmd_bundle() to handle the two cases
> differently.

So here's a potential series. It does teach "-" to the reading side.
Which is technically a behavior change, but one that I hope people will
find pretty reasonable.

The patches are:

  [1/5]: bundle: let "-" mean stdin for reading operations

    Does what it says. I did it as a preparatory patch before yours, so
    that there's never a state where we are treating "-" as special for
    prefixing but it doesn't actually work yet. :-/

  [2/5]: bundle: document handling of "-" as stdin

    One half of the doc-fixes discussed earlier, but of course covering
    all operations now.

  [3/5]: bundle: don't blindly apply prefix_filename() to "-"

    Your patch, but rebased and with the comment above fix_filename()
    dropped (since it's handled below). I saw you prepared yours on
    "maint". I did this one on "master", because some of the
    leak-handling in the other patches needs it. Since this has been
    broken for ages, and since "master" is about to become "maint" when
    2.40 release in a few days, it seemed simpler to just wait. But if
    we really want to, I think we could reorder and split it into two
    topics.

  [4/5]: parse-options: consistently allocate memory in fix_filename()

    Leak-fixes that also get us ready for using your new helper. :)

  [5/5]: parse-options: use prefix_filename_except_for_dash() helper

    And using the new helper. This could arguably be squashed into 4,
    but I wasn't sure at the outset what order to do it in (another
    option is putting 4 earlier, and then just converting it over in
    your patch 3).

 Documentation/git-bundle.txt        |  8 +++++---
 abspath.c                           |  7 +++++++
 builtin/archive.c                   |  3 ++-
 builtin/bundle.c                    | 28 +++++++++++++++++++++++-----
 builtin/checkout.c                  |  3 ++-
 builtin/reset.c                     |  4 +++-
 builtin/tag.c                       |  4 +++-
 cache.h                             |  3 +++
 parse-options.c                     | 12 ++++++------
 t/helper/test-parse-pathspec-file.c |  3 ++-
 t/t6020-bundle-misc.sh              | 26 ++++++++++++++++++++++++++
 11 files changed, 82 insertions(+), 19 deletions(-)

-Peff
