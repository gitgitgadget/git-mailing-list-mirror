Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2724CA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 08:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjILI1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 04:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjILI1s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 04:27:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F14FE6F
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 01:27:44 -0700 (PDT)
Received: (qmail 14521 invoked by uid 109); 12 Sep 2023 08:27:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Sep 2023 08:27:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16770 invoked by uid 111); 12 Sep 2023 08:27:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Sep 2023 04:27:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Sep 2023 04:27:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/2] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
Message-ID: <20230912082742.GB1630538@coredump.intra.peff.net>
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
 <64825651-00d2-d2c5-2da2-91a9917bef21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64825651-00d2-d2c5-2da2-91a9917bef21@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2023 at 01:09:52AM +0200, Rubén Justo wrote:

> GIT_TEST_SANITIZE_LEAK_LOG=true with a test that leaks, will make the
> test return zero unintentionally:
> 
>   $ git checkout v2.40.1
>   $ make SANITIZE=leak
>   $ make -C t GIT_TEST_SANITIZE_LEAK_LOG=true t3200-branch.sh
>   ...
>   With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!
>   # faked up failures as TODO & now exiting with 0 due to --invert-exit-code
> 
> Let's use invert_exit_code only if needed.

Hmm, OK. So we saw some actual test errors (maybe from leaks or maybe
not), but then we _also_ saw entries in the leak-log. So the inversion
cancels out, and we accidentally say everything is OK, which is wrong.

I'm not quite sure of your fix, though. In the if-else chain you're
touching, we know going in that we found a leak in the log. And then we
cover these 5 cases:

  1. if the test is marked as passing-leak
    a. if we saw no test failures, invert (and mention the leaking log)
    b. otherwise, do not invert (and mention the log)
  2. else if we are in "check" mode
    a. if we saw no test failures, do not invert (we do have a leak,
       which is equivalent to a test failure). Mention the log.
    b. otherwise, invert (to switch back to "success", since we are
       looking for leaks), but still mention the log.
  3. invert to trigger failure (and mention the log)

And the problem is in (3). You switch it to trigger only if we have no
failures (fixing the inversion). But should we have the same a/b split
for this case? I.e.:

  3a. if we saw no test failures, invert to cause a failure
  3b. we saw other failures; do not invert, but _do_ mention that the
      log found extra leaks

In 3b we are explaining to the user what happened. Though maybe it is
not super important, because I think we'd have dumped the log contents
anyway?

Other than that, I think the patch is correct. I wondered when we ran
this "check_test_results_san_file_" code, but it is only at the end of
the script. So we are OK to make a definitive call on the zero/non-zero
count of failed tests.

-Peff
