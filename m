Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34354C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 07:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiKAHj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 03:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKAHj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 03:39:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CB315A30
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 00:39:57 -0700 (PDT)
Received: (qmail 4798 invoked by uid 109); 1 Nov 2022 07:39:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 07:39:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20325 invoked by uid 111); 1 Nov 2022 07:39:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Nov 2022 03:39:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Nov 2022 03:39:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t5516/t5601: be less strict about the number of
 credential warnings
Message-ID: <Y2DNS0W5vgk2Q3qJ@coredump.intra.peff.net>
References: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
 <Y2CD6GBl6ORqKsug@coredump.intra.peff.net>
 <221101.861qqn5ovf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221101.861qqn5ovf.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 04:29:31AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > It is unclear as to _why_, but under certain circumstances the warning
> > about credentials being passed as part of the URL seems to be swallowed
> > by the `git remote-https` helper in the Windows jobs of Git's CI builds.
> 
> ..this description dosen't match what the patch is doing, okey, so
> there's a case where the remote helper swallows the warnings, i.e. we'll
> emit fewer than we expected...

So I really didn't revisit this commit much at all, and was just trying
to save Dscho (or Taylor) the work of having to rebase it, if we go with
my patch 1.

IMHO it is OK enough as it is, but if I were writing it from scratch I
probably would have given the rationale that the tests are insiting on a
dumb, sub-optimal behavior. And flakes or inconsistencies aside, they
should be asserting only the presence or absence of the message. And
probably would have left each at "grep" and dropped the test_line_count
totally.

It is not even clear to me that the remote-https is the one being
swallowed (at least, I have not seen an argument or evidence that this
is so; it does seem plausible).

> > @@ -654,7 +654,7 @@ test_expect_success 'push warns or fails when using username:password' '
> >  	test_must_fail git -c transfer.credentialsInUrl=die \
> >  		push $url_userpass 2>err &&
> >  	grep "fatal: $message" err >warnings &&
> > -	test_line_count = 1 warnings
> > +	test_line_count -ge 1 warnings
> >  '
> 
> ...but then why are we modifying these codepaths that have nothing to do
> with invoking the remote helper, i.e. where we die early before we get
> to that?

If you're arguing that we should only do s/= 3/-ge 1/ for the test that
is flaking, I could buy that. Though like I said, I consider the value
here to be focusing the purpose of the tests as much as dealing with the
flake.

I really don't care that much either way, though.

I'd also be fine with a separate test (marked expect_failure) that
checks the number of messages.

> And even if some of this was invoking that remote helper and we were
> modifying it blindly, then presumably the helper swallowing it would
> result in 0 some of the time, so "-ge 1" would be wrong.
> 
> (That's not the case, but it's why I think the patch doesn't make much
> sense).

I thought the point is that the outer program calling the helper would
consistently produce the error, always yielding at least one instance.
The helper one is generally "extra" and undesired.

-Peff
