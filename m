Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACCFC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D6520674
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBDT5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:57:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:52374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727423AbgBDT5K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 14:57:10 -0500
Received: (qmail 11088 invoked by uid 109); 4 Feb 2020 19:57:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Feb 2020 19:57:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2373 invoked by uid 111); 4 Feb 2020 20:05:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Feb 2020 15:05:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Feb 2020 14:57:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Mike McGranahan <mike@mcgwiz.com>, git@vger.kernel.org
Subject: Re: Patch text in git-add patch mode lacks whitespace highlighting
Message-ID: <20200204195709.GC12705@coredump.intra.peff.net>
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001311304140.46@tvgsbejvaqbjf.bet>
 <20200201110203.GA1864964@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2002012205520.46@tvgsbejvaqbjf.bet>
 <20200203085456.GD2164@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2002031320180.46@tvgsbejvaqbjf.bet>
 <20200203145155.GA272077@coredump.intra.peff.net>
 <xmqqlfpi8au6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfpi8au6.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 10:29:53AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If just the human-readable one, then many options that change the line
> > count would be problems: diff.context, diff.interhunkcontext,
> > diff.orderfile, etc.
> >
> > If both, then some options would be problematic for applying. Just
> > looking over the list, these jump out at me:
> >
> >   - color.diff=always would obviously be an issue (though TBH I think
> >     anybody doing that is inviting a lot of breakages anyway)
> >
> >   - diff.external would be a problem if it kicked in, though I think it
> >     would require --ext-diff to actually do anything
> >
> >   - diff.submodule would generate diffs that can't be applied
> 
> What can truly help "git add -p" might be a new output mode from
> "git diff", perhaps, in which instead of writing a stream of text
> (with color codes intermixed), the output machinery makes a call to
> API-user supplied callbacks to report ("type of output line", "the
> payload", "list of coloring information") tuples for each line, so
> that the API-user can synthesize _both_ versions it currently uses
> with a single invocation of "diff"?  There may be tons of "output
> line" types, like the diff header, hunk header, context, removed,
> added, etc., and depending on the type, the form the payload takes
> may be different (e.g. a context line may be just a plain text, a
> hunk header line may be a five-tuple (pre- and post-context line
> numbers and line countsm plus the function-header line text).

I agree that would be a nice thing to have, and would let us avoid
running the same diff twice. But I don't think it solves the problem you
quoted above, unless all of the features are represented in some
machine-readable form. E.g., what would diff.submodule do in such an
output, and how would "add -p" decide to show it?

> As long as the call the API-user makes to the diff machinery grabs
> everything that is needed for both human and machine consumption in
> a single call, there is no risk of getting confused by two sets of
> inconsistent patch data.

Yes, but we still can't say "use machine-readable output, and turn on
all the config bells and whistles" because we'd have to know how to
handle every bell and whistle.

-Peff
