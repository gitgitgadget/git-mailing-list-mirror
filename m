Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A4719D082
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725568; cv=none; b=NG4zOMia4nr/C9nDkjxRUO39mmDXWJniB79eUIOofILrwPLxuvdshM9yaOt1A7TN0G2Y2peNpGcBQ5fAs2WG49/Lu9S8hVRCgC2h1yXWwPVLDZ6cOmv/NuPISRsDBcbuFl9jrB0sG+pY2KDbc+mhLBkBD45reXhhJD9nMw9l9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725568; c=relaxed/simple;
	bh=3Dmc0j0XmJw88vmOR1/wASvXAMG9g3h0DankyWMFjfY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LNy5LMaXNdevB1A+yaivApIlMDX1JGMSGzJeO7L4xfp8SbgiP/Llrv+oTtAyeFFZfQ1NCUhktudZX8k08mXhx4DRgXFUXYBumj/F7D/nAkY3SOix+zc3bcxgJpmlbcWW7rtgKwL0Uq7bwofJy9JSxugW7ixZkwieOQGCfjCCrfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Aq5Xce1r; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Aq5Xce1r"
Received: (qmail 6857 invoked by uid 109); 30 Sep 2024 19:46:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=3Dmc0j0XmJw88vmOR1/wASvXAMG9g3h0DankyWMFjfY=; b=Aq5Xce1rU2RNuJKVghcY18K2t0PgdbOebchOLgbDVZiiV1HSAwAv6LKquZSFgxX/TVrwlJP3dT24jzVquk8VvMUMgakvl3c3lNKrPd6oYV4BRs3SAbed/PHjcl04e5amWEVikWFP9DmAj752DLb6QcJT6Ket6sKDEPQpgjH0GIWUf+Gd/tZeYv/3F/NwZCwnFfLy2/UETzZyljBi138qg4/8mCuoMmNSv80NBDLT5V1I3Kmycn0mxyanErGxqVzK59TnrwE7T5mDwERQ8o1xmobuwNh2Za3nvNtNXrmKeWtft0Ub7Z8RGtwYW9NcGp6xpGIorVs35jSB7oko+dGyOQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Sep 2024 19:46:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17457 invoked by uid 111); 30 Sep 2024 19:46:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Sep 2024 15:46:01 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Sep 2024 15:46:00 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: fsmonitor deadlock / macOS CI hangs
Message-ID: <20240930194600.GA1805534@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I did some more digging on the hangs we sometimes see when running the
test suite on macOS. I'm cc-ing Patrick as somebody who dug into this
before, and Johannes as the only still-active person mentioned in the
relevant code.

For those just joining, you can reproduce the issue by running t9211
with --stress on macOS. Some earlier notes are here:

  https://lore.kernel.org/git/20240517081132.GA1517321@coredump.intra.peff.net/

but the gist of it is that we end up with Git processes waiting to read
from fsmonitor, but fsmonitor hanging.

Since then, I swapped out gdb for lldb, which let me see a bit more of
who is doing what.

