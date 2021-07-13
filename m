Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45560C11F66
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310F661154
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 14:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbhGMOms (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 10:42:48 -0400
Received: from siwi.pair.com ([209.68.5.199]:47459 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236873AbhGMOmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 10:42:47 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 71C713F40E4;
        Tue, 13 Jul 2021 10:39:57 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2B5923F40D9;
        Tue, 13 Jul 2021 10:39:57 -0400 (EDT)
Subject: Re: [PATCH v3 14/34] fsmonitor--daemon: implement 'start' command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <9fe902aad87f1192705fb69ea212a2d066d0286d.1625150864.git.gitgitgadget@gmail.com>
 <87a6n5d600.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <80fb703d-0f88-110e-5a5c-e8e9a90bbc17@jeffhostetler.com>
Date:   Tue, 13 Jul 2021 10:39:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87a6n5d600.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


My response here is in addition to Dscho's remarks on this topic.
He makes excellent points that I'll just #include here.  I do want
to add my own $0.02 here.

On 7/1/21 6:18 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> +#ifdef GIT_WINDOWS_NATIVE
>> +/*
>> + * Create a background process to run the daemon.  It should be completely
>> + * disassociated from the terminal.
>> + *
>> + * Conceptually like `daemonize()` but different because Windows does not
>> + * have `fork(2)`.  Spawn a normal Windows child process but without the
>> + * limitations of `start_command()` and `finish_command()`.
>> + *
>> + * The child process execs the "git fsmonitor--daemon run" command.
>> + *
>> + * The current process returns so that the caller can wait for the child
>> + * to startup before exiting.
>> + */
>> +static int spawn_background_fsmonitor_daemon(pid_t *pid)
>> +{
>> +	char git_exe[MAX_PATH];
>> +	struct strvec args = STRVEC_INIT;
>> +	int in, out;
>> +
>> +	GetModuleFileNameA(NULL, git_exe, MAX_PATH);
>> +
>> +	in = open("/dev/null", O_RDONLY);
>> +	out = open("/dev/null", O_WRONLY);
>> +
>> +	strvec_push(&args, git_exe);
>> +	strvec_push(&args, "fsmonitor--daemon");
>> +	strvec_push(&args, "run");
>> +	strvec_pushf(&args, "--ipc-threads=%d", fsmonitor__ipc_threads);
>> +
>> +	*pid = mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
>> +	close(in);
>> +	close(out);
>> +
>> +	strvec_clear(&args);
>> +
>> +	if (*pid < 0)
>> +		return error(_("could not spawn fsmonitor--daemon in the background"));
>> +
>> +	return 0;
>> +}
>> +#else
>> +/*
>> + * Create a background process to run the daemon.  It should be completely
>> + * disassociated from the terminal.
>> + *
>> + * This is adapted from `daemonize()`.  Use `fork()` to directly
>> + * create and run the daemon in the child process.
>> + *
>> + * The fork-child can just call the run code; it does not need to exec
>> + * it.
>> + *
>> + * The fork-parent returns the child PID so that we can wait for the
>> + * child to startup before exiting.
>> + */
>> +static int spawn_background_fsmonitor_daemon(pid_t *pid)
>> +{
>> +	*pid = fork();
>> +
>> +	switch (*pid) {
>> +	case 0:
>> +		if (setsid() == -1)
>> +			error_errno(_("setsid failed"));
>> +		close(0);
>> +		close(1);
>> +		close(2);
>> +		sanitize_stdfds();
>> +
>> +		return !!fsmonitor_run_daemon();
>> +
>> +	case -1:
>> +		return error_errno(_("could not spawn fsmonitor--daemon in the background"));
>> +
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +#endif
> 
> The spawn_background_fsmonitor_daemon() function here is almost the same
> as daemonize(). I wonder if this & the Windows-specific one you have
> here can't be refactored into an API from what's now in setup.c.
> 
> Then we could make builtin/gc.c and daemon.c use that, so Windows could
> have background GC, and we'd have a more battle-tested central codepath
> for this tricky bit.
> 

I'd rather not refactor all of this and add unnecessary generality
and complexity just to save duplicating some of the code in daemonize().

And I'd rather not destabilize existing commands like gc and daemon
by changing the daemonize() layer on them.  If those commands need help,
let's have a separate conversation _later_ about what help they need
and if it makes sense to combine them.


> It seems to me like the only limitations on it are to have this return
> slightly more general things (e.g. not set its own errors, return
> structured data), and maybe some callback for what to do in the
> child/parent.

There are several issues here when trying to start a background process
and we're already on the edge of the behavioral differences between
Windows and Unix -- let's not make things more confusing with multiple
callbacks, returning structures, custom errors, and etc.

Also, since Windows doesn't do fork(), we don't have child/parent
branches in the call, so this whole "just pretend it's all Unix"
model doesn't work.

Even if we did pretend I'd still need ifdef'd callback routines to
either call `fsmonitor_run_daemon()` or build a command line (or have
blocks of functions that "just happen to never be called on one
platform or the other").


What I have here is an API that the primary (read: parent) calls
and gets back a 0 or -1 (with error message).  And that's it.
The primary can then wait for the child (whether from fork or
CreateProcess) to become responsive or fail to start.  And then
the primary can exit (with or without error).

So I think we're good.  Yes, there is an ifdef here, but I think
it is worth it.


> 
>> +/*
>> + * This is adapted from `wait_or_whine()`.  Watch the child process and
>> + * let it get started and begin listening for requests on the socket
>> + * before reporting our success.
>> + */
>> +static int wait_for_background_startup(pid_t pid_child)
>> +{
>> +	int status;
>> +	pid_t pid_seen;
>> +	enum ipc_active_state s;
>> +	time_t time_limit, now;
>> +
>> +	time(&time_limit);
>> +	time_limit += fsmonitor__start_timeout_sec;
>> +
>> +	for (;;) {
>> +		pid_seen = waitpid(pid_child, &status, WNOHANG);
>> +
>> +		if (pid_seen == -1)
>> +			return error_errno(_("waitpid failed"));
>> +		else if (pid_seen == 0) {
>> +			/*
>> +			 * The child is still running (this should be
>> +			 * the normal case).  Try to connect to it on
>> +			 * the socket and see if it is ready for
>> +			 * business.
>> +			 *
>> +			 * If there is another daemon already running,
>> +			 * our child will fail to start (possibly
>> +			 * after a timeout on the lock), but we don't
>> +			 * care (who responds) if the socket is live.
>> +			 */
>> +			s = fsmonitor_ipc__get_state();
>> +			if (s == IPC_STATE__LISTENING)
>> +				return 0;
>> +
>> +			time(&now);
>> +			if (now > time_limit)
>> +				return error(_("fsmonitor--daemon not online yet"));
>> +		} else if (pid_seen == pid_child) {
>> +			/*
>> +			 * The new child daemon process shutdown while
>> +			 * it was starting up, so it is not listening
>> +			 * on the socket.
>> +			 *
>> +			 * Try to ping the socket in the odd chance
>> +			 * that another daemon started (or was already
>> +			 * running) while our child was starting.
>> +			 *
>> +			 * Again, we don't care who services the socket.
>> +			 */
>> +			s = fsmonitor_ipc__get_state();
>> +			if (s == IPC_STATE__LISTENING)
>> +				return 0;
>> +
>> +			/*
>> +			 * We don't care about the WEXITSTATUS() nor
>> +			 * any of the WIF*(status) values because
>> +			 * `cmd_fsmonitor__daemon()` does the `!!result`
>> +			 * trick on all function return values.
>> +			 *
>> +			 * So it is sufficient to just report the
>> +			 * early shutdown as an error.
>> +			 */
>> +			return error(_("fsmonitor--daemon failed to start"));
>> +		} else
>> +			return error(_("waitpid is confused"));
>> +	}
>> +}
> 
> Ditto this. could we extend the wait_or_whine() function (or some
> extended version thereof) to do what you need with callbacks?
> 
> It seems the main difference is just being able to pass down a flag for
> waitpid(), and the loop needing to check EINTR or not depending on
> whether WNOHANG is passed.
> 
> For e.g. the "We don't care about the WEXITSTATUS()" you'd get that
> behavior with an adjusted wait_or_whine(). Wouldn't it be better to
> report what exit status it exits with e.g. if the top-level process is
> signalled? We do so in trace2 for other things we spawn...
> 

Again, I don't want to mix my usage here with the existing code
and destabilize all existing callers.  Here we are spinning to give
the child a chance to *start* and confirm that it is in a listening
state and ready for connections.  We do not wait for the child to
exit (unless it dies quickly without becoming ready).

We want to end our wait as soon as we confirm that the child is
ready and return.  All I really need from the system is `waitpid()`.

Also, since we started the child in my `spawn_background...()`, it
is not in the `children_to_clean` list, so there is no need to mess
with that.

So I'd like to leave this as is.

Jeff
