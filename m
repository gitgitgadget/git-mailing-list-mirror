Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D40F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 17:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeGPSTd (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 14:19:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:48070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727618AbeGPSTd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 14:19:33 -0400
Received: (qmail 6714 invoked by uid 109); 16 Jul 2018 17:50:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 17:50:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13381 invoked by uid 111); 16 Jul 2018 17:51:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 13:51:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 13:51:03 -0400
Date:   Mon, 16 Jul 2018 13:51:03 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716175103.GB18636@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716172717.237373-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 10:27:17AM -0700, Jonathan Tan wrote:

> In a087cc9819 ("git-gc --auto: protect ourselves from accumulated
> cruft", 2007-09-17), the user was warned if there were too many
> unreachable loose objects. This made sense at the time, because gc
> couldn't prune them safely. But subsequently, git prune learned the
> ability to not prune recently created loose objects, making pruning able
> to be done more safely, and gc was made to automatically prune old
> unreachable loose objects in 25ee9731c1 ("gc: call "prune --expire
> 2.weeks.ago" by default", 2008-03-12).
> 
> This makes the warning unactionable by the user, as any loose objects
> left are not deleted yet because of safety, and "git prune" is not a
> command that the user is recommended to run directly anyway.

I'm not sure if this tells the whole story. You may still run into a
case where auto-gc runs over and over during the grace period, because
you have a bunch of objects which are not reachable and not yet ready to
be expired. So a gc cannot make forward progress until the 2-week
expiration, and the way to break the cycle is to run an immediate
"prune".

So while I completely agree that it's not a great thing to encourage
users to blindly run "git prune", I think it _is_ actionable.

But...

> This was noticed when a daemonized gc run wrote this warning to the log
> file, and returned 0; but a subsequent run merely read the log file, saw
> that it is non-empty and returned -1 (which is inconsistent in that such
> a run should return 0, as it did the first time).

Yes, this got much worse with daemonized gc. The warning blocks further
runs. And then even after the 2-week period, you still cannot make
further progress until the user steps in! I think we dealt with that in
a831c06a2b (gc: ignore old gc.log files, 2017-02-10). So now we won't
run gc for a day, but eventually we may make further progress.

So the warning _is_ still doing something useful there (it's blocking
immediate auto-gc and kicking in the 1-day threshold).

I agree that the "-1" return is a little funny. Perhaps on the reading
side we should detect that the log contains only a "warning" line and
adjust our exit code accordingly.

Ultimately, I think Git should avoid keeping unreachable objects as
loose in the first place, which would make this whole problem go away.
There's some discussion in this thread:

  https://public-inbox.org/git/87inc89j38.fsf@evledraar.gmail.com/

-Peff
