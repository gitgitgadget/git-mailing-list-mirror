Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE61C760A
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764032; cv=none; b=FltgRm63wIuGZ82Rm4U2e1+gZjb+d+tJVQd7FLRD1My3ch0A6fUqaI7XjbqNhwNcQEAh7IBb0pKI2u/BlAMSwBA9xv1oYjR5fL1V8KTiIgopFDJLeM768T7btW8ExJ+3LPzpLWdQpuQU37TIzbHYaizoBSulbhHh4kuTczqqZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764032; c=relaxed/simple;
	bh=JYp9GwMSMPqoIvczIrOdN8J1WBMyZI8SUYAy+oATuzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agkP/2Vokclv9xTdSGfNq7b7eEnHiideZaXKXqgXGW5VgAGUH4WY+Z7MjW2blX3tYFzda9ucllIk7ZZws7YPi0UQZXte9L26LUbCytyihSv3X4xZKJe4NmehDhhn3IkTg7V+wPEd9e/PnQyMfVHpNFuQmm4PlwOkyhoBSGdKhuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Hf2w/dR3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Hf2w/dR3"
Received: (qmail 17248 invoked by uid 109); 4 Nov 2024 23:47:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JYp9GwMSMPqoIvczIrOdN8J1WBMyZI8SUYAy+oATuzQ=; b=Hf2w/dR3LvUWY0FMKeQHHSULpXGTbkJXtU3g511yrkklWVL5pP/KeghRWJ22TnUHbh0cxnQjz3NhmmU7QgoSzsXQQlVl1ahfcKB1tEKST9/AKNj8Pw/nXCUuOzROmSpnGiqfVn1HViy7XastZ8wf1s4+HywHhX79dg2V1InAo14+sG7q8RjFU9Q3wZm2/bLyzKhHOqavOCxjMkD8kue/3hLHbBamduzUXX07LRe10mgW5wdHUFtanVp9d3gpv1CKa/koVQDkCIqV6/NptFhBmuHa8VI1DdExMWKCd7cA9bG0OG3yj9GUy6/w6iRqsVtt5vttRqiADTJfhgbCHGmrvQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Nov 2024 23:47:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18638 invoked by uid 111); 4 Nov 2024 23:47:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2024 18:47:05 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Nov 2024 18:47:05 -0500
From: Jeff King <peff@peff.net>
To: Taylor R Campbell <git@campbell.mumble.net>
Cc: git@vger.kernel.org
Subject: Re: Synchronous replication on push
Message-ID: <20241104234705.GA3017597@coredump.intra.peff.net>
References: <20241102020653.766D1609AC@jupiter.mumble.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241102020653.766D1609AC@jupiter.mumble.net>

On Sat, Nov 02, 2024 at 02:06:53AM +0000, Taylor R Campbell wrote:

> Whenever I push anything to it, I want the push -- that is, all the
> objects, and all the ref updates -- to be synchronously replicated to
> another remote repository, the back end:

This isn't quite how replication works at, say, GitHub. But let me first
explain some of what you're seeing, and then I'll give some higher level
comments at the end.

> Here are some approaches I've tried:
> 
> 1. `git clone --mirror -o backend git@backend.example.com:/repo.git'
>    to create the front end repository, plus the following pre-receive
>    hook in the front end:
> 
> 	#!/bin/sh
> 	exec git push backend
> 
>    This doesn't work because the pre-receive hook runs in the
>    quarantine environment, and `git push' wants to update
>    `refs/heads/main', which is forbidden in the quarantine
>    environment.
> 
>    (However, git push to frontend doesn't actually fail with nonzero
>    exit status -- it prints an error message, `ref updates forbidden
>    inside quarantine environment', but exits wtih status 0.)
> 
>    But maybe the ref update is harmless in this environment.

I think the quarantine error is working as designed. If your push
updates local refs in the frontend repo, any object-existence checks it
does from the quarantine area are not necessarily valid if the
quarantine environment goes away without migrating the objects (e.g., if
you reject the push).

So this:

> 2. Same as (1), but the pre-receive hook is:
> 
> 	#!/bin/sh
> 	unset GIT_QUARANTINE_PATH
> 	exec git push backend

