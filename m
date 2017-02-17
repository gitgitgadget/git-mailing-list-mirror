Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4738120136
	for <e@80x24.org>; Fri, 17 Feb 2017 19:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934637AbdBQTny (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 14:43:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:57342 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932674AbdBQTnx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 14:43:53 -0500
Received: (qmail 16162 invoked by uid 109); 17 Feb 2017 19:43:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 19:43:52 +0000
Received: (qmail 5040 invoked by uid 111); 17 Feb 2017 19:43:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 14:43:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 14:43:50 -0500
Date:   Fri, 17 Feb 2017 14:43:50 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rename_ref: replace empty deletion message in HEAD's
 log
Message-ID: <20170217194350.prhp5joh33cbvwsd@sigill.intra.peff.net>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
 <20170217035800.13214-1-kyle@kyleam.com>
 <20170217035800.13214-4-kyle@kyleam.com>
 <20170217083112.vn7m4udsopmlvnn5@sigill.intra.peff.net>
 <xmqqk28ou2o1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk28ou2o1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 09:50:54AM -0800, Junio C Hamano wrote:

> > I see we actually already have a "logmsg" parameter. It already says
> > "Branch: renamed %s to %s". Could we just reuse that? I know that this
> > step is technically just the deletion, but I think it more accurately
> > describes the whole operation that the deletion is part of.
> 
> True, but stepping back a bit,...
> 
> Do we even want these "internal" delete_ref() invocations to be
> logged in HEAD's reflog?  I understand that this is inside the
> implementation of renaming an old ref to a new ref, and reflog
> message given to delete_ref() would matter only if the HEAD happens
> to be pointing at old ref---but then HEAD will be repointed to the
> new ref by somebody else [*1*] that called this function to rename
> old to new and it _will_ log it.  So I am not sure if it is a good
> thing to describe the deletion more readably with a message (which
> is what this patch does) in the first place.  If we can just say
> "don't log this deletion event in HEAD's reflog", wouldn't that be
> more desirable?

Yes. I think the options are basically (in order of decreasing
preference in my opinion):

  1. Log a rename entry (same sha1, but note the rename in the free-form
     text).

  2. Log a delete (sha1 goes to null) followed by a creation (from null
     back to the original sha1).

  3. Log nothing at all for HEAD.

This does half of (2). If we do the second half, then I'd prefer it to
(3). But if we can do (1), that is better still (IMHO).

> *1* Is the reason why the code in files_rename_ref() we are looking
>     at does not adjust HEAD to point at the new ref is because it is
>     just handing one ref-store and obviouvious to symrefs in other
>     backends?

I'm actually confused about which bit of code is updating HEAD. I do not
see it either in files_rename_ref() or in the caller. Yet it clearly
happens. But that is the code that would know enough to do (1) or the
second half of (2) above.

-Peff
