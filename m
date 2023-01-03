Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7967AC4708E
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 08:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbjACI5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 03:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbjACI5V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 03:57:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA6F32F
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 00:57:18 -0800 (PST)
Received: (qmail 8735 invoked by uid 109); 3 Jan 2023 08:57:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Jan 2023 08:57:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9252 invoked by uid 111); 3 Jan 2023 08:57:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Jan 2023 03:57:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Jan 2023 03:57:17 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, rsbecker@nexbridge.com,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [BUG] fatal: transport 'file' not allowed during submodule add
Message-ID: <Y7Pt7R0VX3kGI5Dc@coredump.intra.peff.net>
References: <00f901d91a47$09400110$1bc00330$@nexbridge.com>
 <xmqqilhwp5g4.fsf@gitster.g>
 <011201d91aca$a5db7800$f1926800$@nexbridge.com>
 <Y6y+zkUsPhknTYH/@google.com>
 <Y69TMzIf/bdsZe6/@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y69TMzIf/bdsZe6/@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 30, 2022 at 04:08:03PM -0500, Taylor Blau wrote:

> Changing the default value of 'protocol.file.allow' isn't solely about whether
> or not we use the `file://` scheme and transport or not. Instead, it's
> about preventing the user from accidentally cloning local repositories
> containing sensitive data into the working copy of a malicious
> repository.
> 
> One example might be that I convince you to clone my malicious
> repository, which has a Dockerfile that uploads everything in the
> container filesystem to some data harvesting server. Since 'docker run'
> automatically puts everything in '.' into the volume mount, anything in
> the working copy of my malicious repository will get exfiltrated.
> 
> The worry that I wrote about in a1d4f67c was that if I knew that you
> stored, say, your SSH private key material in a repository that is at
> `$HOME/.git` (as is sometimes common practice), then I could add a
> submodule at /home/jrnieder/.git, and extract any sensitive data
> therein.
> 
> So I think our new default is sensible here if we are concerned with
> preventing such a case.

One of the justifications for disallowing filesystem URLs in submodules
is that they're generally a bad idea anyway. If you're cloning over the
network, there's nothing to guarantee that the cloner's filesystem looks
anything like the original committer's. So it's an accident waiting to
happen.

But one case where it's not _completely_ unreasonable is when the
superproject clone itself is happening via the local filesystem. That
matches Randall's example, though I'm not sure if that's his "real"
workflow.

So one thing we could do to soften the change is to allow a submodule to
use a filesystem URL if and only if the immediate parent clone also did
(and naturally, allow "submodule add" on anything). But:

  - it's not clear to me if that just re-opens the Docker problem you
    were trying to fix (I think not, because it should be forbidding
    file:// remotes for the initial clone, too; but...)

  - as a security rule, it's complicated and confusing, which means it
    is likely to have loopholes or be mis-used. As a user I now have to
    be aware that copying an untrusted .git to my filesystem and cloning
    from it has a different trust level than cloning it over https, with
    respect to submodule protocols.

  - in a distributed system, the notion of "the parent clone" is vague
    anyway. During "git clone --recurse-submodules", sure, you can use
    the top-level URL as your basis. But later if I run "git submodule
    update", what's the "original" protocol? I can guess at it by
    looking at remote.origin.url, but of course it could change, there
    could be multiple remotes, etc.

So I think it's probably not worth doing. People with that workflow
should set protocol.file.allow as appropriate.

I also wondered if you could get around this with url.*.insteadOf. That
is, it would seem reasonable to use a unique URL in .gitmodules (even if
it's not a real functional URL!), and then let local developers override
it to point to their filesystem with the insteadOf mechanism. That gives
tighter permissions, and provides more options for local redirection.

Unfortunately, it doesn't work here. We check the protocol permissions
as we're about to use them (which is good, because we catch all paths
that get there). But at that point we have no idea about the rewrite.
Looks like there was some discussion in this thread:

  https://lore.kernel.org/git/CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV7ZoeA@mail.gmail.com/

about having a rewrite make the URL "from the user". But ultimately it
seems scary. And anyway, it doesn't help this case much anyway (people
still need to set up config, so they might as well just set the protocol
config).

-Peff
