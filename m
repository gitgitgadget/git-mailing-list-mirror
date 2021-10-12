Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B90C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 02:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A36160E78
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 02:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhJLCX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 22:23:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:37326 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhJLCX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 22:23:56 -0400
Received: (qmail 30288 invoked by uid 109); 12 Oct 2021 02:21:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 02:21:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31172 invoked by uid 111); 12 Oct 2021 02:21:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Oct 2021 22:21:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Oct 2021 22:21:54 -0400
From:   Jeff King <peff@peff.net>
To:     Chris Chow <cchow@nianticlabs.com>
Cc:     git@vger.kernel.org
Subject: Re: Inconsistency in git credential helper docs
Message-ID: <YWTxQrOBTT8bWmFg@coredump.intra.peff.net>
References: <CAH4DS54U-qN+NY2A50bBawbL1cwD74fdaZdQKdhXyZSzFS-Y+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH4DS54U-qN+NY2A50bBawbL1cwD74fdaZdQKdhXyZSzFS-Y+g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 02:36:13PM -0700, Chris Chow wrote:

> There appears to be a small inconsistency / bug in the documentation
> located at https://git-scm.com/docs/gitcredentials.

I'm not sure I see what you mean.

> Under the "Custom Helpers" subhead, there's a line that reads
> > Generally speaking, rule (3) above is the simplest for users to specify. Authors of credential helpers should make an effort to assist their users by naming their program "git-credential-$NAME", and putting it in the $PATH or $GIT_EXEC_PATH during installation, which will allow a user to enable it with git config credential.helper $NAME.

OK, so here you'd call your helper git-credential-gcloud.sh so that:

  git config credential.helper gcloud.sh

would work.

> Earlier in the document, under "Configuration Options > helper", there
> is a line that reads
> > The name of an external credential helper, and any associated options. If the helper name is not an absolute path, then the string git credential- is prepended

And likewise here, we will run "git credential-gcloud.sh", which in turn
calls "git-credential-gcloud.sh" (since there is no builtin of that
name).

But we would never call "credential-gcloud.sh" in this way. You
could say:

  git config credential.helper '!credential-gcloud.sh'

of course, but that is skipping the auto-name stuff entirely.

> I think the latter text is correct. The maintainers of the google
> cloud SDK followed the advice in the first part, naming their cred
> helper `git-credential-gcloud.sh`, which is not accessible if you set
> the custom credential helper to `gcloud.sh`. I had to make a symlink
> at `credential-gcloud.sh`, following the instructions in the latter
> block, to make it work. One could of course just specify the full path
> in .gitconfig, but I figured it might be good to have these parts be
> consistent anyways.

Both pieces of text are pointing to the name that the gcloud folks used.
I'm not sure why it didn't work, or how a symlink could possibly have
helped. Can you share the exact sequence of commands, with output, that
shows what you're seeing?

Here's a toy example that shows the kind of thing that should work:

  # toy helper that lets us know when it's running
  { echo '#!/bin/sh' && echo 'echo >&2 running the foo helper'; } >foo.sh
  chmod +x foo.sh

  # add our current directory to PATH to experiment; usually these
  # commands would go into /usr/local/bin, ~/bin, etc
  export PATH=$PATH:$PWD

  # make sure we're in a repo so we can stick our config somewhere. In
  # the real world you'd probably be using "git config --global" or
  # similar.
  git init
  git config credential.helper foo.sh

  # this should say "credential-foo.sh is not a git command", because we
  # tried to run "git credential-foo.sh", but that doesn't exist (the
  # command itself is a noop; it just tries to remove a bogus credential
  # that you don't actually have, but that's enough to trigger each
  # helper).
  echo url=https://user:pass@example.com | git credential reject

  # now try it again with credential-foo.sh in the path. That also won't
  # work, with the same outcome.
  mv foo.sh credential-foo.sh
  echo url=https://user:pass@example.com | git credential reject

  # now try it with git-credential-foo.sh in the path. This should
  # trigger the helper successfully.
  mv credential-foo.sh git-credential-foo.sh
  echo url=https://user:pass@example.com | git credential reject

What I'm suspecting is that the "credential-foo.sh is not a git command"
message may have confused you, and then while debugging it you did
something else (e.g., tweaking your PATH, setting the execute bit, etc)
that led the original git-credential-gcloud.sh to work.

-Peff
