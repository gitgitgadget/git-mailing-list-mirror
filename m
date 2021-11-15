Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF42C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 21:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDFA61BE3
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 21:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348087AbhKOV1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:27:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:59340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242252AbhKOVHT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 16:07:19 -0500
Received: (qmail 14179 invoked by uid 109); 15 Nov 2021 21:04:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Nov 2021 21:04:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18297 invoked by uid 111); 15 Nov 2021 21:04:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Nov 2021 16:04:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Nov 2021 16:04:18 -0500
From:   Jeff King <peff@peff.net>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] git push --mirror ignores refs outside head & tags
Message-ID: <YZLLUtPVQt2XtgQX@coredump.intra.peff.net>
References: <robbat2-20211115T063838-612792475Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <robbat2-20211115T063838-612792475Z@orbis-terrarum.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 06:53:21AM +0000, Robin H. Johnson wrote:

> TL;DR: "git push --mirror" does not in fact push all refs, despite
> documentation stating it does. It ONLY pushes refs in refs/heads/ and
> refs/tags/.

Perhaps there's a bug, but it is meant to and does push all refs in a
simple case:

  git init
  git commit --allow-empty -m foo
  git update-ref refs/heads/other-branch HEAD
  git update-ref refs/foo/bar HEAD

  git init --bare dst.git
  git push --mirror dst.git

produces:

  To dst.git
   * [new reference]   refs/foo/bar -> refs/foo/bar
   * [new branch]      main -> main
   * [new branch]      other-branch -> other-branch

> I was surprised to find, on the new server presently configured as
> replica, but intended to take over as the primary, that the
> refs/push-certs was missing on every single repo.

Ah. You are not likely to have success pushing a single-level ref like
that, as receive-pack rejects it:

  $ git update-ref refs/push-certs HEAD
  $ git push dst.git refs/push-certs
  Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
  remote: error: refusing to create funny ref 'refs/push-certs' remotely
  To dst.git
   ! [remote rejected] refs/push-certs -> refs/push-certs (funny refname)
  error: failed to push some refs to 'dst.git'

There I used an explicit refspec naming it. But if I used "refs/*"
(which is what --mirror is doing under the hood), then it doesn't even
try sending it, as the client filters it out from the wildcard
(otherwise, everyone would get server-side errors from refs/stash).

So you probably want to choose a different refname to store your data.

I do think the status of these single-level refs is not well documented.
The rules in git-check-ref-format(1) imply that they are not valid:

  They must contain at least one /. This enforces the presence of a
  category like heads/, tags/ etc. but the actual names are not
  restricted.

but that rule is not enforced internally, as "refs/" is sufficient for
the internal check_refname_format() to allow it. But receive-pack has,
since 1a7141ff28 (Ignore funny refname sent from remote, 2005-10-13),
implemented the format check after stripping refs/. And then the client
side followed that lead in 30affa1e9a (send-pack: do not send out
single-level refs such as refs/stash, 2008-10-29).

-Peff
