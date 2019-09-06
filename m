Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95571F4B7
	for <e@80x24.org>; Fri,  6 Sep 2019 19:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392978AbfIFTNC (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 15:13:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:42398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2392825AbfIFTNC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 15:13:02 -0400
Received: (qmail 22528 invoked by uid 109); 6 Sep 2019 19:13:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 19:13:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6598 invoked by uid 111); 6 Sep 2019 19:14:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 15:14:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 15:13:01 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH 2/2] ci: restore running httpd tests
Message-ID: <20190906191300.GA10769@sigill.intra.peff.net>
References: <20190621101812.27300-8-avarab@gmail.com>
 <20190906121326.23056-1-szeder.dev@gmail.com>
 <20190906121326.23056-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190906121326.23056-2-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 02:13:26PM +0200, SZEDER Gábor wrote:

> Once upon a time GIT_TEST_HTTPD was a tristate variable and we
> exported 'GIT_TEST_HTTPD=YesPlease' in our CI scripts to make sure
> that we run the httpd tests in the Linux Clang and GCC build jobs, or
> error out if they can't be run for any reason [1].

Yikes, good catch.

I wonder if it would be possible for the test suite to catch this. I
think env--helper would have written a message to stderr, but because we
use --exit-code, we can't tell the difference between that and "false".

I think we'd have go back to something more like:

  test_tristate () {
	bool=$(git env--helper --type=bool --default=true "$1") ||
		eval "error \"$1 is not a bool: \$$1\""
	test "$bool" = "true"
  }
  ...
  if test_tristate GIT_TEST_HTTPD
  then
	... use httpd ...
  fi

Not sure if it's worth it.

-Peff
