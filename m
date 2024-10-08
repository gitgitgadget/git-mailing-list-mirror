Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A01CDFDA
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376431; cv=none; b=mL9hkTdaayBPwDl2mokxdWuI3qfChjHuw3KOXpXaqPk2n97eEdcXT0l421eYHRfZcbfj29S1so5yCF1zZLumFVnJV16LsZVWF3ScYr9tS1k7JxRw/Lfx/VrXtkTFoNzv8i18w35DECLZkC6nx2pczcqcc3Rc5tbwVd9PqBnMv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376431; c=relaxed/simple;
	bh=xIYSBvmsBjjFey2cWpyRpdlWlpyr+yPeObaeRXwCFnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWEObssXAGSizYmpckq6URWfbyyVOQ4H915AftA0mz/XHnXc1am0qVuck2lUaLbfMEl8ZkwK21+yXTll3zvf+NYoxlcsG4+UY2HdoOOTaC736gxyBKjBtH5ml72nDAF2OUBwXRObRsdbGG7Y71485DvUGwOVoVbMrBxkub72TZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SsXNVNcr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SsXNVNcr"
Received: (qmail 9579 invoked by uid 109); 8 Oct 2024 08:33:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xIYSBvmsBjjFey2cWpyRpdlWlpyr+yPeObaeRXwCFnw=; b=SsXNVNcrpdo1z7hiRlj2mNkAIV9x9yM0Iu4KFIUFhBwTlFS78y5gCcLOlYIw/qZ+XUbfJmfByOFo/Oiwdg9ZGPQFgohcoDCgVtgYUvNLdKoQJ4S+48KICCnDlX4fd8HyycCWPV42/B5y0GpmnukINovBJuhm8Tabk7VYneWg0Z5TjnQebmJAGPORKyfcBILEtkr4VrBw4JXGvu9aUmiqdijzku9Zb+JwAAUu5UwRywEbqG0h36AHjhyFy52VtWPO2mN5JvcCffOJARwi2abHn59Q5lq9wJoPQ0dcmEadAMralDdrUbDaJsXlgJGxO5jJwWr3czCRRBxJWjDlDttXtg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Oct 2024 08:33:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15767 invoked by uid 111); 8 Oct 2024 08:33:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Oct 2024 04:33:48 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 8 Oct 2024 04:33:47 -0400
From: Jeff King <peff@peff.net>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH 1/2] simple-ipc: split async server initialization and running
Message-ID: <20241008083347.GA1210958@coredump.intra.peff.net>
References: <20241008083121.GA676391@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008083121.GA676391@coredump.intra.peff.net>

To start an async ipc server, you call ipc_server_run_async(). That
initializes the ipc_server_data object, and starts all of the threads
running, which may immediately start serving clients.

This can create some awkward timing problems, though. In the fsmonitor
daemon (the sole user of the simple-ipc system), we want to create the
ipc server early in the process, which means we may start serving
clients before the rest of the daemon is fully initialized.

To solve this, let's break run_async() into two parts: an initialization
which allocates all data and spawns the threads (without letting them
run), and a start function which actually lets them begin work. Since we
have two simple-ipc implementations, we have to handle this twice:

  - in ipc-unix-socket.c, we have a central listener thread which hands
    connections off to worker threads using a work_available mutex. We
    can hold that mutex after init, and release it when we're ready to
    start.

    We do need an extra "started" flag so that we know whether the main
    thread is holding the mutex or not (e.g., if we prematurely stop the
    server, we want to make sure all of the worker threads are released
    to hear about the shutdown).

  - in ipc-win32.c, we don't have a central mutex. So we'll introduce a
    new startup_barrier mutex, which we'll similarly hold until we're
    ready to let the threads proceed.

    We again need a "started" flag here to make sure that we release the
    barrier mutex when shutting down, so that the sub-threads can
    proceed to the finish.

I've renamed the run_async() function to init_async() to make sure we
catch all callers, since they'll now need to call the matching
start_async().

We could leave run_async() as a wrapper that does both, but there's not
much point. There are only two callers, one of which is fsmonitor, which
will want to actually do work between the two calls. And the other is
just a test-tool wrapper.

