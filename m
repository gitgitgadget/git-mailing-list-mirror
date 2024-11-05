Received: from jupiter.mumble.net (jupiter.mumble.net [74.50.56.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2D18641
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.56.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770476; cv=none; b=dAF0wRSuYG+oR5ZHHME7TQRba4FCdqvM7UdvPdI3X59sMm2ZROXGgY+37kMT6f6uCsHgASpPWIpxkPm53rwfosmjjs5ZBOgR8K+2MUCqhg2xjT0jfSh32iSHaJgUvJLljPQMzYg37QW1EWp03RQRGWOrgkHFWbTdyv+UKbgOFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770476; c=relaxed/simple;
	bh=tU+LLb70Zywm56/GVCvfQtL9CFG5kyS13ZpNaMSBxak=;
	h=From:To:CC:In-reply-to:Subject:Date:MIME-Version:Content-Type:
	 Message-Id; b=jtcOhrYG+CRmB4kuItkwjyvKorJBQikYWU0IZgcuxXLd2Fwtcmei0XQOY85zPQ22oYZw4rqTO9K8sL7DXIdgASJcEOYPOqNxok0+thRPyNeTalalasg+38MM3xiuqxDxo7ksDz+yYAuGI2oO497OiBzvZ5L5vJHmRO+ulEmAvtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campbell.mumble.net; spf=pass smtp.mailfrom=mumble.net; dkim=pass (1024-bit key) header.d=mumble.net header.i=@mumble.net header.b=dpK2jknY; arc=none smtp.client-ip=74.50.56.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campbell.mumble.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mumble.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mumble.net header.i=@mumble.net header.b="dpK2jknY"
Received: by jupiter.mumble.net (Postfix, from userid 1014)
	id 4E52260A64; Tue,  5 Nov 2024 01:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mumble.net; s=20240127;
	t=1730770473; h=from:from:sender:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=vr7Qpa635DFrkm0v8d51EAtU8+B132VzsFjA5uvW248=;
	b=dpK2jknYTiPBqld4ZBK9BDk5Ccq+mheLbvdhV6rc7GWX8SNyOKjmKWsnSgF6sqNEVcczlr
	FiJtIeu1wb2Y9vGdEb94oYRAWhdsuSdu2RaNAlCTFCjWiNwgvFRSm3NnjyUz63m/EpN0W0
	clryOMyVVYCAV73DhMox1GQYZvW1xfc=
From: Taylor R Campbell <git@campbell.mumble.net>
To: Jeff King <peff@peff.net>
CC: git@vger.kernel.org
In-reply-to: <20241104234705.GA3017597@coredump.intra.peff.net>
Subject: Re: Synchronous replication on push
Date: Tue, 5 Nov 2024 01:34:32 +0000
Sender: Taylor R Campbell <git@campbell.mumble.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <20241105013433.4E52260A64@jupiter.mumble.net>

> Date: Mon, 4 Nov 2024 18:47:05 -0500
> From: Jeff King <peff@peff.net>
>=20
> On Sat, Nov 02, 2024 at 02:06:53AM +0000, Taylor R Campbell wrote:
>=20
> > Whenever I push anything to it, I want the push -- that is, all the
> > objects, and all the ref updates -- to be synchronously replicated to
> > another remote repository, the back end:
>=20
> This isn't quite how replication works at, say, GitHub. But let me first
> explain some of what you're seeing, and then I'll give some higher level
> comments at the end.

Great, thanks!  I understand Github works differently, and I'm not
trying to replicate everything about Github's architecture, which I
expect to take substantial novel software engineering effort.  But I
am trying to make sure I understand how the parts fit together well
enough provide qualitatively similar types of guarantees about
durability when the user's `git push' exits nonzero.

I really have two different goals here, which have similar needs for
relaying pushes but which I'm sure will diverge at some point:

1. provide a synchronous push/pull git frontend to an hg backend with
   git-cinnabar (so to ordinary git clients it looks just like an
   ordinary git remote, without needing git-cinnabar), and

2. provide a git frontend that replicates to one or many git backends
   for better resilience to server loss.

>                           Instead, you should disable push's attempt to
> update the local tracking refs. There isn't an option to do that, but
> if you don't have a "fetch" config line, then there are no tracking
> refs. I.e., rather than using "clone --mirror", create your frontend
> repo like this:
>=20
>   git init --bare
>   git config remote.backend.url git@backend.example.com:/repo.git
>   git fetch backend refs/*:refs/*
>=20
> And then push won't try to update anything in the frontend repo.

Thanks, that hadn't occurred to me as an option.

>   Side note: there's a small maybe-bug here that I noticed if the
>   backend is on the same local filesystem. In that case
>   GIT_QUARANTINE_PATH remains set for the receive-pack process running
>   on the backend repo, and will refuse to update refs (where it should
>   be safe to do so!). In your example that doesn't happen because
>   GIT_QUARANTINE_PATH does not make it across the ssh connection. But
>   arguably we should be clearing GIT_QUARANTINE_PATH in local_repo_env
>   like we do for GIT_DIR, etc. I don't think you ran into this, but just
>   another hiccup I found while trying to reproduce your situation.

(I did actually run into this, so in my test scripts I have been using

git {clone,config,...} ext::"env -i PATH=3D$PATH git %s /path/to/backend.gi=
t" ...

instead of just

git {clone,config,...} /path/to/backend.git ...

in order to nix GIT_QUARANTINE_PATH from the environment -- and
anything else I might not have thought of -- while running
git-receive-pack on the backend.  But it didn't seem germane to the
problem at hand so I didn't want to clutter up my already somewhat
long question with such details unless someone asked me to share my
reproducer!)

> > 3. Same as (1), but the pre-receive hook assembles a command line of
> >=20
> > 	exec git push backend ${new0}:${ref0} ${new1}:${ref1} ...,
> >=20
> >    with all the ref updates passed on stdin (ignoring the old values).
>=20
> ...yes, this is the correct approach. You're not _quite_ passing all of
> the relevant info, though, because you're ignoring the old value of each
> ref. And ideally you'd make sure you were moving backend's ref0 from
> "old0" to "new0"; otherwise you risk overwriting something that happened
> independently on the backend. Of course that creates new questions,
> like what happens when the frontend and backend get out of sync.

Right -- there will be some combination of --force-with-lease or
pre-receive tests at the other end to handle this.  But for now my
focus is on making git push work in pre-receive at all.

As long as anything out-of-sync leads to noisy failure, possibly
requiring manual intervention, that's good enough for now (and I'm not
(yet) concerned with .

> > 	remote: error: update_ref failed for ref 'refs/heads/main': ref update=
s forbidden inside quarantine environment
> >=20
> >    but somehow the push succeeds in spite of this message, and the
> >    primary and replica both get updated.
>=20
> This is again the quarantine issue updating local tracking branches.
> However, we don't consider that a hard error, as updating them is
> opportunistic (we'd get the new values on the next fetch anyway).
>=20
> If you drop the refspec as above, you shouldn't see that any more.

Yes, thanks!

> Now back to the main point: is this a good way to do replication? I
> don't think it's _terrible_, but there are two flaws I can see:

These are all good points that I will consider once I get to them now
that I can make progress past the obstacle of local tracking ref
updates in pre-receive git push, thanks.

>   1. You're not kicking off the backend push until the frontend has
>      received and processed the whole pack. So you're doubling the
>      end-to-end latency of the push. In an ideal world you'd actually
>      stream the incoming packfile to the backend, which would doing its
>      own quarantined index-pack[*] on it in real-time. And then when you
>      get to the pre-receive hook, all that's left is for all of the
>      replicas to agree to commit to the ref update.

Git doesn't currently have any hooks for doing this, right?  So
presumably this will require a custom git-receive-pack replacement
that understands the git wire protocol to stream the packfile to
backends (which is what I assume Github's spokes proxies do).

>   2. Using "push" isn't a very atomic way of updating refs. The backends
>      will either accept the push or not, and then the frontend will try
>      to update its refs. What if it fails? What if another push comes in
>      simultaneously? Can they overwrite each other or lose pushed data?
>      Or get the frontend and backends out of sync?

Right -- there's a lot to work out for the three-phase commit part.
One simplification for now is to reject non-fast-forward pushes (and
ref deletion), and to not worry too much about ordering of independent
ref updates or whether I even want serializable isolation or just
read-repeatable or -committed for that.

That said, regarding push atomicity: Suppose users concurrently do

alice$ git push frontend X Y
bob$ git push frontend Y X

That is, there are overlapping ref updates, and suppose Alice and Bob
have incompatible referents for X and Y (non-fast-forward, or they're
using --force-with-lease but not --atomic, or whatever).

When are the locks on X and Y taken relative to pre-receive in the
frontend?  Can the pre-receive hooks for Alice's push and Bob's push
run concurrently or are they serialized by locks on the common refs X
and Y?  This can't deadlock, can it?  (I assume the locks on refs are
taken in a consistent order.)

It's unclear to me from the githooks(5), git-push(1), and
git-receive-pack(1) man pages what the ordering of hooks and ref
locking is, or what serialization guarantees hooks have -- if any.
