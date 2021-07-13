Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E78C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 15:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A15561360
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 15:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbhGMPVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 11:21:22 -0400
Received: from siwi.pair.com ([209.68.5.199]:51766 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236932AbhGMPVW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 11:21:22 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2968F3F40D9;
        Tue, 13 Jul 2021 11:18:32 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 85C253F4095;
        Tue, 13 Jul 2021 11:18:31 -0400 (EDT)
Subject: Re: [PATCH v3 19/34] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5bba5eb3d1bd172f09fdf6eb2e9b8ac4dd7f940f.1625150864.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2107062102500.8230@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <806e2108-5391-9b92-368f-403e7b2d44b7@jeffhostetler.com>
Date:   Tue, 13 Jul 2021 11:18:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2107062102500.8230@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/6/21 3:09 PM, Johannes Schindelin wrote:
> Hi Jeff,
> 
> 
> On Thu, 1 Jul 2021, Jeff Hostetler via GitGitGadget wrote:
> 
> Jeff Hostetler <jeffhost@microsoft.com>
> 
> the win32 backend to register a watch on the working tree
> irectory (recursively).  Also watch the <gitdir> if it is
> side the working tree.  And to collect path change notifications
> atches and publish.
> 
> -off-by: Jeff Hostetler <jeffhost@microsoft.com>
> 
> t/fsmonitor/fsmonitor-fs-listen-win32.c | 530 +++++++++++++++++++
> e changed, 530 insertions(+)
> 
>> diff --git a/compat/fsmonitor/fsmonitor-fs-listen-win32.c b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
>> index 880446b49e3..d707d47a0d7 100644
>> --- a/compat/fsmonitor/fsmonitor-fs-listen-win32.c
>> +++ b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
>> @@ -2,20 +2,550 @@
>> + [...]
>> +
>> +static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
>> +				      const char *path)
>> +{
>> +	struct one_watch *watch = NULL;
>> +	DWORD desired_access = FILE_LIST_DIRECTORY;
>> +	DWORD share_mode =
>> +		FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE;
>> +	HANDLE hDir;
>> +
>> +	hDir = CreateFileA(path,
>> +			   desired_access, share_mode, NULL, OPEN_EXISTING,
>> +			   FILE_FLAG_BACKUP_SEMANTICS | FILE_FLAG_OVERLAPPED,
>> +			   NULL);
> 
> The `*A()` family of Win32 API functions disagree with Git in one very
> interesting aspect: Git always assumes UTF-8, while e.g. `CreateFileA()`
> will use the current Win32 locale to internally transform to wide
> characters and then call `CreateFileW()`.
> 
> This poses no problem when your locale is US American and your paths
> contain no non-ASCII characters.
> 
> In the Git for Windows bug tracker, it was reported that it _does_ cause
> problems when venturing outside such a cozy scenario (for full details,
> see https://github.com/git-for-windows/git/issues/3262)
> 
> I need this (and merged it before starting the process to release Git for
> Windows v2.32.0(2)) to fix that (could I ask you to integrate this in case
> a re-roll will become necessary?):
> 
> -- snipsnap --
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Mon, 5 Jul 2021 13:51:05 +0200
> Subject: [PATCH] fixup! fsmonitor-fs-listen-win32: implement FSMonitor backend
>   on Windows
> 
> Let's keep avoiding the `*A()` family of Win32 API functions because
> they are susceptible to incoherent encoding problems. In Git for
> Windows, we always assume paths to be UTF-8 encoded. Let's use the
> dedicated helper to convert such a path to the wide character version,
> and then use the `*W()` function instead.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   compat/fsmonitor/fsmonitor-fs-listen-win32.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/compat/fsmonitor/fsmonitor-fs-listen-win32.c b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
> index ba087b292df..3b42ab311d9 100644
> --- a/compat/fsmonitor/fsmonitor-fs-listen-win32.c
> +++ b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
> @@ -111,8 +111,14 @@ static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
>   	DWORD share_mode =
>   		FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE;
>   	HANDLE hDir;
> +	wchar_t wpath[MAX_PATH];
> 
> -	hDir = CreateFileA(path,
> +	if (xutftowcs_path(wpath, path) < 0) {
> +		error(_("could not convert to wide characters: '%s'"), path);
> +		return NULL;
> +	}
> +
> +	hDir = CreateFileW(wpath,
>   			   desired_access, share_mode, NULL, OPEN_EXISTING,
>   			   FILE_FLAG_BACKUP_SEMANTICS | FILE_FLAG_OVERLAPPED,
>   			   NULL);
> --
> 2.32.0.windows.1.15.gf1590a75e2d
> 

Thanks for the heads up.  I'll pull this into my next release.
Jeff
