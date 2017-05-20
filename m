Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08F8F201A7
	for <e@80x24.org>; Sat, 20 May 2017 17:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756187AbdETRAW (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 13:00:22 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:53201 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755431AbdETRAV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 13:00:21 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wVWPv10Cfz5tlH;
        Sat, 20 May 2017 19:00:18 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 965ED4323;
        Sat, 20 May 2017 19:00:18 +0200 (CEST)
Subject: Re: [PATCH] mingw: simplify PATH handling
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <c5b7292f-6367-e4a9-2ee0-96b93b1b587f@web.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5d4f08c0-07e2-b59c-a132-d165a21323df@kdbg.org>
Date:   Sat, 20 May 2017 19:00:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <c5b7292f-6367-e4a9-2ee0-96b93b1b587f@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.05.2017 um 17:29 schrieb René Scharfe:
> -static char *path_lookup(const char *cmd, char **path, int exe_only)
> +static char *path_lookup(const char *cmd, int exe_only)
>   {
> +	const char *path;
>   	char *prog = NULL;
>   	int len = strlen(cmd);
>   	int isexe = len >= 4 && !strcasecmp(cmd+len-4, ".exe");
>   
>   	if (strchr(cmd, '/') || strchr(cmd, '\\'))
> -		prog = xstrdup(cmd);
> +		return xstrdup(cmd);
>   
> -	while (!prog && *path)
> -		prog = lookup_prog(*path++, cmd, isexe, exe_only);
> +	path = mingw_getenv("PATH");
> +	if (!path)
> +		return NULL;
> +
> +	for (; !prog && *path; path++) {
> +		const char *sep = strchrnul(path, ';');
> +		if (sep == path)
> +			continue;
> +		prog = lookup_prog(path, sep - path, cmd, isexe, exe_only);
> +		path = sep;
> +	}

The loop termination does not work here. When the final PATH component 
is investigated, sep points to the NUL. This pointer is assigned to 
path, which is incremented and now points one past NUL. Then the loop 
condition (*path) accesses the char behind NUL.

>   
>   	return prog;
>   }
> @@ -1569,13 +1527,10 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
>   	}
>   
>   	if (getenv("GIT_STRACE_COMMANDS")) {
> -		char **path = get_path_split();
> -		char *p = path_lookup("strace.exe", path, 1);
> +		char *p = path_lookup("strace.exe", 1);
>   		if (!p) {
> -			free_path_split(path);
>   			return error("strace not found!");
>   		}
> -		free_path_split(path);
>   		if (xutftowcs_path(wcmd, p) < 0) {
>   			free(p);
>   			return -1;

Upstream does not have this hunk.

Otherwise, good catch!

-- Hannes
