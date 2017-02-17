Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70B19201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964960AbdBQXyB (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:54:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:57693 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964941AbdBQXyA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:54:00 -0500
Received: (qmail 32744 invoked by uid 109); 17 Feb 2017 23:53:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 23:53:27 +0000
Received: (qmail 9049 invoked by uid 111); 17 Feb 2017 23:53:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 18:53:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 18:53:25 -0500
Date:   Fri, 17 Feb 2017 18:53:25 -0500
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rename_ref: replace empty deletion message in HEAD's
 log
Message-ID: <20170217235324.n3jabck23bvd4cs2@sigill.intra.peff.net>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
 <20170217035800.13214-1-kyle@kyleam.com>
 <20170217035800.13214-4-kyle@kyleam.com>
 <20170217083112.vn7m4udsopmlvnn5@sigill.intra.peff.net>
 <xmqqk28ou2o1.fsf@gitster.mtv.corp.google.com>
 <871suwqtar.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871suwqtar.fsf@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 06:41:32PM -0500, Kyle Meyer wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> [...]
> 
> > Do we even want these "internal" delete_ref() invocations to be
> > logged in HEAD's reflog?  I understand that this is inside the
> > implementation of renaming an old ref to a new ref, and reflog
> > message given to delete_ref() would matter only if the HEAD happens
> > to be pointing at old ref---but then HEAD will be repointed to the
> > new ref by somebody else [*1*] that called this function to rename
> > old to new and it _will_ log it.
> 
> I know the discussion has developed further, but just a note that I
> think the last statement is inaccurate: currently, a rename will not be
> recorded in HEAD's log.  "git branch -m" will show a renaming event in
> the new branch's log, but the only trace of the event in HEAD's log is
> the deletion entry with an empty message.

Right. I assumed Junio was talking about the hypothetical behavior we'd
want.

Your response did make me think of one other option: if we updated HEAD
_before_ writing the new ref, then it would automatically get the
"create" half of the rename. IOW, if the rename process were:

  1. delete old; this writes a reflog to HEAD, per the magic
     HEAD-detection in commit_ref_update().

  2. update HEAD to point to new

  3. re-create new; this uses the same magic to write a HEAD reflog.

That's probably a crazy path to go, though. Right now steps (1) and (3)
happen in a low-level function, and step (2) happens outside of it
completely. Arguably it would be good to change that, but I think we
want to think of (1) and (3) as an atomic operation. Putting more things
which might fail between them is a bad idea.

So I think your existing patches (modulo the review comments), plus the
"something like this" that I sent on top are probably a better end
state.

-Peff
