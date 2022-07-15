Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D313CC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 18:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiGOS23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 14:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGOS22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 14:28:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5B66A9C9
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 11:28:27 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 190511A9382;
        Fri, 15 Jul 2022 14:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o+SN1LxcVCdIIDXT395R15hesxyCiAK0iYh5Ez
        qn/0c=; b=t/1bWM0qJP9Pq2MbLvxmHEvNhcwvH3CfbyY+4zi0ybzyMhfjYyun1x
        667S4zEX+sjijnBOYI32AzPtHdT5Ts21Dz/mZp6EE/rcSSXOqXAEv8OOlkKkIZEE
        F5gmbuW4qlJljazeuVNmR1rgYvzJ6V8RsKlph38LDocArzrd6zwE0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F2821A9381;
        Fri, 15 Jul 2022 14:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5CFC1A9380;
        Fri, 15 Jul 2022 14:28:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: write effective filter to trace2
References: <20220715172943.2681492-1-jonathantanmy@google.com>
        <770e3c15-90ea-7d6c-4854-608c0ad8cbaa@jeffhostetler.com>
Date:   Fri, 15 Jul 2022 11:28:22 -0700
In-Reply-To: <770e3c15-90ea-7d6c-4854-608c0ad8cbaa@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 15 Jul 2022 13:38:42 -0400")
Message-ID: <xmqqmtdaz0vt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E920700E-046B-11ED-8F1C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 7/15/22 1:29 PM, Jonathan Tan wrote:
>> Administrators of a managed Git environment (like the one at $DAYJOB)
>> might want to quantify the performance change of fetches with and
>> without partial clone from the client's point of view. Therefore, log
>> the effective filter being sent to the server whenever a fetch (or
>> clone) occurs. Note that this is not necessarily the same as what's
>> specified on the CLI, because during a fetch, the configured filter is
>> used whenever a filter is not specified on the CLI.
>> This is implemented for protocol v0, v1, and v2.

Is that different to say "for all protocols"?  I am wondering if it
is worth saying (unlike in a hypothetical case where we do not
support v0 and v1 we may want to state why we only support v2).

>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
>>   fetch-pack.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index cb6647d657..dec8743bec 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -392,7 +392,10 @@ static int find_common(struct fetch_negotiator *negotiator,
>>   	if (server_supports_filtering && args->filter_options.choice) {
>>   		const char *spec =
>>   			expand_list_objects_filter_spec(&args->filter_options);
>> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", spec);
>>   		packet_buf_write(&req_buf, "filter %s", spec);
>> +	} else {
>> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", "none");

Do we show "none" anywhere else where an expanded list objects
filter spec is expected?

I am wondering two things: 

 - The lack of this line would be a cleaner implementation of a
   signal to say "this client did not ask any filtering".

 - It would be good if we keep what report here more-or-less the
   same as what we can pass "--filter=" on the command line of
   "git pack-objects".

If "--filter=none" meant "this --filter passes everything", then
saying "none" here makes perfect sense wrt the latter, but I doubt
it is the case.

>>   	}
>>   	packet_buf_flush(&req_buf);
>>   	state_len = req_buf.len;
>> @@ -1328,9 +1331,12 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>>   		const char *spec =
>>   			expand_list_objects_filter_spec(&args->filter_options);
>>   		print_verbose(args, _("Server supports filter"));
>> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", spec);
>>   		packet_buf_write(&req_buf, "filter %s", spec);
>> -	} else if (args->filter_options.choice) {
>> -		warning("filtering not recognized by server, ignoring");
>> +	} else {
>> +		if (args->filter_options.choice)
>> +			warning("filtering not recognized by server, ignoring");
>> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", "none");

At the first glance, this seems to lose data, because you should be
able to use expand_list_objects_filter_spec() to report the filter
spec.  But this is reporting the filter that was actually in effect,
so it is OK.

But the same question about "none" remains.

>>   	}
>>     	if (server_supports_feature("fetch", "packfile-uris", 0)) {
>> 
>
> This looks nice.  Thanks!
> Jeff

Will queue with your Acked-by, then?

Thanks, both.
