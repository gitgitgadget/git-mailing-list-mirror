Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32C31F461
	for <e@80x24.org>; Sat, 11 May 2019 22:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfEKWbW (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 18:31:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:54934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726033AbfEKWbW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 18:31:22 -0400
Received: (qmail 23777 invoked by uid 109); 11 May 2019 22:31:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 May 2019 22:31:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27310 invoked by uid 111); 11 May 2019 22:31:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 11 May 2019 18:31:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 May 2019 18:31:20 -0400
Date:   Sat, 11 May 2019 18:31:20 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Antonio Ospite <ao2@ao2.it>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: new segfault in master (6a6c0f10a70a6eb1)
Message-ID: <20190511223120.GA25224@sigill.intra.peff.net>
References: <20190511205711.tdclwrdixaau75zv@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190511205711.tdclwrdixaau75zv@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 11, 2019 at 08:57:11PM +0000, Eric Wong wrote:

> This test-tool submodule segfault seems new.  Noticed it while
> checking dmesg for other things.

Yeah, I hadn't seen it before. It's almost certainly the expect_failure
added in 2b1257e463 (t/helper: add test-submodule-nested-repo-config,
2018-10-25), since otherwise we'd be complaining of a test failure.

I know we don't expect this to do the right thing yet, but it seems like
there's still a bug, since the test seems to think we should output a
nice message (and it's possible that the segfault can be triggered from
non-test-tool code, too).

+cc the author.

> There's also "name-rev HEAD~4000" (bottom), which is old, I think...
> [...]
> Looks like a stack overflow:

Yeah, this one is old and expected. It's also in an expect_failure. The
CI we run things through at GitHub complains if there are any segfaults,
and I hacked around it with the patch below.

I sort of assumed nobody else cared, since they hadn't mentioned it. But
we could do something similar. Though note in my version the default is
"do not run the test", and we'd maybe want to flip it the other way (and
also break up the setup step so that the succeeding test actually runs).

-- >8 --
Subject: [PATCH] t6120: mark a failing test with SEGFAULT_OK prereq

Upstream recently added a test of name-rev on a deep repository, which
shows that its recursive algorithm can blow out the stack and segfault.
We have several such tests already, but the twist here is that it's
expect_failure. So we _know_ it's going to segfault and Git's test suite
is OK with that, until the problem is fixed.

But our CI is not so forgiving. If it sees any segfault at all, it
interrupts the test run and declares the whole thing a failure.

Let's just skip this test by adding a prerequisite that isn't filled.
It's not telling us anything interesting. And if it ever gets fixed
upstream, that will cause a conflict and we can start running it.

Note that we also have to skip the test after it, which relies on the
state set up by the first one. This isn't a big deal, as it's not
testing code that we're likely to change ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6120-describe.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 1c0e8659d9..9d98b95ba6 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -310,7 +310,7 @@ test_expect_success 'describe ignoring a borken submodule' '
 	grep broken out
 '
 
-test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
+test_expect_failure ULIMIT_STACK_SIZE,SEGFAULT_OK 'name-rev works in a deep repo' '
 	i=1 &&
 	while test $i -lt 8000
 	do
@@ -331,7 +331,7 @@ EOF"
 	test_cmp expect actual
 '
 
-test_expect_success ULIMIT_STACK_SIZE 'describe works in a deep repo' '
+test_expect_success ULIMIT_STACK_SIZE,SEGFAULT_OK 'describe works in a deep repo' '
 	git tag -f far-far-away HEAD~7999 &&
 	echo "far-far-away" >expect &&
 	git describe --tags --abbrev=0 HEAD~4000 >actual &&
-- 
2.21.0.1388.g2b1efd806f

