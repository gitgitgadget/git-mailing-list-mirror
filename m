Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F663C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8005D6102A
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhECWA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 18:00:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:30352 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhECWAX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 18:00:23 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D25A73F4090;
        Mon,  3 May 2021 17:59:28 -0400 (EDT)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9A5883F4047;
        Mon,  3 May 2021 17:59:28 -0400 (EDT)
Subject: Re: [PATCH 19/23] fsmonitor--daemon: use a cookie file to sync with
 file system
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <038b62dc6744e8d8004f3f8423a40066821c0f1b.1617291666.git.gitgitgadget@gmail.com>
 <5669d313-4084-dceb-1204-acd005e58657@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6bea878c-a9b6-ea88-0364-dc6ff60155f5@jeffhostetler.com>
Date:   Mon, 3 May 2021 17:59:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5669d313-4084-dceb-1204-acd005e58657@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/27/21 10:23 AM, Derrick Stolee wrote:
> On 4/1/2021 11:41 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach fsmonitor--daemon client threads to create a cookie file
>> inside the .git directory and then wait until FS events for the
>> cookie are observed by the FS listener thread.
>>
>> This helps address the racy nature of file system events by
>> blocking the client response until the kernel has drained any
>> event backlog.
> 
> This description matches my expectation of the cookie file,
> which furthers my confusion about GIT_TEST_FSMONITOR_CLIENT_DELAY.

I'm going to try to create the cookie earlier in the thread
and see if that lets me eliminate the delay.  I don't remember
if I added the delay first and then the cookie when I was testing
or not.  IIRC I was switching between the 2 techniques at one point.

> 
>> +enum fsmonitor_cookie_item_result {
>> +	FCIR_ERROR = -1, /* could not create cookie file ? */
>> +	FCIR_INIT = 0,
>> +	FCIR_SEEN,
>> +	FCIR_ABORT,
>> +};
>> +
>> +struct fsmonitor_cookie_item {
>> +	struct hashmap_entry entry;
>> +	const char *name;
>> +	enum fsmonitor_cookie_item_result result;
>> +};
>> +
>> +static int cookies_cmp(const void *data, const struct hashmap_entry *he1,
>> +		     const struct hashmap_entry *he2, const void *keydata)
> 
> I'm interested to see why a hashset is necessary.

I suppose I could search a linked list of active cookies, but
this seemed easier.  Basically, we have an active cookie (and a
socket listener thread blocked) for each active client connection.
When the FS event thread receives an FS notification for a cookie
file, it needs to do a quick lookup on the cookie file and release
the associate socket thread.

Given that we're only likely to have a few clients connected at
any given time, a list might be faster.

> 
>> +static enum fsmonitor_cookie_item_result fsmonitor_wait_for_cookie(
>> +	struct fsmonitor_daemon_state *state)
>> +{
>> +	int fd;
>> +	struct fsmonitor_cookie_item cookie;
>> +	struct strbuf cookie_pathname = STRBUF_INIT;
>> +	struct strbuf cookie_filename = STRBUF_INIT;
>> +	const char *slash;
>> +	int my_cookie_seq;
>> +
>> +	pthread_mutex_lock(&state->main_lock);
> 
> Hm. We are entering a locked region. I hope this is only for the
> cookie write and not the entire waiting period.

I'm taking the lock to increment the cookie_seq and to add
the hash-entry to the hashmap mainly.  The cond_wait() after
the open() is an atomic unlock-and-wait-and-relock.  So we
wait there for the FS thread to tell us it has seen our cookie
file.  Then we remove our hash-entry from the hashmap and unlock.

Yes, I am doing several things here, but it didn't seem
worth it to lock-unlock-lock-unlock-lock-cond_wait...

> 
>> +	my_cookie_seq = state->cookie_seq++;
>> +
>> +	strbuf_addbuf(&cookie_pathname, &state->path_cookie_prefix);
>> +	strbuf_addf(&cookie_pathname, "%i-%i", getpid(), my_cookie_seq);
>> +
>> +	slash = find_last_dir_sep(cookie_pathname.buf);
>> +	if (slash)
>> +		strbuf_addstr(&cookie_filename, slash + 1);
>> +	else
>> +		strbuf_addbuf(&cookie_filename, &cookie_pathname);
> 
> This business about the slash-or-not-slash is good defensive
> programming. I imagine the only possible way for there to not
> be a slash is if the Git process is running with the .git
> directory as its working directory?
> 
>> +	cookie.name = strbuf_detach(&cookie_filename, NULL);
>> +	cookie.result = FCIR_INIT;
>> +	// TODO should we have case-insenstive hash (and in cookie_cmp()) ??
> 
> This TODO comment should be cleaned up. Doesn't match C-style, either.
> 
> As for the question, I believe that we can limit ourselves to names that
> don't need case-insensitive hashes and trust that the filesystem will not
> change the case. Using lowercase letters should help with this.
> 

I'm going to redo the pathname construction (to solve a conflict
with VSCode) and will clean up this.

