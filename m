Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5E0C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 18:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiBXSNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 13:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiBXSNm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 13:13:42 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659F8214F90
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 10:13:11 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8BB013F4860;
        Thu, 24 Feb 2022 13:13:10 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1E2CE3F483E;
        Thu, 24 Feb 2022 13:13:10 -0500 (EST)
Subject: Re: [PATCH v5 00/30] Builtin FSMonitor Part 2
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
 <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202171655390.348@tvgsbejvaqbjf.bet>
 <37f54cd9-3e53-7d38-2c23-2fc245dc1132@jeffhostetler.com>
 <nycvar.QRO.7.76.6.2202241650200.11118@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4aa1293e-00b6-b9ef-efd4-cdf605db37a1@jeffhostetler.com>
Date:   Thu, 24 Feb 2022 13:13:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2202241650200.11118@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/24/22 11:22 AM, Johannes Schindelin wrote:
> Hi Jeff,
> 
> On Tue, 22 Feb 2022, Jeff Hostetler wrote:
> 
>> On 2/17/22 11:06 AM, Johannes Schindelin wrote:
>>
>>> On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:
>>>
>>>> In this version I removed the core.useBuiltinFSMonitor config
>>>> setting and instead extended the existing core.fsmonitor.
>>>
>>> I am somewhat surprised that a reviewer suggested this, as it breaks
>>> the common paradigm we use to allow using several Git versions on the
>>> same worktree.
>>>
>>> Imagine, for example, that you run a Git version that understands
>>> `core.fsmonitor=true` to imply the built-in FSMonitor, while you
>>> _also_ use an IDE that bundles a slightly older Git version that
>>> mistakes the `true` for meaning the executable `true` (which is not a
>>> FSMonitor at all, but its exit code suggests that everything's fine
>>> and dandy). The result would be that the IDE does not see _any_
>>> updates anymore, but nothing would suggest that anything is wrong.
>>>
>>> We can probably warn users about this, and we can also work around the
>>> fact that Git for Windows already uses `core.useBuiltinFSMonitor`, but
>>> it makes me somewhat uneasy nevertheless.
>>
>> This is a valid concern and I should have thought to mention it when
>> the suggestion came up on the list.  Yes, extending `core.fsmonitor` to
>> take a boolean or a path could confuse older clients (like ones bundled
>> with an IDE, like VS).
>>
>> My assumption was that since we shipped `core.useBuiltinFSMonitor`
>> in GFW with an experimental label, that normal users would not be
>> using it at all and especially not from their IDEs, so it wouldn't
>> matter.  And experimental features are just that -- experimental
>> and subject to change.
>>
>> But your point is valid -- if someone does have the odd hook called
>> "true" or "1", they'll get an unexpected result.
> 
> I wondered about that for a while, and put that to a test last night. I
> set `core.fsmonitor = true` and then modified a file and ran `git status`.
> Something I did not expect happened: it picked up on the modified file!
> 
> It also printed out a warning:
> 
> 	warning: Empty last update token.
> 
> This is the reason why it works: by default, current Git versions assume
> that the FSMonitor hook understands the FSMonitor protocol v2, which
> starts by the client sending out a token, receiving a new token and then
> the paths of the files/directories/symlinks to inspect. Since the program
> `true` does _not_ write that token, Git warns that it did not receive a
> token and continues as if no FSMonitor had been configured.
> 
> So that's good news!
> 
> The less good news is that prior to v2.26.0, Git did not support v2 of the
> FSMonitor protocol, but only v1. And v1 does not expect such a token. Git
> versions between v2.16.0 and v2.26.0 will interpret a successful run of
> the `true` executable with an empty output to mean that no files have been
> modified.
> 
> And indeed, in my tests, after making sure that the Git index had been
> refreshed explicitly and then modifying a file and then running `git
> status` with v2.16.0, Git did not pick up on the modification.
> 
> That's the less good news.
> 
> At first I thought that we're pretty safe because nobody should use older
> Git versions and enable FSMonitor because FSMonitor protocol v1 is known
> to be subject to racy behavior. But then, Git users sometimes do not
> completely control which Git versions they use. Take for example Visual
> Studio users who also use the Git Bash to work on their worktree. While
> their Git Bash might be reasonably recent, Visual Studio comes with its
> own embedded Git version. Therefore, a user might want to play with the
> built-in FSMonitor in Git Bash, find that it dramatically speeds up
> everything (as it does for me, thank you so much!), and not realize that
> the Git executable used by Visual Studio totally misinterprets
> `core.fsmonitor` to refer to `/usr/bin/true.exe` and then miss any
> modifications.
> 
> As long as the embedded Git version is at least v2.26.0, Visual Studio
> will at least work correctly (because it ignores `true.exe`'s output and
> continue as if no FSMonitor had been configured). But as soon as an older
> version is used, Git would work incorrectly, without any indication what
> is going wrong.
> 
> I tried to come up with alternatives (because I _really_ dislike being a
> reviewer who only points out what's wrong without any constructive
> suggestion how to do it better), and the best alternatives I came up were:
> 
> - stick with `core.useBuiltinFSMonitor` as before, or
> 
> - use a special value of `core.fsmonitor` that simply is not a valid
>    executable name. In 2019, when I worked on the original precursor of the
>    built-in FSMonitor (before I had to drop working on FSMonitor
>    because of all the security work that went into v2.24.1), I had picked
>    `:builtin:` because colons are illegal on Windows, but of _course_ they
>    are legal everywhere else. But one thing is not possible, even on Linux:
>    to have a trailing slash in an executable name. So something like
>    `/builtin-fsmonitor/` would work.
> 
> However, after seeing how nicely your latest iteration cleans up the code
> by simply interpreting a Boolean value to refer to the built-in FSMonitor,
> I _really_ would like to make it work.
> 
> Maybe we can declare that it is "safe enough" to rely on new enough Git
> versions to be used by users who use multiple Git versions on the same
> worktree? They should use _at least_ v2.26.1 anyway, because that one
> fixed a rather important vulnerability (CVE-2020-5260)? At least for
> Visual Studio, this is true: it ships with Git version 2.33.0.windows.2.
> 
> What do you think? Can we somehow make `core.fsmonitor = true` work?
> 
> Ciao,
> Dscho
> 

