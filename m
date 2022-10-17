Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29531C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 00:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJQACX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 20:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJQACV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 20:02:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040DE2CE17
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 17:02:20 -0700 (PDT)
Received: (qmail 24058 invoked by uid 109); 17 Oct 2022 00:02:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Oct 2022 00:02:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 735 invoked by uid 111); 17 Oct 2022 00:02:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 16 Oct 2022 20:02:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 16 Oct 2022 20:02:19 -0400
From:   Jeff King <peff@peff.net>
To:     kpcyrd <kpcyrd@archlinux.org>
Cc:     rb-general@lists.reproducible-builds.org,
        arch-dev-public@lists.archlinux.org, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de
Subject: Re: git 2.38.0: Change in `git archive` output
Message-ID: <Y0ybi66K40+uH+im@coredump.intra.peff.net>
References: <20b14207-a6f2-033f-3419-271662bffba9@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20b14207-a6f2-033f-3419-271662bffba9@archlinux.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 16, 2022 at 11:57:40PM +0200, kpcyrd wrote:

> multiple people in Arch Linux noticed the output of our `git archive`
> command doesn't match the tarball served by github anymore.
> 
> First I suspected an update in our gzip package until I found this line in
> the git 2.38.0 release notes:
> 
> > * Teach "git archive" to (optionally and then by default) avoid
> >   spawning an external "gzip" process when creating ".tar.gz" (and
> >   ".tgz") archives.
> 
> I've then found this commit that could be considered a breaking change in
> `git archive`:
> 
> https://github.com/git/git/commit/4f4be00d302bc52d0d9d5a3d4738bb525066c710
> 
> I don't know if there's some kind of gzip standard that could be used to
> align the git internal gzip implementation with gnu gzip.

Interesting. For a small input, they seem to produce the same file for
me:

  git init repo
  cd repo
  seq 1000 >file
  git add file
  git commit -m foo
 
  git -c tar.tar.gz.command='git archive gzip' \
    archive --format=tar.gz HEAD >internal.tar.gz
  git -c tar.tar.gz.command='gzip -cn' \
    archive --format=tar.gz HEAD >external.tar.gz
  cmp internal.tar.gz external.tar.gz && echo ok

but if I instead do "seq 10000", then the files differ. I didn't dig
into the actual binary to see the source of the change. It might be
something we can tweak (e.g., if it's how a header is represented, or if
we can change the zlib parameters to find the same compressions).

> I'm not saying this is necessarily a bug or regression but it makes it
> harder to reproduce github tar balls from a git repository. Just sharing
> what I've debugged. :)

I don't think we make promises about stable output from "git archive".
We've fixed bugs in the tar-generating side before that lead to changes.
But if we can easily make them the same, that might be worth doing.

In the meantime, you can use the config option I showed above to get the
old, external behavior. At some point GitHub will probably update their
version, though, at which point you'd want the internal (they may also
try to retain the old one, though; lots of distro/packaging projects get
broken when GitHub's archives aren't byte-for-byte identical).

-Peff
