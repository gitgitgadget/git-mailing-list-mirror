Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0E155A24
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376577; cv=none; b=FBmBIkwxSi0QKqY8jP4T6mrVz/iERr/zvIWt2OvPuYWHuQPwpv7lduEKXnlmGSz5xOLSCgWQ4HvpMbPbBzS85srxR9hLjQtZAC0NopaVscX6/jf+g3Qwhti9YJ3/xkcasmToJKZmPZ9bg/H5+7sbFO4uo1A1pouW4F9jGld5TTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376577; c=relaxed/simple;
	bh=XCfLSQkMhGk8UF9LguP26pdHf2GUmt+QMQt4RSOb6Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiwwNuwwOpYuRzyt8e1I6CUIO5fVKt6xEkiYQTbtBnEIF7U+6fOSgU9cqqJqlYMh3pP7A9vm+LSgX40Qc43EZxk+CIcsrLsOD1P0C3ITn0496gAj0X/DYqOhpVB6Dht1OXcjMZhCrO8niD0WUpPGCUm3RXyuhjW/yP6I4xgGPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iO56fmeI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iO56fmeI"
Received: (qmail 9596 invoked by uid 109); 8 Oct 2024 08:36:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XCfLSQkMhGk8UF9LguP26pdHf2GUmt+QMQt4RSOb6Ew=; b=iO56fmeIwJLEPgFiGjyiFhQCwN/NuXJLlfNaCOyM11Aww8TS+skkHXnl5vOtB5mjrM1IDqQYu1SDBr+AHNPNzZgxE7ATrKuBpUVS1xrhBabE6dO6HCEnRjpMUvbqZs32MUzPrYaEWHrg7RPsdQLTqzq05BWc91C0/iJ1MW6VSawBNREBOnnU9yMv6FAZTSbL67/kTbe4yilNWXUbMDlNLrjW006LCHcQH94ZcVcBH2HPTsb0kC0GCwxCuxHBwztCCB+PNruXg3mpFVMJFkP+n61ZrXOJzNOa+ojCHQNDL+56nuevfHMuE05XtxJhTk7UsVQGhttIHy4/z/OwsCm3iA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Oct 2024 08:36:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15806 invoked by uid 111); 8 Oct 2024 08:36:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Oct 2024 04:36:14 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 8 Oct 2024 04:36:13 -0400
From: Jeff King <peff@peff.net>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH 2/2] fsmonitor: initialize fs event listener before accepting
 clients
Message-ID: <20241008083613.GB1210958@coredump.intra.peff.net>
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

There's a racy hang in fsmonitor on macOS that we sometimes see in CI.
When we serve a client, what's supposed to happen is:

  1. The client thread calls with_lock__wait_for_cookie() in which we
     create a cookie file and then wait for a pthread_cond event

  2. The filesystem event listener sees the cookie file creation, does
     some internal book-keeping, and then triggers the pthread_cond.

But there's a problem: we start the listener that accepts client threads
before we start the fs event thread. So it's possible for us to accept a
client which creates the cookie file and starts waiting before the fs
event thread is initialized, and we miss those filesystem events
entirely. That leaves the client thread hanging forever.

In CI, the symptom is that t9210 (which is testing scalar, which always
enables fsmonitor under the hood) may hang forever in "scalar clone". It
is waiting on "git fetch" which is waiting on the fsmonitor daemon.

The race happens more frequently under load, but you can trigger it
predictably with a sleep like this, which delays the start of the fs
event thread:

  --- a/compat/fsmonitor/fsm-listen-darwin.c
  +++ b/compat/fsmonitor/fsm-listen-darwin.c
  @@ -510,6 +510,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
          FSEventStreamSetDispatchQueue(data->stream, data->dq);
          data->stream_scheduled = 1;

  +       sleep(1);
          if (!FSEventStreamStart(data->stream)) {
                  error(_("Failed to start the FSEventStream"));
                  goto force_error_stop_without_loop;

One solution might be to reverse the order of initialization: start the
fs event thread before we start the thread listening for clients. But
the fsmonitor code explicitly does it in the opposite direction. The fs
event thread wants to refer to the ipc_server_data struct, so we need it
to be initialized first.

A further complication is that we need a signal from the fs event thread
that it is actually ready and listening. And those details happen within
backend-specific fsmonitor code, whereas the initialization is in the
shared code.

So instead, let's use the ipc_server init/start split added in the
previous commit. The generic fsmonitor code will init the ipc_server but
_not_ start it, leaving that to the backend specific code, which now
needs to call ipc_server_start_async() at the right time.

For macOS, that is right after we start the FSEventStream that you can
see in the diff above.

It's not clear to me if Windows suffers from the same problem (and we
simply don't trigger it in CI), or if it is immune. Regardless, the
obvious place to start accepting clients there is right after we've
established the ReadDirectoryChanges watch.

This makes the hangs go away in our macOS CI environment, even when
compiled with the sleep() above.

Helped-by: Koji Nakamaru <koji.nakamaru@gree.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsmonitor--daemon.c          | 2 --
 compat/fsmonitor/fsm-listen-darwin.c | 6 ++++++
 compat/fsmonitor/fsm-listen-win32.c  | 6 ++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 4a077810d0..f3f6bd330b 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1215,8 +1215,6 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 			_("could not start IPC thread pool on '%s'"),
 			state->path_ipc.buf);
 
-	ipc_server_start_async(&state->ipc_server_data);
-
 	/*
 	 * Start the fsmonitor listener thread to collect filesystem
 	 * events.
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 2fc67442eb..dfa551459d 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -516,6 +516,12 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	}
 	data->stream_started = 1;
 
+	/*
+	 * Our fs event listener is now running, so it's safe to start
+	 * serving client requests.
+	 */
+	ipc_server_start_async(state->ipc_server_data);
+
 	pthread_mutex_lock(&data->dq_lock);
 	pthread_cond_wait(&data->dq_finished, &data->dq_lock);
 	pthread_mutex_unlock(&data->dq_lock);
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 5a21dade7b..80e092b511 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -741,6 +741,12 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	    start_rdcw_watch(data->watch_gitdir) == -1)
 		goto force_error_stop;
 
+	/*
+	 * Now that we've established the rdcw watches, we can start
+	 * serving clients.
+	 */
+	ipc_server_start_async(state->ipc_server_data);
+
 	for (;;) {
 		dwWait = WaitForMultipleObjects(data->nr_listener_handles,
 						data->hListener,
-- 
2.47.0.427.g067ae60d0d
