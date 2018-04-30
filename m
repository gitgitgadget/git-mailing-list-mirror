Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5B4215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 19:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbeD3TVv (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 15:21:51 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:2191 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753482AbeD3TVv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 15:21:51 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40ZZCx6zrnz5tlB;
        Mon, 30 Apr 2018 21:21:49 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5C8FF1C94;
        Mon, 30 Apr 2018 21:21:49 +0200 (CEST)
Subject: Re: [PATCH v1] test-drop-caches: simplify delay loading of
 NtSetSystemInformation
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
Newsgroups: gmane.comp.version-control.git
References: <20180430142555.23260-1-benpeart@microsoft.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2c785509-8e9f-816b-9ab0-3ff2f3e4a3f3@kdbg.org>
Date:   Mon, 30 Apr 2018 21:21:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430142555.23260-1-benpeart@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.04.2018 um 16:26 schrieb Ben Peart:
> @@ -82,8 +83,6 @@ static int cmd_dropcaches(void)
>   {
>   	HANDLE hProcess = GetCurrentProcess();
>   	HANDLE hToken;
> -	HMODULE ntdll;
> -	DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG);
>   	SYSTEM_MEMORY_LIST_COMMAND command;
>   	int status;
>   
> @@ -95,14 +94,9 @@ static int cmd_dropcaches(void)
>   
>   	CloseHandle(hToken);
>   
> -	ntdll = LoadLibrary("ntdll.dll");
> -	if (!ntdll)
> -		return error("Can't load ntdll.dll, wrong Windows version?");
> -
> -	NtSetSystemInformation =
> -		(DWORD(WINAPI *)(INT, PVOID, ULONG))GetProcAddress(ntdll, "NtSetSystemInformation");
> -	if (!NtSetSystemInformation)
> -		return error("Can't get function addresses, wrong Windows version?");
> +	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NtSetSystemInformation, INT, PVOID, ULONG);

This is a declaration-after-statement. Even though this is not in 
generic code, it is all too easy to trigger a warning from GCC if a 
corresponding warning is turned on.

> +	if (!INIT_PROC_ADDR(NtSetSystemInformation))
> +		return error("Could not find NtSetSystemInformation() function");
>   
>   	command = MemoryPurgeStandbyList;
>   	status = NtSetSystemInformation(
> @@ -115,8 +109,6 @@ static int cmd_dropcaches(void)
>   	else if (status != STATUS_SUCCESS)
>   		error("Unable to execute the memory list command %d", status);
>   
> -	FreeLibrary(ntdll);
> -
>   	return status;
>   }

-- Hannes
