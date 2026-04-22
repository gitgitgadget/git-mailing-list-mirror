Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031CC19D89E
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776897353; cv=none; b=ra6ULmD1NTYaUFqnMmF1nIcvDc542nrJ2xExyM9oMD6vc/8A48Vhx36EKA/NYO0RG4qHrtpPqRPjR9FNRItKSmvi9Y4J5jdDxKGNtlXrRxM2QnkYBnpTTg9MM5cr5GvN1XCN2JIPnRt/HBYNo4ThZoM34ifO0FWkOgY85z1n/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776897353; c=relaxed/simple;
	bh=R5xonGVXp5UFZkXt3jRnF7DOjHZXZe/qBKdSJ8Enc2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r376Iwo4SsjEXCCZ7BPsMsFzcOfe25mORfwpOl/t4iMSfBsaMOgqQjYqdzd0+tVzTzRuMAagLALAoNtYy9fmMmpGRB6GvaWtqEbeiaLSkeogZHhCIuFxjbyQ/8F21X9hll8VZwZSrF+J2o+DgrC3BIRBtMGE/NMoj8CHX7lxoQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CkkvKuen; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CkkvKuen"
Received: (qmail 428535 invoked by uid 106); 22 Apr 2026 22:35:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=R5xonGVXp5UFZkXt3jRnF7DOjHZXZe/qBKdSJ8Enc2U=; b=CkkvKuenJWal6sdQ3C33frZCk9yzIpvw3UuaMHcXOBdJYLrp2ef0vIT9wVxHw25isyWTql01nZWkj0i6CKRNgbRq5sUdC/w1wMCUWBcZ4p4eQWH2sdKRS7xxEZbbQdX6s3EVb3BwTdcWI0SnIE4uejrEjTfj98s3PjwtIf2cuymK5EUT++4wNpAm4E3QvvCqHI08RhI3GU37lgnBWShao/2RzZYLCTpdzmVXbxj8Pukr9Vpd/Sx6X65EidH22mgCcEZZXyAGzUmTK9J2XtPJgptJY7+noiXOuBIyaboARRWiUU0TuML8WGx8rkPg+CR1NyUMOvp1YYII0xzd6LlS1Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Apr 2026 22:35:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 977454 invoked by uid 111); 22 Apr 2026 22:35:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2026 18:35:43 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 22 Apr 2026 18:35:42 -0400
From: Jeff King <peff@peff.net>
To: Jan Palus <jpalus@fastmail.com>
Cc: git@vger.kernel.org, Andrew Au <cshung@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: regression 2.54.0: test suite hangs indefinitely with mksh
Message-ID: <20260422223542.GA110382@coredump.intra.peff.net>
References: <aekVSi4iu9YLaPLQ@rock.grzadka>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aekVSi4iu9YLaPLQ@rock.grzadka>

On Wed, Apr 22, 2026 at 09:00:30PM +0200, Jan Palus wrote:

> If /bin/sh points to mksh, git's test suite hangs forever and never
> completes. An example of process tree for such hung test:
> [...]

Thanks, I can reproduce the problem easily here with mksh.

> bisect points to the following commit:
> 
> commit dd3693eb0859274d62feac8047e1d486b3beaf31 (HEAD)
> Author: Andrew Au <cshung@gmail.com>
> Date:   Thu Mar 12 22:49:37 2026
> 
>     transport-helper, connect: use clean_on_exit to reap children on abnormal exit

Yup, same here.

> From commit message alone it seems the change tries to avoid reparenting
> child processes to PID 1, however this does not seem to work for
> processes which were spawned with "sh -c".
> 
> For example if /bin/sh points to bash tests pass because bash appears to
> react to SIGTERM differently -- shell process ends but its children are
> reparented anyway.
> 
> mksh on the other hand seems to ignore SIGTERM (or queues it?) but
> waits for child process and so test suite never ends.

Yeah, I agree with your analysis. It looks mksh's signal handler waits
for its children. If I run:

  # note start of script
  date

  # mksh with a slow child
  mksh -c 'echo before; sleep 3; echo after' &

  # wait for it to have started child, then kill
  sleep 1
  kill $!

  # and now wait and mark the time
  wait $!
  date

