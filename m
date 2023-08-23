Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28C9C3DA6F
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 19:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbjHWTAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbjHWTAa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 15:00:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51883E6A
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 12:00:28 -0700 (PDT)
Received: (qmail 2971 invoked by uid 109); 23 Aug 2023 19:00:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Aug 2023 19:00:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10940 invoked by uid 111); 23 Aug 2023 19:00:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Aug 2023 15:00:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Aug 2023 15:00:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 7/7] diff: drop useless "status" parameter from
 diff_result_code()
Message-ID: <20230823190022.GA2355007@coredump.intra.peff.net>
References: <20230821201358.GA2663749@coredump.intra.peff.net>
 <20230821202046.GG1798590@coredump.intra.peff.net>
 <xmqq350air6e.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq350air6e.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2023 at 04:38:17PM -0700, Junio C Hamano wrote:

> > This function also takes a "status" parameter, which seems at first
> > glance that it could be used to propagate an error encountered when
> > computing the diff. But it doesn't work that way:
> >
> >   - negative values are passed through as-is, but are not appropriate as
> >     program exit codes
> >
> >   - when --exit-code or --check is in effect, we _ignore_ the passed-in
> >     status completely. So a failed diff which did not have a chance to
> >     set opts.found_changes would erroneously report "success, no
> >     changes" instead of propagating the error.
> >
> > After recent cleanups, neither of these bugs is possible to trigger, as
> 
> Here "after recent cleanups" refers to the changes to make them
> die() upon seeing an error, instead of using it to call this
> function with non-zero in the status parameter?  At least, they were
> signaling errors correctly when --exit-code is not in use, but now
> all the callers are responsible for exiting with non-zero status to
> signal an error even when --exit-code is *not* used.

Sort of. Prior to this series, callers were responsible for ferrying
exit codes to diff_result_code(), which mis-handled them (a little for
the path without --exit-code, and badly with it). Now they are
responsible for handling the errors themselves. I'd say that is not much
more work than passing them along, and provides better outcomes (they
can produce more useful error messages, or die() as appropriate).

But what I really meant with "after recent cleanups" was just that
nobody is even bothering to pass anything but 0 to diff_result_code().
Which was already true before the series for every code path except the
few index/argument parsing paths in builtin/diff.c, and after the
cleanups is entirely true.

-Peff
