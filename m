Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B3DA1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 08:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfH0IQC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 04:16:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55349 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbfH0IQB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 04:16:01 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i2Wdz-00034d-VN; Tue, 27 Aug 2019 10:15:59 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i2Wdz-0006sZ-N5; Tue, 27 Aug 2019 10:15:59 +0200
Date:   Tue, 27 Aug 2019 10:15:59 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     git@vger.kernel.org
Cc:     entwicklung@pengutronix.de
Subject: git slow unless piped to cat
Message-ID: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have a problem here with git being slow in some situations.
Using git 2.23.0 (from Debian) the effect is:

ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git show v5.2
tag v5.2
...

real	0m12.727s
user	0m0.300s
sys	0m0.371s

But to get the actual data isn't the problem:

ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git show v5.2 | cat
tag v5.2
...

real	0m0.764s
user	0m0.014s
sys	0m0.020s

My expectation is that both commands should take approximately the same
amount of time. This is 100% reproducible here.

The backing filesystem could be quicker (don't know, this is xfs in an
logical volume) but this applies to both calls, so this doesn't seem to
be the biggest culprit at least.

This is not a regression, I see similar problems since >2 years. (Didn't
report before because I didn't know such an obvious reproducer.)

Using perf I get in the first case:

   7.99%  git      libz.so.1.2.11      [.] inflate
   3.02%  git      libc-2.28.so        [.] __memcmp_sse4_1
   1.67%  git      [kernel.kallsyms]   [k] __list_del_entry_valid
   1.32%  git      [kernel.kallsyms]   [k] unmap_page_range
   1.25%  git      [kernel.kallsyms]   [k] filemap_map_pages
   ...

while with cat I get:

   3.35%  git      [kernel.kallsyms]  [k] __update_load_avg_cfs_rq
   3.22%  git      [kernel.kallsyms]  [k] update_blocked_averages
   2.37%  git      [kernel.kallsyms]  [k] __list_del_entry_valid
   1.92%  git      [kernel.kallsyms]  [k] hrtimer_interrupt
   1.91%  git      [kernel.kallsyms]  [k] __pagevec_lru_add_fn

It doesn't seem to be related to stdio buffering or coloring as

	stdbuf -o0 git show --no-color v5.2

is slow, too.

Any idea what could be the problem? Is there some info that I might
report additionally to make this better understandable?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
