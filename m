Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474BB1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 10:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfH0KE3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 06:04:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57451 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0KE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 06:04:29 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i2YKx-00078A-Rc; Tue, 27 Aug 2019 12:04:27 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i2YKx-0002HR-J2; Tue, 27 Aug 2019 12:04:27 +0200
Date:   Tue, 27 Aug 2019 12:04:27 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, git@vger.kernel.org,
        entwicklung@pengutronix.de
Subject: Re: git slow unless piped to cat
Message-ID: <20190827100427.u3a5uvmylm5vddn2@pengutronix.de>
References: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
 <20190827084111.GU20404@szeder.dev>
 <20190827085637.g6cpnuofpteyfqfz@pengutronix.de>
 <1566897126.4102.5.camel@pengutronix.de>
 <20190827094407.GV20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827094407.GV20404@szeder.dev>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 11:44:07AM +0200, SZEDER Gábor wrote:
> On Tue, Aug 27, 2019 at 11:12:06AM +0200, Philipp Zabel wrote:
> > On Tue, 2019-08-27 at 10:56 +0200, Uwe Kleine-König wrote:
> > > On Tue, Aug 27, 2019 at 10:41:11AM +0200, SZEDER Gábor wrote:
> > > > On Tue, Aug 27, 2019 at 10:15:59AM +0200, Uwe Kleine-König wrote:
> > > > > I have a problem here with git being slow in some situations.
> > > > > Using git 2.23.0 (from Debian) the effect is:
> > > > > 
> > > > > ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git show v5.2
> > > > > tag v5.2
> > > > > ...
> > > > > 
> > > > > real	0m12.727s
> > > > > user	0m0.300s
> > > > > sys	0m0.371s
> > > > > 
> > > > > But to get the actual data isn't the problem:
> > > > > 
> > > > > ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git show v5.2 | cat
> > > > > tag v5.2
> > > > > ...
> > > > > 
> > > > > real	0m0.764s
> > > > > user	0m0.014s
> > > > > sys	0m0.020s
> > > > > 
> > > > 
> > > > How does 'git --no-pager show v5.2' perform?  If it's as fast as the
> > > > case piping the output to cat, then look into what pager and pager
> > > > options you use.
> > > 
> > > 	ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git --no-pager show v5.2
> > > 	tag v5.2
> > > 	...
> > > 
> > > 	real	0m13.225s
> > > 	user	0m0.355s
> > > 	sys	0m0.336s
> > > 
> > > So this doesn't seem to be the problem. Also the local configuration
> > > can be ruled out:
> > > 
> > > 	ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time env GIT_CONFIG_NOSYSTEM=1 HOME=/nonexistant XDG_CONFIG_HOME=/nonexistant git --no-pager show --no-color v5.2
> > > 	tag v5.2
> > > 	...
> > > 
> > > 	real	0m13.587s
> > > 	user	0m0.335s
> > > 	sys	0m0.336s
> > > 
> > > Thanks
> > > Uwe
> > 
> > Have you checked strace output? I see a directory walk through .git/refs
> > and .git/packed-refs if the output is not redirected.
> 
> That's a good point, 'git show/log' show decorations (refs pointing to
> any commits shown) when the output is a terminal:
> 
>   $ git show v5.2
>   [...]
>   commit 0ecfebd2b52404ae0c54a878c872bb93363ada36 (HEAD -> master, tag: v5.2)
>   [...]
>   $ git show v5.2 |cat
>   [...]
>   commit 0ecfebd2b52404ae0c54a878c872bb93363ada36
>   [...]

> And indeed, if you have a lot of refs and cold cache, then that might
> account for a couple of seconds difference.  So, how does 'git show
> --no-decorate v5.2' perform, and if it performs well, then how many
> refs do you have ('git for-each-ref |wc -l')?

	$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time env GIT_CONFIG_NOSYSTEM=1 HOME=/nonexistant XDG_CONFIG_HOME=/nonexistant git --no-pager show --no-color --no-decorate v5.2
	...

	real	0m1.041s
	user	0m0.000s
	sys	0m0.021s

	$ git for-each-ref |wc -l
	10013

So this is indeed the problem.

I'm a bit surprised that the default for --decorate depends on the
output being a terminal.

Thanks for your help, I will think about what I want to do. Just using
--no-decorate will work, but isn't nice either. Will test if just
throwing away all those tags from linux-next will make this already
better.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
