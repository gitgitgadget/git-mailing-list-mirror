Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35D91F87F
	for <e@80x24.org>; Thu, 13 Jun 2019 19:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfFMTAl (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 15:00:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:54238 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726603AbfFMTAl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 15:00:41 -0400
Received: (qmail 3952 invoked by uid 109); 13 Jun 2019 19:00:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jun 2019 19:00:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21064 invoked by uid 111); 13 Jun 2019 19:01:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Jun 2019 15:01:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jun 2019 15:00:37 -0400
Date:   Thu, 13 Jun 2019 15:00:37 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, aleksandrs@ledovskis.lv,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Espen Antonsen <espen@inspired.no>, git@vger.kernel.org
Subject: Re: Git status parse error after v.2.22.0 upgrade
Message-ID: <20190613190037.GA27217@sigill.intra.peff.net>
References: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906112127420.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <38b0f33a-1da1-4231-802e-ae14d9843ad2@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906122046400.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190613093023.GA3919@ariake.ledovskis.lv>
 <xmqqr27xwjwj.fsf@gitster-ct.c.googlers.com>
 <20190613162432.GA12128@sigill.intra.peff.net>
 <8981e6c8-eb20-fde7-2b4c-1fbf2057caef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8981e6c8-eb20-fde7-2b4c-1fbf2057caef@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 06:43:41PM +0100, Phillip Wood wrote:

> >>  (2) make the sequencer machinery more careful to clean up after it
> >>      is done or it is aborted  (for example, "git reset --hard"
> >>      could remove these state files preemptively even when a rebase
> >>      is not in progress, I would think).
> >>
> >> I think we already had some patches toward the latter recently.
> > 
> > Maybe I am not understanding it correctly, but do you mean in (2) that
> > "git reset --hard" would always clear sequencer state?
> 
> I think the commit Junio is referring to is
> b07d9bfd17 ("commit/reset: try to clean up sequencer state", 2019-04-16)
> which will only remove the sequencer directory if it stops after the
> pick was the last one in the series. The idea is that if cherry-pick
> stops for a conflict resolution on the last pick user commits the result
> directly or run reset without running `cherry-pick --continue`
> afterwards the sequencer state gets cleaned up properly.

OK, that makes a lot more sense to me. It did make me wonder if doing an
"e"dit on the final commit of a rebase followed by "reset HEAD^" would
clear the sequencer state. But looking at that commit, this kicks in
only for the cherry-pick and revert cases.

Thanks for explaining.

> If we do want to do something then maybe teaching gc not to collect
> commits listed in .git/sequencer/todo and
> .git/rebase-merge/git-rebase-todo would be useful.

IMHO that opens up a can of worms, because the reachability rules get
more complicated (so for example people trying to prune away unwanted
history get confused about what is still mentioning the objects). That's
a reasonable rare case. OTOH, so is mentioning commits in an ongoing
rebase that are not still reachable from the branch you are rebasing,
nor the HEAD reflog.

-Peff
