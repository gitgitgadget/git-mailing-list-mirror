Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD39C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 12:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiJTM5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 08:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJTM46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 08:56:58 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF17C15A966
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 05:56:50 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 65610CA1251;
        Thu, 20 Oct 2022 08:56:49 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3A639CC8314;
        Thu, 20 Oct 2022 08:56:49 -0400 (EDT)
Subject: Re: [PATCH] fsmonitor: long status advice adapted to the fsmonitor
 use case
To:     Rudy Rigot <rudy.rigot@gmail.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
 <087d3fca-d01e-f36a-85f5-7e861e4d11ca@jeffhostetler.com>
 <CANaDLWKcF07=FQgT7ZTKmcgworH45YdNy8hy2faMBg3CGYEf+w@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d696b07f-cfa9-be45-b6d2-adb72811a205@jeffhostetler.com>
Date:   Thu, 20 Oct 2022 08:56:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CANaDLWKcF07=FQgT7ZTKmcgworH45YdNy8hy2faMBg3CGYEf+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/17/22 12:59 PM, Rudy Rigot wrote:
>> We should be careful here, FSMonitor only helps with untracked
> files if the untracked cache (UC) is also turned on.  They do work
> well together and they greatly speed up things, but if either is
> turned off, `git status` will still need to scan.
> 
> Oh, thanks, I didn't realize! With that, I agree that the messaging I'm
> proposing is not technically correct, and needs to be fixed.
> 
> I agree with your advice about the message when FSMonitor and
> untracked cache are both turned off. I'm also trying to think about
> what advice to give when they are turned on, and git status was
> slow because the update-index was building the cache on that call.
> 
> Importantly, I'm trying to think of ways to keep the messaging
> accessible even when the user is not familiar with those concepts.

Agreed.  We sometimes forget that not everyone is an expert in the
subtleties and terms of Git.  Even the original message "...enumerate
untracked files..." can be a little obscure to the casual user.

> I'm thinking a user may not even know what is currently enabled or
> not in their environment, so there's probably value in detecting their
> situation, and best adapting the messaging to it.
> 
> For context, in our case, we set core.fsmonitor and core.untrackedCache
> as part of our dev environment setup script, because we don't expect
> our least advanced developers to ramp up on what they are. And yet,
> it is useful to all of them to have them enabled, our git status is about
> 30 seconds long without FSMonitor and UC.
> 
> As a result, we have been receiving negative feedback that git status is
> slow, but when we inform the user that it is cached, they run it again and
> confirm that it is fine like this. The problem being about educating
> users and not a technical issue, of course we're adding the info to our
> setup doc, but I figured other large repos may hit this usability issue, so
> here I am.
> 
> What do you think of those phrasings?
> 
> - If neither FSMonitor nor the untracked cache are turned on, changing
> the current advice to: "It took %.2f seconds to enumerate untracked files.
> You may want to skip that part with 'status -uno' but you have to be
> careful not to forget to add new files yourself (see 'git help status').
> Otherwise, you can enable the core.untrackedCache config to have
> it be cached, and potentially the core.fsmonitor config to further improve
> the cache's performance."
> 
> - If only the untracked cache is turned on, since you said it could already
> improve some: "It took %.2f seconds to enumerate untracked files.
> Your untracked cache is enabled, but you may want to enable the
> core.fsmonitor config to further improve the cache's performance.
> Otherwise, you may want to skip that part with 'status -uno' but you have
> to be careful not to forget to add new files yourself (see 'git help status')."
> 
> - If they're both turned on: "It took %.2f seconds to enumerate untracked
> files. Your untracked cache is enabled and fsmonitor is on,
> so your next calls may be faster. Otherwise, you may want to skip that part
> with 'status -uno' but you have to be careful not to forget to add new
> files yourself (see 'git help status')."

All three of these are a bit wordy and/or awkward -- but I'm not sure
how to say it either, so don't feel bad.  I think it is just the quality
of the corner that we've been backed into -- there are just too many
knobs and not enough space to do them justice.  And I've always found
the "turn this on, but be careful..." advice/warning a bit odd.


As an alternative, and definitely just thinking out loud here.

Would it be better to add a "Untracked Files and Status Speed"
section to the bottom of https://git-scm.com/docs/git-status
(aka `Documentation/git-status.txt`) near
https://git-scm.com/docs/git-status#_background_refresh

Describe the various combination of config options in more detail
and discuss the pros/cons of each, what the defaults are, and how to
set them, how to tell what they are currently set to, and so on.

Then have the advice message reference that new section.

We might also reword the large paragraph ("When `-u` option is not...")
in the `--untracked-files` argument to reference the new section.  It is
a little stale and just as awkward.

Just a thought...


Jeff
