Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD04C3DA7D
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 09:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjACJEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 04:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbjACJEo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 04:04:44 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56833E000
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 01:04:43 -0800 (PST)
Received: (qmail 8764 invoked by uid 109); 3 Jan 2023 09:04:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Jan 2023 09:04:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9291 invoked by uid 111); 3 Jan 2023 09:04:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Jan 2023 04:04:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Jan 2023 04:04:42 -0500
From:   Jeff King <peff@peff.net>
To:     Andrew Hlynskyi <ahlincq@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] `git gc` or `git pack-refs` wipes all notes for `git
 notes` command
Message-ID: <Y7Pvqk00sj3R7cZv@coredump.intra.peff.net>
References: <CAAYtLELp4v=id-UUdGT+BoCxLuTV05Z0fFMQmPfd3Mt-yXJ9Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAYtLELp4v=id-UUdGT+BoCxLuTV05Z0fFMQmPfd3Mt-yXJ9Tw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 03, 2023 at 05:22:01AM +0200, Andrew Hlynskyi wrote:

> Steps to reproduce:
> 1. Create some notes with the `git notes add` command.
> 2. Run `git notes` to list stored notes.
> 3. Run any of `git gc  --prune=now` or `git pack-refs --all` commands.
> 4. Run `git notes` again and see that there are no more seen notes.

This doesn't reproduce for me at all. Running:

  git init repo
  cd repo

  git commit --allow-empty -m "this is the commit message"
  git notes add -m "this is the note"

  git notes
  git pack-refs --all
  git notes

Shows the same output before and after packing the refs.

> The reason is that all commands like `git notes` or `git log --notes`
> expect to find notes head as unpacked ref in .git/refs/notes/commits.
> But the gc or the pack-refs command packs .git/refs/notes/commits ref
> into .git/packed-refs file.

That would be very surprising. The lookup of the ref in the notes code
uses the same generic ref code that the rest of Git uses, which
understands packed-refs and so on.

Can you share the .git directory of a repository that exhibits this
behavior? It's possible there's a bug or something in the packed-refs
code, though I find it pretty unlikely, as it's fairly well exercised in
normal use.

-Peff
