Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0BC3A8F0
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 05:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280714; cv=none; b=HrfZ8enmWf/T49gpPGA5hLj0eNZ/Gk5bAkB36x6iWu+K9sw57FDWK6MQU3qEImV6HyObrFwemJHubXTcNSPU3TmzR6y4W6Qs7dYfDAIrxkNueL4FkjafI8fX28tN0oePF1LL7vtXm6kr2AbczY0jY//lIwsoe5l48nLxwO2ZO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280714; c=relaxed/simple;
	bh=67a0/KHO72YZptSwmsHp+E+qmteUNmYrDCPLWpdPS6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwSq1CDdLv7VtHJn00ueHRyjS27RWJ69iVQAsIX+gPJ4AfxKuJq4+9ZXGztlcXAovNgtZErXxOd3X1PIgGz0ju4bbbrQ2wzZKO3ZXWFqf8Z8j2Q1w0WyLTC67+Ztgnx7IJEUqhG0HQ0BUirUJIBkqJ6BGUfMfJYnnvyPNuZgi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=atJ0vPhv; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="atJ0vPhv"
Received: (qmail 31485 invoked by uid 109); 7 Oct 2024 05:58:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=67a0/KHO72YZptSwmsHp+E+qmteUNmYrDCPLWpdPS6U=; b=atJ0vPhvl7SMAQDw3nu853gD9Xv4t3GZPO9rAT2Rd1tYv9jvk6TYOv3KqUi81N3pLCUV21h3S4YsMKr71ANPdwflBmEIPrv3P8CTxcsm8GTwwMYfvXAM09xhyUv4zPDXB7f4CN5iVglfD4UdCNkLlPIMidrkXyHqjlk5gU26cvMhXIq9e93ggMBf6Yq09Yq0yLfRpzgJkb8VAr8vQBZJhafQ8xXP4gGb9a8UV82jzCQx1MFgWdE9rAA8J+xStQUR6P6uRlsqdRuxzoIW1/0xg/oBdA2fnSoEznRjF2r0qf3DVnTUlBNbUP+dfcnTWGDwH3v7pbRWqjzyS+/axfC50A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Oct 2024 05:58:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3387 invoked by uid 111); 7 Oct 2024 05:58:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Oct 2024 01:58:22 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 7 Oct 2024 01:58:21 -0400
From: Jeff King <peff@peff.net>
To: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] fsmonitor: fix hangs by delayed fs event listening
Message-ID: <20241007055821.GA34037@coredump.intra.peff.net>
References: <pull.1804.git.1727862424713.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1804.git.1727862424713.gitgitgadget@gmail.com>

On Wed, Oct 02, 2024 at 09:47:04AM +0000, Koji Nakamaru via GitGitGadget wrote:

> From: Koji Nakamaru <koji.nakamaru@gree.net>
> 
> The thread serving the client (ipc-thread) calls
> with_lock__wait_for_cookie() in which a cookie file is
> created. with_lock__wait_for_cookie() then waits for the event caused by
> the cookie file from the thread for fs events (fsevent-thread).
> 
> However, in high load situations, the fsevent-thread may start actual fs
> event listening (triggered by FSEventStreamStart() for Darwin, for
> example) *after* the cookie file is created. In this case, the
> fsevent-thread cannot detect the cookie file and
> with_lock__wait_for_cookie() waits forever, so that the whole daemon
> hangs [1].

First off, thank you for looking into this. I _think_ what you have here
would work, but I had envisioned something a little different. So let me
first try to walk through your solution...

> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index dce8a3b2482..ccff2cb8bed 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -172,6 +172,9 @@ static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
>  	trace_printf_key(&trace_fsmonitor, "cookie-wait: '%s' '%s'",
>  			 cookie->name, cookie_pathname.buf);
>  
> +	while (fsmonitor_get_listen_error_code(state) == 0)
> +		sleep_millisec(50);
> +
>  	/*
>  	 * Create the cookie file on disk and then wait for a notification
>  	 * that the listener thread has seen it.

OK, so here we're going to basically busy-wait for the error code value
to become non-zero.

That happens in a thread-safe way inside our helper function, and the
matching thread-safe set() is called here:

> diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
> index 2fc67442eb5..92373ce247f 100644
> --- a/compat/fsmonitor/fsm-listen-darwin.c
> +++ b/compat/fsmonitor/fsm-listen-darwin.c
> @@ -515,6 +515,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
>  		goto force_error_stop_without_loop;
>  	}
>  	data->stream_started = 1;
> +	fsmonitor_set_listen_error_code(state, 1);
>  
>  	pthread_mutex_lock(&data->dq_lock);
>  	pthread_cond_wait(&data->dq_finished, &data->dq_lock);

which then releases all of the waiting clients to start working.

They'd similarly be released on errors such as this one:

> @@ -522,7 +523,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
>  
>  	switch (data->shutdown_style) {
>  	case FORCE_ERROR_STOP:
> -		state->listen_error_code = -1;
> +		fsmonitor_set_listen_error_code(state, -1);
>  		/* fall thru */
>  	case FORCE_SHUTDOWN:
>  		ipc_server_stop_async(state->ipc_server_data);

There's some risk that we'd have a code path fails to set the listen
code, in which case our clients might spin forever. But from a cursory
look, I think you've got all spots.

I think your patch has one small bug, which is that you don't
pthread_mutex_destroy() at the end of fsmonitor_run_daemon(). But other
than that I think it should work OK (I haven't tried it in practice yet;
I assume you did?).