is potentially dangerous. Instead, you should disable push's attempt to
update the local tracking refs. There isn't an option to do that, but
if you don't have a "fetch" config line, then there are no tracking
refs. I.e., rather than using "clone --mirror", create your frontend
repo like this:

  git init --bare
  git config remote.backend.url git@backend.example.com:/repo.git
  git fetch backend refs/*:refs/*

And then push won't try to update anything in the frontend repo.

  Side note: there's a small maybe-bug here that I noticed if the
  backend is on the same local filesystem. In that case
  GIT_QUARANTINE_PATH remains set for the receive-pack process running
  on the backend repo, and will refuse to update refs (where it should
  be safe to do so!). In your example that doesn't happen because
  GIT_QUARANTINE_PATH does not make it across the ssh connection. But
  arguably we should be clearing GIT_QUARANTINE_PATH in local_repo_env
  like we do for GIT_DIR, etc. I don't think you ran into this, but just
  another hiccup I found while trying to reproduce your situation.

Moving on...

>    This doesn't work because `git push' in the pre-receive hook
>    doesn't find anything it needs to push -- the ref update hasn't
>    happened yet.

Right. You could do it from a post-receive, but if the point is to be
able to reject the push to the frontend, it must happen before the refs
have been updated! So...

> 3. Same as (1), but the pre-receive hook assembles a command line of
> 
> 	exec git push backend ${new0}:${ref0} ${new1}:${ref1} ...,
> 
>    with all the ref updates passed on stdin (ignoring the old values).

...yes, this is the correct approach. You're not _quite_ passing all of
the relevant info, though, because you're ignoring the old value of each
ref. And ideally you'd make sure you were moving backend's ref0 from
"old0" to "new0"; otherwise you risk overwriting something that happened
independently on the backend. Of course that creates new questions,
like what happens when the frontend and backend get out of sync.

>    This fails because `--mirror can't be combined with refspecs'.

Yes. I don't think you really want "--mirror" in the first place, since
you won't be fetching from the backend (or will you? If you are, that
creates new questions about atomicity and syncing). If you do the
init+fetch above, it won't be set.

> 4. Same as (3), but remote.backend.mirror is explicitly disabled after
>    `git clone --mirror' finishes.
> 
>    On push to the primary, this prints an error message
> 
> 	remote: error: update_ref failed for ref 'refs/heads/main': ref updates forbidden inside quarantine environment
> 
>    but somehow the push succeeds in spite of this message, and the
>    primary and replica both get updated.

This is again the quarantine issue updating local tracking branches.
However, we don't consider that a hard error, as updating them is
opportunistic (we'd get the new values on the next fetch anyway).

If you drop the refspec as above, you shouldn't see that any more.

> 5. Same as (1), but the pre-receive hook assembles a command line of
> 
> 	exec git send-pack git@backend.example.com:/repo.git \
> 		${new0}:${ref0} ${new1}:${ref1} ...
> 
>    with all the ref updates passed on stdin (ignoring the old values).
> 
>    This seems to work, and it propagates errors injected on push to
>    the replica, but it is limited to local or ssh remotes, as far as I
>    can tell -- it does not appear that git-send-pack works with custom
>    remote transports.

I don't remember all of the limitations of send-pack anymore. Even
though "push" is more porcelain than plumbing, I'd probably still
recommend it for a script, just because I think direct use of send-pack
isn't going to be all that exercised, so you are likely to find missing
bits of functionality and so forth. I think just dropping the refspecs
and using push would be following the more well-trodden path.


Now back to the main point: is this a good way to do replication? I
don't think it's _terrible_, but there are two flaws I can see:

  1. You're not kicking off the backend push until the frontend has
     received and processed the whole pack. So you're doubling the
     end-to-end latency of the push. In an ideal world you'd actually
     stream the incoming packfile to the backend, which would doing its
     own quarantined index-pack[*] on it in real-time. And then when you
     get to the pre-receive hook, all that's left is for all of the
     replicas to agree to commit to the ref update.

     [*] That would fix the latency, but of course you'd be spending a
     bunch of CPU on each replica to do the same indexing computation.
     You _could_ do that once, streaming the result out to the replicas,
     and then sending them just the resulting index. But there is some
     safety in repeating the computation on each replica (they _should_
     all have the same objects, but if that isn't the case, you'd notice
     if one of them was missing, say, a delta base that the others
     have). GitHub's original replication design did repeat the
     computation, and AFAIK that is still the case today.

  2. Using "push" isn't a very atomic way of updating refs. The backends
     will either accept the push or not, and then the frontend will try
     to update its refs. What if it fails? What if another push comes in
     simultaneously? Can they overwrite each other or lose pushed data?
     Or get the frontend and backends out of sync?

     Git's ref atomicity strategy is generally to take a lock on a ref,
     then check that its current value is the expected "old" value, and
     then update it to the "new" value and release the lock atomically.
     So you probably want to ask each backend replica to take the ref
     locks and check the old values, then respond "yes, I'm ready to
     commit", and then you send back "OK, commit" at which point they do
     the update.

     But "push" doesn't give you that kind of granularity (neither for
     the backends or on the frontend). Back when GitHub's replication
     system was designed, nothing did, and we had to use custom code.
     These days the reference-transaction lets you act in that stage
     where the ref lock is held (and my understanding is that GitLab
     implemented it to do the same kind of three-phase commit).

     But I don't have much experience with it myself. It might be
     enough if the frontend transaction hook talked to the backends,
     initiating an update-ref there with a transaction hook to pause and
     wait for the three-phase agreement.

Maybe some of that points you in the right direction.

-Peff
