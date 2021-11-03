Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D9EC433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 02:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646D9610E8
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 02:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhKCC15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 22:27:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:51992 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhKCC1z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 22:27:55 -0400
Received: (qmail 4068 invoked by uid 109); 3 Nov 2021 02:25:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Nov 2021 02:25:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13992 invoked by uid 111); 3 Nov 2021 02:25:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Nov 2021 22:25:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Nov 2021 22:25:18 -0400
From:   Jeff King <peff@peff.net>
To:     Steven Penny <srpen6@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: credential-store get: No such file or directory
Message-ID: <YYHzDuoJfWknI1XM@coredump.intra.peff.net>
References: <CAP8dQmu6Dfo4KBsVk+6xeR6=+S8bOKk-kbc3ub7c0jAsH61-cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8dQmu6Dfo4KBsVk+6xeR6=+S8bOKk-kbc3ub7c0jAsH61-cg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 02, 2021 at 07:27:44PM -0500, Steven Penny wrote:

> I recently tried to use this:
> 
>     git config --global credential.helper store

That should work...

> but whenever I run this:
> 
>     git push
> 
> I get this result:
> 
>     fatal: cannot run git credential-store get: No such file or directory

Hmm. That sounds like it is treating "git credential-store get" as a
single executable name, rather than splitting it. I'm not sure how we'd
end up with such a bug, though.

Can you show us the contents of your ~/.gitconfig file? I'm wondering if
there's any funny quoting (there shouldn't be from the git-config
command you gave above, but maybe there's another stale entry or
something?).

Also, what does:

  GIT_TRACE=1 git push

say about what it's trying to execute?

And finally, does running:

  echo "url=https://example.com" | git credential-store get

work? I wouldn't expect it to produce any output (since you'd have
nothing stored for that site), but it shouldn't give you the "no such
file or directory" complaint.

> I have tried changing HOME value, as well as XDG_CONFIG_HOME, and it
> doesn't seem to change anything. I also tried manually creating the
> credentials file, to see if that would fix it, but error remains. I am
> using Git 2.33. I know this worked
> in the past, but it's been some years since I tried it.

I think it is not complaining about finding the credential file, but
running the credential-store helper in the first place. The "cannot run"
message comes from our run-command.c code.

-Peff
