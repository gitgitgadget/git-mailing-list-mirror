Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03EB01FC44
	for <e@80x24.org>; Tue,  9 May 2017 02:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbdEICei (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:34:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:47790 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbdEICei (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:34:38 -0400
Received: (qmail 10333 invoked by uid 109); 9 May 2017 02:34:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 02:34:37 +0000
Received: (qmail 18599 invoked by uid 111); 9 May 2017 02:35:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 22:35:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 22:34:34 -0400
Date:   Mon, 8 May 2017 22:34:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeff Smith <whydoubt@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 02/10] Move textconv_object to be with other textconv
 methods
Message-ID: <20170509023434.hxhmvemmrymgu5ij@sigill.intra.peff.net>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170505052729.7576-3-whydoubt@gmail.com>
 <xmqqwp9v6vw2.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZ4k7qVKE7OpSEELorwSx5hUgJksLAeNgVGs0w1JC_Ffg@mail.gmail.com>
 <xmqq1ss0cg8t.fsf@gitster.mtv.corp.google.com>
 <20170508215525.gcyzzntqvm52mqcc@sigill.intra.peff.net>
 <xmqqziem6bq8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqziem6bq8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2017 at 10:49:19AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The specific helpers have less visibility, which is good. The public
> > functions a() and b() were already public, so no change. But now the
> > common helper is public, too, even though nobody except a() and b() care
> > about it.
> >
> > So it's a tradeoff. And the important question is: is the bleed-over
> > between a() and b() worse than the common bits being made public?
> 
> At this point you are saying the same thing as I said ;-) 

Maybe, but I think my hunch is that the answer to the question is
different than yours. ;)

> I haven't touched diff.c for a while, but my impression was that it
> was already a smallest logical unit, especially since some bits like
> diff-lib.c (the interface for the front-end programs to drive the
> machinery via the three standard pairs of sources) and ws.c (diff
> subsystem to deal with whitespace errors) are already split out (and
> needless to say, the diffcore transformations are all in their own
> separate files).  Over time people may have added what does not
> belong there merely for convenience, which may want to get ejected,
> but I do not think of many instances of them offhand.

Just skimming the file, I suspect diff_filespec could be broken out into
a semi-public interface (many of its functions already are public
anyway), probably dirstat could be broken out, and possibly other
specific formats could be broken into their own files. But I didn't
spend much time on it.

> It appears that the textconv related helpers (which was where this
> discussion thread started from) could be first restructured so that
> they do not depend on diff_filespec and turned into a more generic
> "I have this path and a blob object name, please run textconv to it
> and..." interface and then moved out of the file into its own
> textconv.[ch].  It does not need access to quite a few fields in
> diff_filespec structure (e.g.  it shouldn't care what filemode the
> thing has).  The diff machinery wants the result in a contiguous
> piece of memory and that could be a good starting point, but I said
> "and..." above because I am not sure if it is the best generic
> thing the restructured interface can do to the result.

I think some of the users of textconv do have to go through some
contortions to turn their buffers into diff_filespecs (e.g., blame and
grep), and it would be nice to fix that. But the diff-driver lookup and
caching is tied to the diff_filespec, too (which is perhaps a sign of a
misfeature in the first place, as the "diff" attribute is being used for
things like "grep" and "cat-file"). So we'd have to resolve that.

So I think there is room for improvement there, but I'm also not sure it
is worth the trouble. AFAIK neither textconv nor the general length of
diff.c is holding up anybody's work or even making it significantly more
difficult. If people have spare cycles, they are free to work on
anything, of course. But I can think of code that is probably in more
dire need of refactoring. :)

-Peff
