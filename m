Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717B120281
	for <e@80x24.org>; Thu, 21 Sep 2017 03:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbdIUDb4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 23:31:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:45488 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751283AbdIUDbz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 23:31:55 -0400
Received: (qmail 30648 invoked by uid 109); 21 Sep 2017 03:31:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 03:31:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18478 invoked by uid 111); 21 Sep 2017 03:32:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 23:32:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 23:31:52 -0400
Date:   Wed, 20 Sep 2017 23:31:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Subject: Re: Behaviour of 'git stash show' when a stash has untracked files
Message-ID: <20170921033152.4hbkctzxraww5rqo@sigill.intra.peff.net>
References: <1505626069.9625.6.camel@gmail.com>
 <xmqqfubinddb.fsf@gitster.mtv.corp.google.com>
 <20170920193630.l7ifret5dpqgxiwm@sigill.intra.peff.net>
 <xmqqpoakn8tj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpoakn8tj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2017 at 10:23:36AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I sketched out a possible solution in:
> >
> >   https://public-inbox.org/git/20170317141417.g2oenl67k74nlqrq@sigill.intra.peff.net/
> >
> > though I share your concerns over whether people would be annoyed to see
> > the existing "stash show" output changed.
> 
> Forgot about that one.  I sometimes do "stash show -p | apply", so
> changing what is included without any option would be annoying, and
> not having an option to restore the original behaviour would be
> doubly irritating.

I think it would mostly Just Work for your case. git-apply should ignore
the subject cruft at the top of the patch. And if you didn't create a
stash with "-u" or with bits in the index, then those would be absent
from the diff.

And if you _did_ create such a stash, I actually suspect that "apply"
barfing on the resulting patch may be a better outcome than silently
ignoring the changes.

I dunno. I do not use either of those features ("-u" or stashing the
index state) myself. But I have always been bothered how the saved state
is a bit hidden from the user. It seems like a recipe for user confusion
when they save something with "git stash" but then "stash show" doesn't
even mention it.

> Perhaps "stash show [--[untracked|index|worktree]]" to show only
> one, without the "==> I am this variant <==" label, would be
> workable, and with no option we would do --worktree that is the
> traditional output.
> 
> In addition "stash show --all" could be the output in your earlier
> patch.  I like the way it uses the '.' pathspec to squelch the
> entire thing when there is no change ;-)

Those all seem like sane interface proposals. As I said above, I have a
vague feeling that the default _ought_ to tell about everything. But I
don't care all that much myself, and I agree that we should avoid
creating headaches for existing users (it's just not clear to me how big
the headaches would be).

I guess the nuclear option there is introducing "git stash info" or
something, and marking "git stash show" as an alias for "git stash info
--worktree". It is too bad, though, as "show" is really the perfect
name.

Anyway. I don't have plans to work on this anytime soon, but I'd be
happy to review if anybody picked up the topic.

-Peff
