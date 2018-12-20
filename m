Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2E891F405
	for <e@80x24.org>; Thu, 20 Dec 2018 14:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeLTO7z (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 09:59:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:46808 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725681AbeLTO7z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 09:59:55 -0500
Received: (qmail 31574 invoked by uid 109); 20 Dec 2018 14:59:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Dec 2018 14:59:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31313 invoked by uid 111); 20 Dec 2018 14:59:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Dec 2018 09:59:06 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2018 09:59:31 -0500
Date:   Thu, 20 Dec 2018 09:59:31 -0500
From:   Jeff King <peff@peff.net>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     git@vger.kernel.org,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 1/3] ref-filter: add worktreepath atom
Message-ID: <20181220145931.GB27361@sigill.intra.peff.net>
References: <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181216215759.24011-1-nbelakovski@gmail.com>
 <20181216215759.24011-2-nbelakovski@gmail.com>
 <20181218172236.GA28455@sigill.intra.peff.net>
 <CAC05384H1LgsGMO=ggUyfFTXrXAFcjUXDSdcmev9ActPt5081A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC05384H1LgsGMO=ggUyfFTXrXAFcjUXDSdcmev9ActPt5081A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 19, 2018 at 11:09:59PM -0800, Nickolai Belakovski wrote:

> > Also, why are we replacing it with a single space? Wouldn't the empty
> > string be more customary (and work with the other "if empty, then do
> > this" formatting options)?
> 
> I was just following what was done for HEAD, but overall I agree that
> empty is preferable to single space, will change.

Ah, right, that makes more sense. I do still think for %(HEAD) it's a
little different because it is "+" or a single space, so always one
character.  Here we have some value or not, and in the "not" case for
such things we usually give an empty string (e.g., for %(push),
%(upstream), etc).

> To sum up the hashmap comments:
> -I hadn't thought to re-use the head_ref of worktree as the key.
> That's clever. I like the readability of having separate entries for
> key and value, but I can see the benefit of not having to do an extra
> allocation. I can make up for the readability hit with a comment.

Thanks, that makes sense.

> -Actually, for any valid use case there will only be one instance of
> the map since the entries of used_atom are cached, but regardless it
> makes sense to keep per-atom info in used_atom and global context
> somewhere else, so I'll make that change to make it a static variable
> outside of used_atom.

Ah, right, I forgot there was some magic around used_atom. I do still
agree that the separate static global makes things a little simpler.

> -Will change the lookup logic to remove the extra allocation. Since
> I'm letting the hashmap use its internal comparison function on the
> hash, I don't need to provide a comparison function.

I don't think that works. The default function is always_equal(), which
will treat two entries equal if they have the same hash value. I.e., any
collisions would be considered a match.

> Thanks for all the feedback, will try to turn these around quickly.

Great, thanks! I'll be on vacation for the next two weeks, so I may be
very slow to look at the next iteration. :)

-Peff