For now I've added the start_async() calls in fsmonitor where they would
otherwise have happened, so there should be no behavior change with this
patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsmonitor--daemon.c         |  8 +++--
 compat/simple-ipc/ipc-shared.c      |  5 +--
 compat/simple-ipc/ipc-unix-socket.c | 28 ++++++++++++++---
 compat/simple-ipc/ipc-win32.c       | 48 ++++++++++++++++++++++++++---
 simple-ipc.h                        | 17 +++++++---
 5 files changed, 88 insertions(+), 18 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index e1e6b96d09..4a077810d0 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1208,13 +1208,15 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	 * system event listener thread so that we have the IPC handle
 	 * before we need it.
 	 */
-	if (ipc_server_run_async(&state->ipc_server_data,
-				 state->path_ipc.buf, &ipc_opts,
-				 handle_client, state))
+	if (ipc_server_init_async(&state->ipc_server_data,
+				  state->path_ipc.buf, &ipc_opts,
+				  handle_client, state))
 		return error_errno(
 			_("could not start IPC thread pool on '%s'"),
 			state->path_ipc.buf);
 
+	ipc_server_start_async(&state->ipc_server_data);
+
 	/*
 	 * Start the fsmonitor listener thread to collect filesystem
 	 * events.
diff --git a/compat/simple-ipc/ipc-shared.c b/compat/simple-ipc/ipc-shared.c
index cb176d966f..d1c21b49bd 100644
--- a/compat/simple-ipc/ipc-shared.c
+++ b/compat/simple-ipc/ipc-shared.c
@@ -16,11 +16,12 @@ int ipc_server_run(const char *path, const struct ipc_server_opts *opts,
 	struct ipc_server_data *server_data = NULL;
 	int ret;
 
-	ret = ipc_server_run_async(&server_data, path, opts,
-				   application_cb, application_data);
+	ret = ipc_server_init_async(&server_data, path, opts,
+				    application_cb, application_data);
 	if (ret)
 		return ret;
 
+	ipc_server_start_async(server_data);
 	ret = ipc_server_await(server_data);
 
 	ipc_server_free(server_data);
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 9b3f2cdf8c..57d919c6b4 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -328,6 +328,7 @@ struct ipc_server_data {
 	int back_pos;
 	int front_pos;
 
+	int started;
 	int shutdown_requested;
 	int is_stopped;
 };
@@ -824,10 +825,10 @@ static int setup_listener_socket(
 /*
  * Start IPC server in a pool of background threads.
  */
