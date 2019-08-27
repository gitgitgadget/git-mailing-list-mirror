Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0197A1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 21:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfH0Vcw (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 17:32:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41873 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0Vcv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 17:32:51 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i2j57-0002ho-0q; Tue, 27 Aug 2019 23:32:49 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i2j56-0007x6-Bf; Tue, 27 Aug 2019 23:32:48 +0200
Date:   Tue, 27 Aug 2019 23:32:48 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, git@vger.kernel.org,
        entwicklung@pengutronix.de
Subject: Re: git slow unless piped to cat
Message-ID: <20190827213248.kzpszutt46ipboq4@pengutronix.de>
References: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
 <20190827084111.GU20404@szeder.dev>
 <20190827085637.g6cpnuofpteyfqfz@pengutronix.de>
 <1566897126.4102.5.camel@pengutronix.de>
 <20190827094407.GV20404@szeder.dev>
 <20190827100427.u3a5uvmylm5vddn2@pengutronix.de>
 <20190827185929.GA3150@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827185929.GA3150@sigill.intra.peff.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 02:59:30PM -0400, Jeff King wrote:
> On Tue, Aug 27, 2019 at 12:04:27PM +0200, Uwe Kleine-König wrote:
> 
> > 	$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time env GIT_CONFIG_NOSYSTEM=1 HOME=/nonexistant XDG_CONFIG_HOME=/nonexistant git --no-pager show --no-color --no-decorate v5.2
> > 	...
> > 
> > 	real	0m1.041s
> > 	user	0m0.000s
> > 	sys	0m0.021s
> > 
> > 	$ git for-each-ref |wc -l
> > 	10013
> > 
> > So this is indeed the problem.
> 
> That's not that many refs. Are they mostly unpacked? Loose refs are
> awful on a cold cache, since it's one inode per ref (or worse, since it
> has walk the directories, too).
> 
> Try:
> 
>   find .git/refs -type f | wc -l

ukl@dude.ptx:/ptx/src/git/linux.git$ find refs -type f | wc -l 
2874

(Note this is a bare repository. So I used refs instead of .git/refs.)

> to see the loose ones. If there are a lot, try:
> 
>   git pack-refs --prune --all
> 
> (or just "git gc", which does this).

This is a daily updated mirror that is also incrementally backed up. I
repack from time to time, but hesitate to do this regularily as each
time I repack the next backup run is "expensive" and I get many small
packs. I did this now anyhow.

After that I have:

	$ find objects/[0-9a-f][0-9a-f] -type f | wc -l
	166
	$ find objects/pack | wc -l
	98

> Modern versions of Git should delete any leftover empty directories
> after pruning the loose variants, but I think won't go out of their way
> to remove ones they didn't delete from. And those are still expensive to
> walk on a cold cache. If it's still slow, try:
> 
>   find .git/refs/* -type d | xargs rmdir -v

There were a few:

$ find refs/ -depth -type d -empty -print -delete | wc -l
147

(Oops, after the repacking above this also removed ./refs which I had to
restore to make git recognize this as a repository.)

With these two things done it is a bit faster:

	$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time env GIT_CONFIG_NOSYSTEM=1 HOME=/nonexistant XDG_CONFIG_HOME=/nonexistant git --no-pager show --no-color v5.2 
	tag v5.2

	...
	real	0m11.022s
	user	0m0.321s
	sys	0m0.248s

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
