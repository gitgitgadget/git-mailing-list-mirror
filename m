Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64B8A1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbdAZOUB (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:20:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:45298 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbdAZOUA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:20:00 -0500
Received: (qmail 3956 invoked by uid 109); 26 Jan 2017 14:19:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 14:19:59 +0000
Received: (qmail 23228 invoked by uid 111); 26 Jan 2017 14:19:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 09:19:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 09:19:57 -0500
Date:   Thu, 26 Jan 2017 09:19:57 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/5] revision.c: group ref selection options together
Message-ID: <20170126141957.qcc75szbimqove2n@sigill.intra.peff.net>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com>
 <20170125125054.7422-3-pclouds@gmail.com>
 <20170125205037.cg3aebh5rsx4zb2l@sigill.intra.peff.net>
 <CACsJy8CeUWD9ux3Q-VRhwR4-qbSD69CzH2mmztVH_-cx=31h8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CeUWD9ux3Q-VRhwR4-qbSD69CzH2mmztVH_-cx=31h8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 04:18:06PM +0700, Duy Nguyen wrote:

> > Hmm. I see what you're trying to do here, and abstract the repeated
> > bits. But I'm not sure the line-count reflects a real simplification.
> > Everything ends up converted to an enum, and then that enum just expands
> > to similar C code.
> 
> It's not simplification, but hopefully for better maintainability. This
> 
> if (strcmp(arg, "--remotes")) {
>    if (preceded_by_exclide())
>       does_something();
>    else if (preceded_by_decorate())
>       does_another()
> } else if (strcmp(arg, "--branches")) {
>    if (preceded_by_exclide())
>       does_something();
>    else if (preceded_by_decorate())
>       does_another()
> }
> 
> starts to look ugly especially when the third "preceded_by_" comes
> into picture. Putting all "does_something" in one group and
> "does_another" in another, I think, gives us a better view how ref
> selection is handled for a specific operation like --exclude or
> --decorate-ref.

I agree that would be ugly. But the current structure, which is:

  if (strcmp(arg, "--remotes")) {
          handle_refs(...);
	  cleanup();
  } else if(...) {
          handle_refs(...);
	  cleanup();
  }

does not seem so bad, and pushes those conditionals into the
handle_refs() function, where they only need to be expressed once (I
didn't look, but I wonder if you could push the cleanup steps in there,
too, or if there is a caller who wants to handle() multiple times before
cleaning up).

-Peff
