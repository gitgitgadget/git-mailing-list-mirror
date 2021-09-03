Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C970C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 11:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8520560F9C
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 11:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348628AbhICLHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 07:07:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:38616 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235007AbhICLHG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 07:07:06 -0400
Received: (qmail 27065 invoked by uid 109); 3 Sep 2021 11:06:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Sep 2021 11:06:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7465 invoked by uid 111); 3 Sep 2021 11:06:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Sep 2021 07:06:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Sep 2021 07:06:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 2/5] strvec: add a strvec_pushvec()
Message-ID: <YTIBnT8Ue1HZXs82@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
 <patch-v3-2.5-321b8ba3f0e-20210826T140414Z-avarab@gmail.com>
 <xmqq8s0m9xbl.fsf@gitster.g>
 <xmqq4kba9x1h.fsf@gitster.g>
 <YSm3ofxlRB1ViBf5@coredump.intra.peff.net>
 <87v93i8svd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v93i8svd.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 03, 2021 at 01:19:33AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > One thing that did surprise me: the use of "int" here for iterating,
> > rather than size_t. But it seems that strvec is already storing ints,
> > which is an accident!
> 
> Is it really? If you temporarily try to say convert that to "size_t *nr"
> to have the compiler catch all the cases where we use "nr", and then
> s/size_t/int/g those all, you'll find that e.g. setup_revisions() and
> the like expect to take either "int argc" or the strvec equivalent.

It most definitely is an accident, in the sense that the commit which
changed it did not mean to. :)

> We can sensibly convert some of those to size_t, but not all, and the
> int v.s. size_t inconsistency as a result feels weird.
> 
> Since the main point of this API is to be a wrapper for what a C main()
> would take, shouldn't its prototype mirror its prototype? I.e. we should
> stick to "int" here?

That isn't the main point of this API. The reason the name changed away
from argv_array was so that it would be more obviously a generally
useful array of strings.

But even if that were the use, the point isn't that we expect to see 2B
or even 4B strings in any reasonable use case. The point is that we
don't want to accidentally overflow the integer counter, leading to
reads and writes of random bits of memory. And all it takes to do that
is some code like:

  while (strbuf_readline(stdin, &buf))
	strvec_push(&foo, buf.buf);

On a system with 32-bit size_t, you are not likely to actually allocate
2B strings before you'd fail. But on most 64-bit systems, you have
plenty of address space (and these days, often RAM) to do so, but you
still only need 2B strings, because "int" is 32 bits.

So code like setup_revisions() which uses an int is fine. It is reading
from a source with that much smaller "int" limit in the first place.
Whether strvec can handle bigger arrays or not does not matter either
way. And when it later uses ints to operate on such a strvec, it's OK in
practice; even if the size_t gets truncated on the fly to an int, we
know we did not put more than an int's worth of items into the array in
the first place.

But code which has potentially larger inputs (either because it reads
iteratively into the strvec as above, or because it is itself using a
larger data type) is now also OK, because it's using size_t.

What's not OK is code which operates on a potentially-unbounded strvec
using an int. E.g., following the code I showed above with something
like:

  int nr = foo.nr;
  foo.v[nr] = xstrdup("replacement string");

which may write to memory outside of foo.v.

Obviously that's nonsense nobody would ever write directly. It is
possible for some code to do this inadvertently (say, passing a ptr/int
pair through a function interface), but I think it's fairly unlikely in
practice. So while I do think more code ought to be using size_t in
general, I don't think it's necessary to audit this carefully. The
important thing to me is protecting strvec itself.

-Peff
