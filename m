Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1727ECAAD5
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 17:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbiIFRY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 13:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiIFRYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 13:24:12 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271458E459
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 10:13:46 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8F488CA1249;
        Tue,  6 Sep 2022 13:13:45 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1015:b110:85b0:ed17:3499:a7f5:58a])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 297A7CC8327;
        Tue,  6 Sep 2022 13:13:45 -0400 (EDT)
Subject: Re: [PATCH v4 4/4] fsmonitor: normalize FSEvents event paths to the
 real path
To:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <56cabf3be3b9e228bc948da372db4c9d11fd3926.1661962145.git.gitgitgadget@gmail.com>
 <bdf26d53-7068-87a6-484b-aeef99be35bd@jeffhostetler.com>
 <BYAPR05MB5573B477ED53CBC4C996729DD97A9@BYAPR05MB5573.namprd05.prod.outlook.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a583a787-1f54-74ba-add1-61f9e30d5c2a@jeffhostetler.com>
Date:   Tue, 6 Sep 2022 13:13:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR05MB5573B477ED53CBC4C996729DD97A9@BYAPR05MB5573.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/2/22 12:35 PM, Eric DeCosta wrote:
> 
> 
>> -----Original Message-----
>> From: Jeff Hostetler <git@jeffhostetler.com>
>> Sent: Thursday, September 1, 2022 4:06 PM
>> To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>;
>> git@vger.kernel.org
>> Cc: Eric DeCosta <edecosta@mathworks.com>
>> Subject: Re: [PATCH v4 4/4] fsmonitor: normalize FSEvents event paths to the
>> real path
>>
>>
>>
>> On 8/31/22 12:09 PM, Eric DeCosta via GitGitGadget wrote:
>>> From: Eric DeCosta <edecosta@mathworks.com>
>>>
>>> Consider the following network working directory that is mounted under
>>> /System/Volumes/Data:
>>>
>>> /network/working/directory
>>>
>>> The git working directory path is:
>>>
>>> /System/Volumes/Data/network/working/directory
>>>
>>> The paths reported by FSEvents always start with /network. fsmonitor
>>> expects paths to be under the working directory; therefore it fails to
>>> match /network/... and ignores the change.
>>
>> I'm not sure I understand what's going on here.
>> Are you saying that FSEvents reports network mounted directories with a
>> path relative to the mount-point rather than an absolute path?
>>
> 
> Yes
> 
>> In your example, is "/network/working/directory" a valid path on your
>> system (that also happens to be the same directory as
>> "/System/Volumes/...")
>>
>> That is, do you have some aliasing going on where both paths are valid -- like
>> a pair of hard-linked directories?
>> Or, is there something special about a network mount point?
>>
>>
>> Did you have to "cd /System/Volumes/..." to get Git to have the absolute
>> path be this?  Or were you doing a "cd /network/..."?
>> (Sorry to ask so many questions but I don't have a pair of systems to test any
>> of this on right now.)
>>
> 
>   "/network/working/directory" is mounted under
> "/System/Volumes/Data/network/working/directory"
> 
> There is also a symlink:
> 
> "/network" -> "/System/Volumes/Data/network"
> 
> No matter if I "cd /System/Volumes/Data/network/working/directory"
> or "cd /network/working/directory" the paths reported by FSEvents
> always start with "/network/working/directory"
> 
> If I do a similar symlink with local directories, I do not get this
> unexpected behavior.
> 
> I need to remove the symlink and try it that way, but I need to
> coordinate with the machine's owner.


I think you have stumbled upon a recent MacOS feature called
"firmlinks".  I'm just reading up on it myself, so I shouldn't
speculate here (yet), but maybe you too could do some reading
on the subject.

This makes me wonder if the symlink is historical.  The real
magic is in the firmlinks.  For example, if I do:

	$ (cd / ; ls -l | grep Users)
	drwxr-xr-x   6 root  admin   192 Apr  6  2020 Users

	$ (cd /Users ; df .)
	Filesystem   512-blocks      Used Available Capacity iused      ifree 
%iused  Mounted on
	/dev/disk1s1  976490576 608954344 338850488    65% 4181323 4878271557 
  0%   /System/Volumes/Data

we can see that /Users is on /System/Volumes/Data (and there is a
/System/Volumes/Data/Users directory with the same metadata), but
it is not a symlink.


See [1] for more info.

[1] 
http://www.swiftforensics.com/2019/10/macos-1015-volumes-firmlink-magic.html


[...]
>>> @@ -209,7 +209,12 @@ static void
>> fsevent_callback(ConstFSEventStreamRef streamRef,
>>>    		/*
>>>    		 * On Mac, we receive an array of absolute paths.
>>>    		 */
>>> -		path_k = paths[k];
>>> +		if (fsm_settings__get_allow_remote(the_repository) > 0) {
>>> +			strbuf_reset(&tmp);
>>> +			strbuf_realpath_forgiving(&tmp, paths[k], 0);
>>> +			path_k = tmp.buf;
>>> +		} else
>>> +			path_k = paths[k];
>>
>> This feels wrong.
>>
>> It is not that fsmonitor.allowRemote is true, but whether or not this
>> particular file system *IS* remote, right?
> 
> True. I suppose each path could be checked, or some bit could be set
> if the working directory is remote, perhaps along the lines of
> fsmonitor_ipc__get_path. Then the determination of the IPC path
> and whether it is remote would be in one place. fsm-settings-*
> would then just get that bit and check it against allowRemote.
> 
> Thoughts?

I'll do some digging here.  There ought to be a way to tell if a
component directory in a pathname has a firmlink peer.  (But I'm
traveling for GitMerge, so I might not have time to look at this
until afterwards.)

This would indicate that a "bi-directional wormhole" (their words)
alias is available (and hopefully, a way to computer the other peer....)

I'm thinking that the "/network/..." path in the FSEvents is because
FSEventD is using a particular peer spelling (that we weren't
expecting).

If we can compute the spellings of the peers once when the daemon
starts up (and maybe make a little dictionary), then we can do
prefix tricks on the absolute path after the
         path_k = paths[k];
step in fsevent_callback() to extract a relative path rather than
an absolute path.

Then call fsmonitor_classify_path_relative() instead of _absolute().

Watch out though, there are several places that do
         rel = path+k + ...state->path_worktree_watch.len...
that would need to be adjusted.

Hope this helps,
Jeff





