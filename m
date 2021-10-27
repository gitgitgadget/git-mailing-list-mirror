Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEA1C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 22:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7439C60234
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 22:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhJ0Woa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:44:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:48456 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhJ0Wo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 18:44:29 -0400
Received: (qmail 14589 invoked by uid 109); 27 Oct 2021 22:42:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Oct 2021 22:42:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29441 invoked by uid 111); 27 Oct 2021 22:42:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Oct 2021 18:42:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Oct 2021 18:42:02 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Peter Hunkeler <phunsoft@gmx.net>,
        Git Mailinglist <git@vger.kernel.org>
Subject: Re: Git not commiting anything if file created and "git add"ed in
 pre-commit hook is the only file in the staging area
Message-ID: <YXnVuhyPuFFfJ8zq@coredump.intra.peff.net>
References: <0165d68f-79a7-d8b7-1bba-89a1449e87a7@gmx.net>
 <YXnNvyi62j5gcxQV@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXnNvyi62j5gcxQV@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 10:07:59PM +0000, brian m. carlson wrote:

> > Further testing shows that the newly created file *is* added to the
> > commit, *if* at least one other change
> > was registered to be commited (git add some time before the git commit).
> 
> Yes, this occurs because the first thing we do is invoke the pre-commit
> hook.  It passes, and then we consider various reasons why we should not
> commit: the hook failed, there's nothing to commit, etc.  We discover
> one since we haven't re-read the index yet and last we saw there was
> nothing to commit, so we abort.
> 
> There's a giant comment before we re-read the index that says this:
> 
> 		/*
> 		 * Re-read the index as pre-commit hook could have updated it,
> 		 * and write it out as a tree.  We must do this before we invoke
> 		 * the editor and after we invoke run_status above.
> 		 */
> 
> The commit history does not explain why we must do this _after_ invoking
> run_status, but if the comment is incorrect and we re-read it
> immediately, then this problem would go away.  I lack the relevant
> context to determine whether this is appropriate, but if folks think
> this is advisable, then I can write up a patch this weekend.  It should
> be relatively trivial.

There's some related discussion of this area in:

  https://lore.kernel.org/git/CADv3qkGq3jA8iXsjhrqfsUX=gW+KOuLyeVgDzmku1tUpsMdvtw@mail.gmail.com/

I don't find it particularly enlightening as to the history, but it does
point to other people wanting to re-read before run_status().

-Peff
