Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917DCC43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 15:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344453AbiFIPXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344452AbiFIPXs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 11:23:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F3E4B42C
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 08:23:46 -0700 (PDT)
Received: (qmail 11250 invoked by uid 109); 9 Jun 2022 15:23:46 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jun 2022 15:23:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 9 Jun 2022 11:23:46 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, John Cai <johncai86@gmail.com>
Subject: Re: [RFC PATCH 1/3] test-tool: don't fake up BUG() exits as code 99
Message-ID: <YqIQghPvB/rbkos8@coredump.intra.peff.net>
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
 <RFC-patch-1.3-78431bdc8f0-20220525T234908Z-avarab@gmail.com>
 <xmqqv8theehf.fsf@gitster.g>
 <xmqqczfpe9ua.fsf@gitster.g>
 <YqD100DRVJoZCC+x@coredump.intra.peff.net>
 <220609.86czfitfgz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220609.86czfitfgz.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 09, 2022 at 10:09:25AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > IMHO the whole "let's trigger BUG() intentionally via test-tool" stuff
> > in t1406 is misguided. It's literally introducing broken code that is
> > not run in the normal Git binary in order to make sure that it's broken.
> 
> I haven't looked at that ref code in particular, but in general adding
> coverage for the case we actually expect to defend against with BUG()
> via a test-tool is something I think we could use in more cases.
> 
> E.g. parse-options.c will BUG() out on various bad options structs,
> there it makes sense to feed those bad structs in to make sure our
> assertion code is doing what we still expect, but we don't have those
> tests.

These seem like low-value tests to me. Once you've identified a case in
parse-options.c that should BUG(), it's not very many lines of code to
detect it and call the function. But to then create a test case,
including a harness that triggers the internal code in such a way that
is designed never to happen in the production code, seems much more
error prone to me.

I.e., it is very unlikely to me that such a test case will find an
actual problem, and it carries a lot of scaffolding cost.

Meanwhile the much more likely problem is that a BUG() can be triggered,
but we simply don't have test coverage of the right cases. Once you've
identified the case, the problem can be demonstrated (and fixed) in the
production code.

> I didn't know about that Jenkins case, but in any case I think we can
> probably stop worrying about this given that we haven't had complaints
> about ac14de13b22 (t4058: explore duplicate tree entry handling in a bit
> more detail, 2020-12-11) (although I've noticed in in "dmesg" before).

I didn't notice those ones. It's probable that the CI instance I was
using at GitHub changed under the hood. And GitHub is more likely than
most people to run git's test suite in a CI environment. :) So yeah, it
may not matter that much. I do still think dumping cores around the
filesystem (remembering that they do not always go into the trash
directory) and polluting the kernel log are a bit unfriendly. If we can
avoid it easily, it might be worth doing.

> On the other hand those segfaults in t4058 should probably be converted
> to a BUG()...

Agreed. Those stack-exhaustion ones (which were what originally alerted
me to the Jenkins issue) are hard to catch.

-Peff
