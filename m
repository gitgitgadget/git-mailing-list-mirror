Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8EFC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbiGSVCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiGSVCO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:02:14 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C976481C6
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:02:12 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F2C6A3F47EF;
        Tue, 19 Jul 2022 17:02:11 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [74.205.145.90])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B66CE3F47F9;
        Tue, 19 Jul 2022 17:02:11 -0400 (EDT)
Subject: Re: Possible git bug when working with Microsoft Mapped drives
To:     paul@kinzelman.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <f946c577-d3d6-212c-cec5-a6c63856b77d@kinzelman.com>
 <b5931787-3589-102f-cfeb-caeb8a07e149@jeffhostetler.com>
 <YtXS1s66fw/UCvLU@tapette.crustytoothpaste.net>
 <d4a77fd1-6be7-6466-8c94-6e2552184094@kinzelman.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e39ce708-afbf-4524-187c-20dcd979a061@jeffhostetler.com>
Date:   Tue, 19 Jul 2022 17:02:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d4a77fd1-6be7-6466-8c94-6e2552184094@kinzelman.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Could you maybe create an issue against GFW for this so that we don't
forget about it?

https://github.com/git-for-windows/git/issues

Jeff


On 7/18/22 5:55 PM, Paul Kinzelman wrote:
> Thank you! Jeff was right on, but I didn't want to create extra noise
> on the elist, so I replied just to him.
> 
> His suggestion of the --no-hardlinks
> caused it to work!
> 
> Might be good to test to see if a drive letter is on a remote system
> and do that automagically.
> 
> On 7/18/2022 3:38 PM, brian m. carlson wrote:
>> On 2022-07-18 at 20:46:44, Jeff Hostetler wrote:
>>> On 7/18/22 4:28 PM, Paul Kinzelman wrote:
>>>> I'm using git version 2.37.1.windows.1 and Windows 10
>>>>
>>>> I've got two systems which are miles apart and so are not on the same
>>>> LAN, and I have connected them together using the ui.com VPN and M$
>>>> RDP/TSclient. I mapped each system's C: drive to be accessed by the
>>>> other system as Drive X: and I can transfer files back and forth
>>>> initiated on each system.
>>>>
>>>> I can also see all the repository files on the source system, including
>>>> the tree of files under the .git directory. Note I had to unhide the
>>>> .git folder so that I could see that folder from the other system.
>>>>
>>>> However, when I run 'git clone' on one system to get the repository 
>>>> from
>>>> the other system, git seems to think the repository on the other
>>>> system is empty when it's not. As I said, I can even do a directory
>>>> and see all the other files.
>>> I can't duplicate your setup, so I'll just speculate out loud
>>> here.  I have to wonder if the "X:" drive letters are tricking
>>> Git to thinking that the remote instance is actually local and
>>> Git is trying to use some shortcuts. (For example, it might
>>> hardlink them rather than copy them on Linux.)
>>>
>>> So I'm wondering if "--no-local" or "--no-hardlinks" or using
>>> a file URL rather than a pathname might make it behave differently.
>> It may also be the case that the remote file system lacks some
>> functionality that Git needs.  For example, Windows can support mapping
>> HTTP DAV resources as drives, but the DAV protocol is incapable of
>> providing certain operations that Git expects of a file system (Git
>> roughly needs something that's POSIX compliant, but can paper over case
>> insensitivity) and thus such a disk simply can't work with Git.
>>
>> This may end up looking like the file system is empty because, for
>> example, the function to query directory contents may return an error.
>> The contents may not actually be empty, but because they cannot be
>> enumerated in the way Git needs them to be, it appears that way.
>>
>> Again, I don't know if this is the case here, but you're the second
>> person recently to have seen problems with using RDP for this purpose.
>> You may wish to try SFTP, which should work (at least it does for Unix
>> systems), or possibly SMB/CIFS (which may or may not work, but I believe
>> it typically does).
> 
