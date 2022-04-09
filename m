Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9498DC433F5
	for <git@archiver.kernel.org>; Sat,  9 Apr 2022 04:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiDIEMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Apr 2022 00:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiDIEMn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Apr 2022 00:12:43 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B90D38BDC
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 21:10:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
        t=1649477434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W217XN14crc/cfGIJOqcYKxEFDK1PKV4Lb3+KmrRYU0=;
        b=da/i3lJGx1wBPMYQH8y94o5jKT9KMJHWpEkv7EuIrZOXeVW7h7uK5k6O1NhJeSD0n1B17S
        8FfNtIxQpWN639wnVgmaKAwHcAjKFcYYU/sFPjcLNBl5NAnHCxYNdSjLa5DGlLtTNaFa20
        /VFBlKq1BGUUSJNUxhqm7TAYJD80kleipA4nvs5BPG5YqOXvaRyX8a4slJAMRYbp1uSrmj
        7hEmAiGjIFKuINrC+z0gzWFSMoNKdrJeiQ170D7WtAMFhFzb8sTctT5sF3lKgFzLebd5os
        U7EWAlz9h6SgB1WOLAa6yzqoKm22GAmfbz5MhxtLWht7dv45QgAfoZWUvYmrZQ==
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        joostkremers@fastmail.fm
Subject: Re: [PATCH] stash: disable literal treatment when passing top pathspec
In-Reply-To: <xmqqa6cvmmzn.fsf@gitster.g>
References: <20220408031228.782547-1-kyle@kyleam.com>
 <xmqqa6cvmmzn.fsf@gitster.g>
Date:   Sat, 09 Apr 2022 00:10:32 -0400
Message-ID: <877d7y3nif.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: kyleam.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:

> Kyle Meyer <kyle@kyleam.com> writes:
[...]
>>  * the 'git clean' call, triggered by --include-untracked, does not
>>    remove untracked files from the working tree
>>
>>  * the 'git checkout' call, triggered by --keep-index, fails with a
>>    message about ":/" not matching any known files, and the main
>>    command exits with a non-zero status
>>
>> Fix both of these spots by passing --no-literal-pathspecs to the
>> subprocess commands.
>
> Yuck (to the original problem, not to the proposed solution).
>
> I wonder if stopping to use ":/" (or using "." instead, if we need
> to give _some_ pathspec) is a better approach.  Don't we move to the
> top of the working tree by the time cmd_stash() is called and whatever
> subprocess we spawn via run_command() interface will start at the
> top anyway, no?

For the --keep-index/checkout case, yes, it looks like the command
starts from the top-level.  Passing "." as the pathspec to checkout
works fine, as far as I can tell.

However, for --include-untracked/clean case, the subprocess directory is
set to startup_info->original_cwd since 0fce211ccc (stash: do not
attempt to remove startup_info->original_cwd, 2021-12-09).
