Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739EF386452
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775691760; cv=none; b=bwYfx2RoocykXv7xk9msJoc8dHj+XmCzOub5JaSc5Byfx0cLT8/UbseRKvCqWbzODP3yrlVthMnhdoFm6ONzRFchiVt2xpdSfVRHbUBTI1lilFAeYjER5zHhHKoot8AB+URM+2tM8LQf1Jh2WTSYoTjr0bMZMUMF7mpd6iNril8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775691760; c=relaxed/simple;
	bh=VvGGD8xc+HMYHByR3r5SF2uOiIRYAQVekCV7a08LSdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxwHZ0nI5g51MqU2rFDmSzKJuMp774sa+/Bvisbb6uXNck7G0kTTzNCeLXsjP6YWz2R0Kj03LbMS3HewHe2Xq+4EJxt1zwnos0RSwlfB7VDmfjceupNiUXlGX9u+dpPNocoM3yTqHBKziSXd7seWY5FBgaWq34x+37H10NWJyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VC+U3pxu; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VC+U3pxu"
Received: (qmail 287050 invoked by uid 106); 8 Apr 2026 23:42:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VvGGD8xc+HMYHByR3r5SF2uOiIRYAQVekCV7a08LSdM=; b=VC+U3pxu+it45gBF7G+eeRsvuEAu92wYri44z8bOJ/FSgfv/M/xIdxO7W2SgSEiOgoPk5p/bXkPdZzx7/y9TVzJWBQTHD5E/pRs2+Tg64HQv1PYuocFedQSx0lbSSLkUVt8/kr6H9dEMRkcntf4yJiAxNoXwUdToZKgWWTZEoWU9/M08CDlSlb/QvTmFbQ4WGmQXygq1tdlBoup5O13BBqFhLR8oFUAwXWuXnk+rhALH53NEBjckZskLWHsCN035jodToLb0jgVNKbFa+K/2NDh3g0ZF8Qh4rCaMRdIOrAIDfeTNcdR7E9doiYV4lo6MKPoj2hDJDg46QYlVpXxXQw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Apr 2026 23:42:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 470619 invoked by uid 111); 8 Apr 2026 23:42:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2026 19:42:36 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Apr 2026 19:42:36 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, rsbecker@nexbridge.com,
	git@vger.kernel.org
Subject: Re: [PATCH] run_processes_parallel(): fix order of sigpipe handling
Message-ID: <20260408234236.GA2980392@coredump.intra.peff.net>
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
 <20260408052031.GB1324339@coredump.intra.peff.net>
 <xmqqpl491mfd.fsf@gitster.g>
 <87y0ix1kq4.fsf@collabora.com>
 <20260408172055.GA2293804@coredump.intra.peff.net>
 <xmqqcy09z62e.fsf@gitster.g>
 <xmqqmrzdxjel.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmrzdxjel.fsf@gitster.g>

On Wed, Apr 08, 2026 at 01:54:26PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> >> Signed-off-by: Jeff King <peff@peff.net>
> >
> > Thanks, all of you, for addressing the issue so quickly.
> >
> > Applied.
> 
> We have a few places where we sigchain_push(SIGPIPE, SIG_IGN) then
> run start_command().  One is in upload-pack.c where we spawn
> "rev-list" for reachability check, and the other is in fetch-pack.c
> where we spawn unpack-objects/index-pack.
> 
> Currently neither subprocess is marked with the clean-on-exit bit.
> but if somebody is careless and flips the bit for these
> subprocesses, start_command() will call mark_child_for_cleanup() and
> causes sigchain_push_common() to set up cleanup_children_on_signal()
> to be called, which would lead to a very similar bug.

Hmm, good catch. This is a bit worrisome, as we've added some
clean_on_exit calls recently, and might do so again.

> I wonder if swapping the order of start_command() and sigchain_push()
> in these two code paths have downsides, or is it making the code worse
> just to futureproof it against a future that is unlikely to come?

I don't think it's really making the code worse. It's putting the
SIGPIPE handling closer to where we're actually doing the writes. But I
don't like that it is a subtle thing that people writing new code have
to worry about. And I wouldn't be surprised if there are other cases
where we disable SIGPIPE, and then call start_command() in a much lower
level of the call chain, which would make reordering harder.

