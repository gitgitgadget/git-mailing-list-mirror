Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE002C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 19:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0517613EA
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 19:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhD3Tdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 15:33:36 -0400
Received: from siwi.pair.com ([209.68.5.199]:50628 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230508AbhD3Tde (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 15:33:34 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 10FE23F47F9;
        Fri, 30 Apr 2021 15:32:45 -0400 (EDT)
Received: from HCIPROD2.AZHCI.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D46DF3F47F4;
        Fri, 30 Apr 2021 15:32:44 -0400 (EDT)
Subject: Re: [PATCH 13/23] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <a57ddb3bc7cc2de9a48472c4faff32ef46132f73.1617291666.git.gitgitgadget@gmail.com>
 <4b0066f5-5962-e57e-5987-5358f3d394f7@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1c6dec17-89be-7f5f-7125-263e6778d2ba@jeffhostetler.com>
Date:   Fri, 30 Apr 2021 15:32:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4b0066f5-5962-e57e-5987-5358f3d394f7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/27/21 1:22 PM, Derrick Stolee wrote:
> On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach the win32 backend to register a watch on the working tree
>> root directory (recursively).  Also watch the <gitdir> if it is
>> not inside the working tree.  And to collect path change notifications
>> into batches and publish.
> 
> Is it valuable to list the important API methods here for an interested
> reader to discover them? Perhaps using links to the docs [1] might be
> too ephemeral, in case those URLs stop being valid.
> 
> In any case, here are the URLs I found helpful:
> 
> [1] https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-readdirectorychangesw
> [2] https://docs.microsoft.com/en-us/windows/win32/api/ioapiset/nf-ioapiset-getoverlappedresult
> [3] https://docs.microsoft.com/en-us/windows/win32/fileio/cancelioex-func
> [4] https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-resetevent
> [5] https://docs.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-file_notify_information
> [6] https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitformultipleobjects

I could see adding them.  I think I had some in an earlier draft.
(And I'm always glad to find them when I go back and revisit the
code later :-)

And yes, the Win32 APIs and code are a bit dense and tricky to
understand -- especially the async IO stuff, so this would be good.

> 
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
...
>> +static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
>> +				      const char *path)
>> +{
>> +	struct one_watch *watch = NULL;
>> +	DWORD desired_access = FILE_LIST_DIRECTORY;
>> +	DWORD share_mode =
>> +		FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE;
> 
> Ah, this is probably why we can delete a repo that is under a watch.

Yes, we're holding a handle to the directory (and we're CD'd into it),
but I have code in there to detect when the .git directory is deleted
and trigger a shutdown.  A "rm -rf" on the worktree will delete the
.git directory first and we "usually" win that race before "rm" gets
around to deleting the root directory.

I intend to harden this a bit more.  The Git startup code does the CD
to the root directory and I'd like to CD out after we get everything
setup.

...
>> +static int recv_rdcw_watch(struct one_watch *watch)
>> +{
>> +	watch->is_active = FALSE;
>> +
>> +	if (GetOverlappedResult(watch->hDir, &watch->overlapped, &watch->count,
>> +				TRUE))
>> +		return 0;
>> +
>> +	// TODO If an external <gitdir> is deleted, the above returns an error.
>> +	// TODO I'm not sure that there's anything that we can do here other
>> +	// TODO than failing -- the <worktree>/.git link file would be broken
>> +	// TODO anyway.  We might try to check for that and return a better
>> +	// TODO error message.
> 
> These are not fit C-style comments. This situation can be handled
> by a later patch series, if valuable enough.

Oooops, I missed that one before I posted it.

> 
>> +
>> +	error("GetOverlappedResult failed on '%s' [GLE %ld]",
>> +	      watch->path.buf, GetLastError());
>> +	return -1;
>> +}
>> +
>> +static void cancel_rdcw_watch(struct one_watch *watch)
>> +{
>> +	DWORD count;
>> +
>> +	if (!watch || !watch->is_active)
>> +		return;
>> +
>> +	CancelIoEx(watch->hDir, &watch->overlapped);
>> +	GetOverlappedResult(watch->hDir, &watch->overlapped, &count, TRUE);
>> +	watch->is_active = FALSE;
>> +}
>> +
>> +/*
>> + * Process filesystem events that happen anywhere (recursively) under the
>> + * <worktree> root directory.  For a normal working directory, this includes
>> + * both version controlled files and the contents of the .git/ directory.
>> + *
>> + * If <worktree>/.git is a file, then we only see events for the file
>> + * itself.
>> + */
>> +static int process_worktree_events(struct fsmonitor_daemon_state *state)
>> +{
>> +	struct fsmonitor_daemon_backend_data *data = state->backend_data;
>> +	struct one_watch *watch = data->watch_worktree;
>> +	struct strbuf path = STRBUF_INIT;
>> +	struct string_list cookie_list = STRING_LIST_INIT_DUP;
>> +	struct fsmonitor_batch *batch = NULL;
>> +	const char *p = watch->buffer;
>> +
>> +	/*
>> +	 * If the kernel gets more events than will fit in the kernel
>> +	 * buffer associated with our RDCW handle, it drops them and
>> +	 * returns a count of zero.  (A successful call, but with
>> +	 * length zero.)
>> +	 */
> 
> I suppose that since we create a cookie file, we don't expect a zero
> result to ever be a meaningful value? Or, is there another way to
> differentiate between "nothing happened" and "too much happened"?

This is independent of cookie files.  We have a thread watching
watching for FS events and building up batches of changes and
assembling the list of batches.  This is always running.

Cookies are created by the threads in the IPC thread pool and
those threads wait until we get a FS event for their cookie file.

All of these threads are running independently.

The code here is saying that Windows will give us a non-error but
zero result when the kernel had to drop events.  (The "too much
happened" case.)

If nothing happens on the FS, our Async IO doesn't trigger a
wakeup and the FS listener thread stays in the WaitForMultipleObjects().

All of this is pretty dense I realize.

> 
>> +	if (!watch->count) {
>> +		trace2_data_string("fsmonitor", NULL, "fsm-listen/kernel",
>> +				   "overflow");
>> +		fsmonitor_force_resync(state);
>> +		return LISTENER_HAVE_DATA_WORKTREE;
>> +	}
>> +
>> +	/*
>> +	 * On Windows, `info` contains an "array" of paths that are
>> +	 * relative to the root of whichever directory handle received
>> +	 * the event.
>> +	 */
>> +	for (;;) {
>> +		FILE_NOTIFY_INFORMATION *info = (void *)p;
>> +		const char *slash;
>> +		enum fsmonitor_path_type t;
>> +
>> +		strbuf_reset(&path);
>> +		if (normalize_path_in_utf8(info, &path) == -1)
>> +			goto skip_this_path;
>> +
>> +		t = fsmonitor_classify_path_workdir_relative(path.buf);
>> +
>> +		switch (t) {
>> +		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
>> +			/* special case cookie files within .git */
>> +
>> +			/* Use just the filename of the cookie file. */
>> +			slash = find_last_dir_sep(path.buf);
>> +			string_list_append(&cookie_list,
>> +					   slash ? slash + 1 : path.buf);
> 
> Ok, I see now how we special-case cookies in the list of events.
> 
>> +			break;
>> +
>> +		case IS_INSIDE_DOT_GIT:
>> +			/* ignore everything inside of "<worktree>/.git/" */
>> +			break;
>> +
>> +		case IS_DOT_GIT:
>> +			/* "<worktree>/.git" was deleted (or renamed away) */
>> +			if ((info->Action == FILE_ACTION_REMOVED) ||
>> +			    (info->Action == FILE_ACTION_RENAMED_OLD_NAME)) {
>> +				trace2_data_string("fsmonitor", NULL,
>> +						   "fsm-listen/dotgit",
>> +						   "removed");
>> +				goto force_shutdown;
>> +			}
>> +			break;
>> +
>> +		case IS_WORKDIR_PATH:
>> +			/* queue normal pathname */
>> +			if (!batch)
>> +				batch = fsmonitor_batch__new();
>> +			fsmonitor_batch__add_path(batch, path.buf);
>> +			break;
>> +
>> +		case IS_GITDIR:
>> +		case IS_INSIDE_GITDIR:
>> +		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
>> +		default:
>> +			BUG("unexpected path classification '%d' for '%s'",
>> +			    t, path.buf);
> So these events should be caught by the _other_ watcher. I suppose
> BUG() is somewhat appropriate, but also seems heavy-handed. For
> example, the 'goto' in the next line will never be visited. A die()
> would even be appropriate, but somewhat less harsh than a BUG(),
> especially for a background process.
> 
>> +			goto skip_this_path;

Right, the IS_*GITDIR events should only happen in the other
watcher.  They are bugs in the sense that the path classifier
failed.  And the "default:" is my usual backstop for such an enum
where any other value would be a bug.

I'm not sure whether BUG(), die(), or error() is better than the
other.  The daemon runs with without a console normally, so the
messages will not be seen -- unless you're debugging it or running
it in the foreground.

I could get rid of the goto.

>> +		}
>> +
>> +skip_this_path:
>> +		if (!info->NextEntryOffset)
>> +			break;
>> +		p += info->NextEntryOffset;
>> +	}
>> +
>> +	fsmonitor_publish(state, batch, &cookie_list);
>> +	batch = NULL;
>> +	string_list_clear(&cookie_list, 0);
>> +	strbuf_release(&path);
>> +	return LISTENER_HAVE_DATA_WORKTREE;
>> +
>> +force_shutdown:
>> +	fsmonitor_batch__free(batch);
>> +	string_list_clear(&cookie_list, 0);
>> +	strbuf_release(&path);
>> +	return LISTENER_SHUTDOWN;
>> +}
>> +
>> +/*
>> + * Process filesystem events that happend anywhere (recursively) under the
> 
> s/happend/happened
> 
>> + * external <gitdir> (such as non-primary worktrees or submodules).
>> + * We only care about cookie files that our client threads created here.
>> + *
>> + * Note that we DO NOT get filesystem events on the external <gitdir>
>> + * itself (it is not inside something that we are watching).  In particular,
>> + * we do not get an event if the external <gitdir> is deleted.
> 
> This is an interesting change of behavior. I forget if it is listed in
> the documentation file, but definitely could be. I imagine wanting a
> "Troubleshooting" section that describes special cases like this.
> 
> Also, because of this worktree-specific behavior, we might want to
> recommend using 'git config --worktree' when choosing to use FS Monitor,
> so that each worktree is opted-in as requested. Without --worktree, all
> worktrees with a common base would stard using FS Monitor simultaneously.

I'll take a look.

> 
>> + */
>> +static int process_gitdir_events(struct fsmonitor_daemon_state *state)
>> +{
>> +	struct fsmonitor_daemon_backend_data *data = state->backend_data;
>> +	struct one_watch *watch = data->watch_gitdir;
>> +	struct strbuf path = STRBUF_INIT;
>> +	struct string_list cookie_list = STRING_LIST_INIT_DUP;
>> +	const char *p = watch->buffer;
>> +
>> +	if (!watch->count) {
>> +		trace2_data_string("fsmonitor", NULL, "fsm-listen/kernel",
>> +				   "overflow");
>> +		fsmonitor_force_resync(state);
>> +		return LISTENER_HAVE_DATA_GITDIR;
>> +	}
>> +
>> +	for (;;) {
>> +		FILE_NOTIFY_INFORMATION *info = (void *)p;
>> +		const char *slash;
>> +		enum fsmonitor_path_type t;
>> +
>> +		strbuf_reset(&path);
>> +		if (normalize_path_in_utf8(info, &path) == -1)
>> +			goto skip_this_path;
>> +
>> +		t = fsmonitor_classify_path_gitdir_relative(path.buf);
>> +
>> +		trace_printf_key(&trace_fsmonitor, "BBB: %s", path.buf);
>> +
>> +		switch (t) {
>> +		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
>> +			/* special case cookie files within gitdir */
>> +
>> +			/* Use just the filename of the cookie file. */
>> +			slash = find_last_dir_sep(path.buf);
>> +			string_list_append(&cookie_list,
>> +					   slash ? slash + 1 : path.buf);
>> +			break;
>> +
>> +		case IS_INSIDE_GITDIR:
>> +			goto skip_this_path;
>> +
>> +		default:
>> +			BUG("unexpected path classification '%d' for '%s'",
>> +			    t, path.buf);
> 
> If we decide against BUG() earlier, then also get this one.
> 
>> +			goto skip_this_path;
>> +		}
>> +
>> +skip_this_path:
>> +		if (!info->NextEntryOffset)
>> +			break;
>> +		p += info->NextEntryOffset;
>> +	}
>> +
>> +	fsmonitor_publish(state, NULL, &cookie_list);
>> +	string_list_clear(&cookie_list, 0);
>> +	strbuf_release(&path);
>> +	return LISTENER_HAVE_DATA_GITDIR;
>>   }
>>   
>>   void fsmonitor_fs_listen__loop(struct fsmonitor_daemon_state *state)
>>   {
>> +	struct fsmonitor_daemon_backend_data *data = state->backend_data;
>> +	DWORD dwWait;
>> +
>> +	state->error_code = 0;
>> +
>> +	if (start_rdcw_watch(data, data->watch_worktree) == -1)
>> +		goto force_error_stop;
>> +
>> +	if (data->watch_gitdir &&
>> +	    start_rdcw_watch(data, data->watch_gitdir) == -1)
>> +		goto force_error_stop;
>> +
>> +	for (;;) {
>> +		dwWait = WaitForMultipleObjects(data->nr_listener_handles,
>> +						data->hListener,
>> +						FALSE, INFINITE);
> 
> Since you use INFINITE here, that says that we will wait for at least one
> signal, solving the confusion about zero results: zero results unambiguously
> indicates a loss of events.

Right.

> 
>> +
>> +		if (dwWait == WAIT_OBJECT_0 + LISTENER_HAVE_DATA_WORKTREE) {
>> +			if (recv_rdcw_watch(data->watch_worktree) == -1)
>> +				goto force_error_stop;
>> +			if (process_worktree_events(state) == LISTENER_SHUTDOWN)
>> +				goto force_shutdown;
>> +			if (start_rdcw_watch(data, data->watch_worktree) == -1)
>> +				goto force_error_stop;
>> +			continue;
>> +		}
>> +
>> +		if (dwWait == WAIT_OBJECT_0 + LISTENER_HAVE_DATA_GITDIR) {
>> +			if (recv_rdcw_watch(data->watch_gitdir) == -1)
>> +				goto force_error_stop;
>> +			if (process_gitdir_events(state) == LISTENER_SHUTDOWN)
>> +				goto force_shutdown;
>> +			if (start_rdcw_watch(data, data->watch_gitdir) == -1)
>> +				goto force_error_stop;
>> +			continue;
>> +		}
>> +
>> +		if (dwWait == WAIT_OBJECT_0 + LISTENER_SHUTDOWN)
>> +			goto clean_shutdown;
>> +
>> +		error(_("could not read directory changes [GLE %ld]"),
>> +		      GetLastError());
>> +		goto force_error_stop;
>> +	}
>> +
>> +force_error_stop:
>> +	state->error_code = -1;
>> +
>> +force_shutdown:
>> +	/*
>> +	 * Tell the IPC thead pool to stop (which completes the await
>> +	 * in the main thread (which will also signal this thread (if
>> +	 * we are still alive))).
>> +	 */
>> +	ipc_server_stop_async(state->ipc_server_data);
>> +
>> +clean_shutdown:
>> +	cancel_rdcw_watch(data->watch_worktree);
>> +	cancel_rdcw_watch(data->watch_gitdir);
>>   }
>>   
>>   int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
>>   {
>> +	struct fsmonitor_daemon_backend_data *data;
>> +
>> +	data = xcalloc(1, sizeof(*data));
> 
> CALLOC_ARRAY()
> 
>> +
>> +	data->hEventShutdown = CreateEvent(NULL, TRUE, FALSE, NULL);
>> +
>> +	data->watch_worktree = create_watch(state,
>> +					    state->path_worktree_watch.buf);
>> +	if (!data->watch_worktree)
>> +		goto failed;
>> +
>> +	if (state->nr_paths_watching > 1) {
>> +		data->watch_gitdir = create_watch(state,
>> +						  state->path_gitdir_watch.buf);
>> +		if (!data->watch_gitdir)
>> +			goto failed;
>> +	}
>> +
>> +	data->hListener[LISTENER_SHUTDOWN] = data->hEventShutdown;
>> +	data->nr_listener_handles++;
>> +
>> +	data->hListener[LISTENER_HAVE_DATA_WORKTREE] =
>> +		data->watch_worktree->hEvent;
>> +	data->nr_listener_handles++;
>> +
>> +	if (data->watch_gitdir) {
>> +		data->hListener[LISTENER_HAVE_DATA_GITDIR] =
>> +			data->watch_gitdir->hEvent;
>> +		data->nr_listener_handles++;
>> +	}
> 
> This is a clever organization of the event handles. I imagine it
> will requires some rework if we decide to include another optional
> handle whose inclusion is orthogonal to the gitdir one, but that
> is unlikely enough to keep these well-defined array indices.

I think we're good here.  I think an INVALID_HANDLE value can
be used to supply a hole in the vector of event handles.
But yes, we don't have to worry about that now.

> 
>> +	state->backend_data = data;
>> +	return 0;
>> +
>> +failed:
>> +	CloseHandle(data->hEventShutdown);
>> +	destroy_watch(data->watch_worktree);
>> +	destroy_watch(data->watch_gitdir);
>> +
>>   	return -1;
>>   }
>>   
>>   void fsmonitor_fs_listen__dtor(struct fsmonitor_daemon_state *state)
>>   {
>> +	struct fsmonitor_daemon_backend_data *data;
>> +
>> +	if (!state || !state->backend_data)
>> +		return;
>> +
>> +	data = state->backend_data;
>> +
>> +	CloseHandle(data->hEventShutdown);
>> +	destroy_watch(data->watch_worktree);
>> +	destroy_watch(data->watch_gitdir);
>> +
>> +	FREE_AND_NULL(state->backend_data);
>>   }
> 
> I tried to follow all the API calls and check the documentation for
> any misuse, but did not find any. I can only contribute nitpicks
> here, and rely on the tests to really see that this is working as
> expected.
> 
> I was hoping to find in here why we need to sleep in the test suite,
> but have not pinpointed that issue yet.

The sleep was only needed on severely under-powered CI machines
(think 1 core).  I revisit this.  I think I might be able to get
rid of it.

Thanks,
Jeff


