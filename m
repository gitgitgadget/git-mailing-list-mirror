Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95F1C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F269610A7
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbhEFRAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 13:00:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:46578 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235881AbhEFRAC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 13:00:02 -0400
Received: (qmail 30370 invoked by uid 109); 6 May 2021 16:59:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 May 2021 16:59:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23446 invoked by uid 111); 6 May 2021 16:59:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 May 2021 12:59:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 May 2021 12:59:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] Makefile: don't re-define PERL_DEFINES
Message-ID: <YJQgVsKdb+gh5Sep@coredump.intra.peff.net>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
 <patch-1.4-ed2005a2fbf-20210505T121857Z-avarab@gmail.com>
 <YJKm0dnwHBwQuTi+@coredump.intra.peff.net>
 <87y2csv0qm.fsf@evledraar.gmail.com>
 <xmqq7dkcz20u.fsf@gitster.g>
 <87sg30usm9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sg30usm9.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 06, 2021 at 11:04:34AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Actually, strictly speaking there was *no* bug because assigning
> > three items with := made sure the previous recursively expanded one
> > to be ineffective.  In other words, there was a valid reason to use
> > ":=" there in the original version.
> 
> Yes, there wasn't any bug with the the eventual value being
> incorrect. I.e. both of these are equivalent in a Makefile:
> 
>     FOO = abc
>     FOO := def
>     FOO += ghi
> 
> And:
> 
>     FOO = abc
>     FOO = def
>     FOO += ghi
> 
> Both will yield "def ghi". They're just different in a case like:
>     
>     X = Y
>     FOO = abc
>     FOO := $(X)
>     X = Z
>     FOO += ghi
> 
> Where using := will echo "Y ghi", and using = will echo "Z ghi". As a
> practical matter the distinction doesn't matter in this case.

Yeah, I don't think the ":=" was impacting the bug or no bug (not to
mention that even if we duplicated those entries in the variable, it
_still_ wouldn't be a bug, since the whole point of the variable is just
to notice when the content changes).

> > Now your patch removed the recursively expanded one that was
> > immediately invalidated, there no longer is a reason to use :=
> > there.  So "unrelated to the more narrow bugfix" is a rather lame
> > excuse to do only half a task.  If we remove that extra one (which
> > is a good thing), then we should correct := into = because the
> > original used := only because there was the unwanted extra one, no?
> 
> I don't see how removing the stray line changes the reason to use ":="
> or "=" there. I agree it should be removed, it's just unrelated to
> removing the stay line. Looking at 07d90eadb50 it's clear that it's just
> some copy/pasting error.

Yeah, I'd agree it is truly orthogonal. I don't mind seeing it cleaned
up in addition (or am even actively happy to see it cleaned up :) ), but
IMHO it would not need to hold up the series.

-Peff
