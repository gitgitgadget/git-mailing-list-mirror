Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E3C20248
	for <e@80x24.org>; Tue,  5 Mar 2019 04:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfCEEpd (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 23:45:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:38822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726522AbfCEEpd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 23:45:33 -0500
Received: (qmail 777 invoked by uid 109); 5 Mar 2019 04:45:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 04:45:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28663 invoked by uid 111); 5 Mar 2019 04:45:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 23:45:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 23:45:30 -0500
Date:   Mon, 4 Mar 2019 23:45:30 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 0/2] fsck --connectivity-only --dangling
Message-ID: <20190305044530.GG19800@sigill.intra.peff.net>
References: <20190227145549.GA3255@sigill.intra.peff.net>
 <20190227145928.GA3727@sigill.intra.peff.net>
 <xmqqlg1z9uko.fsf@gitster-ct.c.googlers.com>
 <20190305042601.GF19800@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190305042601.GF19800@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 11:26:01PM -0500, Jeff King wrote:

> > > So I sketched up what it might look like to just fix the bug (but kick
> > > in only when needed), which is below.
> > 
> > As the primariy purose of the --conn-only option being such, perhaps
> > we should have made --no-dangling the default when --conn-only is in
> > effect.
> 
> Yes, perhaps. Though after thinking on this for a few days, I actually
> think there is no real reason not to just have --dangling do the right
> thing here (and we're still much faster than a full fsck, and not much
> slower than the current code unless you happen to have a large number
> of unreachable commits and trees).
> 
> And then if the user says "--no-dangling", we can be even faster (i.e.,
> the same as the current code).
> 
> We could also make "--no-dangling" the default for
> "--connectivity-only", though I do not have a strong feeling either way.

So here's a re-rolled series. The first patch just clarifies how
--connectivity-only works, since there are a few subtle points that came
up in this thread.

The second one is my fix from before. That lets us drop the initial
"explain why it doesn't work" documentation patch, though I did add a
note to the documentation pointing the user to --no-dangling.

  [1/2]: doc/fsck: clarify --connectivity-only behavior
  [2/2]: fsck: always compute USED flags for unreachable objects

 Documentation/git-fsck.txt | 14 +++++++--
 builtin/fsck.c             | 62 ++++++++++++++++++++++++++++++++++++++
 t/t1450-fsck.sh            | 19 ++++++++++--
 3 files changed, 90 insertions(+), 5 deletions(-)

-Peff
