Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1BC2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbdBWT6y (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:58:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:32793 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbdBWT6x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:58:53 -0500
Received: (qmail 11382 invoked by uid 109); 23 Feb 2017 19:32:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 19:32:12 +0000
Received: (qmail 18085 invoked by uid 111); 23 Feb 2017 19:32:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 14:32:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 14:32:10 -0500
Date:   Thu, 23 Feb 2017 14:32:10 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net>
 <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
 <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
 <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 11:09:32AM -0800, Linus Torvalds wrote:

> On Thu, Feb 23, 2017 at 10:46 AM, Jeff King <peff@peff.net> wrote:
> >>
> >> So I agree with you that we need to make git check for the opaque
> >> data. I think I was the one who brought that whole argument up.
> >
> > We do already.
> 
> I'm aware of the fsck checks, but I have to admit I wasn't aware of
> 'transfer.fsckobjects'. I should turn that on myself.
> 
> Or maybe git should just turn it on by default? At least the
> per-object fsck costs should be essentially free compared to the
> network costs when you just apply them to the incoming objects.

Yeah, they're not expensive. We've discussed enabling them by default.
The sticking point is that there is old history with minor bugs which
triggers some warnings (e.g., malformed committer names), and it would
be annoying to start rejecting that unconditionally.

So I think we would need a good review of what is a "warning" versus an
"error", and to only reject on errors (right now the NUL thing is a
warning, and it should probably upgraded).

> And in particular, while the *kernel* doesn't generally have critical
> opaque blobs, other projects do. Things like firmware images etc are
> open to attack, and crazy people put ISO images in repositories etc.
> 
> So I don't think this discussion should focus exclusively on the git metadata.
> 
> It is likely much easier to replace a binary blob than it is to
> replace a commit or tree (or a source file that has to go through a
> compiler). And for many projects, that would be a bad thing.

Yes, I'd agree we need to consider both. And no matter what Git does in
its own data formats, blobs will always be a sequence of bytes. Hiding
collision-cruft in them isn't up to us, but rather the data format.

The nice thing about a blob collision, though, is that you can only
replace the opaque files, not, say, C source code. That doesn't make it
a non-issue, but it reduces the scope of an attack.

Replacing a commit or tree wholesale means the attacker has a lot more
flexibility. So to whatever degree we can make that harder (like
complaining of commits with NULs), the better.

> > It's not an identical prefix, but I think collision attacks generally
> > are along the lines of selecting two prefixes followed by garbage, and
> > then mutating the garbage on both sides. That would "work" in this case
> > (modulo the fact that git would complain about the NUL).
> 
> I think this particular attack depended on an actual identical prefix,
> but I didn't go back to the paper and check.

The paper describes the content as:

  SHA-1(P | M1 | M2 | S)

and they replace both "M1" and "M2", with a near-collision for the
first, and then the final collision for the second. What's not clear to
me is if part of M1 can be chosen, or if it's perturbed fully into
random garbage.

> But the attacks tend to very much depend on particular input bit
> patterns that have very particular effects on the resulting
> intermediate hash, and those bit patterns are specific to the hash and
> known.
> 
> So a very powerful defense is to just look for those bit patterns in
> the objects, and just warn about them. Those patterns don't tend to
> exist in normal inputs anyway, but particularly if you just warn, it's
> a heads-ups that "ok, something iffy is going on"

Yes, that would be a wonderful hardening to put into Git if we know what
those patterns look like. That part isn't clear to me.

> The whole _point_ of an SCM is that it isn't about a one-time event,
> but about continuous history. That also fundamentally means that a
> successful attack needs to work over time, and not be detectable.

Yeah, I'd certainly agree with that. You spend loads of money to
generate a collision, there's a reasonably high chance of detection, and
then as soon as one person detects it, your investment is lost.

According to the paper, the current cost of the computation for a single
collision is ~$670K.

At least for now, an attacker is much better off using that money to
break into your house and install a keylogger.

-Peff