My two small-ish complaints are:

  - busy-waiting feels a bit hacky. I think it's not too bad here
    because it only happens during startup (and even then only if we get
    a request) because after that the listen code will already be set to
    "1".

  - the check for the listen code is in the wait_for_cookie() function.
    So even after we've started up, we'll still keep taking a lock to
    check it for every such request. I guess it probably isn't much
    overhead in practice, though.

But what I had envisioned instead was teaching the ipc_server code to
let us control when it starts actually running. We can do that by
holding the existing work lock, and letting the callers (in this case,
the individual fsm backends) tell it when to start operating.

And then we are not introducing a new lock, but rather relying on the
existing lock-checks for getting work to do. So there's no busy-wait.
And after the startup sequence finishes, there are no additional lock
checks.

The patch below implements that. The only complication is that we have
to keep a "started" flag to avoid double-locking during an early
shutdown. Access to the "started" flag is not thread-safe, but I think
that's OK. Until we've started the clients, only the main thread would
do either a start or shutdown operation.

So I dunno. Both solutions have their own little warts, I suppose, and
I'm not sure if one is vastly better than the other.

---
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 2fc67442eb..17d0b426e3 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -516,6 +516,12 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	}
 	data->stream_started = 1;
 
+	/*
+	 * Our fs event listener is now running, so it's safe to start
+	 * serving client requests.
+	 */
+	ipc_server_start(state->ipc_server_data);
+
 	pthread_mutex_lock(&data->dq_lock);
 	pthread_cond_wait(&data->dq_finished, &data->dq_lock);
 	pthread_mutex_unlock(&data->dq_lock);
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 5a21dade7b..d9a02bc989 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -741,6 +741,8 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	    start_rdcw_watch(data->watch_gitdir) == -1)
 		goto force_error_stop;
 
+	ipc_server_start(state->ipc_server_data);
+
 	for (;;) {
 		dwWait = WaitForMultipleObjects(data->nr_listener_handles,
 						data->hListener,
diff --git a/compat/simple-ipc/ipc-shared.c b/compat/simple-ipc/ipc-shared.c
index cb176d966f..603b60403b 100644
--- a/compat/simple-ipc/ipc-shared.c
+++ b/compat/simple-ipc/ipc-shared.c
@@ -21,6 +21,7 @@ int ipc_server_run(const char *path, const struct ipc_server_opts *opts,
 	if (ret)
 		return ret;
 
+	ipc_server_start(server_data);
 	ret = ipc_server_await(server_data);
 
 	ipc_server_free(server_data);
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 9b3f2cdf8c..9a2e93cff5 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -328,6 +328,7 @@ struct ipc_server_data {
 	int back_pos;
 	int front_pos;
 
+	int started;
 	int shutdown_requested;
 	int is_stopped;
 };
@@ -888,6 +889,12 @@ int ipc_server_run_async(struct ipc_server_data **returned_server_data,
 	server_data->accept_thread->fd_send_shutdown = sv[0];
 	server_data->accept_thread->fd_wait_shutdown = sv[1];
 
+	/*
+	 * Hold work-available mutex so that no work can start until
+	 * we unlock it.
+	 */
+	pthread_mutex_lock(&server_data->work_available_mutex);
+
 	if (pthread_create(&server_data->accept_thread->pthread_id, NULL,
 			   accept_thread_proc, server_data->accept_thread))
 		die_errno(_("could not start accept_thread '%s'"), path);
@@ -918,6 +925,15 @@ int ipc_server_run_async(struct ipc_server_data **returned_server_data,
 	return 0;
 }
 
+void ipc_server_start(struct ipc_server_data *server_data)
+{
+	if (!server_data || server_data->started)
+		return;
+
+	server_data->started = 1;
+	pthread_mutex_unlock(&server_data->work_available_mutex);
+}
+
 /*
  * Gently tell the IPC server treads to shutdown.
  * Can be run on any thread.
@@ -933,7 +949,9 @@ int ipc_server_stop_async(struct ipc_server_data *server_data)
 
 	trace2_region_enter("ipc-server", "server-stop-async", NULL);
 
-	pthread_mutex_lock(&server_data->work_available_mutex);
+	/* If we haven't started yet, we are already holding lock. */
+	if (!server_data->started)
+		pthread_mutex_lock(&server_data->work_available_mutex);
 
 	server_data->shutdown_requested = 1;
 
diff --git a/simple-ipc.h b/simple-ipc.h
index a849d9f841..764bf7a309 100644
--- a/simple-ipc.h
+++ b/simple-ipc.h
@@ -179,12 +179,21 @@ struct ipc_server_opts
  * When a client IPC message is received, the `application_cb` will be
  * called (possibly on a random thread) to handle the message and
  * optionally compose a reply message.
+ *
+ * This initializes all threads but no actual work will be done until
+ * ipc_server_start() is called.
  */
 int ipc_server_run_async(struct ipc_server_data **returned_server_data,
 			 const char *path, const struct ipc_server_opts *opts,
 			 ipc_server_application_cb *application_cb,
 			 void *application_data);
 
+/*
+ * Let an async server start running. This needs to be called only once
+ * after initialization.
+ */
+void ipc_server_start(struct ipc_server_data *server_data);
+
 /*
  * Gently signal the IPC server pool to shutdown.  No new client
  * connections will be accepted, but existing connections will be

