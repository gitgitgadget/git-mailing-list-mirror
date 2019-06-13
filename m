Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AFEC1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfFMQYq (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:24:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:53914 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732899AbfFMQYi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 12:24:38 -0400
Received: (qmail 3016 invoked by uid 109); 13 Jun 2019 16:24:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jun 2019 16:24:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19569 invoked by uid 111); 13 Jun 2019 16:25:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Jun 2019 12:25:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jun 2019 12:24:32 -0400
Date:   Thu, 13 Jun 2019 12:24:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     aleksandrs@ledovskis.lv,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Espen Antonsen <espen@inspired.no>, git@vger.kernel.org
Subject: Re: Git status parse error after v.2.22.0 upgrade
Message-ID: <20190613162432.GA12128@sigill.intra.peff.net>
References: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906112127420.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <38b0f33a-1da1-4231-802e-ae14d9843ad2@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906122046400.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190613093023.GA3919@ariake.ledovskis.lv>
 <xmqqr27xwjwj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr27xwjwj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 09:05:16AM -0700, Junio C Hamano wrote:

> aleksandrs@ledovskis.lv writes:
> 
> > My repo indeed contains a ".git/sequencer/todo" file which
> > contains references to commits long-gone (i.e., rebased).
> > Renaming or deleting this file stops whines about "error: could
> > not parse".
> 
> Interesting.  So in short, when the repository has leftover
> sequencer state file that is not in use, "git status parse" thing
> (whatever it is---are you getting it when you run "git status"
> command???)---is not careful enough to notice that it does not
> matter even if that leftover file is unusable.
> 
> Two issues "the sequencer" folks may want to address are
> 
>  (1) make the one that reads an irrelevant/stale 'todo' file more
>      careful to ignore errors in such a file;
> 
>  (2) make the sequencer machinery more careful to clean up after it
>      is done or it is aborted  (for example, "git reset --hard"
>      could remove these state files preemptively even when a rebase
>      is not in progress, I would think).
> 
> I think we already had some patches toward the latter recently.

Maybe I am not understanding it correctly, but do you mean in (2) that
"git reset --hard" would always clear sequencer state? That seems
undesirable to me, as I often use "git reset" to move the head around
during a rebase. (e.g., when using "rebase -i" to split apart I commit,
I stop on that commit, "git reset" back to the parent, and then
selectively "add -p" the various parts).

Direction (1) seems quite sensible to me, though.

-Peff
