Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B47C0015E
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 00:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjHJAt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 20:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHJAt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 20:49:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77DCC9
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 17:49:57 -0700 (PDT)
Received: (qmail 24658 invoked by uid 109); 10 Aug 2023 00:49:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Aug 2023 00:49:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3334 invoked by uid 111); 10 Aug 2023 00:49:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Aug 2023 20:49:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Aug 2023 20:49:56 -0400
From:   Jeff King <peff@peff.net>
To:     Wesley Schwengle <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Fix bug when more than one readline instance is used
Message-ID: <20230810004956.GA816605@coredump.intra.peff.net>
References: <20230810003939.1420306-1-wesleys@opperschaap.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810003939.1420306-1-wesleys@opperschaap.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 08:39:33PM -0400, Wesley Schwengle wrote:

> The following error was emitted if one issued the command
> 
>     git send-email --compose 0001-my.patch
> 
> Can't locate object method "IN" via package "FakeTerm" at
> /home/wesleys/libexec/git-core/git-send-email line 997.
> 
> After added a warn in the relevant function that created the term it was
> obvious what happened:
> 
> Only one Term::ReadLine::Gnu instance is allowed. at
> /home/wesleys/libexec/git-core/git-send-email line 981.

I posted a similar fix yesterday, which is currently in 'next' via
d42e4ca9f8:

  https://lore.kernel.org/git/20230808180935.GA2096901@coredump.intra.peff.net/

However...

> More or less the same logic happens in git-svn.perl so I fixed it there
> as well.

...I didn't touch git-svn.perl, and I agree it probably has the same
problem (I didn't try it in practice, but any time ask() is called twice
it will run into the same issue).

Do you want to prepare a patch on top removing the git-svn bits
(probably all of FakeTerm, too)?

-Peff