Thanks for the testing and background information here!

I agree.  I would like to keep the current

     "core.fsmonitor = <bool> | <path>"

usage that I have in V5.

It cleaned up things very nicely and it got rid of the somewhat awkward
usage of having "core.useBuiltinFSMonitor" override the existing
"core.fsmonitor" setting.

It is unfortunate that it might cause a breakage for users who are
*also* running a Git version between 2.16 ... 2.26.  I have to wonder
if it wouldn't be better to spend our energy documenting that users
should upgrade, rather than trying to support interop with them.

The 2.16 ... 2.26 versions don't have the security fix referenced
above.

The 2.16 ... 2.26 versions are based upon the V1 FSMonitor protocol
and don't have fixes for several serious bugs or races in the original
implementation:

* 398a3b0899 (fsmonitor: force a refresh after the index was discarded, 
2019-05-07)
* 679f2f9fdd (unpack-trees: skip stat on fsmonitor-valid files, 2019-11-20)
* dfaed02862 (fsmonitor: update documentation for hook version and 
watchman hooks, 2020-01-23)

That last fix added the V2 FSMonitor protocol.  This is used by both
the hook- and the IPC-based providers.

So anything still using the V1 FSMonitor protocol is going to unreliable
and racy and users should not use it, so I don't think it is worth the 
effort to complicate our current solution to maintain compatibility.
(I hate to say that, but they just shouldn't be using V1 any more.)


On a slight tangent, the current code (before my patch series) does
support a "core.fsmonitorhookversion" to allow the client to talk to
a V1 or V2 provider explicitly (vs the default of trying V2 and then
trying V1).  The IPC implementation does not use this config setting,
but I could see adding something to emit a warning if it was set to
1 when using the builtin FSMonitor.  This might help users who are
*also* running a Git version between 2.26 and 2.35 to understand the
fallback after the true.exe warning that Johannes described.


On another slight tangent, I'm wondering if we want to officially
deprecate the V1 hook code and/or remove support for it from the code.


Jeff
