Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 908FD1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 14:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbeLTOxq (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 09:53:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:46798 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729722AbeLTOxq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 09:53:46 -0500
Received: (qmail 31317 invoked by uid 109); 20 Dec 2018 14:53:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Dec 2018 14:53:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31263 invoked by uid 111); 20 Dec 2018 14:52:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Dec 2018 09:52:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2018 09:53:22 -0500
Date:   Thu, 20 Dec 2018 09:53:22 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] setup: drop return value from
 `read_repository_format()`
Message-ID: <20181220145322.GA27361@sigill.intra.peff.net>
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-2-martin.agren@gmail.com>
 <20181219152735.GA14802@sigill.intra.peff.net>
 <20181220001752.GA35965@genre.crustytoothpaste.net>
 <20181220025211.GB24002@sigill.intra.peff.net>
 <20181220034555.GC35965@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181220034555.GC35965@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 03:45:55AM +0000, brian m. carlson wrote:

> > > I will point out that with the SHA-256 work, reading the config file
> > > becomes essential for SHA-256 repositories, because we need to know the
> > > object format. Removing the config file leads to things blowing up in a
> > > bad way (what specific bad way I don't remember).
> > > 
> > > That may influence the direction we want to take in this work, or not.
> > 
> > Wouldn't we just treat that the same way we do now? I.e., assume the
> > default of sha1, just like we assume repositoryformatversion==0?
> 
> Yeah, we'll default to SHA-1, but the repository will be broken. HEAD
> can't be read. Trying to run git status dies with "fatal: Unknown index
> entry format". And so on. We've written data with 64-character object
> IDs, which can't be read by Git in SHA-1 mode.

Oh, I see. Yes, if you have a SHA-256 repository and you don't tell
anybody (via a config entry), then everything will fail to work. That
seems like a perfectly reasonable outcome to me.

> My point is essentially that in an SHA-256 repository, the config file
> isn't optional anymore. We probably need to consider that and error out
> in more situations (e.g. unreadable file or I/O error) instead of
> silently falling back to the defaults, since failing loudly in a visible
> way is better than having the user try to figure out why the index is
> suddenly "corrupt".

Yes, I agree that ideally we'd produce a better error message. I'd just
be wary of breaking compatibility for the existing cases by making new
requirements when we don't yet suspect the repo is SHA-256.

When we see such a corruption, would it be possible to poke at the data
as if it were the old SHA-1 format, and if _that_ looks sane, suggest to
the user what the problem might be? That would help a number of cases
beyond this one (i.e., you're missing config, you have config but it has
the wrong repo format, you're missing the correct extensions field,
etc).

-Peff
