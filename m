Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06E1C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB6D22CA1
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgHCTkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:40:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:46686 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbgHCTkI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 15:40:08 -0400
Received: (qmail 28863 invoked by uid 109); 3 Aug 2020 19:40:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Aug 2020 19:40:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3693 invoked by uid 111); 3 Aug 2020 19:40:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Aug 2020 15:40:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Aug 2020 15:40:06 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: Renaming the "master" branch without breaking existing clones
Message-ID: <20200803194006.GA2715275@coredump.intra.peff.net>
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
 <20200803160051.GA50799@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803160051.GA50799@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 12:00:51PM -0400, Taylor Blau wrote:

> This is more-or-less what I was proposing in the message that I linked
> above. Maybe a more solidified proposal might look something as follows:
> 
>   - We could introduce a mechanism to mark certain refs as aliases to
>     other refs. For example, a remote might publish its
>     'refs/heads/master' as an alias to 'refs/heads/main', so that any
>     reads or writes to the former get applied to the latter
>     transparently.

I think symrefs do this already. Try this:

  git init parent
  git -C parent checkout -b main
  git -C parent commit --allow-empty -m one
  git -C parent symbolic-ref refs/heads/master refs/heads/main

  git clone parent clone
  cd clone
  GIT_TRACE_PACKET=1 git ls-remote 2>&1 >/dev/null |
  perl -lne '/git</ && /packet: (.*)/ and print $1'

Assuming you have the v2 protocol enabled, you should see:

  git< 3ba9220cd714e9350cb4becd1cb56d0cacf29d9b HEAD symref-target:refs/heads/main
  git< 3ba9220cd714e9350cb4becd1cb56d0cacf29d9b refs/heads/main
  git< 3ba9220cd714e9350cb4becd1cb56d0cacf29d9b refs/heads/master symref-target:refs/heads/main

(if you don't you'll still see them as aliases, but you won't be told
that master is a symref).

And it even works for pushing. Doing:

  git checkout -b master origin/master
  git commit --allow-empty -m two
  git push

updates both "main" and "master".

The real trick is that you can't create or update symbolic refs on the
server side using a client. So this would have to be something that
hosting providers allow (and there might be some security implications;
I'm not sure what happens if you create a loop in the symref
resolution).

>   - A ref alias can be annotated to say "I am a transition ref alias",
>     i.e., that clients should be taught to rename their copy of 'master'
>     to 'main' (and update remote-tracking refs accordingly).

It's not specifically marked as a transition, but a client could act on
the symref advertisement above.

-Peff
