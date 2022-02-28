Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B12C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 17:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiB1RBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiB1RBY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 12:01:24 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B3E85BCD
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 09:00:45 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B9E973F482C;
        Mon, 28 Feb 2022 12:00:44 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5DF923F483C;
        Mon, 28 Feb 2022 12:00:44 -0500 (EST)
Subject: Re: [PATCH 00/11] Partial bundles
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6af04989-835b-7fae-6862-002ecd411037@jeffhostetler.com>
Date:   Mon, 28 Feb 2022 12:00:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/23/22 12:55 PM, Derrick Stolee via GitGitGadget wrote:
> While discussing bundle-URIs [1], it came to my attention that bundles have
> no way to specify an object filter, so bundles cannot be used with partial
> clones.
> 
> [1]
> https://lore.kernel.org/git/7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com/
> 
> This series provides a way to fix that by adding a 'filter' capability to
> the bundle file format and allowing one to create a partial bundle with 'git
> bundle create --filter=blob:none '.

Nicely done.  There's a lot of refactoring here to move the
filtering code into a more usable place and get rid of some
of the awkward limitations of my original code.  Sorry that
you had to slog thru all of that.

> 
> There are a couple things that I want to point out about this implementation
> that could use some high-level feedback:
> 
>   1. I moved the '--filter' parsing into setup_revisions() instead of adding
>      another place to parse it. This works for 'git bundle' but it also
>      allows it to be parsed successfully in commands such as 'git diff' which
>      doesn't make sense. Options such as '--objects' are already being parsed
>      there, and they don't make sense either, so I want some thoughts on
>      this.

This feels like something that can wait for another task.
Let's keep this series focused on adding partial bundles.

> 
>   2. If someone uses 'git clone partial.bdl partial' where 'partial.bdl' is a
>      filtered bundle, then the clone will fail with a message such as
> 
> fatal: missing blob object '9444604d515c0b162e37e59accd54a0bac50ed2e' fatal:
> remote did not send all necessary objects
> 
> This might be fine. We don't expect users to clone partial bundles or fetch
> partial bundles into an unfiltered repo and these failures are expected. It
> is possible that we could put in custom logic to fail faster by reading the
> bundle header for a filter.
> 
> Generally, the idea is to open this up as a potential way to bootstrap a
> clone of a partial clone using a set of precomputed partial bundles.

I think this is to be expected.

Would it help to have Git do a no-checkout clone when cloning
from a partial bundle?  Maybe that would give the user a chance to set
a real remote (and maybe set the partial clone/fetch config settings)
and then backfill their local clone??   (That might be functional, but
not very user-friendly....)

Or should we just consider this limitation as a placeholder while we
wait for the Bundle URI effort?

Jeff

> 
> Thanks, -Stolee
> 
> Derrick Stolee (11):
>    index-pack: document and test the --promisor option
>    revision: put object filter into struct rev_info
>    pack-objects: use rev.filter when possible
>    pack-bitmap: drop filter in prepare_bitmap_walk()
>    list-objects: consolidate traverse_commit_list[_filtered]
>    MyFirstObjectWalk: update recommended usage
>    bundle: safely handle --objects option
>    bundle: parse filter capability
>    rev-list: move --filter parsing into revision.c
>    bundle: create filtered bundles
>    bundle: unbundle promisor packs
> 
>   Documentation/MyFirstObjectWalk.txt | 44 ++++++---------
>   Documentation/git-index-pack.txt    |  8 +++
>   builtin/pack-objects.c              |  9 +--
>   builtin/rev-list.c                  | 29 +++-------
>   bundle.c                            | 87 ++++++++++++++++++++++++-----
>   bundle.h                            |  3 +
>   list-objects-filter-options.c       |  2 +-
>   list-objects-filter-options.h       |  5 ++
>   list-objects.c                      | 25 +++------
>   list-objects.h                      | 12 +++-
>   pack-bitmap.c                       | 24 ++++----
>   pack-bitmap.h                       |  2 -
>   reachable.c                         |  2 +-
>   revision.c                          | 11 ++++
>   revision.h                          |  4 ++
>   t/t5300-pack-object.sh              |  4 +-
>   t/t6020-bundle-misc.sh              | 48 ++++++++++++++++
>   17 files changed, 215 insertions(+), 104 deletions(-)
> 
> 
> base-commit: 45fe28c951c3e70666ee4ef8379772851a8e4d32
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1159%2Fderrickstolee%2Fbundle%2Fpartial-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1159/derrickstolee/bundle/partial-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1159
> 
