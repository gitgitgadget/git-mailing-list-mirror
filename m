Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08AEB202DA
	for <e@80x24.org>; Tue,  7 Mar 2017 20:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbdCGUkc (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 15:40:32 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:22054 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756115AbdCGUkb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 15:40:31 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3vd7n92H3pz5tlH;
        Tue,  7 Mar 2017 21:39:41 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 980C8376;
        Tue,  7 Mar 2017 21:39:39 +0100 (CET)
Subject: Re: [PATCH] t*: avoid using pipes
To:     Stefan Beller <sbeller@google.com>,
        Prathamesh Chavan <pc44800@gmail.com>
References: <CAME+mvUe7itzg7JLu9_131smzHHE0JsN-z7q8_dTY1qEdugYWw@mail.gmail.com>
 <CAGZ79kaYi1OLuOKvbCmDrMCq0fZnO2Ry7JML=Puwmx6TTtEYog@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3026648b-a26c-bc67-62dc-170217d6c2ca@kdbg.org>
Date:   Tue, 7 Mar 2017 21:39:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaYi1OLuOKvbCmDrMCq0fZnO2Ry7JML=Puwmx6TTtEYog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.03.2017 um 18:21 schrieb Stefan Beller:
> On Tue, Mar 7, 2017 at 8:10 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
>> I'm Prathamesh Chavan. As a part of my micropraoject I have been working on
>> "Avoid pipes for git related commands in test suites".

Welcome to the Git community!

> * keep it micro first, e.g. just convert one file,
>   send to list, wait for reviewers feedback and incorporate that
>   (optional step after having done the full development cycle:
>   convert all the other files; each as its own patch)
> * split up this one patch into multiple patches, e.g. one
>   file per patch, then send a patch series.

Actually, being a *micro* project, it should stay so. Not doing all of 
the changes would leave some tasks for other apprentices to get warm 
with our review process.

>> https://github.com/pratham-pc/git/tree/micro-proj
>
> While I did look at that, not everyone here in the git community
> does so. (Also for getting your change in, Junio seems to strongly prefer
> patches on list instead of e.g. fetching and cherry-picking from your
> github)

Thank you, Stefan, for digging out one particularly interesting case.

> When looking at the content, the conversion seems a bit mechanical
> (which is fine for a micro project), such as:
> ...
> - test "$(git show --pretty=format:%s | head -n 1)" = "one"
> + test "$(git show --pretty=format:%s >out && head -n 1 <out)" = "one"
> ...
>
> specifically for the "head" command I don't think it makes a
> difference in correctness whether you pipe the file into the tool
> or give the filename, i.e.  "head -n 1 out" would work just as fine.

True, but!

The intent of removing git invocations from the upstream of a pipe is 
that a failure exit code is able to stop a && chain.

The example above does not achieve this even after removal of the pipe. 
The reason is that exit code of process expansions $(...) is usually 
ignored. To meet the intent, further changes are necessary, for example to:

	git show --pretty=format:%s >out &&
	test "$(head -n 1 out)" = "one"

Side note: There is one exception where the exit code of $(...) is not 
ignored: when it occurs in the last variable assignment of a command 
that consists only of variable assignments.

-- Hannes

