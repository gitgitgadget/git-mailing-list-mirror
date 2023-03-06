Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106EFC678D4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 08:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCFI5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 03:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCFI5L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 03:57:11 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5D71F5DA
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 00:57:10 -0800 (PST)
Received: (qmail 5451 invoked by uid 109); 6 Mar 2023 08:57:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Mar 2023 08:57:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27817 invoked by uid 111); 6 Mar 2023 08:57:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Mar 2023 03:57:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Mar 2023 03:57:09 -0500
From:   Jeff King <peff@peff.net>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] test-lib: allow storing counts with test harnesses
Message-ID: <ZAWq5VFE/UjjtPJS@coredump.intra.peff.net>
References: <20221224225200.1027806-1-adam@dinwoodie.org>
 <20230304212220.qkzc2joco5xj7d4s@lucy.dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230304212220.qkzc2joco5xj7d4s@lucy.dinwoodie.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 04, 2023 at 09:22:20PM +0000, Adam Dinwoodie wrote:

> Currently, test result files are only stored in test-results/*.counts if
> $HARNESS_ACTIVE is not set.  This dates from 8ef1abe550 (test-lib: Don't
> write test-results when HARNESS_ACTIVE, 2010-08-11), where the
> assumption was that if someone were using a test harness like prove,
> that would track results and the count files wouldn't be required.
> However, as of 49da404070 (test-lib: show missing prereq summary,
> 2021-11-20), those files also store the list of git test prerequisites
> that were missing during the test run, which isn't something that a
> generic test harness like prove can provide.
> 
> To allow folk using test harnesses to access the lists of missing
> prerequisites, add a --counts argument to test-lib that will keep these
> counts files even if a test harness is in use.  This means that a
> subsequent call of, say, `make -C t aggregate-results` will report
> useful information.

Your goal seems reasonable. I have to wonder if it is even worth
requiring "--counts" here, though. Even 8ef1abe550 claims that the I/O
from writing the results files is minimal. And certainly I run under
prove with "--root=/some/ram/disk", and I haven't noticed any difference
with and without my usual "--verbose-log", which writes a lot more data
into test-results/.

So would it be worth it to just revert 8ef1abe550, and always store the
meta-files? That's one less option to support, and one less surprise
when some other feature is built around them.

Or is there some reason that we really want to have a mode where nothing
is written into t/? From reading 8ef1abe550 it sounded like this was
mostly a hygiene / optimization thing, and not some special mode we
cared about supporting.

>  t/test-lib.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

The patch itself looks correct, if we want to go with a --counts option.

-Peff
