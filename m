Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F962027C
	for <e@80x24.org>; Wed, 31 May 2017 00:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbdEaANc (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 20:13:32 -0400
Received: from avasout07.plus.net ([84.93.230.235]:43063 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdEaANb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 20:13:31 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id SoDU1v0031keHif01oDVSC; Wed, 31 May 2017 01:13:30 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=rTqSFGo54_sH6d97jYgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [GSoC][PATCH v5 1/3] submodule: fix buggy $path and $sm_path
 variable's value
To:     Stefan Beller <sbeller@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <20170521125814.26255-2-pc44800@gmail.com>
 <20170526151713.10974-1-pc44800@gmail.com>
 <01e8c552-fd3a-ee05-1ff1-3b3ea0f7feeb@ramsayjones.plus.com>
 <CAGZ79kYbi5QxWAsxdfPkuWEyMt9Qg753sm0vExsKaWyksDVw+Q@mail.gmail.com>
 <24ebb17b-4324-c6ef-7e3a-5576cda3b595@ramsayjones.plus.com>
 <CAGZ79kYc9wx23N9quxhuYAf2H1Rm3tGNg_0Ydz0KO4qPH-Kz5w@mail.gmail.com>
 <56bcf006-06f1-1851-87de-5697f988cb08@ramsayjones.plus.com>
 <CAGZ79kYMA6Me_ZnBZQitW7ZSJ0kfvb-LPnH=1gTwhRN-KOe5pA@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6e1db1f4-abbe-199e-a206-a56d83fac4ff@ramsayjones.plus.com>
Date:   Wed, 31 May 2017 01:13:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYMA6Me_ZnBZQitW7ZSJ0kfvb-LPnH=1gTwhRN-KOe5pA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 31/05/17 00:29, Stefan Beller wrote:
 
>> As I said above, I can't remember how git-ls-files worked back then,
>> but it seems that I thought of it as the path to the submodule from
>> the root of the working tree. Again, by definition, $sm_path == $path
>> (as documented). Of course, that may have changed since then.
> 
> Documented in 64394e3 (git-submodule.sh: Don't use $path variable in
> eval_gettext string, by yourself)
> 
> What I intended to say above was "documented to the end user",
> and I do not count our commit messages as such. The end user facing
> documentation only talks about path, not mentioning sm_path.

Correct, and that is exactly what I was saying. ie. $path as
'documented to the end user'. (again by _definition_ $sm_path
_is_ $path).

>>> After rereading that test, I would think so?
>>
>> Really? So, if it differs from $path, then something changed between
>> commit 64394e3ae9 and commit 091a6eb0fe. I haven't really read that
>> commit/test, so take what I say with a pinch of salt ...
> 
> Well yes. I am specifically reading 091a6eb0fe, the changes to t7407.
> 
> In that test sm_path contains the relative path from $PWD to the
> submodule. (It does NOT: "$[sm_]path is the name of the submodule
> directory relative to the superproject" as documented but rather
> ... relative to the $PWD)

In that case, the current user documentation does not agree with
the current implementation, yes?

So, was the user documentation always wrong? (did git-ls-files work
from a sub-directory, limiting its output to the cwd, or did it
chdir() to the top of the worktree first?).

>> As I said in commit 64394e3ae9, $path was part of the API, so I could
>> not just rename it, without a deprecation period, etc ... So, I was
>> 'crossing my fingers' that nobody would export $path in their user
>> scripts (not very likely, after all).
> 
> Ok. So another approach to get away in the C conversion:
> * export the sm_path as all other environment variables
> * for "$path" we do not export it into the environment, but
>   prefix the command with it, i.e. we'd ask our shell to run
>   "path=%s; %s", sm_path, argv[0]
>   to preserve the historic behavior.

Yes, that would probably work.

ATB,
Ramsay Jones

