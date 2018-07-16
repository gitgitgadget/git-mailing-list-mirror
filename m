Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1422E1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeGPTVk (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:21:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:48200 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728285AbeGPTVk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:21:40 -0400
Received: (qmail 9549 invoked by uid 109); 16 Jul 2018 18:52:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 18:52:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14298 invoked by uid 111); 16 Jul 2018 18:53:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 14:53:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 14:52:56 -0400
Date:   Mon, 16 Jul 2018 14:52:56 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716185255.GC22298@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716175103.GB18636@sigill.intra.peff.net>
 <20180716182207.GA11513@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716182207.GA11513@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 11:22:07AM -0700, Jonathan Nieder wrote:

> > I'm not sure if this tells the whole story. You may still run into a
> > case where auto-gc runs over and over during the grace period, because
> > you have a bunch of objects which are not reachable and not yet ready to
> > be expired. So a gc cannot make forward progress until the 2-week
> > expiration, and the way to break the cycle is to run an immediate
> > "prune".
> >
> > So while I completely agree that it's not a great thing to encourage
> > users to blindly run "git prune", I think it _is_ actionable.
> 
> To flesh this out a little more: what user action do you suggest?  Could
> we carry out that action automatically?

Er, the action is to run "git prune", like the warning says. :)

And no, I do not think we should run it automatically. It deletes
objects without respect to the grace period, which may not be what the
user wants. (And yes, the existing warning is terrible because it does
not at all make clear that following its advice may be dangerous).

> I mentally make a distinction between this warning from "git gc
> --auto" and the warning from commands like "git gui".  The former was
> saying "Please run 'git prune', because I'm not going to do it", and
> as Jonathan noticed, that's not true any more.  The latter says
> 
> 	This repository currently has approximately %i loose objects.
> 
> 	To maintain optimal performance it is strongly recommended
> 	that you compress the database.
> 
> 	Compress the database now?
> 
> which is relevant to the current operation (slowly reading the
> repository) and easy to act on (choose "yes").

I don't think those warnings are the same. The warning from "git gui"
is: you may benefit from running gc.

The warning that is deleted by this patch is: you _just_ ran gc, and hey
we even did it automatically for you, but we're still in a funky state
afterwards. You might need to clean up this state.

(As an aside, I think the git-gui warning pre-dates "gc --auto", and
probably should just run that rather than implementing its own
heuristic).

> > I agree that the "-1" return is a little funny. Perhaps on the reading
> > side we should detect that the log contains only a "warning" line and
> > adjust our exit code accordingly.
> 
> Yes, this is a real problem, and it would affect any other warning
> (or even GIT_TRACE=1 output) produced by gc --auto as well.  I think we
> should consider it a serious bug, separate from the symptom Jonathan is
> fixing.
> 
> Unfortunately I don't have a great idea about how to fix it.  Should
> we avoid writing warnings to gc.log in daemon mode?  That would
> prevent the user from ever seeing the warnings, but because of the
> nature of a warning, that might be reasonable.

If you do that without anything further, then it will break the
protection against repeatedly running auto-gc, as I described in the
previous email.

> Should we put warnings
> in a separate log file with different semantics?  Should we change the
> format of gc.log to allow more structured information (include 'gc'
> exit code) and perform a two-stage migration to the new format (first
> learn to read the new format, then switch to writing it)?

Any of those would work similarly to the "just detect warnings" I
suggested earlier, with respect to keeping the "1 day" expiration
intact, so I'd be OK with them. In theory they'd be more robust than
scraping the "warning:" prefix. But in practice, I think you have to
resort to scraping anyway, if you are interested in treating warnings
from sub-processes the same way.

-Peff
