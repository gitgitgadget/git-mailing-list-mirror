Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E073FC636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 12:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBPMIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 07:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBPMII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 07:08:08 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69326367EF
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 04:08:07 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 2DAA01F626;
        Thu, 16 Feb 2023 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1676549287;
        bh=7728YQMuzJefPv7t6KTcX8YgyWfbHzM6Aazx+yMcy8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syWptD7RqDwazo3fLBpWWpubRW+zkWIkjQu7iytSqAey/gIqgTx0ArWTW2lPIL/uP
         XTs25PPOjtHjF2Hn/R44ydH3wtEkpwEMK9pgjNKyIzNttCNRIbJvent1Ay/y8dROVC
         8ZJdeKKC2svOw0e/caR3ghGs2axf4E6qlNYZBaTo=
Date:   Thu, 16 Feb 2023 12:08:07 +0000
From:   Eric Wong <e@80x24.org>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] delta-islands: fix segfault when freeing island marks
Message-ID: <20230216120807.M50492@dcvr>
References: <61e490595b80b34c55fd640e093e021ff6fa9591.1676542973.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61e490595b80b34c55fd640e093e021ff6fa9591.1676542973.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> wrote:
> In 647982bb71 (delta-islands: free island_marks and bitmaps, 2023-02-03)
> we have introduced logic to free `island_marks` in order to reduce heap
> memory usage in git-pack-objects(1). This commit is causing segfaults in
> the case where this Git command does not load delta islands at all, e.g.
> when reading object IDs from standard input. One such crash can be hit
> when using repacking multi-pack-indices with delta islands enabled.
> 
> The root cause of this bug is that we unconditionally dereference the
> `island_marks` variable even in the case where it is a `NULL` pointer,
> which is fixed by making it conditional. Note that we still leave the
> logic in place to set the pointer to `-1` to detect use-after-free bugs
> even when there are no loaded island marks at all.

Oops, my fault :x  Thanks for this fix.

I think eliminating global flags like use_delta_islands and just
allocating `struct delta_islands_foo *' in builtin/pack-objects.c would
make it harder for people unfamiliar with the code to avoid bugs like this.

Tested-by: Eric Wong <e@80x24.org>

> An easy way to reproduce the segfault is:
> 
>     $ git pack-objects .git/objects/pack/pack --delta-islands </dev/null
> 
> I didn't add a test for git-pack-objects(1) directly though, mostly
> because I didn't find any location to put it. I'm happy to do so though
> in case we want that.

*shrug* I'm often unsure where to add tests, too.
Maybe just append it to the end of t/t5300-pack-object.sh ?
