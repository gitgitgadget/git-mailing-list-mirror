Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583C7C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 13:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7D5207BB
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 13:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgHTNIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:08:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:36234 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbgHTNIO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 09:08:14 -0400
Received: (qmail 6824 invoked by uid 109); 20 Aug 2020 13:08:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Aug 2020 13:08:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15206 invoked by uid 111); 20 Aug 2020 13:08:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Aug 2020 09:08:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Aug 2020 09:08:13 -0400
From:   Jeff King <peff@peff.net>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200820130813.GC2522289@coredump.intra.peff.net>
References: <cover.1597853634.git.lukasstraub2@web.de>
 <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
 <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
 <xmqqimdetpuw.fsf@gitster.c.googlers.com>
 <20200819201736.GA2511157@coredump.intra.peff.net>
 <20200820143755.06d39a05@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820143755.06d39a05@luklap>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 20, 2020 at 02:37:55PM +0200, Lukas Straub wrote:

> > Right now git-fsck complains about ".git" appearing in a tree, and that
> > check blocks people from pushing such trees to any hosting sites that
> > enable transfer.fsckObjects (which includes hosters like GitHub). So
> > you'd not only need to allow the behavior to be loosened for all of the
> > people using the feature, but you'd need to convince server-side hosters
> > to loosen their config. And because part of the purpose is to protect
> > downstream clients from attacks, I doubt that public hosters like GitHub
> > would do so.
> 
> I guess they can add a checkbox to their (secured) web-ui to configure
> this.

No, that would defeat the purpose. Hosting sites aren't protecting users
from themselves. They're concerned about malicious actors pushing up
objects that violate expectations and make the hosting site a vector for
attacks. Either against other parts of the site, or against downstream
users who aren't running fully-patched versions of Git (or perhaps are
running a misconfigured one, if there's a known-unsafe configuration).

I don't know of a version of Git that's vulnerable to ".git" (it should
be blocked from entering the index by verify_path()), but the fsck
checks are one layer of a multiple-layer defense against such problems
(which have helped us contain other path-related vulnerabilities).
Letting the potential attacker turn off that layer makes it pointless.

> In the worst-case where the hosting sites don't adopt this config, the user
> enables and uses this feature despite the warnings and then wants to use a
> hosting site, he can still rewrite the history. Not nice, but no disaster
> either.

In general, I do like to err on the side of providing users tools to
shoot themselves in the foot. But this feels like it crosses even my bar
for a foot-gun, especially when there are other solutions available.

-Peff
