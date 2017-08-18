Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652FE1F667
	for <e@80x24.org>; Fri, 18 Aug 2017 11:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbdHRLpd (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 07:45:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:42558 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750949AbdHRLpc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 07:45:32 -0400
Received: (qmail 3658 invoked by uid 109); 18 Aug 2017 11:45:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 11:45:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1517 invoked by uid 111); 18 Aug 2017 11:45:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 07:45:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Aug 2017 07:45:30 -0400
Date:   Fri, 18 Aug 2017 07:45:30 -0400
From:   Jeff King <peff@peff.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 4/4] commit: rewrite read_graft_line
Message-ID: <20170818114530.hiks5iiljtxeyrha@sigill.intra.peff.net>
References: <cover.1503020338.git.patryk.obara@gmail.com>
 <cb98970b3f6c175321f52efb65deb48f9cfeabae.1503020338.git.patryk.obara@gmail.com>
 <20170818064335.h5sr5iz7mh64axji@sigill.intra.peff.net>
 <xmqqziaxcobp.fsf@gitster.mtv.corp.google.com>
 <CAJfL8+SHSAhgrMY6ONVHLMWEHcT0mhm4oKMmq6D=89SErDKiMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfL8+SHSAhgrMY6ONVHLMWEHcT0mhm4oKMmq6D=89SErDKiMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 01:30:23PM +0200, Patryk Obara wrote:

> > We'd reject such an input totally (though as an interesting side effect,
> > you can convince the parser to allocate 20x as much RAM as you send it;
> > one oid for each space).
> 
> Grafts are not populated during clone operation, so it really would be user
> making his life miserable. I could allocate FLEXI_ARRAY of size
> min(n, line->len / (GIT_*MIN*_HEXSZ+1)) instead… but I think it's not even
> worth the cost of making the code more complicated (and I don't want
> to reintroduce these size macros in here.
> 
> We _could_ put an artificial limit on graft parents, though (e.g. 10) and
> display an error message urging the user to stop using grafts?

Yeah, sorry, I should have made more clear that this is fine. I always
try to read parsing code with my paranoid hat on, but I agree that
grafts aren't really exposed to untrusted entities.

In general I'd prefer to avoid artificial limits unless there's a need
for them. There are already spots (like receive-pack) where you can ask
Git to store bytes in RAM as fast as you can send them. What I found
interesting about this one was the 20:1 amplification. :)

> Before sending v3 I tried two other alternative implementations (perhaps I
> should've listed them in the v3 cover letter):

It might even be worth listing them in the commit message. Somebody
finding your commit 3 years from via "git log -S" or "git blame" might
say "yes, but why didn't they just do it like...". You can respond to
them preemptively. :)

-Peff
