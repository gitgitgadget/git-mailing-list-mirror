Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B7C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 15:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJGPTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJGPTW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 11:19:22 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FE4102505
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 08:19:21 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 67815CA1268;
        Fri,  7 Oct 2022 11:19:20 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3A97FCC8323;
        Fri,  7 Oct 2022 11:19:20 -0400 (EDT)
Subject: Re: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0f67ca77-f17f-d844-e689-ca9a9bdf7993@jeffhostetler.com>
Date:   Fri, 7 Oct 2022 11:19:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/6/22 3:43 PM, Jeff Hostetler via GitGitGadget wrote:
> This patch series fixes three syntax errors that caused compiler errors with
> clang 11.0.0 on MacOS. I've included the error/warning messages in the
> commit messages. The offending statements did compile successfully under
> clang 14.0.0 on MacOS, so I have to assume that this usage is newer than
> what clang 11 supports.
[...]

I didn't realize that these variable initialization fixes would
spawn such a large response here [1].  Nor that it had been already
discussed in great length in [2] in July.

I'm not sure how to best proceed here.

* I'm not sure these fixes are important enough to warrant the
   engineering time to hack up the Makefile or config.mak.uname
   to conditionally turn off -Wno-missing-braces based on some
   {platform-os-version, gcc/clang-version} combination.

* While -Wno-missing-braces option may prevent the warning/error
   (depending on -Werror) for these "{0}" should be "{{0}}"
   errors, do we know that this won't hide real problems.  (I mean
   we tend to only see it for these {0} / {{0}} false alarms, but
   I'd hate to lose the protection for non-false alarms.)

* The suggestion to use a <type>_INIT macro to hide the {0} or
   {{0}} may help in the:
         xmparam_t xmp = XMPARAM_INIT;
   case, but in the `mmfile_t mmfs[3]` case, we have an array of
   that type, so we'd need something like:
      mmfile_t mmfs[3] = { MMFILE_INIT }; or
      mmfile_t mmfs[3] = MMFILE_INIT_ARRAY;
   for the macros to make sense.
   I'm not sure either of these two is better than just writing "{{0}}".

* I wasn't sure which compiler versions we *want* to support or
   want to drop support for.
   * I've only thought about it in the context of clang on MacOS.
   * Clang 11 (from what I can tell (without looking too hard))
     comes with the version of XCode that runs on MacOS 10.15
     Catalina.  (In contrast, clang 14 comes with the version of
     XCode that runs on MacOS 12.6 Monterey.)
   * I can't comment on other old-ish compilers on other platforms.

* I'm not the first one who has stumbled over this and had to
   rediscover the solution.  So I'd hate to just kick this down
   the road some more, but then again I'd hate to waste a lot of
   time on it -- for very little actual functional value.

* Is "{{0}}" really that ugly ???

So as I said earlier, I'm not sure how to proceed here.

Jeff


[1] 
https://lore.kernel.org/git/pull.1375.git.1665085395.gitgitgadget@gmail.com/

[2] 
https://lore.kernel.org/git/365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com/
