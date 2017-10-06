Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4F02036B
	for <e@80x24.org>; Fri,  6 Oct 2017 10:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbdJFKGw (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 06:06:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:35024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750915AbdJFKGw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 06:06:52 -0400
Received: (qmail 23776 invoked by uid 109); 6 Oct 2017 10:06:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 10:06:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4649 invoked by uid 111); 6 Oct 2017 10:06:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 06:06:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 06:06:49 -0400
Date:   Fri, 6 Oct 2017 06:06:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Krey <a.krey@gmx.de>, Git Users <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Regression in 'git branch -m'?
Message-ID: <20171006100649.rrbsw5dqf5gionzb@sigill.intra.peff.net>
References: <20171005172552.GA11497@inner.h.apk.li>
 <20171005183303.f77dpkhs5ztxlmyv@sigill.intra.peff.net>
 <20171006073913.yavdbdd3p3y5vjhd@sigill.intra.peff.net>
 <20171006083719.jap56jucgmlsuvuo@sigill.intra.peff.net>
 <xmqqzi94vcd7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzi94vcd7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 06:45:08PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So this patch fixes the problem:
> >
> > diff --git a/refs.c b/refs.c
> > index df075fcd06..2ba74720c8 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1435,7 +1435,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
> >  		if (refs_read_raw_ref(refs, refname,
> >  				      sha1, &sb_refname, &read_flags)) {
> >  			*flags |= read_flags;
> > -			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
> > +			if ((errno != ENOENT && errno != EISDIR) ||
> > +			    (resolve_flags & RESOLVE_REF_READING))
> 
> Ooo, good find--is_missing_file_error() strikes back...

Almost. That uses ENOTDIR, so that looking for "foo/bar" handles the
case where "foo" is a regular file.

But this is the opposite: we ask about "foo", but "foo/bar" exists. The
answer isn't "it's not there" in the general case, but "it's not the
thing you were expecting".

But in the case of refs, the filesystem is just a representation of the
abstract namespace. In asking for "refs/heads/foo", if "refs/heads/foo/bar"
exists, then answer is still "no, it's not a ref".

So EISDIR is needed for this case, though I suspect the opposite case
would need ENOTDIR. I actually wonder if the files-backend read_raw_ref
ought to be normalizing all of those to ENOENT.

> >  				return NULL;
> >  			hashclr(sha1);
> >  			if (*flags & REF_BAD_NAME)
> >
> > but seems to stimulate a test failure in t3308. I have a suspicion that
> > I've just uncovered another bug, but I'll dig in that. In the meantime I
> > wanted to post this update in case anybody else was looking into it.

That failure indeed turned out to be a red herring. So I think I'm
definitely onto the right track.

I want to play with the ENOTDIR case, and then I'll write up the whole
thing and send it in later today.

-Peff