-int ipc_server_run_async(struct ipc_server_data **returned_server_data,
-			 const char *path, const struct ipc_server_opts *opts,
-			 ipc_server_application_cb *application_cb,
-			 void *application_data)
+int ipc_server_init_async(struct ipc_server_data **returned_server_data,
+			  const char *path, const struct ipc_server_opts *opts,
+			  ipc_server_application_cb *application_cb,
+			  void *application_data)
 {
 	struct unix_ss_socket *server_socket = NULL;
 	struct ipc_server_data *server_data;
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
 
+void ipc_server_start_async(struct ipc_server_data *server_data)
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
+	if (server_data->started)
+		pthread_mutex_lock(&server_data->work_available_mutex);
 
 	server_data->shutdown_requested = 1;
 
diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 8bfe51248e..a8fc812adf 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -371,6 +371,9 @@ struct ipc_server_data {
 	HANDLE hEventStopRequested;
 	struct ipc_server_thread_data *thread_list;
 	int is_stopped;
+
+	pthread_mutex_t startup_barrier;
+	int started;
 };
 
 enum connect_result {
@@ -526,6 +529,16 @@ static int use_connection(struct ipc_server_thread_data *server_thread_data)
 	return ret;
 }
 
+static void wait_for_startup_barrier(struct ipc_server_data *server_data)
+{
+	/*
+	 * Temporarily hold the startup_barrier mutex before starting,
+	 * which lets us know that it's OK to start serving requests.
+	 */
+	pthread_mutex_lock(&server_data->startup_barrier);
+	pthread_mutex_unlock(&server_data->startup_barrier);
+}
+
 /*
  * Thread proc for an IPC server worker thread.  It handles a series of
  * connections from clients.  It cleans and reuses the hPipe between each
@@ -550,6 +563,8 @@ static void *server_thread_proc(void *_server_thread_data)
 	memset(&oConnect, 0, sizeof(oConnect));
 	oConnect.hEvent = hEventConnected;
 
+	wait_for_startup_barrier(server_thread_data->server_data);
+
 	for (;;) {
 		cr = wait_for_connection(server_thread_data, &oConnect);
 
@@ -752,10 +767,10 @@ static HANDLE create_new_pipe(wchar_t *wpath, int is_first)
 	return hPipe;
 }
 
-int ipc_server_run_async(struct ipc_server_data **returned_server_data,
-			 const char *path, const struct ipc_server_opts *opts,
-			 ipc_server_application_cb *application_cb,
-			 void *application_data)
+int ipc_server_init_async(struct ipc_server_data **returned_server_data,
+			  const char *path, const struct ipc_server_opts *opts,
+			  ipc_server_application_cb *application_cb,
+			  void *application_data)
 {
 	struct ipc_server_data *server_data;
 	wchar_t wpath[MAX_PATH];
@@ -787,6 +802,13 @@ int ipc_server_run_async(struct ipc_server_data **returned_server_data,
 	strbuf_addstr(&server_data->buf_path, path);
 	wcscpy(server_data->wpath, wpath);
 
+	/*
+	 * Hold the startup_barrier lock so that no threads will progress
+	 * until ipc_server_start_async() is called.
+	 */
+	pthread_mutex_init(&server_data->startup_barrier, NULL);
+	pthread_mutex_lock(&server_data->startup_barrier);
+
 	if (nr_threads < 1)
 		nr_threads = 1;
 
@@ -837,6 +859,15 @@ int ipc_server_run_async(struct ipc_server_data **returned_server_data,
 	return 0;
 }
 
+void ipc_server_start_async(struct ipc_server_data *server_data)
+{
+	if (!server_data || server_data->started)
+		return;
+
+	server_data->started = 1;
+	pthread_mutex_unlock(&server_data->startup_barrier);
+}
+
 int ipc_server_stop_async(struct ipc_server_data *server_data)
 {
 	if (!server_data)
@@ -850,6 +881,13 @@ int ipc_server_stop_async(struct ipc_server_data *server_data)
 	 * We DO NOT attempt to force them to drop an active connection.
 	 */
 	SetEvent(server_data->hEventStopRequested);
+
+	/*
+	 * If we haven't yet told the threads they are allowed to run,
+	 * do so now, so they can receive the shutdown event.
+	 */
+	ipc_server_start_async(server_data);
+
 	return 0;
 }
 
@@ -900,5 +938,7 @@ void ipc_server_free(struct ipc_server_data *server_data)
 		free(std);
 	}
 
+	pthread_mutex_destroy(&server_data->startup_barrier);
+
 	free(server_data);
 }
diff --git a/simple-ipc.h b/simple-ipc.h
index a849d9f841..3916eaf70d 100644
--- a/simple-ipc.h
+++ b/simple-ipc.h
@@ -179,11 +179,20 @@ struct ipc_server_opts
  * When a client IPC message is received, the `application_cb` will be
  * called (possibly on a random thread) to handle the message and
  * optionally compose a reply message.
+ *
+ * This initializes all threads but no actual work will be done until
+ * ipc_server_start_async() is called.
+ */
+int ipc_server_init_async(struct ipc_server_data **returned_server_data,
+			  const char *path, const struct ipc_server_opts *opts,
+			  ipc_server_application_cb *application_cb,
+			  void *application_data);
+
+/*
+ * Let an async server start running. This needs to be called only once
+ * after initialization.
  */
-int ipc_server_run_async(struct ipc_server_data **returned_server_data,
-			 const char *path, const struct ipc_server_opts *opts,
-			 ipc_server_application_cb *application_cb,
-			 void *application_data);
+void ipc_server_start_async(struct ipc_server_data *server_data);
 
 /*
  * Gently signal the IPC server pool to shutdown.  No new client
-- 
2.47.0.427.g067ae60d0d

