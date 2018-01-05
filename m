Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539851F428
	for <e@80x24.org>; Fri,  5 Jan 2018 16:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeAEQbL (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 11:31:11 -0500
Received: from siwi.pair.com ([209.68.5.199]:15230 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbeAEQbK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 11:31:10 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B0D16844CB;
        Fri,  5 Jan 2018 11:31:09 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1E4AB844C6;
        Fri,  5 Jan 2018 11:31:09 -0500 (EST)
Subject: Re: [PATCH v3 2/5] status: add --[no-]ahead-behind to status and
 commit for V2 format.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180103214733.797-1-git@jeffhostetler.com>
 <20180103214733.797-3-git@jeffhostetler.com>
 <xmqqlghde0uy.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6fe41395-6cb5-cbfe-88cd-5b0b21fad7b8@jeffhostetler.com>
Date:   Fri, 5 Jan 2018 11:31:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqlghde0uy.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/4/2018 5:05 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> +		sti = stat_tracking_info(branch, &nr_ahead, &nr_behind,
>> +					 &base, s->ahead_behind_flags);
>>   		if (base) {
>>   			base = shorten_unambiguous_ref(base, 0);
>>   			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
>>   			free((char *)base);
>>   
>> -			if (ab_info)
>> -				fprintf(s->fp, "# branch.ab +%d -%d%c", nr_ahead, nr_behind, eol);
>> +			if (sti >= 0) {
>> +				if (s->ahead_behind_flags == AHEAD_BEHIND_FULL)
>> +					fprintf(s->fp, "# branch.ab +%d -%d%c",
>> +						nr_ahead, nr_behind, eol);
>> +				else if (s->ahead_behind_flags == AHEAD_BEHIND_QUICK)
>> +					fprintf(s->fp, "# branch.equal %s%c",
>> +						sti ? "neq" : "eq", eol);
> 
> This is related to what I said in the review of [1/5], but this
> arrangement to require the caller to know that _QUICK request
> results in incomplete information smells like a bit of maintenance
> hassle.
> 
> We'd rather allow the caller to tell if it was given incomplete
> information from the values returned by stat_tracking_info()
> function (notice the plural "values" here; what is returned in
> nr_{ahead,behind} also counts).  For example, we can keep the (-1 =>
> "no relation", 0 => "identical", 1 => "different") as return values
> of the function, but have it clear nr_{ahead,behind} when it only
> knows the two are different but not by how many commits.  That way,
> this step can instead do:
> 
> 	ab_info = stat_tracking_info(...);
> 	if (base) {
> 		... do the base thing ...
> 		if (ab_info > 0) {
> 			/* different */
> 			if (nr_ahead || nr_behind)
> 				fprintf(... +%d -%d ... nr_ahead, nr_behind, ...);
> 			else
> 				fprintf(... "neq" ...);
> 		} else if (!ab_info) {
> 			/* same */
> 			fprintf(... +%d -%d ... nr_ahead, nr_behind, ...);
> 		}
> 		...
> 
> That would allow us to later add different kinds of _QUICK that do
> not give full information without having to update this consumer
> with something like
> 
> -	else if (s->ahead_behind_flags == AHEAD_BEHIND_QUICK)
> +	else if (s->ahead_behind_flags == AHEAD_BEHIND_QUICK ||
> +		 s->ahead_behind_flags == AHEAD_BEHIND_QUICK_DIFFERENTLY)
> 
> when it happens.
> 
> Two related tangents.
> 
>   - I do not see why "eq" need to exist at all.  Even in _QUICK mode,
>     when you determine that two are identical, you know your branch
>     is ahead and behind by 0 commit each.
> 
>   - A short-format that is easy to parse by machines does not have to
>     be cryptic to humans.  s/neq/not-equal/ or something may be an
>     improvement.
> 
> Thanks.
> 

Thanks for the review.  Let me update it along the lines suggested here.
It felt odd to define the nr_{ahead,behind} as undefined, but short of
making them negative or something I wasn't sure what was best.

Thanks,
Jeff

