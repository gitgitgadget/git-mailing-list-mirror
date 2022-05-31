Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D8CC433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 21:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244295AbiEaVLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 17:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347910AbiEaVLn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 17:11:43 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB76CD1
        for <git@vger.kernel.org>; Tue, 31 May 2022 14:11:41 -0700 (PDT)
Received: from 224.222.9.51.dyn.plus.net ([51.9.222.224] helo=[192.168.1.75])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nw99O-000AJx-Bp;
        Tue, 31 May 2022 22:11:39 +0100
Message-ID: <44fe5991-3027-5ca7-bd3b-fd005d337caa@iee.email>
Date:   Tue, 31 May 2022 22:11:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Files with \r\n\n line endings can result in needing to
 renormalize twice, after deleting checked out file and restoring from repo
Content-Language: en-US
To:     "Philip, Bevan" <Bevan.Philip@softwareag.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM0PR02MB56357CC96B702244F3271014E8DC9@AM0PR02MB5635.eurprd02.prod.outlook.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <AM0PR02MB56357CC96B702244F3271014E8DC9@AM0PR02MB5635.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/2022 15:24, Philip, Bevan wrote:
> Hello all,
>
> I've experienced an odd bug/limitation with `git add --renormalize`, requiring me to run the command twice on a specific file. Here is a bug report.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> #!/bin/bash -x
> printf "Test\\r\\r\\nTest Another Line\\r\\r\\nFinal Line\\r\\r\\n\\r\\r\\n" > git.bdf
> printf "* text=auto\\n*.bdf text" > .gitattributes
> mkdir test1
> cd test1
> git init
> cp ../git.bdf .
> git add .
> git status
> git commit -m "Add file git.bdf"
> cp ../.gitattributes .
> git add .gitattributes
> git add --renormalize .
> git status
> git commit -m "Renormalize git.bdf"
> git add --renormalize .
> git status
> rm git.bdf
> git restore .
> git add --renormalize .
> git status
>
> What did you expect to happen? (Expected behavior)
> Only needing to renormalize the file once.

That sounds like an obvious expectation, ...
> What happened instead? (Actual behavior)
> Renormalize the file once, then renormalize again after deleting the file that is checked out on disk and restoring it from the object stored within the Git repo.
>
> What's different between what you expected and what actually happened?
> Needed to run the renormalize step again, after deleting the file checked out on disk and restoring the file from the object stored within the Git repo.
>
> Anything else you want to add:
> This only occurs for files with \r\r\n line endings (and possibly also ending the file with \r\r\n\r\n)

... however, if I remember the design discussion correctly, 
normalisation was decided to be just the conversion of the Windows style 
EOL = `\r\n` to the Linux/*nix style EOL =`\n`, and any other characters 
(utf8 / ascii bytes) were to be unchanged, including random '\r' 
characters. So in that respect I think it is working as initially designed.

> The file is in three states:
> - Initial state: \r\r\n line endings within Git object
> - Initial renormalization state: \r\n line endings within Git object
> - Second renormalization state: \n line endings within Git object
>
> Happens on both Windows and Linux (replicated on a fresh install of Git for Windows within Windows Sandbox). Additionally, tested with `next` trunk on Linux.
> System info is for a Windows build where it does happen.
>
> Directory, and file names should be irrelevant.
>
> We encountered this naturally, with some files within a SVN repo we're migrating.

Do you have any information on how the mixed EOL styles (extra \r etc) 
came about?
Should those extra \r characters also be separate EOLs? (and how to 
decide..?)
Are the docs missing anything that would have helped clarify the issue 
earlier?
>
> [System Info]
> git version:
> git version 2.36.1.windows.1
> cpu: x86_64
> built from commit: e2ff68a2d1426758c78d023f863bfa1e03cbc768
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19043
> compiler info: gnuc: 11.3
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
>
>
--
Philip
