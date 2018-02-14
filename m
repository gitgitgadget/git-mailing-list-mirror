Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E13E1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 03:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966633AbeBNDQR (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 22:16:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:51768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966600AbeBNDQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 22:16:16 -0500
Received: (qmail 16061 invoked by uid 109); 14 Feb 2018 03:16:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 03:16:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26739 invoked by uid 111); 14 Feb 2018 03:17:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 13 Feb 2018 22:17:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Feb 2018 22:16:14 -0500
Date:   Tue, 13 Feb 2018 22:16:14 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 3/7] worktree move: new command
Message-ID: <20180214031614.GC25188@sigill.intra.peff.net>
References: <20180124095357.19645-1-pclouds@gmail.com>
 <20180124095357.19645-4-pclouds@gmail.com>
 <CAPig+cQeQRppb2y4YyQnqWWnCO0TXE-PjfTAhxakCJNk45ec1w@mail.gmail.com>
 <CAPig+cRYL6-jEgsQoiQokNSd0zq5zoFkMHBA0Vp9kqa0LvMnsA@mail.gmail.com>
 <CACsJy8A+zMTC2N8Y0Ua-KyLF6Wp2oHL=8mbsSXck6mKZGG=37g@mail.gmail.com>
 <20180206021313.GA26323@sigill.intra.peff.net>
 <CAN0heSofAfuXEUKcfF00ni_a7nAKJYySF_UEnNTL8+nHiBzw-A@mail.gmail.com>
 <CACsJy8BjFex==2UQV6-k4_rTnBijJOzBAOmtNmZopc87U19Jmg@mail.gmail.com>
 <CAN0heSpxcm1a9KN3etWAD5Vc_gkabQmEppa_1P4soZSZOnP8pg@mail.gmail.com>
 <20180213002758.GA9274@duynguyen.dek-tpc.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213002758.GA9274@duynguyen.dek-tpc.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 07:27:58AM +0700, Duy Nguyen wrote:

> > Makes sense to try to make sure that we don't regress leak-free tests. I
> > don't know what our Travis-budget looks like, but I would volunteer to
> > run something like this periodically using my own cycles.
> > 
> > My experience with the innards of our Makefiles and test-lib.sh is
> > non-existant, but from a very cursory look it seems like something as
> > simple as loading GIT_SKIP_TESTS from a blacklist-file might do the
> > trick.
> 
> Yeah my first throught was something along that line too. But maybe
> it's nicer to mark a test file leak-free like this:
> 
> -- 8< --
> diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
> index 459f676683..1446f075b7 100755
> --- a/t/t2028-worktree-move.sh
> +++ b/t/t2028-worktree-move.sh
> @@ -2,6 +2,8 @@
>  
>  test_description='test git worktree move, remove, lock and unlock'
>  
> +test_leak_free=yes
> +
>  . ./test-lib.sh
>  
>  test_expect_success 'setup' '
> -- 8< --

Hmm. That is not too bad, but somehow it feels funny to me to be
polluting each test script with these annotations. And to be driving it
from inside the test scripts.

It seems like:

  make SANITIZE=leak test GIT_SKIP_TESTS="$(cat known-leaky)"

would be sufficient. And updating the list would just be:

  # assume we're using prove, which will keep running after failure,
  # and will record the results for us to parse (using "--state=").
  # Otherwise use "make -k" and grep in t/test-results.
  make SANITIZE=leak test
  (cd t && prove --dry --state=failed) |
  perl -lne '/^(t[0-9]{4})-.*.sh$/ and print $1' |
  sort >known-leaky

That would update both now-passing and now-failing tests. Presumably
we'd keep it checked in, so "git diff" would show you the changes.

-Peff
