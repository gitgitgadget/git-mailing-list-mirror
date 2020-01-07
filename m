Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA70C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4D22146E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgAGSDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:03:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:59472 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728391AbgAGSDr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 13:03:47 -0500
Received: (qmail 14615 invoked by uid 109); 7 Jan 2020 18:03:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Jan 2020 18:03:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3750 invoked by uid 111); 7 Jan 2020 18:09:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2020 13:09:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jan 2020 13:03:46 -0500
From:   Jeff King <peff@peff.net>
To:     Andre Loconte <andre.loconte@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git bundle create produces inconsistent bundle
Message-ID: <20200107180346.GA48806@coredump.intra.peff.net>
References: <QBxpUR_NauPk0G8X2KKsqzlrfyxNuA4OoNR3Dm1KpHMNEELiSUxKr_IDM_qghObDt4aVv-bjg1ZQtCYRgxArdGsK52wCuO1LbsqzlHBto-k=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <QBxpUR_NauPk0G8X2KKsqzlrfyxNuA4OoNR3Dm1KpHMNEELiSUxKr_IDM_qghObDt4aVv-bjg1ZQtCYRgxArdGsK52wCuO1LbsqzlHBto-k=@protonmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 05:44:47PM +0000, Andre Loconte wrote:

> I am running into an issue where "git bundle create" doesn't always
> produce the same bundle, provided the exact same arguments and the
> exact same repo.

This is expected.  A bundle contains a packfile, and the packfile
generation is sensitive to several things:

  - the delta search is threaded (to the same number of threads as you
    have CPUs). Try "git -c pack.threads=1 bundle create ...".

  - we try to reuse on-disk deltas when possible. So the exact set of
    packs you have (or which objects are loose) may impact the result
    slightly. So between two different clones of the same repository,
    I'd expect different results.

Possibly repacking first with "git -c pack.threads=1 repack -adf" might
get you an identical on-disk state in two different clones (assuming you
have the same refs and reflogs in each!).

But as you can see, we don't in general expect packfiles to be
byte-stable (this is also the reason that git clones aren't easily
resumable).

-Peff
