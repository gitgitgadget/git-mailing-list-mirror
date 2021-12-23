Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29579C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 18:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349841AbhLWSYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:24:41 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:61315 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhLWSYi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 13:24:38 -0500
Received: from [91.113.179.170] (helo=[192.168.92.29])
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1n0Slc-0002cE-NC; Thu, 23 Dec 2021 19:24:40 +0100
Message-ID: <b97672fa-837f-1e28-f7f2-aee80e52d374@syntevo.com>
Date:   Thu, 23 Dec 2021 19:24:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] update-index: refresh should rewrite index in case of
 racy timestamps
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1105.git.1640181390841.gitgitgadget@gmail.com>
 <xmqqfsqkdwo4.fsf@gitster.g>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
In-Reply-To: <xmqqfsqkdwo4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/12/2021 00:52, Junio C Hamano wrote:
> Ah, there are cases where we do clear active_cache_changed when we
> notice that an operation detected an error, to avoid spreading the
> breakage by writing the index file out, and I think that is the
> right thing to do.  Which means that the above patch is not quite
> right.  Perhaps taking all of the above together, something like
> this?
> 
> 	*o->has_errors |= refresh_cache(o->flags | flag);
> 	if (*o->has_errors)
> 		active_cache_changed = 0;
> 	else if (has_racy_timestamps(&the_index))
>          	/*
> 		 * Even if nothing else has changed, updating the file
> 		 * increases the chance that racy timestamps become
> 		 * non-racy, helping future run-time performance.
> 		 */
> 		active_cache_changed |= SOMETHING_CHANGED;

I think it's safe to write the index even if refresh_cache() reports an 
"error" and we should actually do that:

The underlying refresh_index() will report an "error" only for "file: 
needs merge" and "file: needs update". In both cases, the corresponding 
entries will not have been updated. Every entry which has been updated 
is good on its own and writing these updates makes the index a little 
bit better. Subsequent calls to refresh_index() won't have to do the 
same work again (like invoking the quite expensive LFS filter).

This is also how cmd_status() currently works: it does not pay attention 
to the return value of refresh_index() and will always write the index 
if racy timestamps are encountered.

Overall, the "error" handling in update-index.c might not always do what 
one expects. Let's consider your suggested fix. When invoking:

update-index --refresh

this won't fix racy timestamps, however:

update-index --refresh --add untracked

will do. I think this is caused by active_cache_changed being used in 
two different ways: to indicate that the cache should be written and to 
indicate that it must not be written. It might be a good idea to take 
the latter "block index write" to a separate static variable in 
update-index.c.

Candidate usages of this new "block index write" variable will be in the 
existing callbacks: errors detected in unresolve_callback() should 
probably continue to block an index write, to ensure that either all or 
none of the specified files will be unresolved. For the 
reupdate_callback(), the underlying do_reupdate() seems to return 0 
always, so there is dead code in the callback (or am I completely 
blind?). To stay on the safe side, we may still continue to block an 
index write here. The refresh_callback() will never block an index write.

Does it make sense to clarify error handling in some preceding commit 
and only then address the razy timestamps? It will probably make this 
second commit clearer.

>> +}
>> +
>> +update_assert_changed() {
>> +	local ts1=$(test-tool chmtime --get .git/index) &&
>> +	test_might_fail git update-index $1 &&
>> +	local ts2=$(test-tool chmtime --get .git/index) &&
>> +	[ $ts1 -ne $ts2 ]
>> +}
>> +
>> +test_expect_success 'setup' '
>> +	touch .git/fs-tstamp &&
> 
> Not that it is wrong, but do we need to create such a throw-away
> file inside the .git directory?

We actually only need a timestamp for which we know that it is before 
the timestamp the next file system operation would create. I agree that 
it should be easy to rewrite that using "test-tool chmtime". This should 
also simplify reset_mtime().

Regarding all other comments, thanks, I'll address them as suggested for 
the next patch. And sorry for not checking CodingGuidelines before (I 
had completely missed this document).

-Marc
