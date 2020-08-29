Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA4CC433E2
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 06:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B15020838
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 06:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgH2Gqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 02:46:51 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:38684 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgH2Gqv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 02:46:51 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Bdn7X6f6Fz1qrM7;
        Sat, 29 Aug 2020 08:46:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Bdn7X6PlBz1qspJ;
        Sat, 29 Aug 2020 08:46:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id dFhBYFa7163x; Sat, 29 Aug 2020 08:46:48 +0200 (CEST)
X-Auth-Info: ZhCFAkM+crnDTMuD4Ul2CZte1HO20LKa7+5654ltsgUL4yGP5+uJ4srl5c3mCZEp
Received: from hase.home (ppp-46-244-166-85.dynamic.mnet-online.de [46.244.166.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 29 Aug 2020 08:46:48 +0200 (CEST)
Received: by hase.home (Postfix, from userid 1000)
        id 1FD171027EE; Sat, 29 Aug 2020 08:46:47 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Ivan Baldo <ibaldo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fastest way to set files date and time to latest commit time of
 each one
References: <CAEbcw=3mOoYuJo2mQgqB2aJgn-D2i_7ZRmhfPvYNVHD1Kp8wuA@mail.gmail.com>
X-Yow:  Should I do my BOBBIE VINTON medley?
Date:   Sat, 29 Aug 2020 08:46:46 +0200
In-Reply-To: <CAEbcw=3mOoYuJo2mQgqB2aJgn-D2i_7ZRmhfPvYNVHD1Kp8wuA@mail.gmail.com>
        (Ivan Baldo's message of "Fri, 28 Aug 2020 22:36:10 -0300")
Message-ID: <87bliu9cfd.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using this script:

#!/bin/sh
git log --name-only --format=format:%n%ct -- "$@" |
perl -e 'my $do_date = 0; chomp(my $cdup = `git rev-parse --show-cdup`);
    while (<>) {
	chomp;
	if ($do_date) {
	    next if ($_ eq "");
	    die "Unexpected $_\n" unless /^[0-9]+$/;
	    $d = $_;
	    $do_date = 0;
	} elsif ($_ eq "") {
	    $do_date = 1;
	} elsif (!defined($seen{$_})) {
	    $seen{$_} = 1;
 	    utime $d, $d, "$cdup$_";
 	}
    }'

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
