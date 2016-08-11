Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E25420193
	for <e@80x24.org>; Thu, 11 Aug 2016 16:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbcHKQTI (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 12:19:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:53637 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751059AbcHKQTH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 12:19:07 -0400
Received: (qmail 22533 invoked by uid 109); 11 Aug 2016 16:19:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 16:19:06 +0000
Received: (qmail 10763 invoked by uid 111); 11 Aug 2016 16:19:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 12:19:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Aug 2016 12:19:03 -0400
Date:	Thu, 11 Aug 2016 12:19:03 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5] pack-objects mru
Message-ID: <20160811161903.zfam5ietxpa2yyqm@sigill.intra.peff.net>
References: <20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net>
 <20160810120248.i2hvm2q6ag3rvsk4@sigill.intra.peff.net>
 <xmqqr39w4bvx.fsf@gitster.mtv.corp.google.com>
 <20160811050252.g3iusy7bp3j6tzte@sigill.intra.peff.net>
 <20160811065751.p64bi3sngbeotwc3@sigill.intra.peff.net>
 <20160811092030.my5c4x6wplxaf7wz@sigill.intra.peff.net>
 <20160811095710.p2bffympjlwmv3gc@sigill.intra.peff.net>
 <xmqqmvkj2vdm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvkj2vdm.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 08:11:33AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So considering "--depth" as a space-saving measure for --aggressive does
> > not seem that effective. But it feels weird to quietly drop actions
> > people might have done with previous aggressive runs.
> 
> That argument cuts both ways, doesn't it?
> 
> If the user explicitly asks to use lower "--depth" from the command
> line when the second repack runs, the intention is clear: the
> existing pack may use delta chains that are too long and is
> detrimental to the run-time performance, and the user wants to
> correct it by repacking with shorter delta chain.
> 
> Should the act of letting "gc --auto" use lower "--depth", by not
> configuring to always use deeper chain, be interpreted the same way?
> I am not sure.  The old packing with large --depth is something the
> user did long time ago, and the decision the user made not to use
> large depth always is also something the user did long time ago.  I
> do not think it is so cut-and-dried which one of the two conflicting
> wishes we should honor when running the second repack, especially
> when it is run unattended like "gc --auto" does.

Good points. Explicitly saying "repack --depth=..." carries a lot more
weight to me than "git gc --auto" randomly kicking in, as far as knowing
that what the user actually wants. My patch doesn't differentiate, of
course, but I think it could.

The other problem with my patch is the fact that we don't do a good job
of finding new, in-limit deltas for the ones we discard. If you want to
do that, you really need to "git repack -f" (at least with the current
code). At which point we do not reuse the on-disk deltas at all, and the
problem is moot (you could also interpret the fact that the user did
_not_ pass "-f" as "you want to reuse deltas, which means you want to
reuse even long chains", but as you've argued above, you can make a lot
of guesses about the user's intention from what they did or did not
say).

So if we were to go this route, I don't think my patch is quite
sufficient; we'd want something else on top to do a better job of
finding replacement deltas.

Regarding my "does not seem that effective" above, I think we should
drop the aggressive depth to 50, and I just posted a patch with
reasoning and numbers:

  http://public-inbox.org/git/20160811161309.ecmebaafcz6rkg6o@sigill.intra.peff.net/

That's maybe orthogonal, but it does remove the weird "gc --aggressive
followed by gc --auto produces a bad pack" issue, because unless you are
doing something clever, the depth will always be 50 (modulo people who
did an aggressive pack with an older version of git :-/ ).

-Peff
