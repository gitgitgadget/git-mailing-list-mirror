Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E516C203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 13:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbcGZNz0 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 09:55:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:27095 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbcGZNzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 09:55:25 -0400
Received: from [10.160.15.137] (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id C935284628;
	Tue, 26 Jul 2016 09:55:22 -0400 (EDT)
Subject: Re: [PATCH v2 5/8] status: print per-file porcelain v2 status data
To:	Junio C Hamano <gitster@pobox.com>,
	Jeff Hostetler <jeffhost@microsoft.com>
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
 <1469474750-49075-6-git-send-email-jeffhost@microsoft.com>
 <xmqqwpk94gbu.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57976B45.9060102@jeffhostetler.com>
Date:	Tue, 26 Jul 2016 09:53:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqwpk94gbu.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/25/2016 04:23 PM, Junio C Hamano wrote:
> Jeff Hostetler <jeffhost@microsoft.com> writes:
>
>> +static void wt_porcelain_v2_print(struct wt_status *s);
>> +
>
> There is no point in this forward declaration, if you just place the
> implementation of these functions here, no?

Right. I just did it that way to make the diffs with the previous
commit draw a little cleaner.  But I can take it out.


>> +/*
>> + * Print porcelain v2 info for tracked entries with changes.
>> + */
>> +static void wt_porcelain_v2_print_changed_entry(
>> +	struct string_list_item *it,
>> +	struct wt_status *s)
>> +{
>> +...
>> +	fprintf(s->fp, "%c %s %s %06o %06o %06o %s %s R%d %s",
>
> It is misleading to always say R in the output when there is no
> rename, isn't it?

Yes, especially if we add it for copied entries too.
I was just looking for a way to have a fixed format.
If we make the R%d field optional, then the first pathname
is ambiguous.  That gets me back to an earlier draft where
we have rename and non-rename line types.

I'll split this up into 1 pathname and 2 pathname forms,
and only include the R%d (or the C%d) field in the latter.

>
>> +	 * Note that this is a last-one-wins for each the individual
>> +	 * stage [123] columns in the event of multiple cache rows
>> +	 * for a stage.
>
> Just FYI, the usual lingo we use for that is "multiple cache entries
> for the same stage", I would think.

thanks.

>
>> +	 */
>> +	memset(stages, 0, sizeof(stages));
>> +	sum = 0;
>> +	pos = cache_name_pos(it->string, strlen(it->string));
>> +	assert(pos < 0);
>> +	pos = -pos-1;
>> +	while (pos < active_nr) {
>> +		ce = active_cache[pos++];
>> +		stage = ce_stage(ce);
>> +		if (strcmp(ce->name, it->string) || !stage)
>> +			break;
>> +		stages[stage - 1].mode = ce->ce_mode;
>> +		hashcpy(stages[stage - 1].oid.hash, ce->sha1);
>> +		sum++;
>> +	}
>> +	if (!sum)
>> +		die("BUG: unmerged entry without any stages");
>
> Hmm, we seem to already have d->stagemask; if you call that variable
> "sum" anyway, perhaps its computation can be more like
>
> 	sum |= 1 << (stage - 1);
>
> so that you can compare it with d->stagemask for this sanity check?

good point.

thanks
jeff


