Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B464CC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 14:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1CB61374
	for <git@archiver.kernel.org>; Mon, 31 May 2021 14:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhEaOsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 10:48:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:42174 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230357AbhEaOqX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 10:46:23 -0400
Received: (qmail 22492 invoked by uid 109); 31 May 2021 14:44:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 31 May 2021 14:44:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29230 invoked by uid 111); 31 May 2021 14:44:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 May 2021 10:44:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 May 2021 10:44:33 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
Message-ID: <YLT2UfCZyQIXWIOv@coredump.intra.peff.net>
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
 <YLP/GEN0qIXvWEUn@coredump.intra.peff.net>
 <CAOLTT8Q0zbxh8X03ZmgAzHadTbE4-Af+AB3POOUF2n22u8RExw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8Q0zbxh8X03ZmgAzHadTbE4-Af+AB3POOUF2n22u8RExw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 31, 2021 at 09:20:34PM +0800, ZheNing Hu wrote:

> > But I think we'd want to solve it by swapping the two conditionals I
> > showed above, which restores the assumption made in print_object_or_die().
> 
> This method is correct. This will ensure that skip_object_info will not
> be set when print_contents is set.

OK, good, it sounds like we are on the same page. :)

> By the way, maybe we can merge this two "if (opt->all_objects)" block to one.
> [...]

Yes, I think that would make sense to do. It might be worth doing as a
separate patch on top of the bug-fix, though, to make it clear that it's
just cosmetic and separate from the bug-fix.

> > > +test_expect_success 'cat-file --batch="batman" with --batch-all-objects will work' '
> > > +     git -C all-two cat-file --batch-all-objects --batch="%(objectname)" | wc -l >expect &&
> > > +     git -C all-two cat-file --batch-all-objects --batch="batman" | wc -l >actual &&
> > > +     test_cmp expect actual
> > > +'
> >
> > Is it worth testing both of these? The %(objectname) one will fail in
> > the same way (because we do not need to run oid_object_info() to get the
> > oid, which we already have). I'm OK doing both for better coverage, but
> > it may be worth mentioning either in a comment or in the commit message
> > that we expect both to fail, and why.
> 
> Yes, these damages need to be pointed out in the commit message.

I think what confused me here is that you are using "%(objectname)" as
the "expect" output, but it also exhibits the bug. So I'd expect this
test to pass even before your patch (though I didn't try it).

Really, the symptom of the bug is that _neither_ of those cat-file
invocations will exit with a success code. But because they're on the
left-hand side of a pipe, we wouldn't even notice.

The simplest test is just:

  git -C all-two cat-file --batch-all-objects --batch="%(objectname)" >/dev/null

which will currently fail. It would be nice to verify that its output is
sensible, but I'm not sure how to easily do that (it will spew a bunch
of binary tree data, and it cannot even be parsed reliably since we
haven't output the sizes).

-Peff
