Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6401C5ACD6
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 10:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37732076D
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 10:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgCRKS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:18:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:42558 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726586AbgCRKS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 06:18:26 -0400
Received: (qmail 13969 invoked by uid 109); 18 Mar 2020 10:18:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Mar 2020 10:18:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15074 invoked by uid 111); 18 Mar 2020 10:28:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Mar 2020 06:28:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Mar 2020 06:18:25 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        james@jramsay.com.au
Subject: Re: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
Message-ID: <20200318101825.GB1227946@coredump.intra.peff.net>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1584477196.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 17, 2020 at 02:39:05PM -0600, Taylor Blau wrote:

> Hi Christian,
> 
> Of course, I would be happy to send along our patches. They are included
> in the series below, and correspond roughly to what we are running at
> GitHub. (For us, there have been a few more clean-ups and additional
> patches, but I squashed them into 2/2 below).
> 
> The approach is roughly that we have:
> 
>   - 'uploadpack.filter.allow' -> specifying the default for unspecified
>     filter choices, itself defaulting to true in order to maintain
>     backwards compatibility, and
> 
>   - 'uploadpack.filter.<filter>.allow' -> specifying whether or not each
>     filter kind is allowed or not. (Originally this was given as 'git
>     config uploadpack.filter=blob:none.allow true', but this '=' is
>     ambiguous to configuration given over '-c', which itself uses an '='
>     to separate keys from values.)

One thing that's a little ugly here is the embedded dot in the
subsection (i.e., "filter.<filter>"). It makes it look like a four-level
key, but really there is no such thing in Git.  But everything else we
tried was even uglier.

I think we want to declare a real subsection for each filter and not
just "uploadpack.filter.<filter>". That gives us room to expand to other
config options besides "allow" later on if we need to.

We don't want to claim "uploadpack.allow" and "uploadpack.<filter>.allow";
that's too generic.

Likewise "filter.allow" is too generic.

We could do "uploadpackfilter.allow" and "uploadpackfilter.<filter>.allow",
but that's both ugly _and_ separates these options from the rest of
uploadpack.*.

We could use a character besides ".", which would reduce confusion. But
what? Using colon is kind of ugly, because it's already syntactically
significant in filter names, and you get:

  uploadpack.filter:blob:none.allow

We tried equals, like:

  uploadpack.filter=blob:none.allow

but there's an interesting side effect. Doing:

  git -c uploadpack.filter=blob:none.allow=true upload-pack ...

doesn't work, because the "-c" parser ends the key at the first "=". As
it should, because otherwise we'd get confused by an "=" in a value.
This is a failing of the "-c" syntax; it can't represent values with
"=". Fixing it would be awkward, and I've never seen it come up in
practice outside of this (you _could_ have a branch with a funny name
and try to do "git -c branch.my=funny=branch.remote=origin" or
something, but the lack of bug reports suggests nobody is that
masochistic).

So...maybe the extra dot is the last bad thing?

> I noted in the second patch that there is the unfortunate possibility of
> encountering a SIGPIPE when trying to write the ERR sideband back to a
> client who requested a non-supported filter. Peff and I have had some
> discussion off-list about resurrecting SZEDZER's work which makes room
> in the buffer by reading one packet back from the client when the server
> encounters a SIGPIPE. It is for this reason that I am marking the series
> as 'RFC'.

For reference, the patch I was thinking of was this:

  https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/

-Peff
