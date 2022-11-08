Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1AC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 15:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiKHPlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 10:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiKHPlh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 10:41:37 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCDA5C74B
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 07:41:35 -0800 (PST)
Received: (qmail 7918 invoked by uid 109); 8 Nov 2022 15:41:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Nov 2022 15:41:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5338 invoked by uid 111); 8 Nov 2022 15:41:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Nov 2022 10:41:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Nov 2022 10:41:34 -0500
From:   Jeff King <peff@peff.net>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: The enduring popularity of git-credential-store
Message-ID: <Y2p4rhiOphuOM0VQ@coredump.intra.peff.net>
References: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 10:50:33AM +0000, M Hickford wrote:

> Among StackOverflow users [1], git-credential-store appears several
> times more popular than any other credential helper. Does this make
> anyone else uneasy? The docs warn that git-credential-store "stores
> your passwords unencrypted on disk" [2]. Are users sacrificing
> security for convenience?
> 
> Firstly, how grave is storing credentials in plaintext? Software
> development guidelines such as CWE discourage storing credentials in
> plaintext [3]. Password managers in desktop environments, mobile
> operating systems and web browsers typically encrypt passwords on disk
> and guard them behind a master password.

So obviously credential-store is the least-common-denominator of
storage, and it should (and does) come with a big warning. However, I
wonder if it actually is a reasonable solution for a lot of people:

  - "passwords" these days are often not keys-to-the-kingdom, but
    special-use tokens that allow limited access.

  - the threat model for many people assumes that their local system is
    trusted. Git needs the credential in plaintext at _some_ point. If
    your local user account is compromised, people can read your
    passwords. But they can also trojan Git, etc.

    I do think one is much worse than the other. Stealing a password
    once is easier than installing a malicious Git that records the
    password. And a stolen password can be used many times, as opposed
    to a malicious Git that misbehaves when run by the local user.

So yeah, obviously using a system password store is better if you can.
But it's sometimes difficult to set up, especially when automation is
involved. And I think it buys people less than they might think.
Especially for git's credential helpers, which are meant to be
scriptable, you can just _ask_ them to retrieve the password from the
system store. So they are really only protecting the credentials at
rest. And other approaches, like full-disk encryption, may be enough for
some people.

You asked "does it make anyone else uneasy?". A little, I guess, because
like you I'm sure there are people who are using it only because they
don't know better, and are not heeding the warnings. But it may also be
that some people are using it as a part of a reasoned tradeoff.

So if you're asking "should we stop shipping credential-store", I'm not
_completely_ opposed, but I do wonder if its popularity means it is
better-than-nothing for some folks. If you're asking how we can nudge
people to better systems, that seems like a pure win. But I also don't
know how to do it. ;)

> Secondly, the docs recommend git-credential-cache [2] which ships with
> Git and is equally easy to configure. So why isn't it more popular? My
> hypothesis: while caching works great for passwords typed from memory,
> the combination of caching with personal access tokens has poor
> usability. The unmemorised token is lost when the cache expires, so
> the user has to generate a new token every session. I suspect GitHub's
> 2021 decision to stop accepting passwords [4] may have inadvertently
> pushed users from 'cache' to 'store'.

Another big problem with credential-cache is that it requires Unix
sockets, so it doesn't run on Windows.

> Thirdly, why doesn't everyone use SSH keys? Unlike HTTP remotes,
> upfront set-up is necessary to clone a public repo. For users
> unfamiliar with SSH, this set-up may be intimidating. Introducing
> users new to Git to SSH at the same time is a significant cognitive
> load.

Yes, I think it's just that it's too hard to set up. In the early days
of GitHub, people getting confused and flustered by setting up SSH keys
was one of the biggest barriers to adoption (which is the whole reason I
improved the https auth flow, including adding credential helpers).

I do wonder what that's like these days, though. When people could
switch to just using their password from the website, I'm sure it was
much easier than learning about ssh keys. But these days you have to
learn about PATs, etc. I don't know if people do that by hand, or rely
on tools to help (like GitHub Desktop, or probably gh-cli).

> Any ideas how to improve the security of the average Git user?

All of which is to say that I have no clue what the user experience is
like these days, or what drives people in their decision about which
tools to use. ;)

I do stand by credential-store as not being _completely_ without value,
but I also recognize that its existence may cause people to make bad
decisions. If you have a plan, I'm all-ears.

-Peff