The test is waiting on a "scalar" process to exit. But that's just in
wait_or_whine() waiting for git-fetch to exit. That git-fetch is in turn
waiting to read() from fsmonitor after sending a command. Here's the
backtrace:

    * frame #0: 0x00007ff81afdbf7e libsystem_kernel.dylib`read + 10
      frame #1: 0x000000010a4fa6ae git`xread(fd=8, buf=0x00007ff7b5d82188, len=4) at wrapper.c:231:8
      frame #2: 0x000000010a4fa8de git`read_in_full(fd=8, buf=0x00007ff7b5d82188, count=4) at wrapper.c:289:20
      frame #3: 0x000000010a417684 git`get_packet_data(fd=8, src_buf=0x0000000000000000, src_size=0x0000000000000000, dst=0x00007ff7b5d82188, size=4, options=9) at pkt-line.c:355:9
      frame #4: 0x000000010a417173 git`packet_read_with_status(fd=8, src_buffer=0x0000000000000000, src_len=0x0000000000000000, buffer="", size=65517, pktlen=0x00007ff7b5d821e4, options=9) at pkt-line.c:421:6
      frame #5: 0x000000010a4178bb git`packet_read(fd=8, buffer="", size=65517, options=9) at pkt-line.c:519:2
      frame #6: 0x000000010a417a07 git`read_packetized_to_strbuf(fd_in=8, sb_out=0x00007ff7b5d82380, options=9) at pkt-line.c:554:16
      frame #7: 0x000000010a508779 git`ipc_client_send_command_to_connection(connection=0x0000600001718000, message="1727469801286015000", message_len=19, answer=0x00007ff7b5d82380) at ipc-unix-socket.c:210:6
      frame #8: 0x000000010a377553 git`fsmonitor_ipc__send_query(since_token="1727469801286015000", answer=0x00007ff7b5d82380) at fsmonitor-ipc.c:94:9
      frame #9: 0x000000010a376149 git`refresh_fsmonitor(istate=0x0000600002910300) at fsmonitor.c:536:20
      frame #10: 0x000000010a376be7 git`add_fsmonitor(istate=0x0000600002910300) at fsmonitor.c:778:3
      frame #11: 0x000000010a376e19 git`tweak_fsmonitor(istate=0x0000600002910300) at fsmonitor.c:818:3
      frame #12: 0x000000010a430840 git`post_read_index_from(istate=0x0000600002910300) at read-cache.c:1968:2

In fsmonitor we have a bunch of threads. The main thread is waiting on
worker threads, which I think is expected:

  * thread #1, queue = 'com.apple.main-thread', stop reason = signal SIGSTOP
      frame #0: 0x00007ff81afdccce libsystem_kernel.dylib`__ulock_wait + 10
      frame #1: 0x00007ff81b01b9b9 libsystem_pthread.dylib`_pthread_join + 348
    * frame #2: 0x000000010e5ec2b1 git`ipc_server_await(server_data=0x0000600002790000) at ipc-unix-socket.c:971:2
      frame #3: 0x000000010e2d3a3f git`fsmonitor_run_daemon_1(state=0x00007ff7b1ca0420) at fsmonitor--daemon.c:1251:2
      frame #4: 0x000000010e2d35c5 git`fsmonitor_run_daemon at fsmonitor--daemon.c:1399:8

Most of the other threads are just waiting for clients:

  * thread #2
    * frame #0: 0x00007ff81afe2242 libsystem_kernel.dylib`poll + 10
      frame #1: 0x000000010e5ec664 git`accept_thread__wait_for_connection(accept_thread_data=0x000060000129c000) at ipc-unix-socket.c:653:12
      frame #2: 0x000000010e5ebf2a git`accept_thread_proc(_accept_thread_data=0x000060000129c000) at ipc-unix-socket.c:728:19
      frame #3: 0x00007ff81b01a1d3 libsystem_pthread.dylib`_pthread_start + 125
      frame #4: 0x00007ff81b015bd3 libsystem_pthread.dylib`thread_start + 15

which I think is again expected. But not this one, which should be
serving our command:

  * thread #3
    * frame #0: 0x00007ff81afde08e libsystem_kernel.dylib`__psynch_cvwait + 10
      frame #1: 0x00007ff81b01a758 libsystem_pthread.dylib`_pthread_cond_wait + 1242
      frame #2: 0x000000010e2d4a90 git`with_lock__wait_for_cookie(state=0x00007ff7b1ca0420) at fsmonitor--daemon.c:209:3
      frame #3: 0x000000010e2d40f2 git`do_handle_client(state=0x00007ff7b1ca0420, command="1727469801286015000", reply=(git`do_io_reply_callback at ipc-unix-socket.c:431), reply_data=0x0000700007d3af38) at fsmonitor--daemon.c:764:19
      frame #4: 0x000000010e2d3c60 git`handle_client(data=0x00007ff7b1ca0420, command="1727469801286015000", command_len=19, reply=(git`do_io_reply_callback at ipc-unix-socket.c:431), reply_data=0x0000700007d3af38) at fsmonitor--daemon.c:984:11
      frame #5: 0x000000010e5ecaa7 git`worker_thread__do_io(worker_thread_data=0x0000600001c9c000, fd=23) at ipc-unix-socket.c:531:9
      frame #6: 0x000000010e5ec056 git`worker_thread_proc(_worker_thread_data=0x0000600001c9c000) at ipc-unix-socket.c:605:9
      frame #7: 0x00007ff81b01a1d3 libsystem_pthread.dylib`_pthread_start + 125

