Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C87C46467
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 19:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbiBGTqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 14:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbiBGTne (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 14:43:34 -0500
X-Greylist: delayed 339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 11:43:33 PST
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BBEC0401E0
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 11:43:33 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8E7863F4096;
        Mon,  7 Feb 2022 14:37:53 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4B3C13F4090;
        Mon,  7 Feb 2022 14:37:53 -0500 (EST)
Subject: Re: [PATCH 0/6] [RFC] partial-clone: add ability to refetch with
 expanded filter
To:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Robert Coup <robert@coup.net.nz>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <596fe1fa-2499-665b-007d-c87ca3399d03@jeffhostetler.com>
Date:   Mon, 7 Feb 2022 14:37:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/1/22 10:49 AM, Robert Coup via GitGitGadget wrote:
> If a filter is changed on a partial clone repository, for example from
> blob:none to blob:limit=1m, there is currently no straightforward way to
> bulk-refetch the objects that match the new filter for existing local
> commits. This is because the client will report commits as "have" during
> negotiation and any dependent objects won't be included in the transferred
> pack. Another use case is discussed at [1].
> 
> This patch series proposes adding a --refilter option to fetch & fetch-pack
> to enable doing a full fetch with a different filter, as if the local has no
> commits in common with the remote. It builds upon cbe566a071
> ("negotiator/noop: add noop fetch negotiator", 2020-08-18).
> 
> To note:
> 
>   1. This will produce duplicated objects between the existing and newly
>      fetched packs, but gc will clean them up.
>   2. This series doesn't check that there's a new filter in any way, whether
>      configured via config or passed via --filter=. Personally I think that's
>      fine.
>   3. If a user fetches with --refilter applying a more restrictive filter
>      than previously (eg: blob:limit=1m then blob:limit=1k) the eventual
>      state is a no-op, since any referenced object already in the local
>      repository is never removed. Potentially this could be improved in
>      future by more advanced gc, possibly along the lines discussed at [2].
> 

Yes, it would be nice to have a way to efficiently extend a
partial clone with a more inclusive filter.

It would be nice to be able to send the old filter-spec and the
new filter-spec and ask the server to send "new && !old" to keep
from having to resend the objects that the client already has.
But I'm not sure we know enough (on either side) to make that
computation.  And as you say, there is no guarantee that the client
has only used one filter in the past.

Jeff
