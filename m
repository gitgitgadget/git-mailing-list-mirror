Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B23DC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 23:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiCDXlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 18:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiCDXlT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 18:41:19 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A466D4C9
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 15:40:30 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AB6DF3F4815;
        Fri,  4 Mar 2022 18:40:29 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 716D93F482D;
        Fri,  4 Mar 2022 18:40:29 -0500 (EST)
Subject: Re: [PATCH 02/23] t7527: test FS event reporing on macOS WRT case and
 Unicode
To:     Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <ad8cf6d9a47b61d9fe41a961466122be16e4f041.1644940773.git.gitgitgadget@gmail.com>
 <c7ee2394-cda0-a997-3b9d-fb8c3d65b312@github.com>
 <20220224173305.gbr2waw77xpuieub@tb-raspi4>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8a32ed13-ed53-3605-ca78-83dac2be1e28@jeffhostetler.com>
Date:   Fri, 4 Mar 2022 18:40:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20220224173305.gbr2waw77xpuieub@tb-raspi4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/24/22 12:33 PM, Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= wrote:
> On Thu, Feb 24, 2022 at 09:52:28AM -0500, Derrick Stolee wrote:
>> On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Confirm that macOS FS events are reported with a normalized spelling.
>>>
>>> APFS (and/or HFS+) is case-insensitive.  This means that case-independent
> 
> This is not true, strictly speaking.
> You can format a disk with "case sensitive" or "case-insenstive, case preserving".
> Both APFS and HFS+  can be formated that way.
> The default, which is what you get when you get a new machine,
> is "case-insenstive, case preserving".
> And I assume, that more 99% of all disks are formated that way.
> The "core.ignorecase" is used in the same way as it is used under NTFS,
> FAT or all other case-insenstive file systems.
> (and even ext4 can be formated case-insensitive these days.)
> 
> An interesting article can be found here:
> https://lwn.net/Articles/784041/
> 
> And to be technically correct, I think that even NTFS can be
> "configured to be case insensitive in an empty directory".
> 
> In that sense, I would like to avoid this statement, which
> file system is case insensitive, and which is not.
> Git assumes that after probing the FS in "git init" we have
> a valid configuration in core.ignorecase.

You're right. I was incorrectly glossing over the differences
between APFS and HFS+ -- and conflating case and nfc/nfd
issues.

[...]
>>
>>> NEEDSWORK: I was only able to test case.  It would be nice to add tests
>>
>> "I was only able test the APFS case."?

I'm going to completely redo this commit in the next version.
I now have both APFS and HFS+ partitions on my machine and
can compare the differences in behaviors and will have a new
set of tests to cover this.

>>
>>> that use different Unicode spellings/normalizations and understand the
>>> differences between APFS and HFS+ in this area.  We should confirm that
>>> the spelling of the workdir paths that the daemon sends to clients are
>>> always properly normalized.
>>
>> Are there any macOS experts out there who can help us find the answers
>> to these questions?
> 
> There is a difference between HFS+ and APFS.
> HFS+  is "unicode decomposing" when you call readdir() - file names
> are stored decomposed on disk once created.
> However, opening  file in precompsed form succeds.
> In that sense I would strongly suspect, that any monitors are "sending"
> the decomposed form (on HFS+).
> 
> APFS does not manipulate file names in that way, it is
> "unicode normalization preserving and ignoring".

It took a few hours of poking to figure out what Apple is doing,
but yes on HFS+ they convert to NFD and use that as the on-disk
format.  And they do collision detection as they always have in
NFD-space.

Whereas on APFS, they preserve the NFC/NFD as given when the file
is created, but always do the same collision detection in NFD-space.
The net result is similar, but subtlety different.

FS Events from MacOS are sent using the on-disk format (NFD on HFS+
and whichever on APFS) and my FSMonitor daemon is sending them to
the client as received.

I'm not sure whether or not the daemon should respect the
`core.precompseUnicode` setting and when watching an HFS+
volume do the NFD-->NFC conversion for the client.  I'm not
sure whether that would be any more or less correct than just
reporting the paths as received.  I'm going to leave this as a
question for the future.


Thanks for all of your background information on this topic.
Jeff


