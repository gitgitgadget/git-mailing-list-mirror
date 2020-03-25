Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AE3C18E5B
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0234C20663
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgCYJEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:04:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54787 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgCYJEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 05:04:30 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jH1xa-00076v-Vn; Wed, 25 Mar 2020 10:04:26 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jH1xa-0000Av-5C; Wed, 25 Mar 2020 10:04:26 +0100
Date:   Wed, 25 Mar 2020 10:04:26 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        oystwa@gmail.com, entwicklung@pengutronix.de
Subject: git log behaves strange on non-monotonic commit dates [Was: Re: bug
 in git-log with funny merges]
Message-ID: <20200325090426.3kd7o64vyb5mykmj@pengutronix.de>
References: <20200324172949.yx7kketvkkl5lyvt@pengutronix.de>
 <20200325053039.GA651138@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200325053039.GA651138@coredump.intra.peff.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Jeff,

I adapted the subject for the new evidences.

On Wed, Mar 25, 2020 at 01:30:39AM -0400, Jeff King wrote:
> On Tue, Mar 24, 2020 at 06:29:49PM +0100, Uwe Kleine-König wrote:
> 
> > So v5.4.27 is an ancestor of HEAD:
> > 
> > 	$ git merge-base --is-ancestor v5.4.27 @ && echo yes
> > 	yes
> > 
> > But!:
> > 
> > 	$ git rev-list --count HEAD..v5.4.27
> > 	3868
> 
> Yeah, this seems impossible. If v5.4.27 is an ancestor of HEAD, then
> that rev-list result must be 0 commits. I'd trust merge-base over
> rev-list's limiting, as the latter can be confused by clock skew.
> 
> And indeed, doing:
> 
>   $ git log --graph --format='%h %cd' HEAD
> 
> does point to some weirdness:
> 
>   [...]
>   * | | d1437a91a10e Tue Mar 24 17:53:00 2020 +0100
>   * | | 803aad81ca69 Mon Feb 3 21:24:56 2020 +0100
>   * | | 8a4579487b00 Thu Jan 30 11:58:13 2020 +0100
>   * | | 25a9309d7ded Thu Jan 30 11:54:28 2020 +0100
>   * | | e8f40385c55d Thu Jan 30 14:15:47 2020 +0100
>   * | | b95a62694eae Wed Sep 30 11:19:29 2015 +0200
>   * | | f5af38a6b7a1 Thu Sep 19 17:59:29 2019 +0200
>   * | | 14075cd0ce1b Tue Nov 17 21:20:00 2015 +0100
>   * | | 338647d2ab5c Wed Jul 13 10:41:40 2016 +0200
>   * | | b31f3c6fbc18 Mon Sep 23 15:59:16 2019 +0200
>   * | | 585e0cc08069 Sat Mar 21 08:12:00 2020 +0100

> The commit dates are very out-of-order: we go back to January (and even
> to 2015!) for commits that are built on top of ones from last Saturday.

That's done because the linearisation of the patch stack (that is
created for consumption by quilt) uses the original committer dates for
reproducibility. hmm ...

> So while looking for a common ancestor with v5.4.27 (which is from only
> a few days ago), I think we'd stop walking if we're left only with
> UNINTERESTING commits (which these are, being ancestors of HEAD) that
> seem to be from long before the last interesting one.
> 
> There's a slop-counter which is supposed to skip over up to 5
> out-of-order commits, but that's clearly not enough here. Curiously,
> bumping it to 100k commits isn't enough for this case! I had to bump it
> to a million (effectively disabling the optimization entirely):
> 
> diff --git a/revision.c b/revision.c
> index 8136929e23..cf585f375e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1085,7 +1085,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
>  }
>  
>  /* How many extra uninteresting commits we want to see.. */
> -#define SLOP 5
> +#define SLOP 1000000
>  
>  static int still_interesting(struct commit_list *src, timestamp_t date, int slop,
>  			     struct commit **interesting_cache)
> 
> I guess this depth might have to do with some weird topology between
> linux-stable and linux.git (or maybe just something with your merge, I
> didn't look too closely).

> But my takeaways are:
> 
> One, whatever is generating this history is wrong. Author dates can be
> out of order (and it is perfectly reasonable to do so to represent
> cherry-picked or rebased commits). But commit dates should generally be
> monotonically increasing. If you're applying old patches, etc, you
> should be using the old date for the author timestamp, but the current
> time for the committer timestamp.

Yeah, will take that to the team to discuss how to improve our tool.

Thanks a lot for your analysis.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
