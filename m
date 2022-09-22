Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198DBC6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 06:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIVGfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 02:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiIVGfR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 02:35:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EE797EDA
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 23:35:16 -0700 (PDT)
Received: (qmail 5003 invoked by uid 109); 22 Sep 2022 06:35:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 06:35:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31020 invoked by uid 111); 22 Sep 2022 06:35:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 02:35:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 02:35:14 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "John A. Leuenhagen" <john@zlima12.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] clone: allow "--bare" with "-o"
Message-ID: <YywCImASth7I0Wx2@coredump.intra.peff.net>
References: <YyvzIQL9H9aTYNch@coredump.intra.peff.net>
 <YyvzVdfQVdysvMp2@coredump.intra.peff.net>
 <CAPig+cTEF=jBoW07_eLQ_BAWxULfWtehVa-JbJKpS+8rPenSiQ@mail.gmail.com>
 <Yyv+GjjauvvcX3M1@coredump.intra.peff.net>
 <CAPig+cQxSwz2cZFLNwg_rJ==M5=pxMVvwgbDFV1r=v+rzbCuNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQxSwz2cZFLNwg_rJ==M5=pxMVvwgbDFV1r=v+rzbCuNg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 02:26:09AM -0400, Eric Sunshine wrote:

> > I think you might be mis-reading the advice here. It is saying to use
> > the "pwd" program, rather than relying on the shell's $PWD variable. So
> > $(pwd) and `pwd` are the same thing (and are what I'm using). The $() I
> > think is just indicating that you'd do:
> >
> >   foo=$(pwd)
> >
> > And yes, I think this is a case where using the right one is important
> > (which is why I used the pwd program, and not $pwd in the test).
> >
> > Or am I missing something else?
> 
> I was thinking, in particular, about this snippet from t/test-lib.sh:
> 
>     # git sees Windows-style pwd
>     pwd () {
>         builtin pwd -W
>     }
> 
> If that's inherited by the subshell used in the test, then I suppose
> all is okay, though I think it would not be inherited.

I think it's OK. $() is itself a subshell, and you can find many calls
to FOO=$(pwd) or similar. And in general, functions are inherited in
subshells:

  $ sh -c 'foo() { echo bar; }; (cd .. && foo)'
  bar

They'd have to be or many things in our test suite would break, since we
use test_must_fail, etc, inside subshells.

-Peff
