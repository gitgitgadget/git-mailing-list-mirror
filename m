Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED84CDB465
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjJKXlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjJKXle (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:41:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E3BA9
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:41:32 -0700 (PDT)
Received: (qmail 20769 invoked by uid 109); 11 Oct 2023 23:41:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 23:41:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11420 invoked by uid 111); 11 Oct 2023 23:41:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 19:41:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 19:41:31 -0400
From:   Jeff King <peff@peff.net>
To:     matthew sporleder <msporleder@gmail.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: gpg.ssh.defaultKeyCommand docs bug?
Message-ID: <20231011234131.GO518221@coredump.intra.peff.net>
References: <CAHKF-AvUxH1Ar3Xijjb4_8N+_kssPHZVHqQSAE9kDGRfTYHyxw@mail.gmail.com>
 <20231009204341.GB3281325@coredump.intra.peff.net>
 <CAHKF-AsjY_P6mbAs7KWcgL39KbLbu9OE9XiLabghhTn-f0ybzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHKF-AsjY_P6mbAs7KWcgL39KbLbu9OE9XiLabghhTn-f0ybzQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 02:16:27PM -0400, matthew sporleder wrote:

> It gave very confusing errors!
> 
> key::ssh-rsa ABC123 me@localhost (no new line)
> error: Load key "....: invalid format?

It's hard to say without seeing the whole output, but I suspect this is
actually coming from ssh, not Git. We just dump the output into a
tempfile and feed it to "ssh-keygen -f".

Though I'd think we would see the same issue with user.signingKey in
that case.

So I'm not sure what's going on here (I haven't set up ssh signing to
play with yet).

> key::ABC123 (yes new line)
> error: Couldn't load public key ...: No such file or directory?

That one makes sense to me. The "ssh-rsa" part is important, because
without it, ssh-keygen has no idea what format it is in.

> key::ssh-rsa ABC123 me@localhost (yes new line)
> works, I think

This is the recommended format.

> ssh-rsa ABC123 me@localhost (yes new line)
> works (the script I provided)

And this is the historical one.

So I don't think the documentation is _wrong_ here, but I agree that it
is a bit on the confusing side (especially understanding that "key::"
came later, and that raw "ssh-rsa" is deprecated, which is only
mentioned in user.signingKey, not gpg.ssh.defaultKeyCommand.

And I'm still not sure what's going on with your no-new-line example,
which I'd have expected to work.

-Peff
