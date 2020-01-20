Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F56FC32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 19:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725F3217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 19:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgATTpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:45:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:47592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgATTpS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 14:45:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A0C47AEAF;
        Mon, 20 Jan 2020 19:45:16 +0000 (UTC)
Date:   Mon, 20 Jan 2020 20:45:15 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Y2038 vs struct cache_time/time_t
Message-ID: <20200120194515.GE4113@kitsune.suse.cz>
References: <nycvar.QRO.7.76.6.2001201555220.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001201555220.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 20, 2020 at 08:38:51PM +0100, Johannes Schindelin wrote:
> Team,
> 
> today, in quite an entertaining thread on Twitter
> (https://twitter.com/jxxf/status/1219009308438024200) I read about yet
> another account how the Year 2038 problem already bites people. And costs
> real amounts of money.
> 
> And after I stopped shaking my head in disbelief, I had a quick look, and
> it seems that we're safe at least until February 7th, 2106. That's not
> great, but I plan on not being around at that date anymore, so there. That
> date is when the unsigned 32-bit Unix epoch will roll over and play
> dead^W^Wwreak havoc (iff the human species manages to actually turn around
> and reverse the climate catastrophe it caused, and that's a big iff):
> https://en.wikipedia.org/wiki/Time_formatting_and_storage_bugs#Year_2106
> 
> Concretely, it looks as if we store our own timestamps on disk (in the
> index file) as uint32_t:
> 
> 	/*
> 	 * The "cache_time" is just the low 32 bits of the
> 	 * time. It doesn't matter if it overflows - we only
> 	 * check it for equality in the 32 bits we save.
> 	 */
> 	struct cache_time {
> 		uint32_t sec;
> 		uint32_t nsec;
> 	};
> 
> The comment seems to indicate that we are still safe even if 2106 comes
> around, but I am not _quite_ that sure, as I expect us to have "greater
> than" checks, not only equality checks.
> 
> But wait, we're still not quite safe. If I remember correctly, 32-bit
> Linux still uses _signed_ 32-bit integers as `time_t`, so when we render
> dates, for example, and use system-provided functions, on 32-bit Linux we
> will at least show the wrong dates starting 2038.
> 
> This got me thinking, and I put on my QA hat. Kids, try this at home:
> 
> 	$ git log --until=1.january.1960
> 
> 	$ git log --since=1.january.2200
> 
> Git does not really do what you expected, eh?
> 
> Maybe we want to do something about that, and while at it also fix the
> overflow problems, probably requiring a new index format?

Which means we can split off the timestamps to a separate file, too ;-)

Thanks

Michal
