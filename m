Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DA6EE4993
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 18:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjHUSJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjHUSJq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 14:09:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B63C10E
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 11:09:45 -0700 (PDT)
Received: (qmail 17084 invoked by uid 109); 21 Aug 2023 18:09:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 18:09:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16160 invoked by uid 111); 21 Aug 2023 18:09:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 14:09:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 14:09:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: handle negative status in diff_result_code()
Message-ID: <20230821180943.GA2617193@coredump.intra.peff.net>
References: <CAHxTZ4AUxow1p7mNG0fuRtfhkaOu=Wpc7cYvM8wRaB80hPNf9Q@mail.gmail.com>
 <20230821003532.GA1113755@coredump.intra.peff.net>
 <xmqqlee4s82d.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlee4s82d.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2023 at 08:56:26AM -0700, Junio C Hamano wrote:

> >   - when --exit-code is in use, we ignore the incoming "status" variable
> >     entirely, and rely on the "has_changes" field. But if we saw an
> >     error, this field is almost certainly invalid, and means we'd likely
> >     just say "no changes", which is completely bogus. Likewise for
> >     the "--check" format.
> 
> Inspecting some callers of diff_result_code() further finds
> curiosities.  wt-status.c for example feeds results form
> run_diff_index() and run_diff_files() to the function, neither of
> which returns anything other than 0. They die or exit(128)
> themselves, though, so they are OK without this fix.
> builtin/describe.c is also in the same boat with its use of
> run_diff_index().
> 
> But of course the presense of such codepaths does not invalidate the
> fix in your patch.

Yeah, I admit I did not dig too much into the callers, as it was obvious
that any negative values were currently being mis-handled, and I knew at
least one caller passed them in (the one in builtin/diff.c).

And in fact I think that is the only problematic caller. Every other
caller either passes the result of run_diff_*(), which always return 0,
or just directly pass zero themselves!

It is only builtin/diff.c that calls its local builtin_diff_blobs(), and
so on, and those may return errors. So one direction is something like:

  - convert those calls to die() more directly; this has the potential
    side effect of producing a better message for the case that started
    this thread by calling usage(builtin_diff_usage) instead of a short
    error

  - drop the now-useless return codes from those functions, along with
    the already-useless ones from run_diff_files(), etc. At this point
    everybody will just be passing a blind "0" to diff_result_code()

  - drop the "status" parameter to diff_result_code()

That would make the code simpler. It does feel a bit like going in the
opposite direction of recent "pass errors up the stack rather than
dying" libification efforts. I think that's OK for the builtin_* helpers
in diff.c, which are just serving the diff porcelain. But things like
run_diff_files(), while pretty big operations, are something we might
call as small part of another operation (like git-describe).

We are not making things worse there, in the sense that their return
codes are currently meaningless. But removing the code entirely feels
like a step in the wrong direction. I dunno. Maybe we should retain
their return codes and have the callers die() if they fail (which would
currently be dead-code, but future-proof us for later cleanups).

-Peff
