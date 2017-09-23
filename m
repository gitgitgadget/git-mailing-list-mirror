Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 443EB20281
	for <e@80x24.org>; Sat, 23 Sep 2017 16:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750896AbdIWQNU (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 12:13:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:48118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750778AbdIWQNT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 12:13:19 -0400
Received: (qmail 20145 invoked by uid 109); 23 Sep 2017 16:13:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 16:13:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13482 invoked by uid 111); 23 Sep 2017 16:13:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 12:13:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Sep 2017 12:13:16 -0400
Date:   Sat, 23 Sep 2017 12:13:16 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] reroll ma/plugleaks; more `object_array`-fixes
Message-ID: <20170923161316.yntnccqrhv5d3jza@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com>
 <20170923043701.4s3xuytp5hdjwmsy@sigill.intra.peff.net>
 <CAN0heSrPBDi4q9fqr=qoTbjRHpFS_VEL0O8=MFFJ4DLCuJwahA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrPBDi4q9fqr=qoTbjRHpFS_VEL0O8=MFFJ4DLCuJwahA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2017 at 11:54:31AM +0200, Martin Ågren wrote:

> Unfortunately, I have not figured out how to get LSan to simply report
> the leaks and continue. Its default behavior is to abort if there are
> leaks. That's useful for finding the first leaking test, but not much
> else. (Later tests might depend on that test doing everything it should,
> so now those later tests will start failing and/or executing different
> code paths.)
> 
> I can tell LeakSanitizer to exit with an exit code instead, but then all
> leaking git-processes exit with the same exit code. That also interferes
> with the tests.
> 
> What I would like is for the git-process to exit with the same exit
> status it would have had without the leak-checking. That would make it
> possible to run the whole test suite, collect all leaks, identify
> duplicates, sort them, categorize them, prioritize them, track how we
> are progressing...

Doesn't:

  LSAN_OPTIONS=abort_on_error=0:exitcode=0

do what you want? I get:

  $ export LSAN_OPTIONS=abort_on_error=0:exitcode=0

  [no leaks, no error]
  $ ./git rev-parse HEAD; echo $?
  0

  [no leaks, error]
  $ ./git rev-parse broken; echo $?
  ...
  128

  [leaks, no error]
  $ ./git --no-pager show; echo $?
  ...
  SUMMARY: LeakSanitizer: 40 byte(s) leaked in 4 allocation(s).
  0

  [leaks, error]
  $ ./git --no-pager show broken; echo $?
  ...
  SUMMARY: LeakSanitizer: 35 byte(s) leaked in 3 allocation(s).
  128

In theory you should be able to just add "log_path=/tmp/lsan/output" to
that, which should put all the logs in a convenient place (and stop the
extra output from confusing any tests which capture stderr). But I can't
seem to get log_path to do anything, contrary to the documentation.

Doing log_to_syslog=1 does work for me. I'm not sure if it's a bug or
I'm holding it wrong. But it does seem like it should be possible to do
what you want.

-Peff
