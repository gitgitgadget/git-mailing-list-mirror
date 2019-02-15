Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDDC31F453
	for <e@80x24.org>; Fri, 15 Feb 2019 16:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfBOQOE (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 11:14:04 -0500
Received: from siwi.pair.com ([209.68.5.199]:17454 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfBOQOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 11:14:04 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0768D3F4013;
        Fri, 15 Feb 2019 11:14:03 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CDA973F4012;
        Fri, 15 Feb 2019 11:14:02 -0500 (EST)
Subject: Re: [PATCH 1/1] mingw: safe-guard a bit more against getenv()
 problems
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.127.git.gitgitgadget@gmail.com>
 <53e3d159c8c80924188f57c44efd2170612f2ee5.1550243863.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <96793350-0991-6e8f-6ab2-15777e2071be@jeffhostetler.com>
Date:   Fri, 15 Feb 2019 11:14:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <53e3d159c8c80924188f57c44efd2170612f2ee5.1550243863.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/15/2019 10:17 AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Running up to v2.21.0, we fixed two bugs that were made prominent by the
> Windows-specific change to retain copies of only the 30 latest getenv()
> calls' returned strings, invalidating any copies of previous getenv()
> calls' return values.
> 
> While this really shines a light onto bugs of the form where we hold
> onto getenv()'s return values without copying them, it is also a real
> problem for users.
> 
> And even if Jeff King's patches merged via 773e408881 (Merge branch
> 'jk/save-getenv-result', 2019-01-29) provide further work on that front,
> we are far from done. Just one example: on Windows, we unset environment
> variables when spawning new processes, which potentially invalidates
> strings that were previously obtained via getenv(), and therefore we
> have to duplicate environment values that are somehow involved in
> spawning new processes (e.g. GIT_MAN_VIEWER in show_man_page()).
> 
> We do not have a chance to investigate, let address, all of those issues
> in time for v2.21.0, so let's at least help Windows users by increasing
> the number of getenv() calls' return values that are kept valid. The
> number 64 was determined by looking at the average number of getenv()
> calls per process in the entire test suite run on Windows (which is
> around 40) and then adding a bit for good measure. And it is a power of
> two (which would have hit yesterday's theme perfectly).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   compat/mingw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 4276297595..8141f77189 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1632,7 +1632,7 @@ int mingw_kill(pid_t pid, int sig)
>    */
>   char *mingw_getenv(const char *name)
>   {
> -#define GETENV_MAX_RETAIN 30
> +#define GETENV_MAX_RETAIN 64
>   	static char *values[GETENV_MAX_RETAIN];
>   	static int value_counter;
>   	int len_key, len_value;
> 

Why not use a mem_pool for this?  We have that code isolated
and re-usable now.  Have mingw_getenv() copy the string into
the pool always return the pointer from within the pool.  The
pool automatically handles allocating new blocks as necessary.
And (if we care) we can bulk free the pool before existing.

Jeff