>> +	hashmap_entry_init(&cookie.entry, strhash(cookie.name));
>> +
>> +	/*
>> +	 * Warning: we are putting the address of a stack variable into a
>> +	 * global hashmap.  This feels dodgy.  We must ensure that we remove
>> +	 * it before this thread and stack frame returns.
>> +	 */
>> +	hashmap_add(&state->cookies, &cookie.entry);
> 
> I saw this warning and thought about avoiding it by using the heap, but
> even with a heap pointer we need to be careful to remove the result
> before returning and stopping the thread.
> 
> However, there is likely a higher potential of a bug leading to a
> security issue through an error causing stack corruption and unsafe
> code execution. Perhaps it is worth converting to using heap data here.

I never liked the stack buffer.  I'm going to move it to the heap.

> 
>> +	trace_printf_key(&trace_fsmonitor, "cookie-wait: '%s' '%s'",
>> +			 cookie.name, cookie_pathname.buf);
>> +
>> +	/*
>> +	 * Create the cookie file on disk and then wait for a notification
>> +	 * that the listener thread has seen it.
>> +	 */
>> +	fd = open(cookie_pathname.buf, O_WRONLY | O_CREAT | O_EXCL, 0600);
>> +	if (fd >= 0) {
>> +		close(fd);
>> +		unlink_or_warn(cookie_pathname.buf);
> 
> Interesting that we are ignoring the warning here. Is it possible that
> these cookie files will continue to grow if this unlink fails?

It is possible that the unlink() could fail, but I'm not
sure what we can do about it.  The FS event from the open()
(and/or the close()) will be sufficient to wake up this thread.

> 
>> +
>> +		while (cookie.result == FCIR_INIT)
>> +			pthread_cond_wait(&state->cookies_cond,
>> +					  &state->main_lock);
> 
> Ok, we are waiting here for another thread to signal that the cookie
> file has been found in the events. What happens if the event gets lost?
> I'll look for a later signal that cookie.result can change based on a
> timeout, too.

I'd like to use `pthread_cond_timedwait()` here, but I'm not
sure it is supported everywhere.

I do have code in the FS layers to dump/alert all cookies
at certain times, such as loss of sync.

> 
>> +
>> +		hashmap_remove(&state->cookies, &cookie.entry, NULL);
>> +	} else {
>> +		error_errno(_("could not create fsmonitor cookie '%s'"),
>> +			    cookie.name);
>> +
>> +		cookie.result = FCIR_ERROR;
>> +		hashmap_remove(&state->cookies, &cookie.entry, NULL);
>> +	}
> 
> Both blocks here remove the cookie entry, so move it to the end of the
> method with the other cleanups.

I can move it outside of the IF, but it has to be before we unlock.

> 
>> +
>> +	pthread_mutex_unlock(&state->main_lock);
> 
> Hm. We are locking the main state throughout this process. I suppose that
> the listener thread could be watching multiple repos and updating them
> while we wait here for one repo to update. This is a larger lock window
> than I was hoping for, but I don't currently see how to reduce it safely.

We only watch a single repo/working directory.  We're locking because
we could have multiple clients all hitting us at the same time.

> 
>> +
>> +	free((char*)cookie.name);
>> +	strbuf_release(&cookie_pathname);
>> +	return cookie.result;
> 
> Remove the cookie from the hashset along with these lines.

No, it has to be within the lock above.

