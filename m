Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FDB1A4B44
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410360; cv=none; b=qTchsB2gMn7P8d2qpp5MhMrAIwkcKKAclYV/0/tEKnR8vUXnt6FgJL1c5z3j7mP4C0i2qQrwZuBj00uakErE18Mo+IT80vFWCBvEYpYwZK9VLGmPLfHCEfewsrtfgA1srBQpVwNt4bCm0XPuxgxhtGV9MUNWwjFi8Yw0PvBjfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410360; c=relaxed/simple;
	bh=TPmjZeSz8gUPT1RixUCcJY0j6qRI1YLJJWeHwAY1uO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1FmHx11g3OM6hVW9oiqLyBYauWYoGKxDGSEL10dN79LqdJ1jVFSl4PpeFWHe5QaqkEZ5gIAW5Gj6AVAGPDIkjVvUlnATj5rd6AjDm7gx0XBL1etRRdrQaaCYrEU3InNHsO4lYpVZ9y5yQ01cK4d8vmOWbR73F5RjcWwxf3FmVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4803 invoked by uid 109); 31 Jul 2024 07:19:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Jul 2024 07:19:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18235 invoked by uid 111); 31 Jul 2024 07:19:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2024 03:19:14 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 31 Jul 2024 03:19:09 -0400
From: Jeff King <peff@peff.net>
To: "W. Michael Petullo" <mike@flyn.org>
Cc: git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <20240731071909.GA595974@coredump.intra.peff.net>
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
 <20240727215845.GA1263246@coredump.intra.peff.net>
 <ZqZjRMqpEV_3WIkD@imp.flyn.org>
 <20240728224807.GA1299337@coredump.intra.peff.net>
 <ZqjQi6i2kiY4gcc1@imp.flyn.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqjQi6i2kiY4gcc1@imp.flyn.org>

On Tue, Jul 30, 2024 at 06:37:47AM -0500, W. Michael Petullo wrote:

> A little feedback to regarding why I chose to avoid .gitconfig along
> with some consequences:
> 
> I have a system built around Git in which I use the permissions approaches
> I have described in this email thread. The downside of .gitconfig is
> that its effect is global. I fear I might lose track of the fact that I
> have turned off a security protection in a global way, possibly years
> down the road as I maintain my system.  Instead, I went about this by
> patching particular uses of Git to use "-c" and so on. I only needed to
> do this at two or three places my code executes Git out of dozens.
> 
> This makes my intention clear in the code (that executes Git) and lessens
> the likelihood of me (a year or so later?) forgetting I am responsible
> for ensuring the circumstances leave my use of safe.directory safe.

Makes sense, though I think it's somewhat specific to your setup / use
case. If you had arbitrary clients connecting, telling them to use "-u"
probably wouldn't scale.

> I suppose the inconsistency surrounding "-c" that we have discussed sort
> of works against my approach. Indeed, I wonder if in an ideal world we
> should remove the dangerous features that have good intentions
> (hardlinks and so on) and instead require users to opt in to them.
> I say ideal world because this ignores backward/forward compatibility
> issues.

So there's an open question on the degree to which running upload-pack
is actually dangerous. It's not _supposed_ to be, but the ownership
check is a defense-in-depth approach to safety.

> Perhaps a compromise would be to tie safe.directory to the type
> of source directory given to clone. Would a remote URL be enough to
> turn off the safe.directory checks on a clone, similar to the effect of
> a remote URL on --local/--no-local?

It already is tied to the URL, in the sense that "clone" is not doing
anything at all. It is entirely the server upload-pack that has started
doing the ownership check (as of v2.45). For a local clone, the "server"
is just another process owned by your user on the same machine, and
that's where most people are running into it.

But for all other remotes, the ownership issue is one for the server to
deal with. So server operators serving over http or via git-daemon would
need to make sure their daemon processes match the on-disk repository
ownership (or use safe.directory to get around it). And there really is
_potential_ danger there. The server-side daemon process is running
upload-pack against a repository owned by some other user. If you're
serving untrusted repositories that way (say, a system git-daemon with
repositories owned by users), there could be a mismatch there (but
again, this is defense-in-depth and upload-pack is supposed to be safe
here).

Cloning over ssh is sort of a middle ground. It still is the server's
problem, and the "user" in this case is the user on the server side, not
the user on the local machine running "git clone"). But often that user
is conceptually the same entity (but doesn't have to be; as you can
imagine, GitHub's ssh endpoint does not have one Unix user per
conceptual user).

> The current behavior seems to mean:
> 
> 	(1) -c safe.directory works for some sub-commands, but not clone,

Also fetch, push, ls-remote, etc. Anything dealing with a "remote"
repository which spawn extra processes that clear the environment of
"-c" config.

> 	(2) clone requires your additional workaround, and 
> 
> 	(3) your workaround does not work with SSH/git-shell for the
> 	obvious reason that git-shell needs to limit the "commands" it
> 	will run; this requires another level of intervention.

Right. The workaround does work, though, if you're not using git-shell.

> Another thing I came across was in the git-clone man page:
> 
> 	"When given, and the repository to clone from is accessed via ssh,
> 	this specifies a non-default path for the command run on the other end."
> 
> Your "-u 'git -c safe.directory=X upload-pack'" workaround uses
> upload-pack in the absence of SSH, so I wonder if "and the repository
> to clone from is accessed via ssh" is inaccurate.

Yes, I think that documentation is overly specific. The "-u" command is
used whenever we can ask the other side to run an arbitrary command. So
local clones, as well as ssh. Not git-daemon or http, where we just tell
the other side the type of operation to perform.

-Peff
