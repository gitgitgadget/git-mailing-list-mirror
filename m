Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FD91F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 12:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbeKLWi5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:38:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:35402 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727109AbeKLWi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:38:56 -0500
Received: (qmail 24573 invoked by uid 109); 12 Nov 2018 12:45:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 12:45:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10313 invoked by uid 111); 12 Nov 2018 12:45:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 07:45:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 07:45:47 -0500
Date:   Mon, 12 Nov 2018 07:45:47 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/10] fast-export: when using paths, avoid corrupt
 stream with non-existent mark
Message-ID: <20181112124547.GG3956@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-7-newren@gmail.com>
 <20181111065338.GF30850@sigill.intra.peff.net>
 <CABPp-BGF8C5vhyVbAwpmXeii452fBgtvL4dPRLWdOPxLiCYR0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGF8C5vhyVbAwpmXeii452fBgtvL4dPRLWdOPxLiCYR0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 12:01:43AM -0800, Elijah Newren wrote:

> > It does seem funny that the behavior for the earlier case (bounded
> > commits) and this case (skipping some commits) are different. Would you
> > ever want to keep walking backwards to find an ancestor in the earlier
> > case? Or vice versa, would you ever want to simply delete a tag in a
> > case like this one?
> >
> > I'm not sure sure, but I suspect you may have thought about it a lot
> > harder than I have. :)
> 
> I'm not sure why you thought the behavior for the two cases was
> different?  For both patches, my testcases used path limiting; it was
> you who suggested employing a negative revision to bound the commits.

Sorry, I think I just got confused. I was thinking about the
documentation fixup you started with, which did regard bounded commits.
But that's not relevant here.

> Anyway, for both patches assuming you haven't bounded the commits, you
> can attempt to keep walking backwards to find an earlier ancestor, but
> the fundamental fact is you aren't guaranteed that you can find one
> (i.e. some tag or branch points to a commit that didn't modify any of
> the specified paths, and nor did any of its ancestors back to any root
> commits).  I hit that case lots of times.  If the user explicitly
> requested a tag or branch for export (and requested tag rewriting),
> and limited to certain paths that had never existed in the repository
> as of the time of the tag or branch, then you hit the cases these
> patches worry about.  Patch 4 was about (annotated and signed) tags,
> this patch is about unannotated tags and branches and other refs.

OK, that makes more sense.

So I guess my question is: in patch 4, why do we not walk back to find
an appropriate ancestor pointed to by the signed tag object, as we do
here for the unannotated case?

And I think the answer is: we already do that. It's just that the
unannotated case never learned the same trick. So basically it's:

  1. rewriting annotated tags to ancestors is already known on "master"

  2. patch 4 further teaches it to drop a tag when that fails

  3. patch 6 teaches both (1) and (2) to the unannotated code path,
     which knew neither

Is that right?

> > This hunk makes sense.
> 
> Cool, this was the entirety of the code...so does this mean that the
> code makes more sense than my commit message summary did?  ...and
> perhaps that my attempts to answer your questions in this email
> weren't necessary anymore?

No, it only made sense that the hunk implemented what you claimed in the
commit message. ;)

I think your responses did help me understand that what the commit
message is claiming is a good thing.

-Peff
