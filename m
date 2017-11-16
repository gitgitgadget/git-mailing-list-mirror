Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0215C202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 17:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966241AbdKPRzC (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 12:55:02 -0500
Received: from siwi.pair.com ([209.68.5.199]:17238 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966000AbdKPRx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 12:53:29 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3C96784516;
        Thu, 16 Nov 2017 12:53:28 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E3554844F1;
        Thu, 16 Nov 2017 12:53:27 -0500 (EST)
Subject: Re: [PATCH 04/14] fetch: add object filtering for partial fetch
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171102203129.59417-1-git@jeffhostetler.com>
 <20171102203129.59417-5-git@jeffhostetler.com>
 <20171103133845.b270485dd04c6c6c1b47d42a@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7eb6b165-77e5-78b9-e3a9-151f6a53a39a@jeffhostetler.com>
Date:   Thu, 16 Nov 2017 12:53:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171103133845.b270485dd04c6c6c1b47d42a@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/3/2017 4:38 PM, Jonathan Tan wrote:
>> @@ -1242,6 +1249,20 @@ static int fetch_multiple(struct string_list *list)
>>   	int i, result = 0;
>>   	struct argv_array argv = ARGV_ARRAY_INIT;
>>   
>> +	if (filter_options.choice) {
>> +		/*
>> +		 * We currently only support partial-fetches to the remote
>> +		 * used for the partial-clone because we only support 1
>> +		 * promisor remote, so we DO NOT allow explicit command
>> +		 * line filter arguments.
>> +		 *
>> +		 * Note that the loop below will spawn background fetches
>> +		 * for each remote and one of them MAY INHERIT the proper
>> +		 * partial-fetch settings, so everything is consistent.
>> +		 */
>> +		die(_("partial-fetch is not supported on multiple remotes"));
>> +	}
>> +
>>   	if (!append && !dry_run) {
>>   		int errcode = truncate_fetch_head();
>>   		if (errcode)
> 
> My intention in doing the "fetch: refactor calculation of remote list"
> patch is so that the interaction between the provided list of remotes
> and the specification of the filter can be handled using the following
> diff:
> 
>      -	if (remote)
>      +	if (remote) {
>      +		if (filter_options.choice &&
>      +		    strcmp(remote->name, repository_format_partial_clone_remote))
>      +			die(_("--blob-max-bytes can only be used with the remote configured in core.partialClone"));
>       		result = fetch_one(remote, argc, argv);
>      -	else
>      +	} else {
>      +		if (filter_options.choice)
>      +			die(_("--blob-max-bytes can only be used with the remote configured in core.partialClone"));
>       		result = fetch_multiple(&list);
>      +	}
> 
> (Ignore the "blob-max-bytes" in the error message - that needs to be
> updated.)
> 
> The GitHub link I provided above has this diff, and it seems to work.
> 

I put the filter_options.choice tests inside the fetch_{one,multiple}
routines because the former needs to be able to register partial clone
with the config and/or inherit the default filter-spec for the
promisor remote and that took more code that what can neatly fit inline
here.  This will be more apparent in my next patch series.

Jeff