We got that same command from git-fetch, but we're hanging on a pthread
operation. It's this one, and note the suspicious comment:

          /*
           * Technically, this is an infinite wait (well, unless another
           * thread sends us an abort).  I'd like to change this to
           * use `pthread_cond_timedwait()` and return an error/timeout
           * and let the caller do the trivial response thing, but we
           * don't have that routine in our thread-utils.
           *
           * After extensive beta testing I'm not really worried about
           * this.  Also note that the above open() and unlink() calls
           * will cause at least two FS events on that path, so the odds
           * of getting stuck are pretty slim.
           */
          while (cookie->result == FCIR_INIT)
                  pthread_cond_wait(&state->cookies_cond,
                                    &state->main_lock);

So we're waiting for somebody to trigger the cookies_cond. Who's
supposed to do that? It's done in fsmonitor_publish(), which is
triggered when we actually see filesystem events. The main listening
loop is also waiting on a pthread cond:

  * thread #11
    * frame #0: 0x00007ff81afde08e libsystem_kernel.dylib`__psynch_cvwait + 10
      frame #1: 0x00007ff81b01a758 libsystem_pthread.dylib`_pthread_cond_wait + 1242
      frame #2: 0x000000010e5fab6c git`fsm_listen__loop(state=0x00007ff7b1ca0420) at fsm-listen-darwin.c:520:2
      frame #3: 0x000000010e2d3d76 git`fsm_listen__thread_proc(_state=0x00007ff7b1ca0420) at fsmonitor--daemon.c:1176:2
      frame #4: 0x00007ff81b01a1d3 libsystem_pthread.dylib`_pthread_start + 125
      frame #5: 0x00007ff81b015bd3 libsystem_pthread.dylib`thread_start + 15

which is in this code:

        FSEventStreamSetDispatchQueue(data->stream, data->dq);
        data->stream_scheduled = 1;

        if (!FSEventStreamStart(data->stream)) {
                error(_("Failed to start the FSEventStream"));
                goto force_error_stop_without_loop;
        }
        data->stream_started = 1;

        pthread_mutex_lock(&data->dq_lock);
        pthread_cond_wait(&data->dq_finished, &data->dq_lock);
	pthread_mutex_unlock(&data->dq_lock);

So if I understand fsmonitor correctly, this is expected: we're waiting
for anybody to single dq_finished to tell us it's time to shut down. And
the real work is happening via that FSEventStreamStart(), which will
asynchronously trigger our callback when something happens in the
working tree.

In which case I don't see any particular deadlock. It's just that
somehow establishing our cookie-wait in the thread servicing the client
raced with there being an actual event to report.

I _think_ I un-stuck things at one point by just touching files in the
working tree, but I'm not 100% sure (I was doing a lot of things, and
it's hard to see when things got unstuck). But that would give evidence
to that line of thinking.

I notice there's a similar hang and fix here:

  https://lore.kernel.org/git/pull.1802.git.1727577690390.gitgitgadget@gmail.com/

but I don't think it's quite the same thing. In our repo there are no
submodules (in fact there are no working tree files at all!).

So I'm not sure where to go from here. It seems like a race, but if so
it happened before I attached the debugger. And I'm not at all familiar
with this code, let alone its timing assumptions. I tried turning on
trace2 logging and re-running (since there are some trace2 event calls
in the code that might help us see it more in action), but doing so
seems to make the race go away. :(

The hanging wait comes from b05880d357 (fsmonitor--daemon: use a cookie
file to sync with file system, 2022-03-25). My understanding is that the
author has retired, but Johannes is listed as a co-author. So any
insight is appreciated. :)

-Peff
