Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 576731F461
	for <e@80x24.org>; Tue, 27 Aug 2019 09:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfH0JMJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 05:12:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59735 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0JMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 05:12:09 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i2XWJ-0000Qt-8Z; Tue, 27 Aug 2019 11:12:07 +0200
Message-ID: <1566897126.4102.5.camel@pengutronix.de>
Subject: Re: git slow unless piped to cat
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, entwicklung@pengutronix.de
Date:   Tue, 27 Aug 2019 11:12:06 +0200
In-Reply-To: <20190827085637.g6cpnuofpteyfqfz@pengutronix.de>
References: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
         <20190827084111.GU20404@szeder.dev>
         <20190827085637.g6cpnuofpteyfqfz@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2019-08-27 at 10:56 +0200, Uwe Kleine-König wrote:
> On Tue, Aug 27, 2019 at 10:41:11AM +0200, SZEDER Gábor wrote:
> > On Tue, Aug 27, 2019 at 10:15:59AM +0200, Uwe Kleine-König wrote:
> > > I have a problem here with git being slow in some situations.
> > > Using git 2.23.0 (from Debian) the effect is:
> > > 
> > > ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git show v5.2
> > > tag v5.2
> > > ...
> > > 
> > > real	0m12.727s
> > > user	0m0.300s
> > > sys	0m0.371s
> > > 
> > > But to get the actual data isn't the problem:
> > > 
> > > ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git show v5.2 | cat
> > > tag v5.2
> > > ...
> > > 
> > > real	0m0.764s
> > > user	0m0.014s
> > > sys	0m0.020s
> > > 
> > 
> > How does 'git --no-pager show v5.2' perform?  If it's as fast as the
> > case piping the output to cat, then look into what pager and pager
> > options you use.
> 
> 	ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git --no-pager show v5.2
> 	tag v5.2
> 	...
> 
> 	real	0m13.225s
> 	user	0m0.355s
> 	sys	0m0.336s
> 
> So this doesn't seem to be the problem. Also the local configuration
> can be ruled out:
> 
> 	ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time env GIT_CONFIG_NOSYSTEM=1 HOME=/nonexistant XDG_CONFIG_HOME=/nonexistant git --no-pager show --no-color v5.2
> 	tag v5.2
> 	...
> 
> 	real	0m13.587s
> 	user	0m0.335s
> 	sys	0m0.336s
> 
> Thanks
> Uwe

Have you checked strace output? I see a directory walk through .git/refs
and .git/packed-refs if the output is not redirected.

regards
Philipp
