Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208534A3BC
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668859; cv=none; b=Xw2YR/IA3IFacw8mMESIIf1UwINyAH2wyLael/0gHtudgOyqLOhzpm+iCN3P8Y7dIbPsrk6AZzmglUvNwrYsW1Lf8hKDN1fOaOa54jw01TBmXug7IjIudjQUhHdrEdxMRtyKYqqKseMYCKNWne3S/33Hnagqn66NCuITcB5ZElc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668859; c=relaxed/simple;
	bh=7XHF/p9gIthOMua7z9CcPcosdD4/rROKIXv4jmPq5hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7gmKUDdsEBrSqYZZB/iYUjEgI80WAzMMJVs/64f+t/xWU7brKftmJyLooHWr7rSrM2PTS/c91ZXsNki4EA5Ea7xGHU1s/NMNpPJbLT/YlZB0kQTjK2wJc/pRilZcFg2nSwJinoziLEnvAHkpwdlMu4OqVikIPxIAYdE17YeJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FEnbXfgX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FEnbXfgX"
Received: (qmail 283893 invoked by uid 106); 8 Apr 2026 17:20:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7XHF/p9gIthOMua7z9CcPcosdD4/rROKIXv4jmPq5hM=; b=FEnbXfgXCx4gKTSG1BHM6a7abY455mziV8yIJ0+3u2qdQv/BylQugGX0XzIXCn9YJUn/jlbsW4Y6fgfrpMstlGl/8oRKuuzJ5u6esrXWIAcIDT9fwsCA2grzOLtfFW/WBL4C7b1+ZBjQVMk+eCGBagWKm0+YMg0E7VVNyHcUQZdoA15V0OVzXEFkHV+hIwouEjwcjNfxNMx0e8UpW2NKVN8k5XpmvlXMk/ogu77VXucalikseeDOKP15UnJd6i89DA7BKPQRcHqwDhlOttXSR+fYDAYiJZs5ZbYBzresacE/ek5pIZf4KOX7CIkUAK/KXoOesGejgX4Gm7yr4/1kLw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Apr 2026 17:20:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 466276 invoked by uid 111); 8 Apr 2026 17:20:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2026 13:20:56 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Apr 2026 13:20:55 -0400
From: Jeff King <peff@peff.net>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
	git@vger.kernel.org
Subject: [PATCH] run_processes_parallel(): fix order of sigpipe handling
Message-ID: <20260408172055.GA2293804@coredump.intra.peff.net>
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
 <20260408052031.GB1324339@coredump.intra.peff.net>
 <xmqqpl491mfd.fsf@gitster.g>
 <87y0ix1kq4.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y0ix1kq4.fsf@collabora.com>

On Wed, Apr 08, 2026 at 07:26:59PM +0300, Adrian Ratiu wrote:

> @Peff
> 
> Please let me know if you wish me to send a patch or if you wish to send
> it yourself, since this investigation is your work & effort. :)

Here it is with a small cleanup and a real commit message.

-- >8 --
Subject: run_processes_parallel(): fix order of sigpipe handling

In commit ec0becacc9 (run-command: add stdin callback for
parallelization, 2026-01-28), we taught run_processes_parallel() to
ignore SIGPIPE, since we wouldn't want a write() to a broken pipe of one
of the children to take down the whole process.

But there's a subtle ordering issue. After we ignore SIGPIPE, we call
pp_init(), which installs its own cleanup handler for multiple signals
using sigchain_push_common(), which includes SIGPIPE. So if we receive
SIGPIPE while writing to a child, we'll trigger that handler first, pop
it off the stack, and then re-raise (which is then ignored because of
the SIG_IGN we pushed first).

But what does that handler do? It tries to clean up all of the child
processes, under the assumption that when we re-raise the signal we'll
be exiting the process!

So a hook that exits without reading all of its input will cause us to
get SIGPIPE, which will put us in a signal handler that then tries to
kill() that same child.

This seems to be mostly harmless on Linux. The process has already
exited by this point, and though kill() does not complain (since the
process has not been reaped with a wait() call), it does not affect the
exit status of the process.

However, this seems not to be true on all platforms. This case is
triggered by t5401.13, "pre-receive hook that forgets to read its
input". This test fails on NonStop since that hook was converted to the
run_processes_parallel() API.

We can fix it by reordering the code a bit. We should run pp_init()
first, and then push our SIG_IGN onto the stack afterwards, so that it
is truly ignored while feeding the sub-processes.

Note that we also reorder the popping at the end of the function, too.
This is not technically necessary, as we are doing two pops either way,
but now the pops will correctly match their pushes.

This also fixes a related case that we can't test yet. If we did have
more than one process to run, then one child causing SIGPIPE would cause
us to kill() all of the children (which might still actually be
running). But the hook API is the only user of the new feed_pipe
feature, and it does not yet support parallel hook execution. So for now
we'll always execute the processes sequentially. Once parallel hook
execution exists, we'll be able to add a test which covers this.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 32c290ee6a..574d5c40f0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1895,14 +1895,19 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 					   "max:%"PRIuMAX,
 					   (uintmax_t)opts->processes);
 
+	pp_init(&pp, opts, &pp_sig);
+
 	/*
 	 * Child tasks might receive input via stdin, terminating early (or not), so
 	 * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
 	 * actually writes the data to children stdin fds.
+	 *
+	 * This _must_ come after pp_init(), because it installs its own
+	 * SIGPIPE handler (to cleanup children), and we want to supersede
+	 * that.
 	 */
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	pp_init(&pp, opts, &pp_sig);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1928,10 +1933,10 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		}
 	}
 
-	pp_cleanup(&pp, opts);
-
 	sigchain_pop(SIGPIPE);
 
+	pp_cleanup(&pp, opts);
+
 	if (do_trace2)
 		trace2_region_leave(tr2_category, tr2_label, NULL);
 }
-- 
2.54.0.rc1.274.g1f8c576c50

