Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4E020284
	for <e@80x24.org>; Tue, 23 May 2017 18:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937126AbdEWSjL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 14:39:11 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:37896 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934078AbdEWSjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 14:39:09 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wXPSW3Mv2z5tlC;
        Tue, 23 May 2017 20:39:07 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 90026432E;
        Tue, 23 May 2017 20:39:06 +0200 (CEST)
Subject: Re: [PATCH 0/2] Fix warnings on access of a remote with Windows paths
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>, gitster@pobox.com
References: <cover.1495261020.git.j6t@kdbg.org>
 <alpine.DEB.2.21.1.1705221357360.3610@virtualbox>
 <947b2453-52b6-4940-fd20-ddf350c5df4d@kdbg.org>
 <alpine.DEB.2.21.1.1705231248150.3610@virtualbox>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <574f9050-e711-e83c-ba93-6be2dc2a44bc@kdbg.org>
Date:   Tue, 23 May 2017 20:39:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1705231248150.3610@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.05.2017 um 12:53 schrieb Johannes Schindelin:
> Hi Hannes (& Junio, see below),
> 
> On Mon, 22 May 2017, Johannes Sixt wrote:
> 
>> Am 22.05.2017 um 13:59 schrieb Johannes Schindelin:
>>> On Sat, 20 May 2017, Johannes Sixt wrote:
>>>> This small series fixes these warnings on Windows:
>>>>
>>>> C:\Temp\gittest>git fetch C:\Temp\gittest
>>>> warning: unable to access '.git/remotes/C:\Temp\gittest': Invalid argument
>>>> warning: unable to access '.git/branches/C:\Temp\gittest': Invalid
>>>> warning: argument
>>>>   From C:\Temp\gittest
>>>>    * branch            HEAD       -> FETCH_HEAD
>>>>
>>>> The fix is in the second patch; the first patch is a
>>>> preparation that allows to write the fix in my preferred style.
>>>
>>> Thank you!
>>>
>>> Maybe you want to accompany these patches with a simple test case that
>>> uses e.g. ls-remote on $(pwd | tr / \\\\)?
>>
>> Actually, no, I don't want to. It would have to be protected by MINGW, and I
>> don't want to burden us (and here I mean Windows folks) with a check for a
>> cosmetic deficiency. (Shell scripts, slow forks, yadda, yadda...)
> 
> Actually, yes, I want to.
> 
> Yes, it would have to be protected by MINGW, and yes, it would put a
> burden on us, but also yes: it would put an even higher burden on me to
> check this manually before releasing Git for Windows, or even worse: this
> regression would be the kind of bug that triggers many bug reports,
> addressing which would take a lot more time than writing this test case
> and executing it as part of our test suite.

Fair enough. The patch looks good. I'll be able to test no earlier than 
Monday, though.

> 
> So here goes:
> 
> -- snipsnap --
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Tue, 23 May 2017 12:42:13 +0200
> Subject: [PATCH] mingw: verify that paths are not mistaken for remote nicknames
> 
> This added test case simply verifies that users will not be bothered
> with bogus complaints à la
> 
> 	warning: unable to access '.git/remotes/D:\repo': Invalid argument
> 
> when fetching from a Windows path (in this case, D:\repo).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   t/t5580-clone-push-unc.sh | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
> index b195f71ea98..93ce99ba3c6 100755
> --- a/t/t5580-clone-push-unc.sh
> +++ b/t/t5580-clone-push-unc.sh
> @@ -1,13 +1,19 @@
>   #!/bin/sh
>   
> -test_description='various UNC path tests (Windows-only)'
> +test_description='various Windows-only path tests'
>   . ./test-lib.sh
>   
>   if ! test_have_prereq MINGW; then
> -	skip_all='skipping UNC path tests, requires Windows'
> +	skip_all='skipping Windows-only path tests'
>   	test_done
>   fi
>   
> +test_expect_success 'remote nick cannot contain backslashes' '
> +	BACKSLASHED="$(pwd | tr / \\\\)" &&
> +	git ls-remote "$BACKSLASHED" >out 2>err &&
> +	! grep "unable to access" err
> +'
> +
>   UNCPATH="$(pwd)"
>   case "$UNCPATH" in
>   [A-Z]:*)
> 

