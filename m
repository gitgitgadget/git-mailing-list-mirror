Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22733C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 14:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D8C600CD
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 14:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhDWOIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 10:08:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:33382 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhDWOIY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 10:08:24 -0400
Received: (qmail 7321 invoked by uid 109); 23 Apr 2021 14:07:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 14:07:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8797 invoked by uid 111); 23 Apr 2021 14:07:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 10:07:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 10:07:47 -0400
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: reflog existence & reftable
Message-ID: <YILUs3T4oM78ZcW2@coredump.intra.peff.net>
References: <CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com>
 <87im4f3l62.fsf@evledraar.gmail.com>
 <xmqqim4fzier.fsf@gitster.g>
 <CAFQ2z_OGv3qNp9jaeuMij5gqv1MoOeb73zH9mOvikLs8dWvmmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_OGv3qNp9jaeuMij5gqv1MoOeb73zH9mOvikLs8dWvmmg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 11:20:52AM +0200, Han-Wen Nienhuys wrote:

> On Wed, Apr 21, 2021 at 6:55 PM Junio C Hamano <gitster@pobox.com> wrote:
> > If there isn't, then we could do either one of these two things.
> >
> >  (1) we could add "git reflog create <ref>" and the reftable can
> >      record the fact that "reflog exists for the ref, but no ref
> >      movement recorded yet".  Then the condition C can be checked.
> >
> >  (2) we could declare that there is no way to create an empty reflog
> >      supported across ref backends, and make the tests that rely on
> >      the "feature" conditional on REF_FILES prerequisite.
> >
> > I have no strong preference.  In the early days I found the ability
> > to limit which branches get logged convenient, so if reftable
> > backend can learn the similar trick, we would want to go route (1)
> > (the convenience largely came from the fact that there was no need
> > to add one configuration item per branch, so I do not think we would
> > want to bother with branch.<name>.reflog=bool configuration---that
> > won't be an easy-to-use substitute).  On the other hand, logs are
> > useful, and dormant logs are not costing anything (other than holding
> > onto stale objects we may no longer want), so it could be that it
> > may not be as convenient as it used to be to be able to turn logs on
> > only on selected refs, in which case approach (2) is fine.
> 
> Exactly, these are the two options I outlined in my original message.
> Both can be made to work. I slightly prefer 2 (empty reflogs don't
> exist, and make logging a global switch), because it is simpler to
> understand and document. The divergence with the files backend itself
> is extra complexity, though. Maybe we could deprecate the behavior and
> always write reflogs in the  files backend too.

Yeah, I like (2) as well. This "write a reflog if it always exists"
behavior has always seemed hacky, and like a leftover from early days
when we didn't just turn reflogs on by default. Given that it was
documented as "touch the file", I don't see any need to pretend that it
makes any sense at all in a reftables world.

I'd also be perfectly happy with removing the feature on the files
backend (and perhaps replacing it with a simple globbing config value,
in case anybody really wants to log only some refs). I find it hard to
imagine that anybody would really care, but it _is_ a
backwards-incompatible change. So possibly we should do the usual
deprecation thing, or wait for a major version bump. I dunno.

-Peff
