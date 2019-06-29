Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6E31F461
	for <e@80x24.org>; Sat, 29 Jun 2019 05:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF2FQB (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 01:16:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:54840 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726352AbfF2FQB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 01:16:01 -0400
Received: (qmail 17510 invoked by uid 109); 29 Jun 2019 05:16:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Jun 2019 05:16:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23022 invoked by uid 111); 29 Jun 2019 05:16:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 29 Jun 2019 01:16:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Jun 2019 01:15:59 -0400
Date:   Sat, 29 Jun 2019 01:15:59 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Thurs. June 27)
Message-ID: <20190629051559.GA8908@sigill.intra.peff.net>
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
 <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
 <20190628064520.GB19777@sigill.intra.peff.net>
 <ddf13a6b-42f4-57ae-49f1-8cc758b1dc4b@gmail.com>
 <20190628235903.GB2625@sigill.intra.peff.net>
 <c2e0ceef-c14d-ea1d-7522-eab0bf2e48ce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2e0ceef-c14d-ea1d-7522-eab0bf2e48ce@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 09:36:14PM -0400, Derrick Stolee wrote:

> > Still, if it's not too painful to add them in time-wise, it probably
> > makes sense for the coverage tests to be as exhaustive as possible.
> 
> Unfortunately, even running the t9*.sh tests once (among the two runs:
> first with default options and then with several GIT_TEST_* options)
> causes the build to go beyond the three hour limit, and the builds time
> out.

Is that because you're running the tests sequentially, due to the
corruption of the gcov files?

I think something like this would work to get per-script profiles:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4b346467df..81841191d2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -369,6 +369,9 @@ TZ=UTC
 export LANG LC_ALL PAGER TZ
 EDITOR=:
 
+GCOV_PREFIX=$TEST_RESULTS_BASE.gcov
+export GCOV_PREFIX
+
 # GIT_TEST_GETTEXT_POISON should not influence git commands executed
 # during initialization of test-lib and the test repo. Back it up,
 # unset and then restore after initialization is finished.


And then you can reassemble that with something like this (gcov-tool
comes with gcc):

  for i in t/test-results/t*.gcov; do
    echo >&2 "Merging $i..."
    gcov-tool merge -o . . "$i/$PWD"
  done

The merge is pretty slow, though (and necessarily serial). I wonder if
you'd do better to dump gcov output from each directory and then collate
it as text. I've heard lcov also has better support for handling
multiple runs like this.

-Peff
