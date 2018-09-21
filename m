Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315F41F453
	for <e@80x24.org>; Fri, 21 Sep 2018 23:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391575AbeIVFgz (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 01:36:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:55744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727062AbeIVFgz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 01:36:55 -0400
Received: (qmail 8330 invoked by uid 109); 21 Sep 2018 23:45:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Sep 2018 23:45:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9964 invoked by uid 111); 21 Sep 2018 23:45:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Sep 2018 19:45:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2018 19:45:44 -0400
Date:   Fri, 21 Sep 2018 19:45:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Segfault in master due to 4fbcca4eff
Message-ID: <20180921234543.GA3412@sigill.intra.peff.net>
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
 <87pnx6kjn8.fsf@evledraar.gmail.com>
 <62a46e49-e539-cbb8-4aaf-6f9b5ae6be57@gmail.com>
 <87o9cqkj6p.fsf@evledraar.gmail.com>
 <5e7e6519-21c1-daff-65a5-7d2ca5e1dbd4@gmail.com>
 <xmqqefdmyhe9.fsf@gitster-ct.c.googlers.com>
 <87lg7ujuc2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lg7ujuc2.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 01:37:17AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Thanks, both of you ;-).  I was aware of the issue and proposed fix
> > but forgot about it when merging things down to 'master'.  Sorry
> > about that.
> 
> Just a follow-up question, in your merge commit you just pushed to
> "next" you say:
> 
>     Recent update broke the reachability algorithm when tags pointing
>     at objects that are not commit were involved, which has been fixed.
> 
> And in Derrick's commit message it says:
> 
>     [...]but incorrectly assumed that all objects provided were commits[...]
> 
> I just wanted to double check (without having the time to dig myself at
> this point) whether this bug was understood & tested for, or whether the
> case I had was just /also/ fixed for unexpected reasons.
> 
> I.e. in my upthread test case I have two annotated tags pointing at
> commits, whereas the merge to "next" says "when tags pointing at objects
> that are not commit were involved", which I I assume means say annotated
> tags pointing at blobs..., but that's not what I had.
> 
> Wasn't this just a bug fix that had nothing to do with tags not pointing
> to commits, but just ones where we had the simple case of tags pointing
> to commits, but they just weren't peeled?
> 
> I'm hoping for a "Junio skimmed the fix and wrote a merge message that
> wasn't quite accurate" here, but maybe that's not the case and something
> might be missing (e.g. missing test code).

I think it's a combination of the merge message being slightly
inaccurate, and you slightly misreading it. :)

I think by "tags pointing", Junio meant "tag refs". Which of course,
often point at tag objects, but can also point at trees, etc.

But the problem is not limited to tag refs. I think it's a problem with
any "want" that is a non-commit. So really any ref pointing to a
non-commit is a problem. But of course tags are the likely way for that
to happen, since refs/heads is generally limited to commits.

So in short, yeah, the bug was triggered by fetching any annotated tag.

-Peff
