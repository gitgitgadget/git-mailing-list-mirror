Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE5FC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ECF720771
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 08:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMIsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:48:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:57408 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgHMIsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 04:48:17 -0400
Received: (qmail 17058 invoked by uid 109); 13 Aug 2020 08:48:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 08:48:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11448 invoked by uid 111); 13 Aug 2020 08:48:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 04:48:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 04:48:15 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: avoiding fetching specific refs from a remote
Message-ID: <20200813084815.GA3092220@coredump.intra.peff.net>
References: <CA+P7+xpokJ3Z4xZ9ibCBpBO65D1v-AD6_JknprGUsEDxEvMGGw@mail.gmail.com>
 <20200805063704.GA2690083@coredump.intra.peff.net>
 <CA+P7+xp5aRWV0udmf03+ox4+8nCOmXtfEckmhJrAs-42Tomn0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xp5aRWV0udmf03+ox4+8nCOmXtfEckmhJrAs-42Tomn0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 03:04:09PM -0700, Jacob Keller wrote:

> I dug up the patch and have applied it to master. One concern I have
> is how do we tell what side the negative refspec applies to? It seems
> like we'd need to be able to distinguish whether it applies to the
> refname on the remote, or the refname on the local branch. The patch
> as-is assumes that negative refspecs only ever have "src".. I guess
> for fetch that means the name of the ref on the remote, and for push
> that means the name of the ref on the local end?

Yeah, unlike a normal refspec that can have both a src and dst, there
really is only one "side" to a negative refspec, because it is not going
anywhere. So selecting by src makes the most sense to me. We could also
allow selecting by dst, like:

  git fetch origin refs/heads/*:refs/remotes/origin/* \
    ^refs/heads/foo           \ (1) omit remote foo branch; implies src
    ^refs/heads/bar:          \ (2) omit remote bar branch by explicit src
    ^:refs/remotes/origin/baz   (3) omit remote baz branch by explicit dst

I probably wouldn't bother with (2) or (3) unless somebody really wants
them. We can do (1) now and then extend later without loss of
compatibility.

Another thing to think about is how to handle overlap. E.g., in:

  ^refs/heads/foo refs/heads/*:refs/remotes/origin/*

should:

  1. The first take precedence over the second because we apply
     positive, then negative?

  2. Or should it be first over second because the first is specific and
     the second is a wildcard?

  3. Or should it be second over first because later refspecs override
     earlier?

I don't have a real preference, and I think there are many
self-consistent schemes you could come up with. But it probably makes
sense to think it through so that we don't get stuck supporting a
half-baked behavior later.

> I was trying to modify the patch to add support to the push code flows
> so that it was more complete and could be submitted. I'll be sending
> what I have as an RFC soon.

Sounds good. Thanks for picking this up!

-Peff
