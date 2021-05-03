Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E789CC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B487F611C9
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhECPFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 11:05:16 -0400
Received: from siwi.pair.com ([209.68.5.199]:42769 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhECPFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 11:05:14 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7B1CE3F4165;
        Mon,  3 May 2021 11:04:20 -0400 (EDT)
Received: from msranlcmt20.fareast.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 471AC3F413A;
        Mon,  3 May 2021 11:04:20 -0400 (EDT)
Subject: Re: [PATCH 16/23] fsmonitor--daemon: implement handle_client callback
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <2b4ae4fc3d622f0fee8eb5e527a51467e13acfc5.1617291666.git.gitgitgadget@gmail.com>
 <35876c33-4e1a-bc07-cd6c-8d43a25c7903@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <cde39ed5-1175-9163-698a-eb5eca93ba59@jeffhostetler.com>
Date:   Mon, 3 May 2021 11:04:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <35876c33-4e1a-bc07-cd6c-8d43a25c7903@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/21 5:01 PM, Derrick Stolee wrote:
> On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach fsmonitor--daemon to respond to IPC requests from client
>> Git processes and respond with a list of modified pathnames
>> relative to the provided token.
> 
> (I'm skipping ahead to this part. I'll examine the platform
> specific bits after I finish with "the Git bits".)
> 
>> +static void fsmonitor_format_response_token(
>> +	struct strbuf *response_token,
>> +	const struct strbuf *response_token_id,
>> +	const struct fsmonitor_batch *batch)
>> +{
>> +	uint64_t seq_nr = (batch) ? batch->batch_seq_nr + 1 : 0;
>> +
>> +	strbuf_reset(response_token);
>> +	strbuf_addf(response_token, "builtin:%s:%"PRIu64,
>> +		    response_token_id->buf, seq_nr);]
> 
> Ah, right. The token string gets _even more specific_ to allow
> for multiple "checkpoints" within a batch.
> 
>> +static int fsmonitor_parse_client_token(const char *buf_token,
>> +					struct strbuf *requested_token_id,
>> +					uint64_t *seq_nr)
>> +{
>> +	const char *p;
>> +	char *p_end;
>> +
>> +	strbuf_reset(requested_token_id);
>> +	*seq_nr = 0;
>> +
>> +	if (!skip_prefix(buf_token, "builtin:", &p))
>> +		return 1;
>> +
>> +	while (*p && *p != ':')
>> +		strbuf_addch(requested_token_id, *p++);
> 
> My mind is going towards microoptimizations, but I wonder if there
> is a difference using
> 
> 	q = strchr(p, ':');
> 	if (!q)
> 		return 1;
> 	strbuf_add(requested_token_id, p, q - p);
> 
> We trade one scan with several method calls for instead two scans
> and two method calls, but also those two scans are very optimized.
> 
> Probably not worth it, as this is something like 20 bytes of data
> per round-trip.

I'll take a look at this and your later comment about double parsing
"builtin:".

> 
>> +	if (!skip_prefix(command, "builtin:", &p)) {
>> +		/* assume V1 timestamp or garbage */
>> +
>> +		char *p_end;
>> +
>> +		strtoumax(command, &p_end, 10);
>> +		trace_printf_key(&trace_fsmonitor,
>> +				 ((*p_end) ?
>> +				  "fsmonitor: invalid command line '%s'" :
>> +				  "fsmonitor: unsupported V1 protocol '%s'"),
>> +				 command);
>> +		result = -1;
>> +		goto send_trivial_response;
>> +	}
> 
> This is an interesting protection for users currently using FS
> Monitor but upgrade to the builtin approach.

Yes, the token is stored in the .git/index extension, so we always
have to assume that we'll get an old-school token that they inherited
from the last command executed before they switched FSMonitor providers.

Also, there is a chicken-n-egg problem in the FSMonitor protocol that
we inherited from the V1 effort -- the client has to initiate the
conversation with a token/timestamp, but has yet to talk to the daemon
(or hook) and doesn't know what a V2 token looks like (since they are
opaque to the client).  So I let the client blindly send a V1 timestamp
which the daemon will silently reject and send a trivial response (which
tells the client to do the work itself and gives it a V2 token for the
next call).

> 
>> +	if (fsmonitor_parse_client_token(command, &requested_token_id,
>> +					 &requested_oldest_seq_nr)) {
> 
> It appears you will call skip_prefix() twice this way, once to
> determine we are actually the right kind of token, but a second
> time as part of this call. Perhaps the helper method could start
> from 'p' which has already advanced beyond "buildin:"?
> 
>> +		trace_printf_key(&trace_fsmonitor,
>> +				 "fsmonitor: invalid V2 protocol token '%s'",
>> +				 command);
>> +		result = -1;
>> +		goto send_trivial_response;
>> +	}
> 
> This method is getting a bit long. Could the interesting data
> structure code below be extracted as a method?

Let me try refactoring it.

> 
>> +	pthread_mutex_lock(&state->main_lock);
>> +
>> +	if (!state->current_token_data) {
>> +		/*
>> +		 * We don't have a current token.  This may mean that
>> +		 * the listener thread has not yet started.
>> +		 */
>> +		pthread_mutex_unlock(&state->main_lock);
>> +		result = 0;
>> +		goto send_trivial_response;
>> +	}
>> +	if (strcmp(requested_token_id.buf,
>> +		   state->current_token_data->token_id.buf)) {
>> +		/*
>> +		 * The client last spoke to a different daemon
>> +		 * instance -OR- the daemon had to resync with
>> +		 * the filesystem (and lost events), so reject.
>> +		 */
>> +		pthread_mutex_unlock(&state->main_lock);
>> +		result = 0;
>> +		trace2_data_string("fsmonitor", the_repository,
>> +				   "response/token", "different");
>> +		goto send_trivial_response;
>> +	}
>> +	if (!state->current_token_data->batch_tail) {
>> +		/*
>> +		 * The listener has not received any filesystem
>> +		 * events yet since we created the current token.
>> +		 * We can respond with an empty list, since the
>> +		 * client has already seen the current token and
>> +		 * we have nothing new to report.  (This is
>> +		 * instead of sending a trivial response.)
>> +		 */
>> +		pthread_mutex_unlock(&state->main_lock);
>> +		result = 0;
>> +		goto send_empty_response;
>> +	}
>> +	if (requested_oldest_seq_nr <
>> +	    state->current_token_data->batch_tail->batch_seq_nr) {
>> +		/*
>> +		 * The client wants older events than we have for
>> +		 * this token_id.  This means that the end of our
>> +		 * batch list was truncated and we cannot give the
>> +		 * client a complete snapshot relative to their
>> +		 * request.
>> +		 */
>> +		pthread_mutex_unlock(&state->main_lock);
>> +
>> +		trace_printf_key(&trace_fsmonitor,
>> +				 "client requested truncated data");
>> +		result = 0;
>> +		goto send_trivial_response;
>> +	}
> 
> If these are part of a helper method, then they could be reorganized
> to "goto" the end of the method which returns an error code after
> unlocking the mutex. The multiple unlocks are making me nervous.
> 
>> +
>> +	/*
>> +	 * We're going to hold onto a pointer to the current
>> +	 * token-data while we walk the list of batches of files.
>> +	 * During this time, we will NOT be under the lock.
>> +	 * So we ref-count it.
> 
> I was wondering if this would happen. I'm glad it is.
> 
>> +	 * This allows the listener thread to continue prepending
>> +	 * new batches of items to the token-data (which we'll ignore).
>> +	 *
>> +	 * AND it allows the listener thread to do a token-reset
>> +	 * (and install a new `current_token_data`).
>> +	 *
>> +	 * We mark the current head of the batch list as "pinned" so
>> +	 * that the listener thread will treat this item as read-only
>> +	 * (and prevent any more paths from being added to it) from
>> +	 * now on.
>> +	 */
>> +	token_data = state->current_token_data;
>> +	token_data->client_ref_count++;
>> +
>> +	batch_head = token_data->batch_head;
>> +	((struct fsmonitor_batch *)batch_head)->pinned_time = time(NULL);
>> +
>> +	pthread_mutex_unlock(&state->main_lock);
> 
> We are now pinned. Makes sense.
> 
>> +	/*
>> +	 * FSMonitor Protocol V2 requires that we send a response header
>> +	 * with a "new current token" and then all of the paths that changed
>> +	 * since the "requested token".
>> +	 */
>> +	fsmonitor_format_response_token(&response_token,
>> +					&token_data->token_id,
>> +					batch_head);
>> +
>> +	reply(reply_data, response_token.buf, response_token.len + 1);
>> +	total_response_len += response_token.len + 1;
> 
> I was going to say we should let "reply" return the number of bytes written,
> but that is already an error code. But then we seem to be ignoring it here.
> Should we at least do something like "err |= reply()" to collect any errors?

Maybe. I'll have to look and see what the daemon thread can do
on such an error.

> 
>> +
>> +	trace2_data_string("fsmonitor", the_repository, "response/token",
>> +			   response_token.buf);
>> +	trace_printf_key(&trace_fsmonitor, "response token: %s", response_token.buf);
>> +
>> +	shown = kh_init_str();
>> +	for (batch = batch_head;
>> +	     batch && batch->batch_seq_nr >= requested_oldest_seq_nr;
>> +	     batch = batch->next) {
>> +		size_t k;
>> +
>> +		for (k = 0; k < batch->nr; k++) {
>> +			const char *s = batch->interned_paths[k];
>> +			size_t s_len;
>> +
>> +			if (kh_get_str(shown, s) != kh_end(shown))
>> +				duplicates++;
>> +			else {
>> +				kh_put_str(shown, s, &hash_ret);
> 
> It appears that you could make use of 'struct strmap' instead of managing your
> own khash structure.

Since all of the strings in the batches are already interned
(and we have constant fixed pointers for each string), I'd
eventually like to have this khash take advantage of that and
make this (essentially) a Set on the pointer values rather than
a Set on the strings.  This version is a step in that direction.

> 
>> +
>> +				trace_printf_key(&trace_fsmonitor,
>> +						 "send[%"PRIuMAX"]: %s",
>> +						 count, s);
>> +
>> +				/* Each path gets written with a trailing NUL */
>> +				s_len = strlen(s) + 1;
>> +
>> +				if (payload.len + s_len >=
>> +				    LARGE_PACKET_DATA_MAX) {
>> +					reply(reply_data, payload.buf,
>> +					      payload.len);
>> +					total_response_len += payload.len;
>> +					strbuf_reset(&payload);
>> +				}
>> +
>> +				strbuf_add(&payload, s, s_len);
>> +				count++;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (payload.len) {
>> +		reply(reply_data, payload.buf, payload.len);
>> +		total_response_len += payload.len;
>> +	}
>> +
>> +	kh_release_str(shown);
>> +
>> +	pthread_mutex_lock(&state->main_lock);
>> +	if (token_data->client_ref_count > 0)
>> +		token_data->client_ref_count--;
>> +
>> +	if (token_data->client_ref_count == 0) {
>> +		if (token_data != state->current_token_data) {
>> +			/*
>> +			 * The listener thread did a token-reset while we were
>> +			 * walking the batch list.  Therefore, this token is
>> +			 * stale and can be discarded completely.  If we are
>> +			 * the last reader thread using this token, we own
>> +			 * that work.
>> +			 */
>> +			fsmonitor_free_token_data(token_data);
>> +		}
>> +	}
> 
> Perhaps this could be extracted to a method, so that any (locked) caller
> could run
> 
> 	free_token_if_unused(state, token_data);
> 
> and the token will either keep around (because client_ref_count > 0 or
> state->current_token_data is still on token_data). Otherwise I predict
> this being implemented in two places, which is too many when dealing with
> memory ownership.

I'll take a look at this.

> 
>> +
>> +	pthread_mutex_unlock(&state->main_lock);
>> +
>> +	trace2_data_intmax("fsmonitor", the_repository, "response/length", total_response_len);
>> +	trace2_data_intmax("fsmonitor", the_repository, "response/count/files", count);
>> +	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
>> +
>> +	strbuf_release(&response_token);
>> +	strbuf_release(&requested_token_id);
>> +	strbuf_release(&payload);
>> +
>> +	return 0;
>> +
>> +send_trivial_response:
>> +	pthread_mutex_lock(&state->main_lock);
>> +	fsmonitor_format_response_token(&response_token,
>> +					&state->current_token_data->token_id,
>> +					state->current_token_data->batch_head);
>> +	pthread_mutex_unlock(&state->main_lock);
>> +
>> +	reply(reply_data, response_token.buf, response_token.len + 1);
>> +	trace2_data_string("fsmonitor", the_repository, "response/token",
>> +			   response_token.buf);
>> +	reply(reply_data, "/", 2);
>> +	trace2_data_intmax("fsmonitor", the_repository, "response/trivial", 1);
>> +
>> +	strbuf_release(&response_token);
>> +	strbuf_release(&requested_token_id);
>> +
>> +	return result;
>> +
>> +send_empty_response:
>> +	pthread_mutex_lock(&state->main_lock);
>> +	fsmonitor_format_response_token(&response_token,
>> +					&state->current_token_data->token_id,
>> +					NULL);
>> +	pthread_mutex_unlock(&state->main_lock);
>> +
>> +	reply(reply_data, response_token.buf, response_token.len + 1);
>> +	trace2_data_string("fsmonitor", the_repository, "response/token",
>> +			   response_token.buf);
>> +	trace2_data_intmax("fsmonitor", the_repository, "response/empty", 1);
>> +
>> +	strbuf_release(&response_token);
>> +	strbuf_release(&requested_token_id);
>> +
>> +	return 0;
>> +}
>> +
>>   static ipc_server_application_cb handle_client;
>>   
>>   static int handle_client(void *data, const char *command,
>>   			 ipc_server_reply_cb *reply,
>>   			 struct ipc_server_reply_data *reply_data)
>>   {
>> -	/* struct fsmonitor_daemon_state *state = data; */
>> +	struct fsmonitor_daemon_state *state = data;
>>   	int result;
>>   
>> +	trace_printf_key(&trace_fsmonitor, "requested token: %s", command);
>> +
>>   	trace2_region_enter("fsmonitor", "handle_client", the_repository);
>>   	trace2_data_string("fsmonitor", the_repository, "request", command);
>>   
>> -	result = 0; /* TODO Do something here. */
>> +	result = do_handle_client(state, command, reply, reply_data);
>>   
>>   	trace2_region_leave("fsmonitor", "handle_client", the_repository);
>>   
> 
> A simple integration with earlier work. Good.
> 
> Thanks,
> -Stolee
> 

Thanks,
Jeff
