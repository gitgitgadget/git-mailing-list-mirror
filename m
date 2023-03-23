Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C89C76195
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 14:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjCWOAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 10:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjCWN7o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 09:59:44 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD9D38471
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 06:59:17 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 95DB6CA126A;
        Thu, 23 Mar 2023 09:59:16 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:c177:8495:3315:729] (unknown [IPv6:2600:1700:840:e768:c177:8495:3315:729])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5C9B7CC8310;
        Thu, 23 Mar 2023 09:59:16 -0400 (EDT)
Message-ID: <ba23850b-0fc5-4a82-49df-88550ae8b4ed@jeffhostetler.com>
Date:   Thu, 23 Mar 2023 09:59:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] split-index; stop abusing the `base_oid` to strip the
 "link" extension
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
 <f1897b880729b649ab24da14cbc3432d44b7c731.1679500859.git.gitgitgadget@gmail.com>
 <xmqqjzz8cwdp.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqjzz8cwdp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/23 5:24 PM, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> When a split-index is in effect, the `$GIT_DIR/index` file needs to
>> contain a "link" extension that contains all the information about the
>> split-index, including the information about the shared index.
>> ...
>> Let's stop zeroing out the `base_oid` to indicate that the "link"
>> extension should not be written.
> 
> Nicely explained.
> 
>> One might be tempted to simply call `discard_split_index()` instead,
>> under the assumption that Git decided to write a non-split index and
>> therefore the the `split_index` structure might no longer be wanted.
> 
> "the the".
> 
>> +enum strip_extensions {
>> +	WRITE_ALL_EXTENSIONS = 0,
>> +	STRIP_ALL_EXTENSIONS = 1,
>> +	STRIP_LINK_EXTENSION_ONLY = 2
>> +};
> 
> We do not need to spell out the specific values for this enum; the
> users' (i.e. the callers of do_write_index()) sole requirement is
> for these symbols to have different values.

There are several calls to do_write_locked_index() that pass 0 or 1
as the new final arg.  If we update them to use these enum values,
then we don't need integer values here.

> 
> Also do we envision that (1) we would need to keep STRIP_LINK_ONLY
> to be with the largest value among the enum values, or (2) we would
> never add new value to the set?  Otherwise let's end the last one
> with a trailing comma.
> 
> Looking at the way strip_extensions variable is used in
> do_write_index(), an alternative design might be to make it a set of
> bits (e.g. unsigned write_extension) and give one bit to each
> extension.  But such a clean-up is better left outside the topic, I
> would imagine, as we do not have any need to skip an arbitrary set
> of extensions right now.

Agreed, I thought about suggesting a set of bits too, but right now
we only need to strip all of them or just this one.

> 
>> +/*
>> + * Write the Git index into a `.lock` file
>> + *
>> + * If `strip_link_extension` is non-zero, avoid writing any "link" extension
>> + * (used by the split-index feature).
>> + */
> 
> Not exposing "enum strip_extensions" to the caller of this function,
> like this patch does, is probably a very safe and sensible thing to
> do.  We do not have a reason to allow its callers to (perhaps
> mistakenly) pass STRIP_ALL_EXTENSIONS to it.
> 
>>   static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
>> -				 unsigned flags)
>> +				 unsigned flags, int strip_link_extension)
>>   {
>>   	int ret;
>>   	int was_full = istate->sparse_index == INDEX_EXPANDED;
>> @@ -3185,7 +3197,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
>>   	 */
>>   	trace2_region_enter_printf("index", "do_write_index", the_repository,
>>   				   "%s", get_lock_file_path(lock));
>> -	ret = do_write_index(istate, lock->tempfile, 0, flags);
>> +	ret = do_write_index(istate, lock->tempfile, strip_link_extension ? STRIP_LINK_EXTENSION_ONLY : 0, flags);

In the else of the ?: operator, could we use the WRITE_ALL_EXTENSIONS
instead of 0?

>>   	trace2_region_leave_printf("index", "do_write_index", the_repository,
>>   				   "%s", get_lock_file_path(lock));
>>   
> 
> OK.
> 
> Very nicely done.
