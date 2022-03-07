Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E54C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 20:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbiCGUqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbiCGUql (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 15:46:41 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAE3811B2
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 12:45:45 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 12EED3F4803;
        Mon,  7 Mar 2022 15:45:45 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B7E683F4838;
        Mon,  7 Mar 2022 15:45:44 -0500 (EST)
Subject: Re: [PATCH 02/23] t7527: test FS event reporing on macOS WRT case and
 Unicode
To:     Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <ad8cf6d9a47b61d9fe41a961466122be16e4f041.1644940773.git.gitgitgadget@gmail.com>
 <c7ee2394-cda0-a997-3b9d-fb8c3d65b312@github.com>
 <20220224173305.gbr2waw77xpuieub@tb-raspi4>
 <8a32ed13-ed53-3605-ca78-83dac2be1e28@jeffhostetler.com>
 <20220305085916.7rn6lhmbjkebrm5n@tb-raspi4>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <15d59c97-bcb3-549d-0a22-f08ea0505d45@jeffhostetler.com>
Date:   Mon, 7 Mar 2022 15:45:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20220305085916.7rn6lhmbjkebrm5n@tb-raspi4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/5/22 3:59 AM, Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= wrote:
> On Fri, Mar 04, 2022 at 06:40:27PM -0500, Jeff Hostetler wrote:
>>
>>
>> On 2/24/22 12:33 PM, Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= wrote:
>>> On Thu, Feb 24, 2022 at 09:52:28AM -0500, Derrick Stolee wrote:
>>>> On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
>>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>>>
>>>>> Confirm that macOS FS events are reported with a normalized spelling.
[...]
>>
>>>>
>>>>> that use different Unicode spellings/normalizations and understand the
>>>>> differences between APFS and HFS+ in this area.  We should confirm that
>>>>> the spelling of the workdir paths that the daemon sends to clients are
>>>>> always properly normalized.
>>>>
>>>> Are there any macOS experts out there who can help us find the answers
>>>> to these questions?
>>>
>>> There is a difference between HFS+ and APFS.
>>> HFS+  is "unicode decomposing" when you call readdir() - file names
>>> are stored decomposed on disk once created.
>>> However, opening  file in precompsed form succeds.
>>> In that sense I would strongly suspect, that any monitors are "sending"
>>> the decomposed form (on HFS+).
>>>
>>> APFS does not manipulate file names in that way, it is
>>> "unicode normalization preserving and ignoring".
>>
>> It took a few hours of poking to figure out what Apple is doing,
>> but yes on HFS+ they convert to NFD and use that as the on-disk
>> format.  And they do collision detection as they always have in
>> NFD-space.
>>
>> Whereas on APFS, they preserve the NFC/NFD as given when the file
>> is created, but always do the same collision detection in NFD-space.
>> The net result is similar, but subtlety different.
> 
> That depends what you mean with "net result".
> What Git sees after calling precompose_utf8_readdir() with
> core.precomposeunicode=true ?

I just meant that the OS always does the collision detection
regardless of whether the filesystem is APFS or HFS. (They even
do it on a FAT32 thumb drive).  So the OS layer is always
composition insensitive while the underlying filesystem may
or may not be composition preserving.


>>
>> FS Events from MacOS are sent using the on-disk format (NFD on HFS+
>> and whichever on APFS) and my FSMonitor daemon is sending them to
>> the client as received.
>>
>> I'm not sure whether or not the daemon should respect the
>> `core.precompseUnicode` setting and when watching an HFS+
>> volume do the NFD-->NFC conversion for the client.  I'm not
>> sure whether that would be any more or less correct than just
>> reporting the paths as received.  I'm going to leave this as a
>> question for the future.
> 
> I think that I have a suggestion for an answer:
> We still have HFS+ systems around, and we still have an NFD feature
> in MacOs for USB sticks with FAT or SAMBA mounted network volumes.
> Both return NFD in readdir().
> Even if NFC is on disk for FAT or going over the wire for SAMBA.
> Having a precompose() function in the FSMonitor would help to make
> things consistent.
> And the answer is yes.

I agree.  I'm going to have the mac version always send the NFC
version (like core.precomposeUnicode suggests), but also send NFD
for *if* we get an NFD spelling from the FS event.  So on an HFS
volume we'll get two events for each path that have different
UTF8 spellings.  In the case of APFS we should only get the NFC
spelling -- unless the user really wants to use NFD spellings --
in which case we will respect that and send both.

This maybe be overkill, but the daemon (at the time that it
receives the FS event) doesn't know how the client process will
be configured when it makes a query at some point in the future.
So by recording both and reporting them to the client, the client
can decide how to process them.

Whichever spelling the client sees, it is only using it to mark
the cache-entry or untracked-cache data as possibly dirty so that
the original scanning code can actually check it.  This is a little
different from the diff-tree code that needs the official spelling
from the tree entry to match up items with the working directory.

I've overhauled all of the MacOS Unicode handling in V2.

Jeff

