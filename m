Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB5D1805E
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850343; cv=none; b=iNpLJ03wuPop0MUwiEbz+BZ+0H6HRt9zO3yLFiA+Au7+bd7UHhv7m1KrnJBVuyOrzpHxduE3EaUdEKPHtx1HPRpOTE4hitt5dG+0zu9gNHwH+9C0HYBByB+s+Gd2Dzb/6zFqMW/HfTmGbPuL0pSD8qox7TO7OXhQxnPzI2tNXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850343; c=relaxed/simple;
	bh=m3qMCKDqz5PeDiP3uTLg1Qe0k2Uczrls+pHFfU1XqMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fngopsnrj5z8RHDOVm5gMhcVuVHPaEQZLjC8TIxT6OzcdV6QSq6mOgEMFKmoLa+a4klvh3MILQsjtdw8QU76mPmfQ265S8XrmiX887JKZCsluthRn2gPmkcdcpm4O+k2cj7KEet3ny1WdzJEogzoJqu9PKyWIEiQPOsN7Or4oaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bRAombLP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bRAombLP"
Received: (qmail 2508 invoked by uid 109); 2 Oct 2024 06:25:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=m3qMCKDqz5PeDiP3uTLg1Qe0k2Uczrls+pHFfU1XqMg=; b=bRAombLPc1sBJN+Rv37dmYy5eIE0EBcfNuEXKS1P93Y885M0pyH9nxXgQrnJFkHJeiFuQANxs874zk4vjveWaG7N7BRSuVfVv7hhRrrV3WCNytkJjpAQVw+DLLIW/x675FNpBVh4I4jQlUXb6XTGSmAQtQZfSA+51baWCgef8HUfVtr3PlXwtJ9vqMmgCX4UJ0/QpfAXZg/ZnHaTNJiTH76sNjZ2dQik1j0klyyuJMHqzUdyM5+bDJdkbTFNLwEh6+Vv1gfmXTSy2nHgwSunnhCQ6rVUDtIlfd707ZUw3/fbY6K6K97CmXugmoTwLYXd18xyElgHn76urT2gzbja5Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Oct 2024 06:25:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1569 invoked by uid 111); 2 Oct 2024 06:25:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2024 02:25:39 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Oct 2024 02:25:39 -0400
From: Jeff King <peff@peff.net>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fsmonitor deadlock / macOS CI hangs
Message-ID: <20241002062539.GA2863841@coredump.intra.peff.net>
References: <20240930194600.GA1805534@coredump.intra.peff.net>
 <CAOTNsDykrEBGBnQJqmCghWBTgzirxHZQM25ohsCBysp8ZO1qLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOTNsDykrEBGBnQJqmCghWBTgzirxHZQM25ohsCBysp8ZO1qLg@mail.gmail.com>

On Wed, Oct 02, 2024 at 10:46:03AM +0900, Koji Nakamaru wrote:

> Perhaps I found the cause. fsmonitor_run_daemon_1() starts the fsevent
> Normally FSEventStreamStart() is called before
> with_lock__wait_for_cookie() creates a cookie file, but this is not
> guaranteed. We can reproduce the issue easily if we modify
> fsm_listen__loop() as below:
> 
>   --- a/compat/fsmonitor/fsm-listen-darwin.c
>   +++ b/compat/fsmonitor/fsm-listen-darwin.c
>   @@ -510,6 +510,7 @@ void fsm_listen__loop(struct
> fsmonitor_daemon_state *state)
>           FSEventStreamSetDispatchQueue(data->stream, data->dq);
>           data->stream_scheduled = 1;
> 
>   +       sleep(1);
>           if (!FSEventStreamStart(data->stream)) {
>                   error(_("Failed to start the FSEventStream"));
>                   goto force_error_stop_without_loop;

Ah, good catch. Yes, with that sleep it is much easier to create the
situation in the debugger.

So if I understand (and bear with me if you already know this, but I am
just figuring out how fsmonitor is supposed to work), the expected
order of events is:

  - the thread serving the client creates a cookie file (something like
    ".git/fsmonitor--daemon/cookies/1234-0", based on the pid) and then
    waits for the pthread_cond to be triggered

  - the thread listening for fs events should see that cookie file
    creation, which gets us to with_lock__mark_cookies_seen(), which
    then triggers the cond

But with the sleep, the file creation event happens before the fs event
is actually listening, so we never hear it. We can "unstick" it by
doing:

  # where "1234-0" is the unique cookie file, which you can get by
  # looking at the output from GIT_TRACE_FSMONITOR=1
  echo foo >trash directory.t9211-scalar-clone/cloned/src/.git/fsmonitor--daemon/cookies/1234-0

which then triggers us to mark the cookies seen. I have no clue why
there is this elaborate communication for two threads which are already
sharing a memory space, but let's assume for a moment that it's
required.

The solution then is to avoid letting any client threads run (or at
least create cookies) until we know we're listening for fs events.
Naively I would say we should just have the fs event thread signal us
that it's ready before we spawn any of the client threads. But it looks
like we explicitly start those threads first in fsmonitor_run_daemon_1():

       /*
         * Start the IPC thread pool before the we've started the file
         * system event listener thread so that we have the IPC handle
         * before we need it.
         */
        if (ipc_server_run_async(&state->ipc_server_data,
                                 state->path_ipc.buf, &ipc_opts,
                                 handle_client, state))
                return error_errno(
                        _("could not start IPC thread pool on '%s'"),
                        state->path_ipc.buf);

So I guess we need to let the ipc server initialize itself and then wait
to be told to start serving requests. And then the fs event thread can
trigger that "go ahead" once the fs event stream is started. Which is a
little tricky, but possible with an extra mutex.

But hmm. I wonder if we can hack around it like this:

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 2fc6744..6b06faf 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -510,11 +510,17 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
	FSEventStreamSetDispatchQueue(data->stream, data->dq);
	data->stream_scheduled = 1;

+	sleep(1);
	if (!FSEventStreamStart(data->stream)) {
		error(_("Failed to start the FSEventStream"));
		goto force_error_stop_without_loop;
	}
	data->stream_started = 1;
+	/*
+	 * In case any clients showed up before we initialized the event stream,
+	 * abort all in-progress ops and start fresh.
+	 */
+	fsmonitor_force_resync(state);

	pthread_mutex_lock(&data->dq_lock);
	pthread_cond_wait(&data->dq_finished, &data->dq_lock);


The forced resync aborts the cookies, which triggers the waiting
clients. I'm not sure how "bad" it is to do a resync like this. It's
something that can happen in the normal course of events, so in theory
it's just non-optimal and nobody will do the wrong thing. And this would
only happen once at the start of fsmonitor, so in most cases nobody
would have connected yet, and we wouldn't have processed any events.

So I dunno. It does make the hang go away in this case.

-Peff