I wonder if we can do better.

The root of the issue is that sigchain_push_common() is not really
expressing what we want. We are trying to install a handler to do
cleanup _if_ we are about to exit. And that is always going to be true
for SIGTERM, etc, where we might install handlers but never expect them
to rescue us from exiting. But for SIGPIPE, our desired action is really
dependent on whether the signal is being ignored in general.

So we could perhaps do something like this:

diff --git a/sigchain.c b/sigchain.c
index 66123bdbab..343b5571e0 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -16,7 +16,7 @@ static void check_signum(int sig)
 		BUG("signal out of range: %d", sig);
 }
 
-int sigchain_push(int sig, sigchain_fun f)
+static int sigchain_push_1(int sig, sigchain_fun f, int keep_ignored)
 {
 	struct sigchain_signal *s = signals + sig;
 	check_signum(sig);
@@ -25,10 +25,24 @@ int sigchain_push(int sig, sigchain_fun f)
 	s->old[s->n] = signal(sig, f);
 	if (s->old[s->n] == SIG_ERR)
 		return -1;
+	if (keep_ignored && s->old[s->n] == SIG_IGN) {
+		/*
+		 * The signal was already ignored; keep it that way
+		 * rather than installing a handler which would be used
+		 * for cleanup.
+		 */
+		if (signal(sig, SIG_IGN) < 0)
+			return -1;
+	}
 	s->n++;
 	return 0;
 }
 
+int sigchain_push(int sig, sigchain_fun f)
+{
+	return sigchain_push_1(sig, f, 0);
+}
+
 int sigchain_pop(int sig)
 {
 	struct sigchain_signal *s = signals + sig;
@@ -48,7 +62,7 @@ void sigchain_push_common(sigchain_fun f)
 	sigchain_push(SIGHUP, f);
 	sigchain_push(SIGTERM, f);
 	sigchain_push(SIGQUIT, f);
-	sigchain_push(SIGPIPE, f);
+	sigchain_push_1(SIGPIPE, f, 1);
 }
 
 void sigchain_pop_common(void)


And that turns the handler setup in pp_init() into a noop (for SIGPIPE),
since it sees that we're ignoring the signal already. But I think this
isn't quite enough for the cases in start_command(), which have
something even deeper going on.

The handler we set up in mark_child_for_cleanup() is _never_ popped. The
idea is that we install it once for the first child which needs it, and
then the rest of the invocations just add to the cleanup list. But that
breaks the push/pop paradigm if it's interleaved with other calls. I.e.,
if we do:

  sigchain_push(SIGPIPE, SIG_IGN);
  child.clean_on_exit = 1;
  start_command(&child);
  sigchain_pop(SIGPIPE);

then that pop is not popping SIG_IGN. It's popping the cleanup handler
installed by start_command! So now we're ignoring SIGPIPE forever for
the rest of the process.

To fix that I think we have to reconsider the push/pop idea for signals.
I suspect the semantics we want are more like:

  - Individual subsystems may register a cleanup handler, but may never
    remove it. Handlers should recognize when they have no work to do
    and return (because they have their own lists of children to clean
    up, temporary files to remove, and so forth).

  - When a cleanup handler is registered, we add it to a linked list and
    register _one_ signal handler that iterates over the list, calling
    each cleanup handler that has been registered.

  - You can't install "ignore" or SIG_IGN as a cleanup handler. But...

  - Code can push/pop an "ignore" flag for a given signal. If a signal
    is marked as ignored, then that supersedes all cleanup handlers. It
    can be implemented either with SIG_IGN, or the signal handler can
    just return from the handler without exiting.

That's a total rewrite of our signal handling, though. There might be
details I haven't considered.

As a stop-gap, I think one smaller thing we could do is just register
all of those one-off handlers (like the one for start_command()) at the
beginning of the program, via init_git() or similar. And then they're at
the bottom of the sigchain stack, so they're never interleaved with
other push/pop calls.  That's kind of horrible, but I don't think there
are so many that it's the end of the world.

All of that is out-of-scope for -rc2, though. ;)

-Peff