> 
>> +}
>> +
>> +/*
>> + * Mark these cookies as _SEEN and wake up the corresponding client threads.
>> + */
>> +static void fsmonitor_cookie_mark_seen(struct fsmonitor_daemon_state *state,
>> +				       const struct string_list *cookie_names)
>> +{
>> +	/* assert state->main_lock */
> 
> I'm now confused what this is trying to document. The 'state' should be
> locked by another thread while we are waiting for a cookie response, so
> this method is updating the cookie as seen from a different thread that
> doesn't have the lock.

I'm trying to document that this function must be called while the
thread is holding the main lock (without paying for a lock check or
trying to do a recursive lock or whatever).

Since it is a little static function and I control the 2 or 3 callers,
I can just visually check this without fuss.

> 
> ...
>> +/*
>> + * Set _ABORT on all pending cookies and wake up all client threads.
>> + */
>> +static void fsmonitor_cookie_abort_all(struct fsmonitor_daemon_state *state)
> ...
> 
>> + * [2] Some of those lost events may have been for cookie files.  We
>> + *     should assume the worst and abort them rather letting them starve.
>> + *
>>    * If there are no readers of the the current token data series, we
>>    * can free it now.  Otherwise, let the last reader free it.  Either
>>    * way, the old token data series is no longer associated with our
>> @@ -454,6 +600,8 @@ void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
>>   			 state->current_token_data->token_id.buf,
>>   			 new_one->token_id.buf);
>>   
>> +	fsmonitor_cookie_abort_all(state);
>> +
> 
> I see we abort here if we force a resync. I lost the detail of whether
> this is triggered by a timeout, too.

I don't currently have a cookie timeout for each thread.  I'd like
to use pthread_cond_timedwait(), but I didn't see it in the
compat headers, so I'm not sure if it is portable.  I'll make a note
to look into this again.

> 
>> @@ -654,6 +803,39 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
>>   		goto send_trivial_response;
>>   	}
>>   
>> +	pthread_mutex_unlock(&state->main_lock);
>> +
>> +	/*
>> +	 * Write a cookie file inside the directory being watched in an
>> +	 * effort to flush out existing filesystem events that we actually
>> +	 * care about.  Suspend this client thread until we see the filesystem
>> +	 * events for this cookie file.
>> +	 */
>> +	cookie_result = fsmonitor_wait_for_cookie(state);
> 
> Odd that we unlock before calling this method, then just take the lock
> again inside of it.

Yeah, I didn't like doing that.  I'll revisit.

> 
>> +	if (cookie_result != FCIR_SEEN) {
>> +		error(_("fsmonitor: cookie_result '%d' != SEEN"),
>> +		      cookie_result);
>> +		result = 0;
>> +		goto send_trivial_response;
>> +	}
>> +
>> +	pthread_mutex_lock(&state->main_lock);
>> +
>> +	if (strcmp(requested_token_id.buf,
>> +		   state->current_token_data->token_id.buf)) {
>> +		/*
>> +		 * Ack! The listener thread lost sync with the filesystem
>> +		 * and created a new token while we were waiting for the
>> +		 * cookie file to be created!  Just give up.
>> +		 */
>> +		pthread_mutex_unlock(&state->main_lock);
>> +
>> +		trace_printf_key(&trace_fsmonitor,
>> +				 "lost filesystem sync");
>> +		result = 0;
>> +		goto send_trivial_response;
>> +	}
>> +
>>   	/*
>>   	 * We're going to hold onto a pointer to the current
>>   	 * token-data while we walk the list of batches of files.
>> @@ -982,6 +1164,9 @@ void fsmonitor_publish(struct fsmonitor_daemon_state *state,
>>   		}
>>   	}
>>   
>> +	if (cookie_names->nr)
>> +		fsmonitor_cookie_mark_seen(state, cookie_names);
>> +
> 
> I was confused as to what updates 'cookie_names', but it appears that
> these are updated in the platform-specific code. That seems to happen
> in later patches.

Yes, this is a list of the cookies that the platform layer saw events
for.  It was passed in along with the set of batched paths.  So the
platform code can "publish/prepend" a new set of changed paths and
wake any threads whose cookie was seen.

> 
> Thanks,
> -Stolee
> 

Thanks,
Jeff
