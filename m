Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9580F1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeGRTqC (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 15:46:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:51440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728038AbeGRTqC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 15:46:02 -0400
Received: (qmail 13696 invoked by uid 109); 18 Jul 2018 19:06:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 19:06:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2069 invoked by uid 111); 18 Jul 2018 19:06:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 15:06:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 15:06:46 -0400
Date:   Wed, 18 Jul 2018 15:06:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Andrii Dehtiarov <adehtiarov@google.com>
Subject: Re: [PATCH 3/3] gc: do not return error for prior errors in
 daemonized mode
Message-ID: <20180718190645.GA7778@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180717065151.GA177907@aiede.svl.corp.google.com>
 <20180717065740.GD177907@aiede.svl.corp.google.com>
 <20180717201348.GD26218@sigill.intra.peff.net>
 <xmqqk1psldkx.fsf@gitster-ct.c.googlers.com>
 <20180718172225.GA2677@sigill.intra.peff.net>
 <xmqqlga8jtka.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlga8jtka.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 11:19:01AM -0700, Junio C Hamano wrote:

> > It's also still inconsistent in the daemonize case. The run that yields
> > the error won't return a non-zero exit. But the next run will exit with
> > "2".
> 
> I do not see this particular "inconsistency" a problem.  The run
> that first discovers the problem by definition cannot return with
> non-zero; not waiting until finding out the outcome is the whole
> point of running in the background and giving control back early.

I guess I just see it as encouraging a non-robust flow. I can see
somebody thinking they should care about "gc --auto" errors, because
they can turn up latent repository corruption (because most operations
try to only look at the objects they need to, and gc inherently
considers every object). But doing so would give a very delayed
notification for a repository that is handled infrequently. So finding
out about a corruption that we detected might takes weeks or months.

I dunno. If your primary motivation is not finding latent problems, but
loudly complaining when gc does not make forward progress, I suppose it
makes more sense.

-Peff
