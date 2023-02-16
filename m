Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB4FC636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 18:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjBPSt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPSt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 13:49:58 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DE43B21E
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 10:49:56 -0800 (PST)
Received: (qmail 30728 invoked by uid 109); 16 Feb 2023 18:49:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Feb 2023 18:49:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7030 invoked by uid 111); 16 Feb 2023 18:49:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Feb 2023 13:49:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Feb 2023 13:49:55 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] dir-iterator: drop unused `DIR_ITERATOR_FOLLOW_SYMLINKS`
Message-ID: <Y+560+/G4pelldXF@coredump.intra.peff.net>
References: <9bb10b607e46f867a3f8f5c71abf13c990d1ecfe.1676572031.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bb10b607e46f867a3f8f5c71abf13c990d1ecfe.1676572031.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 01:27:14PM -0500, Taylor Blau wrote:

> The `FOLLOW_SYMLINKS` flag was added to the dir-iterator API in
> fa1da7d2ee (dir-iterator: add flags parameter to dir_iterator_begin,
> 2019-07-10) in order to follow symbolic links while traversing through a
> directory.
> 
> `FOLLOW_SYMLINKS` gained its first caller in ff7ccc8c9a (clone: use
> dir-iterator to avoid explicit dir traversal, 2019-07-10), but it was
> subsequently removed in 6f054f9fb3 (builtin/clone.c: disallow `--local`
> clones with symlinks, 2022-07-28).
> 
> Since then, we've held on to the code for `DIR_ITERATOR_FOLLOW_SYMLINKS`
> in the name of making minimally invasive changes during a security
> embargo.
> 
> In fact, we even changed the dir-iterator API in bffc762f87
> (dir-iterator: prevent top-level symlinks without FOLLOW_SYMLINKS,
> 2023-01-24) without having any non-test callers of that flag.
> 
> Now that we're past those security embargo(s), let's finalize our
> cleanup of the `DIR_ITERATOR_FOLLOW_SYMLINKS` code and remove its
> implementation since there are no remaining callers.

Thanks for following up on this. I think it's an obviously good
direction, and the patch looks sensible. It's hard to grep for
--follow-symlinks or FOLLOW_SYMLINKS to make sure you got everything,
just because there are other unrelated features that use that name. ;)

But I think you got all the relevant spots. The only thing I wondered is
whether we could clean up any of the test setup. Specifically, "dir5"
does not seem to be used in the tests, and everything passes with:

diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 4ed3136b00..1f3e070ec2 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -106,12 +106,6 @@ test_expect_success SYMLINKS 'setup dirs with symlinks' '
 	ln -s d dir4/a/e &&
 	ln -s ../b dir4/a/f &&
 
-	mkdir -p dir5/a/b &&
-	mkdir -p dir5/a/c &&
-	ln -s ../c dir5/a/b/d &&
-	ln -s ../ dir5/a/b/e &&
-	ln -s ../../ dir5/a/b/f &&
-
 	ln -s dir4 dir6
 '
 

But...that is true even before your patch. dir5 is not mentioned in any
of the expected output, even in fa1da7d2ee (dir-iterator: add flags
parameter to dir_iterator_begin, 2019-07-10) where it was added. Was it
just vestigial? Or is it somehow important that it is _not_ in the
output?

I didn't dig, and even if it can be removed, it would probably make
sense to do it separately from your patch anyway.

-Peff
