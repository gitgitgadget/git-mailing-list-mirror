Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF7FC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 20:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350291AbiHSUPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350148AbiHSUPj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 16:15:39 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16633D399C
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 13:15:37 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 48A363F4131;
        Fri, 19 Aug 2022 16:15:37 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1014:b1a9:35ad:581:b5cb:d568:560a])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C6AEA3F40F3;
        Fri, 19 Aug 2022 16:15:36 -0400 (EDT)
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
To:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
 <a63bda82-3dfc-44e0-8ecf-ca340d0a95b4@jeffhostetler.com>
 <BL0PR05MB55718D2BE72492E74EF2A671D96C9@BL0PR05MB5571.namprd05.prod.outlook.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <04e07c9a-6a74-b731-75e5-7d6cd9d8931c@jeffhostetler.com>
Date:   Fri, 19 Aug 2022 16:15:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BL0PR05MB55718D2BE72492E74EF2A671D96C9@BL0PR05MB5571.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/19/22 2:38 PM, Eric DeCosta wrote:
> 
> 
>> -----Original Message-----
>> From: Jeff Hostetler <git@jeffhostetler.com>
>> Sent: Friday, August 19, 2022 12:50 PM
>> To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>;
>> git@vger.kernel.org
>> Cc: Eric DeCosta <edecosta@mathworks.com>
>> Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
>> network-mounted repos
>>
>>
>>
>> On 8/18/22 4:48 PM, Eric DeCosta via GitGitGadget wrote:
>>> From: Eric DeCosta <edecosta@mathworks.com>
>>>

[...]
> Yes, the point is to allow users to try it out.  Self-servingly, I have about
> 3K users who make heavy use of network-mounted sandboxes on the
> three major platforms; all connecting via NFS or SMB to Linux file
> servers.  Hardly exhaustive, but the file system change notification APIs
> (inotify, FSEvents, and ReadDirectoryCHangesW) all seem to work correctly.
> Thus my motivation to work on this aspect of git :-)

Perfect.  I have to be careful here, I don't want to discourage
experimentation and testing -- and if you have access to a pool of
users who can beat on it, then great let's try it.

At the time, I didn't have such a "captive audience"... :-)

And I just wanted to be sure that everyone understood that some of
these combinations have never been tried....

[...]
> As far as multiple client machines mounting the remote repo, I have
> doubts that FSMonitor would even see changes made from another
> machine. Worth trying out and documenting as needed - might even
> be better off being considered as unsupported.

Yeah, that's another dimension.  (1) is whether we miss events
that we generated locally.  (2) is whether events get relayed to
us from other clients.


>> There was a suggestion later in this thread about using a SHA-1
>> or SHA-256 hash of the pathname to avoid the tmp XXXXXX pattern
>> and just put the socket in $HOME (and omit the need for the new
>> fsmonitor-daemon.ipc FILE completely).  This might work, but we
>> need to be careful because a user might have hardlinks or symlinks
>> locally so there may be more than one unique path to the repo
>> on the local system.  (It is OK to have more than one daemon
>> listening to a repo, just less efficient.)
>>
> Ah, I see.
> 
>>
>> As an interim step, you might try using my original socket code
>> plus just the config.allowRemote=true change.  And test it on a
>> mounted repo where you've converted the .git directory to a .git
>> file and moved contents of the .git directory to somewhere local.
>> Then the UDS would be created in the local GITDIR instead of on
>> the remote system.  This won't help any of the sharing cases I
>> described above, but will let you experiment with getting remote
>> events.
>>
> Within the context of the environment that I have available to me
> (macOS over NFS to a Linux file server), FSEvents is working correctly.
> I can make changes at any arbitrary place inside of the repo and an
> event is generated.
> 
> It's looking like that the Unix domain socket (UDS) file should remain
> where it is unless fsmonitor.allowRemote is true.
> 
> If fsmonitor.allowRemote is true then the UDS file can be located
> in $HOME with the caveat that if there is more than one path to
> the repo (via hard or sym links) that things might not work as
> expected.  I think that's OK given the experimental nature of the
> feature.

Yeah, I'd experiment with moving the UDS to $HOME (assuming you don't
remote mount home directories too) and see how it works for you.
Later, after we have more experience with it, we can talk about just
having it always be in $HOME.

Jeff

