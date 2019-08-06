Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AA5B1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbfHFRdv (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:33:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:35760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387421AbfHFRdv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:33:51 -0400
Received: (qmail 20331 invoked by uid 109); 6 Aug 2019 17:33:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 17:33:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4397 invoked by uid 111); 6 Aug 2019 17:36:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 13:36:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 13:33:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] --end-of-options marker
Message-ID: <20190806173349.GA4961@sigill.intra.peff.net>
References: <20190806143829.GA515@sigill.intra.peff.net>
 <xmqqa7cml0s9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7cml0s9.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 09:24:38AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It's hard for scripted uses of rev-list, etc, to avoid option injection
> > from untrusted arguments, because revision arguments must come before
> > any "--" separator. I.e.:
> >
> >   git rev-list "$revision" -- "$path"
> >
> > might mistake "$revision" for an option (with rev-list, that would make
> > it an error, but something like git-log would default to HEAD).
> 
> Just to make sure I understand what I just read, let me paraphrase.
> We would want to accept
> 
> 	git rev-list --max-parents=4 \
> 		--end-of-options \
> 		--count -- docs/
> 
> so that '--count' would go thru the usual "as we have -- later, it
> must be a rev and we do not even disambiguate.  What does get_sha1()
> say it is?" and "docs/" would be taken as a pathspec.

Yes, that's how I'd expect that to be parsed.

> "git rev-list --max-parents=4 --count -- docs/" would have treated
> "--count" as an option and would error out due to lack of any
> starting revision.

Right. Though some options may have an impact even before rev-list would
complain. For instance --output=foo (which is actually a diff option,
but revision.c handles both) opens and truncates "foo" before rev-list
realizes it doesn't have enough options.

> On the other hand, "git log --count -- docs/" would take "--count"
> as an option, but does not complain about lack of any revs.  It just
> starts digging from HEAD and ends up ignoring the "--count" branch

Correct.

> (or is this feature meant to support tags?  As far as I recall, we
> do not allow branch names that begin with a dash).

We do forbid them via "git branch", but they are not forbidden by
check-ref-format. So:

  git update-ref refs/heads/-foo $oid

works fine, and receive-pack is happy to accept it as a push.  I think
it might be reasonable to forbid that, but we'd have to accept potential
fallouts.

That said, for the purposes of option injection, it actually doesn't
matter whether the ref exists or not (or if it's even an allowed name).
The problem is that the caller is feeding what it _thinks_ will be
interpreted as a rev name, but it isn't. So yes, most of the time
treating "--count" as a rev is nonsense and will fail. But the important
thing is not so much that we do the right thing when you have a branch
(or tag) with a funny name, but that we _don't_ do something dangerous
or unexpected.

-Peff
