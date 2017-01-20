Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DC9720756
	for <e@80x24.org>; Fri, 20 Jan 2017 22:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbdATWBi (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 17:01:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:42357 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751146AbdATWBR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 17:01:17 -0500
Received: (qmail 25552 invoked by uid 109); 20 Jan 2017 22:01:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 22:01:16 +0000
Received: (qmail 2735 invoked by uid 111); 20 Jan 2017 22:02:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 17:02:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jan 2017 17:01:14 -0500
Date:   Fri, 20 Jan 2017 17:01:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] Disallow commands from within unpopulated submodules.
Message-ID: <20170120220114.fkf42kdcsmnqy6zo@sigill.intra.peff.net>
References: <20170119193023.26837-1-sbeller@google.com>
 <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
 <CAGZ79kaJQefSDkV-LKxRCTtSepsNsX7U+AZqy3Z_YCd1xsmTxQ@mail.gmail.com>
 <20170120194224.vikzovupwqx53x2c@sigill.intra.peff.net>
 <CAGZ79kYKY=hDVjUx7AkeWZ=3V8Fy2hqQMFPZcoxT4NvXTFgG=Q@mail.gmail.com>
 <20170120200041.hefg44stddqe344z@sigill.intra.peff.net>
 <xmqq37gdxvbx.fsf@gitster.mtv.corp.google.com>
 <xmqqy3y5wg0l.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3y5wg0l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 01:58:02PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >>> And in my current understanding of submodules the check in
> >>> .gitmodules ought to be enough, too.
> >>
> >> Yeah, that probably makes sense. You can have a gitlink without a
> >> .gitmodules file, but I don't quite know what that would mean in terms
> >> of submodules (I guess it's not a submodule but "something else").
> >
> > That may be a lot better than reading the index unconditionally, but
> > I'd rather not to see "git rev-parse" read ".gitmodules" at all.  It
> > would discourage scripted use of Git for no good reason.
> 
> Thinking about this more, I suspect that
> 
> 	cd sub && git anything
> 
> when the index of the top-level thinks "sub" must be a submodule and
> the user is not interested in "sub" (hence it hasn't gone through
> "git submodule init" or "update") should get the same error as you
> would get if you did
> 
> 	cd /var/tmp/ && git anything
> 
> when none of /, /var, /var/tmp/ is controlled by any Git repository.
> I.e. "fatal: Not a git repository".

Not sure if our emails just crossed, but yes, I agree completely.

> Perhaps we can update two things and make it cheap.
> 
>  - checking out the top-level working tree without populating the
>    working tree of a submodule learns to do a bit more than just
>    creating an empty directory.  Instead, it creates the third kind
>    of ".git" (we currently support two kinds of ".git", one that is
>    a repository itself, and another that is points at a repository),
>    that tells us that there is not (yet) a repository there.
> 
>  - the "discovering the root of the working tree" logic learns to
>    notice the third kind of ".git" and stop with "Not a git
>    repository".

Yeah, I thought about suggesting something like that earlier. It's
slightly more efficient than the "find the root and then complain" thing
Stefan and I were talking about, but I'd worry it comes with weird
corner cases. E.g., are there tools (or other parts of git) that care
about it literally being an empty directory? E.g., would parts of
"checkout" need to know that it's OK to blow it away?
