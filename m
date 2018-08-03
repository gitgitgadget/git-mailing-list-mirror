Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63CE1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 13:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbeHCO5O (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 10:57:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:41648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728524AbeHCO5O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 10:57:14 -0400
Received: (qmail 1980 invoked by uid 109); 3 Aug 2018 13:01:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Aug 2018 13:01:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1328 invoked by uid 111); 3 Aug 2018 13:01:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 Aug 2018 09:01:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2018 09:00:58 -0400
Date:   Fri, 3 Aug 2018 09:00:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Liam Decker <ldecker@indeed.com>, git@vger.kernel.org
Subject: Re: Question regarding quarantine environments
Message-ID: <20180803130058.GA4671@sigill.intra.peff.net>
References: <CALcD6sYfcaftciYU+2AHpzabyOS9ohRcZoE6LDuMyht+dxktHw@mail.gmail.com>
 <20180802183924.GB23690@sigill.intra.peff.net>
 <878t5ntxqs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t5ntxqs.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 03, 2018 at 02:56:11PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Any Git commands you run should therefore find objects from either
> > location, but any writes would go to the quarantine (most notably, Git's
> > own index-pack/unpack-objects processes, which is the point of the
> > quarantine in the first place).
> 
> To add to this, one interesting thing that you can do with hooks because
> of this quarantine is to answer certain questions about the push that
> were prohibitively expensive before it existed, but there's no explicit
> documentation for this.
> 
> E.g. for a hook that wants to ban big blobs in the repo, but wants to
> allow all existing blobs (you don't want to block e.g. a revert of a
> commit that removed it from the checkout), you can juggle these two env
> variables and hide the "main" object dir from the hook for some
> operations, so e.g. if a blob lookup succeeds in the alternate
> quarantine dir, but not the main object dir, you know it's new.

I'd be a bit careful with that, though, as the definition of "new" is
vague there.

For example, completing a thin pack may mean that the receiver creates a
copy of a base object found in the main repo. That object isn't new as
part of the push, nor was it even sent on the wire, but it will appear
in the quarantine directory. But only sometimes, depending on whether we
kept the sender's pack or exploded it to loose objects.

-Peff
