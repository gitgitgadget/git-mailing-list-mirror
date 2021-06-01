Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D19EC47082
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 01:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10617611BE
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 01:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhFABvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 21:51:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:42808 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232356AbhFABvi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 21:51:38 -0400
Received: (qmail 24620 invoked by uid 109); 1 Jun 2021 01:49:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Jun 2021 01:49:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2675 invoked by uid 111); 1 Jun 2021 01:49:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 May 2021 21:49:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 May 2021 21:49:56 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
Message-ID: <YLWSRBJHiph+Bejo@coredump.intra.peff.net>
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
 <YLP/GEN0qIXvWEUn@coredump.intra.peff.net>
 <CAOLTT8Q0zbxh8X03ZmgAzHadTbE4-Af+AB3POOUF2n22u8RExw@mail.gmail.com>
 <YLT2UfCZyQIXWIOv@coredump.intra.peff.net>
 <60b509be97423_24d2820856@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60b509be97423_24d2820856@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 31, 2021 at 11:07:26AM -0500, Felipe Contreras wrote:

> Jeff King wrote:
> > The simplest test is just:
> > 
> >   git -C all-two cat-file --batch-all-objects --batch="%(objectname)" >/dev/null
> > 
> > which will currently fail. It would be nice to verify that its output is
> > sensible, but I'm not sure how to easily do that (it will spew a bunch
> > of binary tree data, and it cannot even be parsed reliably since we
> > haven't output the sizes).
> 
> I use ruby to parse binary data from git all the time:
> 
>         git log --format='%b%x00' |
>                 ruby -e 'ARGF.each("\0", chomp: true) { |chunk| p chunk }'

I doubt we'd want to add a ruby dependency to our test suite, but sure,
we could do the same thing with perl.

The trickier part is that without the sizes, the output is ambiguous
(the command above will dump trees that contain arbitrary bytes
including NULs, so there's no solid delimiter). We could probably devise
a hacky perl snippet that checks for an expected sequence of output that
is unlikely to appear otherwise.

Or we could just generate the entire expected output and check it with
"cmp". The most robust way is probably to loop over the objects, running
"git cat-file" for each, but that's slow. Maybe:

  git cat-file --batch-all-objects --batch-check='%(objectname)' >objects &&
  git cat-file --batch='%(objectname)' <objects >expect &&
  git cat-file --batch-all-objects --batch='%(objectname)' >actual &&
  # not test_cmp, as it is not binary clean!
  cmp expect actual

That feels a bit circular in that it's mostly just exercising most of
the same code in the "expect" and "actual" paths. The interesting part
is the combination of the two options, which is why I think that just
making sure we don't hit an error might be enough.

-Peff
