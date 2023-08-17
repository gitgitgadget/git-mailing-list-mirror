Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689E1C27C7A
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 05:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjHQFo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 01:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348137AbjHQFoI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 01:44:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19511FD0
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 22:44:06 -0700 (PDT)
Received: (qmail 18791 invoked by uid 109); 17 Aug 2023 05:44:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Aug 2023 05:44:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26031 invoked by uid 111); 17 Aug 2023 05:44:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Aug 2023 01:44:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Aug 2023 01:44:05 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick <patrickf3139@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Force usage of pager for diff, show, etc when piping to non-TTY
Message-ID: <20230817054405.GD3006160@coredump.intra.peff.net>
References: <CAMRL+qYYGJ-LYG8qZpJOq+_=YO_C7JSTH4TPDpbEA4fRdANP7w@mail.gmail.com>
 <20230816025715.GB2248431@coredump.intra.peff.net>
 <CAMRL+qbGBOiR49A0FDYgZJmMbsfyeTZkzVmEdrCRYEanjv195A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMRL+qbGBOiR49A0FDYgZJmMbsfyeTZkzVmEdrCRYEanjv195A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2023 at 09:30:38AM -0700, Patrick wrote:

> Jeff, would you be so kind as to elaborate more on the
> interactive.diffFilter approach? My understanding is that
> interactive.diffFilter is only used for git add -p or git reset -p.
> However, the limitation for my use case is I need to use the pager
> for git log and git show so that won't work. So then, you are
> suggesting that I ask my users to opt in by setting an arbitrary git
> config like fzf.pager and then read out the pager from that git var?

Yes, they'd have to set a new config variable. Though if you are really
just filtering diffs and the semantics would be the same as
interactive.diffFilter, I would probably just use that. You could also
introduce a new foo.diffFilter option, and if unset have it default to
the value of interactive.diffFilter. That provides flexibility without
forcing users to repeat themselves.

That said, I would not be surprised if many users who set pager.log do
not even know about interactive.diffFilter. It's a bit more obscure, and
came later.

If you do want to follow that approach, the simplest example is probably
just to see how it was added to the perl code in 01143847db
(add--interactive: allow custom diff highlighting programs, 2016-02-27):

  https://github.com/git/git/commit/01143847dbf4fbf27268650f3ace16eac03b3130

In shell it might look something like:

  filter=$(git config --get interactive.difffilter)
  if test -n "$filter"; then
    git show ... | eval "$filter"
  else
    git show ...
  fi

-Peff
