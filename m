Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BCEC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 02:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BF961053
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 02:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhJHCcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 22:32:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:35510 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhJHCct (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 22:32:49 -0400
Received: (qmail 31566 invoked by uid 109); 8 Oct 2021 02:30:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 02:30:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29793 invoked by uid 111); 8 Oct 2021 02:30:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Oct 2021 22:30:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Oct 2021 22:30:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] cat-file: mention --unordered along with
 --batch-all-objects
Message-ID: <YV+tXVWVuy/rZn/l@coredump.intra.peff.net>
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
 <YVy2DNd+XemykKE0@coredump.intra.peff.net>
 <877derjia9.fsf@evledraar.gmail.com>
 <YVzGeE1T/Kp8DDZD@coredump.intra.peff.net>
 <87tuhuikhf.fsf@evledraar.gmail.com>
 <YV3LonbeIS8DrMsN@coredump.intra.peff.net>
 <87k0ipgmbb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0ipgmbb.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 07, 2021 at 12:18:45PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> The usage of OPT_CMDMODE() in "cat-file"[1] was added in parallel with
> >> the development of[3] the --batch-all-objects option[4], so we've
> >> since grown[5] checks that it can't be combined with other command
> >> modes, when it should just be made a top-level command-mode
> >> instead. It doesn't combine with --filters, --textconv etc.
> >
> > This is not right. --batch-all-objects does not provide a mode exclusive
> > with "-t", etc, by itself.
> 
> Yes it does. See the "if (opt) {" branch on master. We just don't
> implement it via a cmdmode, but --batch-all-objects can definitely be a
> CMDMODE (I see you found that out below...)

I agree that if you make it a CMDMODE it does not introduce any bugs.
But it is semantically confusing. You would not make, say, --buffer a
CMDMODE option. It is a flag which only takes effect under certain
modes. And the same is true of --batch-all-objects, which modifies the
batch cmd modes.

In fact, it _would_ be a bug to make it a CMDMODE if --batch were
correctly marked as one (but it is not sufficient to reason the other
way; --batch without --batch-all-objects is still mutually exclusive
with -t, etc).

What really makes things confusing, IMHO, is the --textconv and --filter
options. They are marked as CMDMODEs, and they are indeed mutually
exclusive with -t, etc. But they also work with --batch, which is itself
a different mode.

So I don't think OPT_CMDMODE could ever present this complete set of
rules, because they are not all mutually exclusive with each other. But
I think calling "--batch-all-objects" a mode is just muddying the waters
even further.

-Peff
