Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC52C433E9
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 22:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A7C64E41
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 22:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhBVW6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 17:58:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:40804 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232396AbhBVW6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 17:58:37 -0500
Received: (qmail 22108 invoked by uid 109); 22 Feb 2021 22:57:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Feb 2021 22:57:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18702 invoked by uid 111); 22 Feb 2021 22:57:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Feb 2021 17:57:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Feb 2021 17:57:50 -0500
From:   Jeff King <peff@peff.net>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     git@vger.kernel.org
Subject: Re: git format-patch lost the last part when branch merge
Message-ID: <YDQ27qbbblPfLCpU@coredump.intra.peff.net>
References: <20210222211621.0C5D.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210222211621.0C5D.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 09:16:21PM +0800, Wang Yugui wrote:

> git format-patch lost the last part when branch merge
> 
> Here is an example.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> Merge tag 'for-5.12/block-2021-02-17' of git://git.kernel.dk/linux-block
> 
> 1, from the web interface,
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/btrfs?id=582cd91f69de8e44857cb610ebca661dac8656b7
> 
> the last part 'diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c' can be confirmed.
> 
> 2, but from ' commit | 582cd91f69de8e44857cb610ebca661dac8656b7 (patch)' of this web page,
> the last part 'diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c' is not in the patch file.
> 
> 3, git format-patch 4f016a316f22.. fs/btrfs/ will not output 'diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c' too.

This is expected. Format-patch omits merge commits entirely, as they
can't be formatted as a simple diff that can be applied.

There are lots of ways to look at the diff of a merge. By default, `git
show` will show a combined diff, which omits hunks where one side was
taken verbatim, but otherwise shows what each side did.

The diff shown in the link above is a diff against the first-parent
(which you can also get locally with `git show --first-parent 582cd91`).
One _could_ apply that diff onto the first parent to achieve the same
tree as the merge plus all of the commits that got merged in. But it
wouldn't make any sense to apply that (aside from conflict resolution,
it would be redundant with all of the commits that format-patch just
output!).

You could imagine ways for format-patch to represent the conflict
resolution done in a merge, but it's not quite trivial, and nobody has
done it yet.

Depending on why you're using format-patch, the solution may be one of:

  - use "git log --cc" instead, which shows the merges using combined
    diffs

  - use "git bundle" instead, which reproduces the whole history graph,
    including merges (though obviously you cannot then re-apply the
    commits onto a different history)

-Peff
