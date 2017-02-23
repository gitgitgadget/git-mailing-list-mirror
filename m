Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79FDB2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbdBWT6C (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:58:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:32789 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbdBWT6B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:58:01 -0500
Received: (qmail 13195 invoked by uid 109); 23 Feb 2017 19:57:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 19:57:56 +0000
Received: (qmail 19433 invoked by uid 111); 23 Feb 2017 19:58:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 14:58:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 14:57:54 -0500
Date:   Thu, 23 Feb 2017 14:57:54 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net>
 <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
 <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
 <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net>
 <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 11:47:16AM -0800, Linus Torvalds wrote:

> On Thu, Feb 23, 2017 at 11:32 AM, Jeff King <peff@peff.net> wrote:
> >
> > Yeah, they're not expensive. We've discussed enabling them by default.
> > The sticking point is that there is old history with minor bugs which
> > triggers some warnings (e.g., malformed committer names), and it would
> > be annoying to start rejecting that unconditionally.
> >
> > So I think we would need a good review of what is a "warning" versus an
> > "error", and to only reject on errors (right now the NUL thing is a
> > warning, and it should probably upgraded).
> 
> I think even a warning (as opposed to failing the operation) is
> already a big deal.
> 
> If people start saying "why do I get this odd warning", and start
> looking into it, that's going to be a pretty strong defense against
> bad behavior. SCM attacks depend on flying under the radar.

Sorry, I conflated two things there. I agree a warning is better than
nothing. But right now transfer.fsck croaks even for warnings, and there
are some warnings that it is not worth croaking for. So before we turn
it on, we need to stop croaking on warnings (and possibly bump up some
warnings to errors).

I think it _is_ important to have dangerous things as errors, though.
Because it helps an unattended server (where nobody would see the
warning) avoid being a vector for spreading malicious objects to older
clients which do not do the fsck.

> There's actually already code for that, pointed to by the shattered project:
> 
>   https://github.com/cr-marcstevens/sha1collisiondetection
> 
> the "meat" of that check is in lib/ubc_check.c.

Thanks, I hadn't seen that yet. That doesn't look like it should be hard
to integrate into Git.

-Peff
