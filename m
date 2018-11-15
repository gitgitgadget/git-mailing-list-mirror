Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196B11F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 16:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbeKPCvg (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 21:51:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:40766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387839AbeKPCvf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 21:51:35 -0500
Received: (qmail 14337 invoked by uid 109); 15 Nov 2018 16:43:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 16:43:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17564 invoked by uid 111); 15 Nov 2018 16:42:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 11:42:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 11:43:01 -0500
Date:   Thu, 15 Nov 2018 11:43:01 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?R2HDq2w=?= Lhez <gael.lhez@gmail.com>
Subject: Re: [PATCH v2 1/1] bundle: cleanup lock files on error
Message-ID: <20181115164300.GA29290@sigill.intra.peff.net>
References: <pull.79.git.gitgitgadget@gmail.com>
 <pull.79.v2.git.gitgitgadget@gmail.com>
 <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com>
 <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com>
 <CAGZ79kZ_wrQ=OdJ6xWbL+F5RDb38YAmzc87o8A=Zb8zBywMJBQ@mail.gmail.com>
 <20181115043409.GA3419@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811151354150.41@tvgsbejvaqbjf.bet>
 <20181115133749.GA26164@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811151725310.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1811151725310.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 05:32:15PM +0100, Johannes Schindelin wrote:

> I cannot claim that I wrapped my head around your explanation or your diff (I am
> busy trying to prepare Git for Windows' `master` for rebasing to v2.20.0-rc0),
> but it does fix the problem. Thank you so much!
> 
> The line `test_expect_code 1 ...` needs to be adjusted to `test_expect_code
> 128`, of course, and to discern from the fixed problem (which also exits with
> code 128), the error output should be verified, like so:
> 
> -- snip --
> test_expect_success 'try to create a bundle with empty ref count' '
> 	test_must_fail git bundle create foobar.bundle master..master 2>err &&
> 	test_i18ngrep "Refusing to create empty bundle" err
> '
> -- snap --

It seems like we should be checking that the stale lockfile isn't left,
which is the real problem (the warning is annoying, but is a symptom of
the same thing). I.e., something like:

  test_must_fail git bundle create foobar.bundle master..master &&
  test_path_is_missing foobar.bundle.lock

That would already pass on non-Windows platforms, but that's OK. It will
never give a false failure.

If you don't mind, can you confirm that the test above fails without
either of the two patches under discussion?

> Do you want to integrate this test into your patch and run with it, or do you
> want me to shepherd your patch?

I'll wrap it up with a commit message and a test.

-Peff
