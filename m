Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91700202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 16:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbdGLQ6V (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 12:58:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:38066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753452AbdGLQ6U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 12:58:20 -0400
Received: (qmail 645 invoked by uid 109); 12 Jul 2017 16:58:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 16:58:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25039 invoked by uid 111); 12 Jul 2017 16:58:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 12:58:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jul 2017 12:58:17 -0400
Date:   Wed, 12 Jul 2017 12:58:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Krey <a.krey@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] gc: run pre-detach operations under lock
Message-ID: <20170712165817.xcq4we5ynl3opm37@sigill.intra.peff.net>
References: <20170704075758.GA22249@inner.h.apk.li>
 <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net>
 <20170706133124.GB1216@inner.h.apk.li>
 <CAGyf7-FnaWM=XNb_Skb1qR4vu_jAw-5swkgWpEDQqwM0NNq3YQ@mail.gmail.com>
 <20170711044553.GG3786@inner.h.apk.li>
 <20170711072536.ijpldg4uxb5pbtdw@sigill.intra.peff.net>
 <20170711090635.swowex7yry7kqb7v@sigill.intra.peff.net>
 <xmqqvamx1u3i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvamx1u3i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 09:46:25AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Instead, we can do something a bit simpler: take the lock
> > only for the duration of the pre-detach work, then detach,
> > then take it again for the post-detach work. Technically,
> > this means that the post-detach lock could lose to another
> > process doing pre-detach work. But in the long run this
> > works out.
> 
> You might have found this part gross, but I actually don't.  It
> looks like a reasonable practical compromise, and I tried to think
> of a scenario that this would do a wrong thing but I didn't---it is
> not like we carry information off-disk from the pre-detach to
> post-detach work to cause the latter make decisions on it, so this
> "split into two phrases" looks fairly safe.

Anytime I have to spend a few paragraphs saying "well, it looks like
this might behave terribly, but it doesn't because..." I get worried
that my analysis is missing a case. And that writing it in a way that
avoids that analysis might be safer, even if it's a little more work.

I gave it some more thought after sending the earlier message. And I
really think it's not "a little more work". Even if we decided to keep
the same file and replace the PID in it with the daemonized one, I think
that still isn't quite right. Because we don't do so atomically unless
we take gc.pid.lock again. But we may actually conflict with somebody
else on that! Even though that somebody would just pick up the lock,
read gc.pid and say "well, looks like somebody else is running" and
release it again. So we'd have to either hold the lock the whole time,
or do some kind of retry loop to race with other processes picking up
the lock.

It's definitely possible, but it's fighting an uphill battle against the
way our locking and tempfile code works. So I came to the conclusion
that it's not worth the trouble, and what I posted is probably a good
compromise.

-Peff
