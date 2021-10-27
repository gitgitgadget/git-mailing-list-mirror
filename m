Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF53C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02B061039
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhJ0Ssa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:48:30 -0400
Received: from siwi.pair.com ([209.68.5.199]:46498 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233856AbhJ0Ssa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 14:48:30 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B5C263F40E4;
        Wed, 27 Oct 2021 14:46:03 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 898A33F40FB;
        Wed, 27 Oct 2021 14:46:03 -0400 (EDT)
Subject: Re: [PATCH v4 01/29] fsmonitor: enhance existing comments
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
 <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
 <ecc40795fa26ea86525421682303449f70132216.1634826309.git.gitgitgadget@gmail.com>
 <xmqq1r4ekt7d.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <295e9e70-8c56-1e77-d878-dd8031b6c2c6@jeffhostetler.com>
Date:   Wed, 27 Oct 2021 14:46:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq1r4ekt7d.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/21/21 4:40 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   fsmonitor.c | 37 ++++++++++++++++++++++++++++++-------
>>   1 file changed, 30 insertions(+), 7 deletions(-)
>>
>> diff --git a/fsmonitor.c b/fsmonitor.c
>> index ab9bfc60b34..ec4c46407c5 100644
>> --- a/fsmonitor.c
>> +++ b/fsmonitor.c
>> @@ -301,9 +301,25 @@ void refresh_fsmonitor(struct index_state *istate)
>>   			core_fsmonitor, query_success ? "success" : "failure");
>>   	}
>>   
>> -	/* a fsmonitor process can return '/' to indicate all entries are invalid */
>> +	/*
>> +	 * The response from FSMonitor (excluding the header token) is
>> +	 * either:
>> +	 *
>> +	 * [a] a (possibly empty) list of NUL delimited relative
>> +	 *     pathnames of changed paths.  This list can contain
>> +	 *     files and directories.  Directories have a trailing
>> +	 *     slash.
>> +	 *
>> +	 * [b] a single '/' to indicate the provider had no
>> +	 *     information and that we should consider everything
>> +	 *     invalid.  We call this a trivial response.
>> +	 */
>>   	if (query_success && query_result.buf[bol] != '/') {
>> -		/* Mark all entries returned by the monitor as dirty */
>> +		/*
>> +		 * Mark all pathnames returned by the monitor as dirty.
>> +		 *
>> +		 * This updates both the cache-entries and the untracked-cache.
>> +		 */
> 
> Not a problem this patch introduces, but we only checked that the
> query result begins with a slash, not "we did receive a trivial
> response", but the "else" clause of this statement pretends as if we
> did.
> 
> It is a shame that we do have fsmonitor_is_trivial_response()
> function defined, but its interface is not capable of helping us
> here.
> 
> Or is fsmonitor_is_trivial_response() already good to do this, and
> reliance of [bol] this code has is the source of confusion?  I
> notice that when we have last update token and makes a call to
> query_fsmonitor() with HOOK_INTERFACE_VERSION1, nobody updates bol
> (hence it stays 0), and with HOOK_INTERFACE_VERSION2, bol is at the
> NUL that terminates the initial string of the query result, after
> which presumably has either '/' NUL (trivial) or list of paths.
> 
> I am not sure about the VERSION1 case, but at least in the VERSION2
> case, making sure that the last three bytes are NUL slash NUL like
> fsmonitor_is_trivial_response() does and the half check the above is
> doing (i.e. the byte after the NUL is slash, without making sure
> about the length of the whole response or what follows the slash is
> NUL), seems "close enough" (meaning: the check in this code is a
> sloppy attempt to reinvent what _is_trivial_response() function
> already does).
> 
> So, would it make sense to rewrite the condition to
> 
> 	if (query_success &&
> 	    !fsmonitor_is_trivial_response(&query_result)) {
> 
> here?  Or perhaps
> 
> 	if (query_success &&
> 	    !(query_result.len == bol + 3 &&
> 	      query_result[bol] == '/' && !query_result[bol+1])) {
> 
> which would be open coding the _is_trivial_response() function.
> 

Yes, there is an opportunity here to clean this up.

The original code was a little sloppy -- just testing buf[bol] for
slash and assuming that that was sufficient.  Technically, no response
should begin with slash (since the set of reported modified files are
relative to the root directory), so my _is_trivial_ function could be
simplified a little.

I'll refactor this.

Thanks
Jeff
