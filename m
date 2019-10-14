Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1181F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 12:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbfJNMpd (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 08:45:33 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:60948 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730733AbfJNMpd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 08:45:33 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iJzj6-0007Ed-7K; Mon, 14 Oct 2019 13:45:28 +0100
Subject: Re: Git Gui: Branch->create currently fails...
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
References: <bfe78474-0eb9-fc5e-1371-3b055308169a@iee.email>
 <20191008000003.qlulu5ie36eij4uq@yadavpratyush.com>
 <e0b45696-7945-4b7d-62e7-bff46eb8129a@iee.email>
 <20191013185007.hogizh23jomaswzx@yadavpratyush.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <fccde9f3-7c5c-f8fb-1af2-bd56f48f7877@iee.email>
Date:   Mon, 14 Oct 2019 13:45:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191013185007.hogizh23jomaswzx@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,
On 13/10/2019 19:50, Pratyush Yadav wrote:
>> I've tried both parts and seen that this looks like some form of buffer
>> overrun or size limit
> Looks like it, but I'm not sure if that is on our end.
>   
>> with the mods I ran:
>> $ git gui > branch_create.txt
>>
>> which produced the 'same' error missing ", but with a slightly different
>> fragment.
>>
>> The branch_create.txt file is size 1.43 MB (1,502,103 bytes) (from the
>> windows explorer file properties dialog..)
>> opening in Notepad++ it's 4900 lines long with the final line trucated at
>> col 188 (shorter than other lines). There is an empty line 4901 (CRLF)
> Yeah, that's a lot of refs! On my git.git clone, I get 1299 lines, and I
> have git.git, my fork of git.git, and gitster in my remotes.
>   
>> the last two lines are:
>> list "refs/heads/branch-patterns" [list "commit"
>> "b2453cea29b58f2ec57f9627b2456b41568ba5da" [concat "" "Philip Oakley"]
>> [reformat_date [concat "" "Tue May 28 20:22:09 2019 +0100"]] "squash! doc
>> branch: provide examples for listing remote tracking branches"] [list "" ""
>> "" [reformat_date ""] ""]
>> list "refs/heads/MSVC-README" [list "commit"
>> "056fb95c8e983ec07e9f5f8baa0b119bf3d13fed" [concat "" "Philip Oakley"]
>> [reformat_date [concat "" "Sun May 19 22:33:37 2019 +0100"]] "compat/vc
>>
>> the file starts with 1018 lines of refs/tags before listing the refs/remotes
>> and finally the refs/heads.
>>
>> The repo is my local Git repo with multiple remotes (git.git, G-f-W, ggg,
>> junio, gitster, dscho, t-b, tboeg, me), so plenty of refs there!
>>
>> So it does look to be specific to repos with a large number of refs/tags,
>> refs/remotes, and refs/heads.
>>
>> something for the back-burner?
> I'm not sure why or where a buffer overflow would occur. We don't store
> the whole output directly in a variable. Instead, we store each line
> from the pipe coming in from `git for-each-ref` in $line, so that's a
> few hundred characters at most. The rest of the data stays in the pipe,
> which the OS should handle, and I don't think a few MBs should cause
> trouble.
>
> If I had to guess, I'd suspect either an internal Tcl limit, or
> something with Tcl pipes.
>
> Just to be sure it is a git-gui/Tcl issue and not an upstream git.git
> issue, can you run:
>
>    fmt='list %(refname) [list %(objecttype) %(objectname) [concat %(taggername) %(authorname)] [reformat_date [concat %(taggerdate) %(authordate)]] %(subject)] [list %(*objecttype) %(*objectname) %(*authorname) [reformat_date %(*authordate)] %(*subject)]'
>    
>    git for-each-ref --tcl --format="$fmt" --sort=-taggerdate refs/heads refs/remotes refs/tags
>
> and see if the output contains that truncated line? If it does, then
> that means the bug is in git-for-each-ref. Note that this is bash
> syntax, and I did a test run on Linux. Do adjust it for Windows and your
> shell if needed.

ran that bit of code (as distinct commands), and got (last two lines):

[list "" "" "" [reformat_date ""] ""]
list "refs/heads/branch-patterns-v2" [list "commit" 
"d5a799d8833b0ae195915eefd5365f3fc4c7c0a4" [concat "" "Philip Oakley"] 
[reformat_date [concat "" "Sat Jun 8 22:50:06 2019 +0100"]] 
"t3203-branch-output: test -a & -r pattern options"] [list "" "" "" 
[reformat_date ""] ""]
list "refs/heads/branch-patterns" [list "commit" 
"b2453cea29b58f2ec57f9627b2456b41568ba5da" [concat "" "Philip Oakley"] 
[reformat_date [concat "" "Tue May 28 20:22:09 2019 +0100"]] "squash! 
doc branch: provide examples for listing remote tracking branches"] 
[list "" "" "" [reformat_date ""] ""]
list "refs/heads/MSVC-README" [list "commit" 
"056fb95c8e983ec07e9f5f8baa0b119bf3d13fed" [concat "" "Philip Oakley"] 
[reformat_date [concat "" "Sun May 19 22:33:37 2019 +0100"]] 
"compat/vcSegmentation fault


Not exactly the same, but almost. Ends the same place, with as similar 
short line.
This is run inside the bash that is started directly by the 
git-for-windows sdk start icon. (Target: C:\git-sdk-64\git-bash.exe   
Stat in: C:/git-sdk-64/)

so looks to be MSYS2/bash related.

-- 
Philip
