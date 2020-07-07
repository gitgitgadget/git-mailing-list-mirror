Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B415C433E1
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 21:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7772320663
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 21:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgGGVwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:52:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:51768 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgGGVwI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 17:52:08 -0400
Received: (qmail 23499 invoked by uid 109); 7 Jul 2020 21:52:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2020 21:52:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32101 invoked by uid 111); 7 Jul 2020 21:52:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2020 17:52:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jul 2020 17:52:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Make some commit hashes in tests reproducible
Message-ID: <20200707215206.GA2300296@coredump.intra.peff.net>
References: <pull.816.git.git.1594149804313.gitgitgadget@gmail.com>
 <xmqqfta33y0m.fsf@gitster.c.googlers.com>
 <20200707205418.GB1396940@coredump.intra.peff.net>
 <xmqq1rln3t4y.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rln3t4y.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 07, 2020 at 02:35:57PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That's using the same start point as test_tick, though really it could
> > be anything. I've intentionally _not_ called test_tick at the beginning
> > of each script, because that would throw off all of the scripts that do
> > use it by one tick (whereas the first test_tick will overwrite these
> > values).
> 
> Yup, I think that is a sensible approach.

OK, I'll see if I can polish it into a series.

> Another thing we could do is under DEVELOPER=YesPlease we can set
> timestamps you just added here to some random time.
> 
> The ones that do care about reproducibility guarantee by using
> test_tick would not be affected, and those that were happy with the
> current time should be happy with such a random timestamp.  Or we
> could just drop what this patch does only under DEVELOPER=YesPlease
> which amounts to be the same as setting random time.

That should be easy to do. I wonder if it's really worth the trouble to
maintain two parallel worlds. I.e., one of the goals would be to stop
worrying about this non-determinism. If we keep it as a requirement,
then we might as well do so all the time (and making it random under
DEVELOPER is effectively keeping it as a requirement, since we expect
all tests to pass under that flag).

I'm also skeptical how often we use system times anyway, because _any_
use of test_commit or test_tick in a script is enough to make all of the
subsequent commands deterministic. I'd be more inclined to let a
particular script say "I'm interested in random times". But then, I'd
think such a script would be better written to trigger its interesting
cases with a well-crafted set of deterministic times.

-Peff
