Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6119DC433EF
	for <git@archiver.kernel.org>; Sun,  5 Jun 2022 13:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350289AbiFEN5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jun 2022 09:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351078AbiFEN4z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jun 2022 09:56:55 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32610FF6
        for <git@vger.kernel.org>; Sun,  5 Jun 2022 06:55:37 -0700 (PDT)
Received: from host-89-242-71-63.as13285.net ([89.242.71.63] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nxqiz-00053Z-Ev;
        Sun, 05 Jun 2022 14:55:26 +0100
Message-ID: <9765fe38-7857-8e02-d559-b0d24ec45562@iee.email>
Date:   Sun, 5 Jun 2022 14:55:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Files with \r\n\n line endings can result in needing to
 renormalize twice, after deleting checked out file and restoring from repo
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
To:     "Philip, Bevan" <Bevan.Philip@softwareag.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM0PR02MB56357CC96B702244F3271014E8DC9@AM0PR02MB5635.eurprd02.prod.outlook.com>
 <44fe5991-3027-5ca7-bd3b-fd005d337caa@iee.email>
 <AM0PR02MB5635C34CA2415C4FB2164B91E8DF9@AM0PR02MB5635.eurprd02.prod.outlook.com>
 <525ed195-2a6f-1c43-3139-06134d3bb7e7@iee.email>
In-Reply-To: <525ed195-2a6f-1c43-3139-06134d3bb7e7@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06/2022 14:14, Philip Oakley wrote:
> On 01/06/2022 11:07, Philip, Bevan wrote:
>> Hey Philip,
>>
>> Thanks for the response!
>>
>>> ... however, if I remember the design discussion correctly, normalisation was decided to be just the conversion of the Windows style EOL = `\r\n` to the Linux/*nix style EOL =`\n`, and any other characters
>>> (utf8 / ascii bytes) were to be unchanged, including random '\r'
>>> characters. So in that respect I think it is working as initially designed.
>> This makes sense.
>>
>>> Do you have any information on how the mixed EOL styles (extra \r etc) came about?
>> I wish I knew how this file came about, but the people that put these files in our VCS have long left. I suspect some broken generation tool.
> I vaguely remember tales that early Macs use \r as their EOL character,
> so may have been that.
>>> Should those extra \r characters also be separate EOLs? (and how to
>>> decide..?)
>> Most tooling I use seems to do this, but I agree that this is an ambiguous topic.
> maybe an extra `sed` invocation changing all the \r to \n in such cases!

It looks like StackOverflow has an answer
https://stackoverflow.com/a/42914886/717355

$ sed -i 's/\r/\n/g; s/\n$//' for the all-at-once conversion filter
using sed (with explanation!). I believe its idempotent (great word to
know ;-)

>>> Are the docs missing anything that would have helped clarify the issue earlier?
>> A brief note on the limitations of renormalization might have proven helpful
> I'll maybe add that to my list of todo's (though it's a bit long and
> aspirational;-)
>
>>  - in particular, the bit that tripped me up was the requirement to remove and restore the files from the Git repository itself.
> I think it's just a checkout and then an `add` of the renormalised files
> `git add --renormalize . ` (not forgetting the all important `dot`),
> though some may have termed the checkout as the files being 'removed'.
>
> I did notice (when cross checking a few points) that there is also a
> `merge.renormalize` config option that will then make sure that when
> branches are merged you get the required re-normalisation (check the man
> pages ..).
>
>>  It wasn't obvious to me that this would have any impact on renormalization. Additionally, a note about the restriction on converting only \r\n to \n might also have proven useful.
> OK.
>
> PS, in-line replies preferred on the list.
>> Thanks,
>> Bevan
>>
>>
>> -----Original Message-----
>> From: Philip Oakley <philipoakley@iee.email>
>> Sent: 31 May 2022 22:12
>> To: Philip, Bevan <Bevan.Philip@softwareag.com>; git@vger.kernel.org
>> Subject: Re: Files with \r\n\n line endings can result in needing to renormalize twice, after deleting checked out file and restoring from repo
>>
>> On 31/05/2022 15:24, Philip, Bevan wrote:
>>> Hello all,
>>>
>>> I've experienced an odd bug/limitation with `git add --renormalize`, requiring me to run the command twice on a specific file. Here is a bug report.
>>>
>>> What did you do before the bug happened? (Steps to reproduce your
>>> issue)
>>>
>>> #!/bin/bash -x
>>> printf "Test\\r\\r\\nTest Another Line\\r\\r\\nFinal
>>> Line\\r\\r\\n\\r\\r\\n" > git.bdf printf "* text=auto\\n*.bdf text" >
>>> .gitattributes mkdir test1 cd test1 git init cp ../git.bdf .
>>> git add .
>>> git status
>>> git commit -m "Add file git.bdf"
>>> cp ../.gitattributes .
>>> git add .gitattributes
>>> git add --renormalize .
>>> git status
>>> git commit -m "Renormalize git.bdf"
>>> git add --renormalize .
>>> git status
>>> rm git.bdf
>>> git restore .
>>> git add --renormalize .
>>> git status
>>>
>>> What did you expect to happen? (Expected behavior) Only needing to
>>> renormalize the file once.
>> That sounds like an obvious expectation, ...
>>> What happened instead? (Actual behavior) Renormalize the file once,
>>> then renormalize again after deleting the file that is checked out on disk and restoring it from the object stored within the Git repo.
>>>
>>> What's different between what you expected and what actually happened?
>>> Needed to run the renormalize step again, after deleting the file checked out on disk and restoring the file from the object stored within the Git repo.
>>>
>>> Anything else you want to add:
>>> This only occurs for files with \r\r\n line endings (and possibly also
>>> ending the file with \r\r\n\r\n)
>> ... however, if I remember the design discussion correctly, normalisation was decided to be just the conversion of the Windows style EOL = `\r\n` to the Linux/*nix style EOL =`\n`, and any other characters
>> (utf8 / ascii bytes) were to be unchanged, including random '\r'
>> characters. So in that respect I think it is working as initially designed.
>>
>>> The file is in three states:
>>> - Initial state: \r\r\n line endings within Git object
>>> - Initial renormalization state: \r\n line endings within Git object
>>> - Second renormalization state: \n line endings within Git object
>>>
>>> Happens on both Windows and Linux (replicated on a fresh install of Git for Windows within Windows Sandbox). Additionally, tested with `next` trunk on Linux.
>>> System info is for a Windows build where it does happen.
>>>
>>> Directory, and file names should be irrelevant.
>>>
>>> We encountered this naturally, with some files within a SVN repo we're migrating.
>> Do you have any information on how the mixed EOL styles (extra \r etc) came about?
>> Should those extra \r characters also be separate EOLs? (and how to
>> decide..?)
>> Are the docs missing anything that would have helped clarify the issue earlier?
