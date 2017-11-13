Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703F01F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 15:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbdKMPEs (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 10:04:48 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:40299 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752551AbdKMPEr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 10:04:47 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id EGI1e0IxLbjdZEGI1e4jTW; Mon, 13 Nov 2017 15:04:45 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=xtxXYLxNAAAA:8 a=NEAV23lmAAAA:8 a=oX-B-6vg45xkkKEZ-ysA:9
 a=D9SZ0WojkjfvGg8R:21 a=zKaRQSi7SpZOq-mq:21 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <0CA45D65AEDF405C987769D865EE0836@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Elijah Newren" <newren@gmail.com>
Cc:     "Git Mailing List" <git@vger.kernel.org>
References: <20171110190550.27059-1-newren@gmail.com> <3076EE0E678D43B286F86E622CB9F06E@PhilipOakley> <CABPp-BE1+32fQQdYuwP-7m+GXqyhoUpHKgMM6SCcW4e9geutvw@mail.gmail.com>
Subject: Re: [PATCH 00/30] Add directory rename detection to git
Date:   Mon, 13 Nov 2017 15:04:49 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171113-0, 13/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfNV7u4svS2QkVerQu68Q29ouWzvfNQCOfEsTkJEi57VCknekfNXzrG/juq7k8Iyw3pBngGD25jlpjoQF2WD+CuJwjhfE5/Yu0RAW1zG5l/mQBJQCu3Vs
 6SGTuzejmtYI5/CzQw0A2bmLKOE3Hu6Cpo5k6Bf/Qbgq9E7SU5I2K+q+1ngrdyzHSpkbdQV8FgwUhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Elijah Newren" <newren@gmail.com>
: Friday, November 10, 2017 11:26 PM
> On Fri, Nov 10, 2017 at 2:27 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> From: "Elijah Newren" <newren@gmail.com>
>>>
>>> In this patchset, I introduce directory rename detection to
>>> merge-recursive,
>>> predominantly so that when files are added to directories on one side of
>>> history and those directories are renamed on the other side of history,
>>> the
>>> files will end up in the proper location after a merge or cherry-pick.
>>>
>>> However, this isn't limited to that simplistic case.  More interesting
>>> possibilities exist, such as:
>>>
>>>  * a file being renamed into a directory which is renamed on the other
>>>    side of history, causing the need for a transitive rename.
>>>
>>
>> How does this cope with the case insensitive case preserving file systems 
>> on
>> Mac and Windows, esp when core.ignorecase is true. If it's a bigger 
>> problem
>> that the series already covers, would the likely changes be reasonably
>> localised?
>>
>> This came up recently on GfW for `git checkout` of a branch where the 
>> case
>> changed ("Test" <-> "test"), but git didn't notice that it needed to 
>> rename
>> the directories on such an file system.
>> https://github.com/git-for-windows/git/issues/1333
>
> I wasn't aware there were problems with git on case insensitive case
> preserving filesystems; fixing them wasn't something I had in mind
> when writing this series.

I was mainly ensuring awareness of the potential issue, as it's not easy to 
solve.

> However, the particular bug you mention is
> actually completely orthogonal to this series; it talks about
> git-checkout without the -m/--merge option, which doesn't touch any
> code path I modified in my series, so my series can't really fix or
> worsen that particular issue.

That's good.
>
> But, if there are further issues with such filesystems that also
> affect merges/cherry-picks/rebases, then I don't think my series will
> either help or hurt there either.  The recursive merge machinery
> already has remove_file() and update_file() wrappers that it uses
> whenever it needs to remove/add/update a file in the working directory
> and/or index, and I have simply continued using those, so the number
> of places you'd need to modify to fix issues would remain just as
> localized as before.

It's when the working directory path/filename has a case change that goes 
undetected (one way or another) that can cause issues. I think that part of 
the problem (after awareness) is not having a cannonical expectation of 
which way is 'right', and what options there may be. E,g. if a project is 
wholly on a case insensitive system then the filenames in the worktree never 
matter, but aligning the path/filenames in the repository would still be a 
problem.

>  Also, I continue to depend on the reading of the
> index & trees that unpack_trees() does, which I haven't modified, so
> again it'd be the same number of places that someone would need to
> fix.  (However, the whole design to have unpack_trees() do the initial
> work and then have recursive merge try to "fix it up" is really
> starting to strain.

Interesting point.

>  I'm starting to think, again, that merge
> recursive needs a redesign, and have some arguments I wanted to float
> out there...but I've dumped enough on the list for a day.)
>
> It's possible that this series fixes one particular issue -- namely
> when merging, if the merge-base contained a "Test" directory, one side
> added a file to that directory, and the other side renamed "Test" to
> "test", and if the presence of both "Test" and "test" directories in
> the merge result is problematic, then at least with my fixes you
> wouldn't end up with both directories and could thus avoid that
> problem in a narrow set of cases.

I'll think on that. It may provide extra clues as to what the right 
solutions could be!
>
> Sorry that I don't have any better news than that for you.
>
> Elijah

Thanks
--
Philip 

