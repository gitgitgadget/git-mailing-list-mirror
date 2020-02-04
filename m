Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B69C3524B
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F7420674
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBDUGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:06:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:52388 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727314AbgBDUGS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 15:06:18 -0500
Received: (qmail 11150 invoked by uid 109); 4 Feb 2020 20:06:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Feb 2020 20:06:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2417 invoked by uid 111); 4 Feb 2020 20:14:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Feb 2020 15:14:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Feb 2020 15:06:17 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jonathan Nieder <jrn@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
Message-ID: <20200204200617.GD12705@coredump.intra.peff.net>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <9138554.c73hJVQVja@mfick-lnx>
 <CAFQ2z_NkU6ekZkMqZpcFSEr8M3kfw0tiVCB2doHp3QTZtQ8UNg@mail.gmail.com>
 <2165647.H0RpPiDeFZ@mfick-lnx>
 <CAFQ2z_OgGvX3mFLeWSvEqdfxupRuHN_eFgqENaCRHHpO364_xA@mail.gmail.com>
 <20200130072122.GC2189233@coredump.intra.peff.net>
 <CAFQ2z_PvKiz==GyS6J1H1uG0FRPL86JvDj+LjX1We4-yCSVQ+g@mail.gmail.com>
 <20200203170555.GB3525@coredump.intra.peff.net>
 <CAFQ2z_P0X87bdCTSCXLHrV-M7vb+3BBjVmG+3CzYVY0RUHdKXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_P0X87bdCTSCXLHrV-M7vb+3BBjVmG+3CzYVY0RUHdKXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 07:54:12PM +0100, Han-Wen Nienhuys wrote:

> > PS I don't know if it's set in stone yet, but if we're changing things
> >    around, is it an option to put reftable-list inside the reftable
> >    directory, just to keep the top-level uncluttered?
> 
> I put up https://git.eclipse.org/r/c/157167/ to update the spec inside
> JGit. Please review.

That looks quite reasonable. The one change I'd make is to put
"refs/heads/.invalid" into HEAD (instead of "refs/.invalid"). In my
experiments, existing Git is happy to write into an invalid refname via
"git update-ref HEAD". But by putting it past the non-directory "heads",
such a write would always fail.

It's also supposed to be a requirement that HEAD only puts to
refs/heads/, though our validate_headref() does not enforce that. I
don't know if any other implementations might, though.

I did compare earlier your "make refs/heads a file" versus "make refs/ a
file and just give it an executable bit". And I think the "refs/heads"
solution does behave slightly better in a few cases. But if I understand
correctly, just giving "refs/" an executable bit would mean we retain
compatibility with the existing JGit implementation.

It does end up playing games with permissions, which I warned against,
but I think it might be tolerable:

  1. Unlike read vs write, there's not generally a reason users would
     need to separate read and execute.

  2. Portability-wise, POSIX permissions give us what we need, and
     non-POSIX systems tend to just say everything is executable.

So I could also live with that direction, if switching the JGit behavior
at this point is too much of a pain.

-Peff
