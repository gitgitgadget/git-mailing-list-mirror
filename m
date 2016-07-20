Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4181F744
	for <e@80x24.org>; Wed, 20 Jul 2016 15:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbcGTPkk (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 11:40:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:18946 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425AbcGTPkj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 11:40:39 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 16D0C84615;
	Wed, 20 Jul 2016 11:40:38 -0400 (EDT)
Subject: Re: [PATCH v1 1/6] Allow --porcelain[=<n>] in status and commit
 commands
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhost@microsoft.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-2-git-send-email-jeffhost@microsoft.com>
 <alpine.DEB.2.20.1607201600050.14111@virtualbox>
Cc:	git@vger.kernel.org, peff@peff.net, gitster@pobox.com
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <578F9AE8.4000407@jeffhostetler.com>
Date:	Wed, 20 Jul 2016 11:38:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1607201600050.14111@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/20/2016 11:08 AM, Johannes Schindelin wrote:
> On Tue, 19 Jul 2016, Jeff Hostetler wrote:
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> +	} else if (arg) {
>> +		int n = strtol(arg, NULL, 10);
>> +		if (n == 1)
>> +			*value = STATUS_FORMAT_PORCELAIN;
>> +		else
>> +			die("unsupported porcelain version");
>> +	} else {
>> +		*value = STATUS_FORMAT_PORCELAIN;
>
> This could be folded into the previous conditional:
>
> 	}
> 	else {
> 		int n = arg ? strtol(arg, NULL, 10) : 1;
> 		...
>

I did it this way because I didn't want to make any assumptions
here on the numeric value of the enum values.  Or rather, I didn't
want to add specific assignments to the enum type.

This also helps make it easier to see my later commit:
         else if (n == 2) *value = STATUS_FORMAT_PORCELAIN_V2;

Also, I didn't want to alter the order of assignments to the global
status_format variable.  That is, if I capture the value of <n> in
a porcelain_version variable and assign that to status_format
afterwards, there is opportunity for mistakes if they type:
         git status --short --porcelain=1 --long
where the status_format variable is assigned 3 times.

> Having said this, ...
>
>> @@ -1336,9 +1347,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>>   			    N_("show status concisely"), STATUS_FORMAT_SHORT),
>>   		OPT_BOOL('b', "branch", &s.show_branch,
>>   			 N_("show branch information")),
>> -		OPT_SET_INT(0, "porcelain", &status_format,
>> -			    N_("machine-readable output"),
>> -			    STATUS_FORMAT_PORCELAIN),
>> +		{ OPTION_CALLBACK, 0, "porcelain", &status_format,
>> +		  N_("version"), N_("machine-readable output"),
>> +		  PARSE_OPT_OPTARG, opt_parse_porcelain },
>
> How about using a COUNTUP here instead? We could then set the status
> format afterwards, like this:
>
> 	if (porcelain == 0)
> 		status_format = STATUS_FORMAT_UNSPECIFIED;
> 	else {
> 		status_format = STATUS_FORMAT_PORCELAIN;
> 		if (porcelain > 1)
> 			warning("No porcelain v%d; falling back to v1",
> 				porcelain);
> 	}
>

Maybe I misread the COUNTUP docs, but it looked like it would
allow "--porcelain --porcelain", but not "--porcelain=2".

Jeff