then we see "before" but not "after", and the script takes 3 seconds to
run (since we wait for mksh to exit). Replacing "mksh" with bash or
dash, it finishes in 1 second.

So what to do?

I think we could alleviate the symptom by teaching clean_on_exit to
follow-up SIGTERM with SIGKILL. But as you note, that patch is not
really solving the original problem in the first place. If we use dash
or bash in the above script and add "ps u | grep sleep" to the end, we
can see that "sleep 3" is still running even after we've returned. So we
have not really accomplished our goal anyway.

So I think just reverting dd3693eb08 is probably the most immediate fix.

We can try again at the same goal later, though I'm not quite sure how
to do so. From Git's perspective, we do not even know the pid of the
child that the shell spawned, so we cannot really kill it or wait on it.
Conceptually we'd want the shell to propagate the signal to its
children, but doing that automatically in the general case is rather
tricky. I don't think we want to get into prepending trap commands at
the start of each shell we invoke.

For the specific cases in dd3693eb08, we probably want to signal to the
child to exit by closing the pipe its reading from. But we can't do that
via the run-command system, so it would have to be a specific signal
handler within the transport system. I think that would avoid true
deadlocks, but it still isn't quite what we want. The process won't die
until it tries to read from the parent, so if it's waiting on a long
network timeout, for example, it could mean that the parent sits around
for quite a while even after having gotten a signal.

The fallback position to what dd3693eb08 was trying to do is roughly:
let them get reparented to pid 1 and don't worry about (and people in
containers should really use "tini" or some other pid-1 replacement).
That doesn't seem like the worst place to be, and we can get there
easily with a revert.


This all does point to some general weaknesses in run-command's
clean_on_exit. If a shell is involved, we're probably not killing who we
meant to. That's usually not the end of the world (if we take "clean" to
be best-effort), but with wait_after_clean tacked on it's a recipe for a
potential hang if the shell doesn't exit. So I tried this:

diff --git a/run-command.c b/run-command.c
index c146a56532..97c223bdf1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -680,6 +680,9 @@ int start_command(struct child_process *cmd)
 	int failed_errno;
 	const char *str;
 
+	if (cmd->use_shell && cmd->wait_after_clean)
+		BUG("combining use_shell and wait_after_clean is not reliable");
+
 	/*
 	 * In case of errors we must keep the promise to close FDs
 	 * that have been passed in via ->in and ->out.

and ran the test suite, which results in several failures. In particular
we'll run a "!" alias as a shell command with those flags, but also for
things like exec-ing external commands (like "git-foo"). So we should be
able to produce a "hang" like this (built with SHELL_PATH=/bin/mksh):

  ./git -c alias.foo='!echo before; sleep 10; echo after' foo &
  sleep 1
  kill $!
  wait

and we can see that the parent "git" process waits 10 seconds, even
though it was killed. There are two saving graces here:

  1. This isn't really a deadlock, but just a slow process. We are
     waiting on the alias to exit anyway, and we do not expect that the
     alias command is waiting on us. This is very different from the
     cases in dd3693eb08, where we are spawning something with a pipe
     which could be waiting to read from us. And it looks like all of
     the existing uses of wait_after_clean are like this; the parent is
     conceptually doing an "exec" of the child, but for various reasons
     we want it to hang around.

     The exception is in http-backend, where I think we really are
     interacting with the child (so if we got a signal and the child
     didn't, I think we could possibly deadlock as it waits for us to
     feed more data).

  2. mksh seems eager to automatically exec its child when fed only a
     single, simple command (like "mksh -c 'sleep 10'). And that
     alleviates the problem, since the signal goes straight to the child
     command, then. So for things like git-foo externals, the shell may
     have gotten out of the way anyway.

So I think the existing, pre-dd3693eb08 cases are _probably_ fine, even
with mksh, though the signal propagation may not be doing quite what we
want it to do. In practice I think most signals end up delivered to the
whole process group anyway (e.g., hitting ^C in a terminal) and that
part doesn't matter so much.

-Peff
