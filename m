Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31B2C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 19:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6557361352
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 19:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbhD1T12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 15:27:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:21226 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239116AbhD1T11 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 15:27:27 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 37B913F40B7;
        Wed, 28 Apr 2021 15:26:42 -0400 (EDT)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0364A3F4098;
        Wed, 28 Apr 2021 15:26:41 -0400 (EDT)
Subject: Re: [PATCH 02/23] fsmonitor-ipc: create client routines for
 git-fsmonitor--daemon
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <3dac63eae201e6d0b949680e682238625cad59bd.1617291666.git.gitgitgadget@gmail.com>
 <5b63eb3f-0b87-209b-3943-ced8412abb93@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <98038a12-4750-456b-6535-8bc59a32693c@jeffhostetler.com>
Date:   Wed, 28 Apr 2021 15:26:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5b63eb3f-0b87-209b-3943-ced8412abb93@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/21 10:31 AM, Derrick Stolee wrote:
> On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
>> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
>> +#define FSMONITOR_DAEMON_IS_SUPPORTED 1
>> +#else
>> +#define FSMONITOR_DAEMON_IS_SUPPORTED 0
>> +#endif
>> +
>> +/*
>> + * A trivial function so that this source file always defines at least
>> + * one symbol even when the feature is not supported.  This quiets an
>> + * annoying compiler error.
>> + */
>> +int fsmonitor_ipc__is_supported(void)
>> +{
>> +	return FSMONITOR_DAEMON_IS_SUPPORTED;
>> +}
> 
> I don't see any other use of FSMONITOR_DAEMON_IS_SUPPORTED,
> so I was thinking you could use the #ifdef/#else/#endif
> construct within the implementation of this method instead
> of creating a macro outside. But my suggestion might be an
> anti-pattern, so feel free to ignore me.

I think an earlier draft did more with the macros
and wasn't as distilled as it is here.  So yes, I
could simplify it here.


>> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
>> +
>> +GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor")
>> +
>> +enum ipc_active_state fsmonitor_ipc__get_state(void)
>> +{
>> +	return ipc_get_active_state(fsmonitor_ipc__get_path());
>> +}
>> +
>> +static int spawn_daemon(void)
>> +{
>> +	const char *args[] = { "fsmonitor--daemon", "--start", NULL };
>> +
>> +	return run_command_v_opt_tr2(args, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
>> +				    "fsmonitor");
>> +}
>> +
>> +int fsmonitor_ipc__send_query(const char *since_token,
>> +			      struct strbuf *answer)
>> +{
>> +	int ret = -1;
>> +	int tried_to_spawn = 0;
>> +	enum ipc_active_state state = IPC_STATE__OTHER_ERROR;
>> +	struct ipc_client_connection *connection = NULL;
>> +	struct ipc_client_connect_options options
>> +		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
>> +
>> +	options.wait_if_busy = 1;
>> +	options.wait_if_not_found = 0;
>> +
>> +	trace2_region_enter("fsm_client", "query", NULL);
>> +
>> +	trace2_data_string("fsm_client", NULL, "query/command",
>> +			   since_token);
>> +
>> +try_again:
>> +	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
>> +				       &connection);
>> +
>> +	switch (state) {
>> +	case IPC_STATE__LISTENING:
>> +		ret = ipc_client_send_command_to_connection(
>> +			connection, since_token, answer);
>> +		ipc_client_close_connection(connection);
>> +
>> +		trace2_data_intmax("fsm_client", NULL,
>> +				   "query/response-length", answer->len);
>> +
>> +		if (fsmonitor_is_trivial_response(answer))
>> +			trace2_data_intmax("fsm_client", NULL,
>> +					   "query/trivial-response", 1);
>> +
>> +		goto done;
>> +
>> +	case IPC_STATE__NOT_LISTENING:
>> +		ret = error(_("fsmonitor_ipc__send_query: daemon not available"));
>> +		goto done;
> 
> I'll need to read up on the IPC layer a bit to find out the difference
> between IPC_STATE__NOT_LISTENING and IPC_STATE__PATH_NOT_FOUND. When
> testing on my macOS machine, I got this error. I was expecting the
> daemon to be spawned. After spawning it myself, it started working.
> 
> I expect that there are some cases where the process can fail and the
> named pipe is not cleaned up. Let's investigate that soon. I should
> make it clear that I had tested the builtin FS Monitor on this machine
> a few weeks ago, but hadn't been using it much since. We should auto-
> recover from this situation.

This probably means that you had a left over (dead) unix domain
socket in your .git directory from your prior testing.  I delete
it when the daemon shuts down normally, but if it was killed or
crashed, it may have been left behind.

When the client tries to connect (to a socket with no listener)
the OS refuses the connection and the IPC layer maps that back
to the __NOT_LISTENING error.

(There are other ways to get __NOT_LISTENING error, such as when
the client times-out because the daemon is too busy to respond,
but I'll ignore that for now.)

The unix daemon startup code tries to gently create the socket
(without stealing it from an existing server) and if that fails
(because there is no server present), it force creates a new socket
and starts listening on it.  (There was a large conversation on the
Simple IPC patch series about this.)  So this is how it fixed itself
after you started the daemon.


> But also: what is the cost of treating these two cases the same? Could
> we attempt to "restart" the daemon by spawning a new one? Will the new
> one find a way to kill a stale one?

On Windows, named pipes are magically deleted when the last handle
is closed (they are hosted on a special Named Pipe FS rather than NTFS,
so they have slightly different semantics).  If a named pipe exists,
but the connect fails, then a server is present but busy (or wedged).
The __NOT_LISTENING error basically means that the connect timed out.
So we know that the server is technically present, but it did not
respond.


On both platforms, if the socket/pipe is not present then the connect
returns __PATH_NOT_FOUND.  So we know that no daemon is present and are
free to implicitly start one.


The subtle difference in the __NOT_LISTENING case between the platforms
is why I hesitated to implicitly start (or restart) the daemon in this
case.

I would like to revisit auto-starting the daemon (at least on Unix)
when we have a dead socket.  I'll review this.

Thanks for the question.


> 
> (Reading on.)
> 
>> +	case IPC_STATE__PATH_NOT_FOUND:
>> +		if (tried_to_spawn)
>> +			goto done;
>> +
>> +		tried_to_spawn++;
>> +		if (spawn_daemon())
>> +			goto done;
> 
> This should return zero on success, OK.
> 
>> +		/*
>> +		 * Try again, but this time give the daemon a chance to
>> +		 * actually create the pipe/socket.
>> +		 *
>> +		 * Granted, the daemon just started so it can't possibly have
>> +		 * any FS cached yet, so we'll always get a trivial answer.
>> +		 * BUT the answer should include a new token that can serve
>> +		 * as the basis for subsequent requests.
>> +		 */
>> +		options.wait_if_not_found = 1;
>> +		goto try_again;
> 
> Because of the tried_to_spawn check, we will re-run the request over
> IPC but will not retry the spawn_daemon() request. I'm unsure how
> this could be helpful: is it possible that spawn_daemon() returns a
> non-zero error code after starting the daemon and somehow that
> daemon starts working? Or, is this a race-condition thing with parallel
> processes also starting up the daemon? It could be good to use this
> comment to describe why a retry might be helpful.

I'm trying to be fairly conservative here.  If no daemon/socket/pipe
is present, we try once to start it and then (with a small delay) try
to connect to the new daemon.  There is a little race with our process
and the new daemon instance, but we have the client spin a little to
give the daemon a chance to get started up.  Normally, that connect
will then succeed.

If that new daemon fails to start or we have some other error, we
need to just give up and tell the caller to do the work -- we've
already held up the caller long enough IMHO.

The thought here is that if that first daemon failed to start, then
subsequent attempts are likely to also fail.  And we don't want to
cause the client to get stuck trying to repeatedly start the daemon.
Better to just give up and go on.

> 
>> +
>> +	case IPC_STATE__INVALID_PATH:
>> +		ret = error(_("fsmonitor_ipc__send_query: invalid path '%s'"),
>> +			    fsmonitor_ipc__get_path());
>> +		goto done;
>> +
>> +	case IPC_STATE__OTHER_ERROR:
>> +	default:
>> +		ret = error(_("fsmonitor_ipc__send_query: unspecified error on '%s'"),
>> +			    fsmonitor_ipc__get_path());
>> +		goto done;
>> +	}
>> +
>> +done:
>> +	trace2_region_leave("fsm_client", "query", NULL);
>> +
>> +	return ret;
>> +}
>> +
>> +int fsmonitor_ipc__send_command(const char *command,
>> +				struct strbuf *answer)
>> +{
>> +	struct ipc_client_connection *connection = NULL;
>> +	struct ipc_client_connect_options options
>> +		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
>> +	int ret;
>> +	enum ipc_active_state state;
>> +
>> +	strbuf_reset(answer);
>> +
>> +	options.wait_if_busy = 1;
>> +	options.wait_if_not_found = 0;
>> +
>> +	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
>> +				       &connection);
>> +	if (state != IPC_STATE__LISTENING) {
>> +		die("fsmonitor--daemon is not running");
>> +		return -1;
>> +	}
>> +
>> +	ret = ipc_client_send_command_to_connection(connection, command, answer);
>> +	ipc_client_close_connection(connection);
>> +
>> +	if (ret == -1) {
>> +		die("could not send '%s' command to fsmonitor--daemon",
>> +		    command);
>> +		return -1;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> I wondier if this ...send_command() method is too generic. It might
> be nice to have more structure to its inputs and outputs to lessen
> the cognitive load when plugging into other portions of the code.
> However, I'll wait to see what those consumers look like in case the
> generality is merited.
>>   struct category_description {
>>   	uint32_t category;
>> @@ -664,6 +665,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
>>   		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
>>   		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
>>   		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
>> +
>> +		if (fsmonitor_ipc__is_supported())
>> +			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
> 
> This change might deserve its own patch, including some documentation
> about how users can use 'git version --build-options' to determine if
> the builtin FS Monitor feature is available on their platform.
> 

Good point.  Thanks.

> Thanks,
> -Stolee
> 
