Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73F3C433E2
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 15:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBAF42067D
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 15:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGQP1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:27:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:60224 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgGQP1p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 11:27:45 -0400
Received: (qmail 30939 invoked by uid 109); 17 Jul 2020 15:27:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jul 2020 15:27:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4053 invoked by uid 111); 17 Jul 2020 15:27:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jul 2020 11:27:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Jul 2020 11:27:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with
 extensions
Message-ID: <20200717152744.GB1224964@coredump.intra.peff.net>
References: <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <20200716062054.GA3242764@google.com>
 <20200716062818.GC3242764@google.com>
 <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
 <20200716110007.GD376357@coredump.intra.peff.net>
 <xmqqd04vigpy.fsf@gitster.c.googlers.com>
 <20200716223719.GA899@gmail.com>
 <xmqqh7u7f29h.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7u7f29h.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 04:50:34PM -0700, Junio C Hamano wrote:

> > - improving the behavior when an extension not supported in v0 is
> >   encountered in a v0 repository.  For extensions that are supported
> >   in v1 and not v0, we should presumably error out so the user can
> >   repair the repository, and we can put the "noop" extension in that
> >   category for the sake of easy testing.  We can also include a check
> >   in "git fsck" for repositories that request the undefined behavior
> >   of v0 repositories with non-v0 extensions, for faster diagnosis.
> >
> >   What about unrecognized extensions that are potentially extensions
> >   yet to be defined?  Should these be silently ignored to match the
> >   historical behavior, or should we error out even in repository
> >   format v0?  I lean toward the latter; we'll need to be cautious,
> >   though, e.g. by making this a separate patch so we can easily tweak
> >   it if this ends up being disruptive in some unanticipated way.
> 
> I disagree with your first paragraph.  Those that weren't honored by
> mistake back in v0 days, in addition to those that aren't known to us
> even now, should just be silently ignored, not causing an error.

That's very much the opposite of my patch.  As we add new extensions,
those "unknowns" will start to die().

I remain unconvinced that there are a bunch of unknown extension.*
config options hanging around in the wild, but maybe I'm being naive.
It seems to me more likely that users will be helped by warning about
extensions that _should_ have had v1 set than that they will be harmed
because they put random crap in their extensions.* config. But maybe you
know of a specific example?

Anyway, if we move to "v1" as the default for "git init" anyway, then
the number of people being helped would become much smaller.

> > My preference would be to move forward in 2.28 with the first two
> > patches in that topic branch (i.e., *not* the third yet), since they
> > don't produce any user facing behavior that would create danger for
> > users or clash with this plan.
> 
> Yup, I agree.  I'd give another name to the third commit and then
> rewind jn/v0-with-extensions-fix by one to prevent mistakes from
> happening.  Thanks.

OK. I was confused to see it still at the tip in the latest What's
Cooking, but I think we're just crossing emails. :)

-Peff
