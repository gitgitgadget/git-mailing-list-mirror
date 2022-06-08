Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD01C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 23:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiFHX1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 19:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiFHX1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 19:27:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7DC213ADD
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 16:27:40 -0700 (PDT)
Received: (qmail 6196 invoked by uid 109); 8 Jun 2022 23:27:40 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jun 2022 23:27:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Wed, 8 Jun 2022 19:27:39 -0400
From:   Jeff King <peff@peff.net>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "Ing. Martin Prantl Ph.D." <perry@ntis.zcu.cz>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 1/2] remote.c: don't BUG() on 0-length branch names
Message-ID: <YqEwa37mNBqT7M+X@coredump.intra.peff.net>
References: <pull.1273.git.git.1654038754.gitgitgadget@gmail.com>
 <df6e4db6072e90afc92505a73792cf3c3221d5e4.1654038754.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df6e4db6072e90afc92505a73792cf3c3221d5e4.1654038754.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 31, 2022 at 11:12:33PM +0000, Glen Choo via GitGitGadget wrote:

> Fix the bug by removing the convenience strlen functionality, so that
> 0 means that the string is 0-length. We still insert a bogus branch name
> into the hash map, but this will be fixed in a later commit.

I think this is a good change, regardless of whether we take the second
commit or not. These kind of "automagically run strlen() sometimes"
interfaces are subtle, and I think have bitten us before.

> diff --git a/remote.c b/remote.c
> index 42a4e7106e1..cf7015ae8ab 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -195,9 +195,6 @@ static struct branch *find_branch(struct remote_state *remote_state,
>  	struct branches_hash_key lookup;
>  	struct hashmap_entry lookup_entry, *e;
>  
> -	if (!len)
> -		len = strlen(name);
> -
>  	lookup.str = name;
>  	lookup.len = len;
>  	hashmap_entry_init(&lookup_entry, memhash(name, len));

This changes the behavior of find_branch() without changing its
signature. So any topics in flight that use it might be subtly broken. I
think that's probably OK in this instance, since it's a file-local
static, and was added relatively recently (i.e., the blast radius is
pretty small and unlikely).

-Peff
