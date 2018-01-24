Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183D21F404
	for <e@80x24.org>; Wed, 24 Jan 2018 15:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934191AbeAXPta (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 10:49:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:55598 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934124AbeAXPt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 10:49:28 -0500
Received: (qmail 8117 invoked by uid 109); 24 Jan 2018 15:49:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 15:49:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25693 invoked by uid 111); 24 Jan 2018 15:50:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 10:50:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 10:49:26 -0500
Date:   Wed, 24 Jan 2018 10:49:26 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] travis-ci: use 'set -e' in the 32 bit Linux build job
Message-ID: <20180124154925.GA15803@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com>
 <20180122133220.18587-3-szeder.dev@gmail.com>
 <20180123162633.GE13068@sigill.intra.peff.net>
 <CAM0VKjkGEfL2j2uzRa9=N5jZFbMMKEHn=UX=thxTAMM_g8TB4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkGEfL2j2uzRa9=N5jZFbMMKEHn=UX=thxTAMM_g8TB4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 01:12:48PM +0100, SZEDER Gábor wrote:

> >> -test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER) &&
> [...]
> Indeed, the && chain is broken, I didn't noticed that.
> 
> Luckily it was broken in a way that it didn't lead to false successes:
> if installing dependencies fails, then the first && chain
> ensures that HOST_UID is not set, and then useradd will error out with
> "invalid user ID 'ci'", causing the second && chain to abort the script
> and thus breaking the build.

True. :) I didn't even look closely at whether the failures could be
correlated.

> >> +HOST_UID=$1
> >> +CI_USER=$USER
> >> +test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER)
> >
> > If this "useradd" step fails, we wouldn't abort the script, because it's
> > part of a conditional. You'd need a manual "|| exit 1" at the end of
> > this line. Or to use a real "if" block.
> 
> No.  It does abort the script, because it isn't part of a conditional.
> Try to run the script twice in the same container instance: in the
> second run the user already exists, useradd fails and the whole script
> aborts.

You're right. I was confusing it with this case:

  (one; two) || three

in which we continue with "two" even if "one" fails. But it's only the
left-hand side of the || that does that.

-Peff
