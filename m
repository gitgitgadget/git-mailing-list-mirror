Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17B2C2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 20:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DB62071E
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 20:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgKAUaR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 1 Nov 2020 15:30:17 -0500
Received: from wp368.webpack.hosteurope.de ([80.237.133.137]:43012 "EHLO
        wp368.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726848AbgKAUaQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Nov 2020 15:30:16 -0500
X-Greylist: delayed 734 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Nov 2020 15:30:16 EST
Received: from [2a02:810d:8abf:c4a8:7881:19a0:11:8ba]; authenticated
        by wp368.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kZJzT-0001W6-EC; Sun, 01 Nov 2020 21:30:15 +0100
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
References: <945ab20e-dcde-540e-83a5-83992c2187b1@enigmage.de>
 <87wnzbhntw.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Manuel_B=c3=a4renz?= <manuel@enigmage.de>
Subject: Re: Feature request: Exponential search in git bisect
Message-ID: <58ba4fcd-50ff-1d1a-fe11-1ee59ad1c533@enigmage.de>
Date:   Sun, 1 Nov 2020 21:30:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <87wnzbhntw.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-bounce-key: webpack.hosteurope.de;manuel@enigmage.de;1604262616;bbf5d90f;
X-HE-SMSGID: 1kZJzT-0001W6-EC
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Let's suppose we have a repository with 700 linear commits:
>     
>     set -e
>     
>     cd /tmp
>     rm -rf /tmp/test-repo
>     mkdir /tmp/test-repo
>     cd /tmp/test-repo
>     git init
>     
>     for i in $(seq 1 700)
>     do
>         touch $i
>         git add $i
>         git commit -m"add $i"
>     done
>
> Then let's bisect it from the root:
>     
>     git bisect start HEAD HEAD~699
>
> And let's further suppose that the feature wasn't introduced until
> commit 650, and it's broken since 653.
>
> With the bisect method of finding this we're going to start our session
> with these commits:
>
>     [bef4b96adf5f082b1103c170eb6a41d1526fa919] add 350 => good
>     [d271fdb29129dbba723d3eac1035b58b6dc6f583] add 525 => good
>     [b0c9b7da646334a6c7eadb333b5ae77ec35388b3] add 612 => good
>     [2a78858d04cc5542e176dd8f68fa2660b8b48ab3] add 656 => bad (or skip)
>
> Whereas with this proposed exponential search it'll be commits #:
>     
>     2
>     4
>     8
>     16
>     32
>     64
>     128
>     256
>     512
>
> So we're going to test 8 commits before we get past the mid-point that
> bisect now starts with. Of course that may be more efficient, but if the
> regression is in some random place I don't see why we wouldn't test the
> middle instead of weighing things towards the start of the history. If
> the relevant commit is an early one like #50 bisect is still faster.
That's true. If the feature was broken n commits ago, and exponential
search has to be useful, then the feature must not have been introduced
later than a*n commits ago, where a is the exponent.
> With the disclaimer that I may be missing something, I'm just plowing
> ahead:
>
> I don't see the usefulness of this proposed exponential search, but I
> definitely *do* see the usefulness of a "bisect undo", and I've been
> bitten many times by the lack of that myself. We should definitely have
> that.
What exactly would you undo? If an older commit has been marked as
"bad", should e.g. a later "good" marker undo the earlier "bad" marker?
I don't know how this helps because the bigger problem is that if I tend
to mark old commits as good rather than skip, I will more likely
accidentally mark a bad commit as good, and I don't see how I could undo
that.
> And as Christian pointed out in [1] it seems you're (understandably, it
> can be confusing) conflating skip and "good" in your example.
Yes, knowingly, unfortunately. Or to put it more precise: I cannot write
a script that is good enough to really detect a good old commit reliably.
>  So to
> re-state the problem you have, if I were to use "skip" in the above
> example bisect for me will do:
>     
>     [bef4b96adf5f082b1103c170eb6a41d1526fa919] add 350 => skip
>     [15c181442dcbd785bf2b28cfddcf1932aaa71c42] add 351 => skip
>     [c985feffa2c92b2d3d9804a43b215e26c7275549] add 374 => skip
>     [effa691ec5dc2d80c0b070c4d8ac9fa70cbfea9f] add 168 => skip
>     [212a5ee3ff55834196661d0632f584098e9f6fb2] add 369 => skip
>     [2ca67a4500c9f3cd489b9e529d41eb99252dc8f6] add 179 => skip
>     [4067ee067e2298e1b104f4ff9aab15f4e815e101] add 337 => skip
>     [...]
>
> If only there was a way to be on 350 and say "skip everything up to this
> point", so I implemented it!:
>
>     [bef4b96adf5f082b1103c170eb6a41d1526fa919] add 350 => skip-to-here
>     [15c181442dcbd785bf2b28cfddcf1932aaa71c42] add 351 => skip
>     [6f7b5ca1dcc21c28af658a172136e503d7a2d0ea] add 420
>     [...]
>
> etc. now we're not jumping around in 1..350:
>
>     $ git config alias.bisect-skip-to-here
>     !f() { good=$(git for-each-ref refs/bisect/good* --format="%(objectname)"); git bisect skip $good..HEAD; }; f
>
> Great eh? Not really, because I've just discovered a really tedious and
> expensive (I created 350 "skip" refs) of re-inventing what I could do if
> I just did "good" on commit 350[2] :)

I'm not entirely sure whether I understand yet. If you mark a whole
range of commits untestable, then yes. But how do you know whether the
whole range can be skipped? Maybe the feature was really introduced in
300, 320 broke it and 350 just broke it because of a typo?

Maybe another possible, simpler feature would be a different
(configurable?) skip algorithm. It could move exponentially as well.
(I'm not sure how useful that would be, though.)

