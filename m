Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6102320951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751158AbdCNWJm (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:09:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:44240 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbdCNWJl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:09:41 -0400
Received: (qmail 5846 invoked by uid 109); 14 Mar 2017 22:09:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 22:09:40 +0000
Received: (qmail 29838 invoked by uid 111); 14 Mar 2017 22:09:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 18:09:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Mar 2017 18:09:37 -0400
Date:   Tue, 14 Mar 2017 18:09:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Wincent Colaiuta <win@wincent.com>,
        Mislav =?utf-8?B?TWFyb2huacSH?= <mislav.marohnic@gmail.com>
Subject: Re: [PATCH] add--interactive: do not expand pathspecs with ls-files
Message-ID: <20170314220937.xg6isonertnykx4y@sigill.intra.peff.net>
References: <20170314163024.et2cp5e3imrrrf7k@sigill.intra.peff.net>
 <xmqqd1djh5xl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1djh5xl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 14, 2017 at 03:03:34PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We can improve this by skipping "ls-files" completely, and
> > just feeding the original pathspecs to the diff commands.
> > This solution was discussed in 2010:
> >
> >   http://public-inbox.org/git/20100105041438.GB12574@coredump.intra.peff.net/
> >
> > but at the time the diff code's pathspecs were more
> > primitive than those used by ls-files (e.g., they did not
> > support globs). Making the change would have caused a
> > user-visible regression, so we didn't.
> 
> Heh.  The change and the reasoning are both obviously correct, but
> how did you find this?  Do you have a pile of "old patches that
> should be resurrected when time is right" and this was picked out of
> it, or did you see somebody else hit the same thing recently and
> then went back to the archive?

The latter.  Mislav reported it to me off-list earlier today, and I
generated the patch. But after scratching my head at the familiarity and
especially wondering if there was some reason to use "ls-files" here, I
dug up the linked thread. The fact that the patches are identical is
just coincidence (though it's such a simple change that it seems highly
likely).

> >      So this takes us one step closer to working correctly
> >      with files whose names contain wildcard characters, but
> >      it's likely that others remain (e.g., if "git add -i"
> >      feeds the selected paths to "git add").
> 
> We didn't run with --literal-pathspecs which was a bug, but I
> suspect that it didn't exist back then ;-).

Yep. I think judiciously inserting "--literal-pathspecs" is probably the
correct fix. In an earlier thread (that I linked elsewhere from the
discussion here) I suggested just setting $GIT_LITERAL_PATHSPECS to 1.
But that is probably a bad idea. As this patch shows, we do still
sometimes feed the original non-expanded pathspec to some commands.

I left that as potential low-hanging fruit for somebody who cares more
(the trickiest part is probably not the fix, but coming up with a test
case).

-Peff
