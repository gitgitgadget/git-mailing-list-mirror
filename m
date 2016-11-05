Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7412D2022A
	for <e@80x24.org>; Sat,  5 Nov 2016 04:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbcKEEon (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 00:44:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:39011 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752523AbcKEEom (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 00:44:42 -0400
Received: (qmail 9182 invoked by uid 109); 5 Nov 2016 04:44:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Nov 2016 04:44:42 +0000
Received: (qmail 29193 invoked by uid 111); 5 Nov 2016 04:45:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Nov 2016 00:45:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Nov 2016 00:44:40 -0400
Date:   Sat, 5 Nov 2016 00:44:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161105044440.u5imqcrsmpdbtonp@sigill.intra.peff.net>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com>
 <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net>
 <xmqq60o2edy5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60o2edy5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 09:41:06PM -0700, Junio C Hamano wrote:

> > I think the main complication is that the reachability rules are used
> > during object transfer. So you'd probably want to introduce some
> > protocol extension to say "I understand gitrefs", so that when one side
> > says "I have sha1 X and its reachable objects", we know whether they are
> > including gitrefs there. And likewise receivers with
> > transfer.fsckObjects may complain about the new gitref tree mode
> > (fortunately a new object type shouldn't be needed).
> 
> Quite honestly I do not think backward compatibility here matters.
> When gitlinks were introduced, a repository that was created with
> gitlink capable version of Git would have failed "git fsck" that is
> not gitlink aware, and I think this new "link with reachability" is
> the same deal.  No existing implemention understands a tree entry
> whose mode bits are 140000 or whatever new bit pattern we would
> assign to this thing.  You have to wait until both ends understand
> the new thing, and that is perfectly OK.

I'm OK with saying "if you use the gitref feature, you cannot push or
pull those objects with remotes that do not understand it".  But unlike
gitlink, if we fail to notice the situation, we run into a case where we
might silently lose objects, which is bad. So I think we need to be a
bit more careful.

I don't think the problems are insurmountable. I just think that's where
the real complexity is, not in the changes to teach a single git about
gitrefs.

I'm happy to stand back and let you or Josh figure out all the corner
cases. :)

-Peff
