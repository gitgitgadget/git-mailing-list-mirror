Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F841F4F8
	for <e@80x24.org>; Fri, 23 Sep 2016 03:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757545AbcIWDtc (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 23:49:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:46985 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757443AbcIWDtc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 23:49:32 -0400
Received: (qmail 24471 invoked by uid 109); 23 Sep 2016 03:49:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 03:49:31 +0000
Received: (qmail 14247 invoked by uid 111); 23 Sep 2016 03:49:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 23:49:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 23:49:28 -0400
Date:   Thu, 22 Sep 2016 23:49:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Anatoly Borodin <anatoly.borodin@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: pager.<cmd> doesn't work well with editors
Message-ID: <20160923034928.dneomzokebkuxg4z@sigill.intra.peff.net>
References: <nrmbrl$hsk$1@blaine.gmane.org>
 <nrmd6u$imf$1@blaine.gmane.org>
 <xmqqh99bho7a.fsf@gitster.mtv.corp.google.com>
 <20160920014733.7whjuxfuimx5ztdb@sigill.intra.peff.net>
 <xmqqponxb56a.fsf@gitster.mtv.corp.google.com>
 <20160922064730.277nzkqlxbcx2kjg@sigill.intra.peff.net>
 <xmqqfuor6ee3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuor6ee3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 10:19:32AM -0700, Junio C Hamano wrote:

> The level at which configurability happens might be one issue
> (i.e. you may want different pager for two operating modes for the
> same command, hence your need to use "tag.list" not just "tag"), but
> I think another issue is that it conflates if the output need to be
> paged (on/off) and what pager should be used when the output is
> paged.  When we see that a user sets "pager.tag", we should not have
> made it an instruction to Git that _all_ output from "git tag" must
> be paged.

Yes, we could have done it the other way, but I think this was a natural
consequence of implementing it git.c. It _only_ knows about "all output
from git-tag" and nothing else.

At any rate, I do not see much point in moving away from it even if we
change the underlying implementation to be more flexible, if only
because it would be a gratuitous incompatibility.

> So I think we are fundamentally on the same page; it is just you are
> aiming higher than I was, but we both recognize the need for separate 
> codepaths in a single command to decide if the output should be paged.

Yeah. In my examples there are really two proposed improvements:

  1. The decision over whether and when to start a pager is pushed down
     from git.c into individual commands.

  2. As a side effect of (1), commands must declare "this is who I am"
     to look up the correct config.  But "who I am" no longer needs to
     be a whole command, so we are free to slice up the namespace more
     finely. But we do not have to.

     This might also be an opportunity to add more conditions. Like "run
     the pager if I am doing log output with -p, but not otherwise" or
     something. I dunno. That does not sound useful to me, but maybe
     somebody else would find it so.

And I think you are getting at a (3), which is something like:

  3. The config namespace can be made richer, so that "whether" and
     "how" are split. E.g., "pager.log.command" and "pager.log.enabled"
     or something.

     I do not mind that, but we would probably want to keep "pager.log"
     for compatibility, at which point I wonder if the new system is
     worth the bother.

-Peff
