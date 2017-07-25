Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDABA1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 17:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbdGYRwF (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 13:52:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:48572 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750980AbdGYRwE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 13:52:04 -0400
Received: (qmail 4226 invoked by uid 109); 25 Jul 2017 17:52:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jul 2017 17:52:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19681 invoked by uid 111); 25 Jul 2017 17:52:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jul 2017 13:52:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Jul 2017 13:52:02 -0400
Date:   Tue, 25 Jul 2017 13:52:02 -0400
From:   Jeff King <peff@peff.net>
To:     Raman Gupta <rocketraman@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Git rerere and non-conflicting changes during conflict
 resolution
Message-ID: <20170725175202.ar4ykqoadbihwb2w@sigill.intra.peff.net>
References: <17c46229-3b64-34f1-30fa-d40b77e1c054@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17c46229-3b64-34f1-30fa-d40b77e1c054@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 11:09:55AM -0400, Raman Gupta wrote:

> I had an interesting situation today: resolving a merge conflict
> required modification in other files that were not themselves conflicting.
> 
> I just realized that rerere does not remember any changes to these
> additional files -- only changes to the conflicting files. This makes
> the end result of rerere obviously incorrect in this situation.
> 
> So my questions are:
> 
> 1) Is this a known limitation or is there a reason rerere works in
> this manner?

Yes, it's known. Rerere works by storing a mapping of conflicted hunks
to their resolutions. If there's no conflicted hunk, I'm not sure how
we'd decide what to feed into the mapping to see if there is some
content to be replaced.

That said, I'm far from an expert on how rerere works. Junio might have
ideas on how we could handle this better. But I do note that for
repeated integration runs (like we do for topics in git.git, as they get
merged to "pu", then "next", then "master"), he keeps non-conflict
fixups in a separate commit which gets squashed into the merge
automatically. See

  https://github.com/git/git/blob/todo/Reintegrate#L185-L191

> 1b) If it is a limitation/bug, what would be needed to fix it? With
> some guidance, I might be able to submit a patch...

As far as I know, something like the Reintegrate script above is the
state of the art. IMHO it would be useful if something similar were
integrated into rerere, but I'm not sure exactly how it would know when
to trigger.

> 2) In the meantime, is there a way I can identify these cases, without
> which I cannot really trust rerere is doing the right thing?

I do think it would be useful if rerere could look at a merge result and
say "OK, I've recorded these bits, but there are other lines that are
not part of either parent and which are not part of a conflict". That
gives you a warning that such lines need to be part of a fixup (rather
than you being surprised when you redo the merge later and have to
rework the fixup).

But I don't think even then you can ever trust rerere fully.
Fundamentally you're applying some changes from one merge into another
context. There may be new sites that also need fixing up, and the tool
has no way to know. So you should treat a rerere-helped merge as any
other merge: assume it's a good starting point but use other tools (like
the compiler or automated tests) to confirm that the result is sensible.

-Peff
