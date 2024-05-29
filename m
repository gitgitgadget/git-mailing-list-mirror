Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE5178387
	for <git@vger.kernel.org>; Wed, 29 May 2024 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978190; cv=none; b=gDgOKihUFv7F0tPRBKs2COnmE0iFKGDjh6U1QB9oL9H5tsshPCMXTqBpxZ5KbODpgEtqI7Gv4XRJWi+14t44+yUOgwbAZJpXOq7HKLsnB9wQvNCGTQWx4Yv3RHYokQ3qNScFNutV5BV1q/RwVUC6Zf7c3Ki+frm7eOPGwudwq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978190; c=relaxed/simple;
	bh=KzLYJE5nS8ykTFUwRr/m0hJUiroTVklhfBQIf8fUCEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiiARz6KmAd+DlcHhjdmBM771w7uYyul+5tKdd2GRhDQ3mG2qLgB7e2Xo8rE0l4Adacp96CK/j1pof5DiN6ff+gNc/jqACmg8BpHRVPvViVp6r3kyDk2vmT3O1MqGlt6cbFHy93JCKonzXGC/Lz4+vKLbxHSkzWAX8zdx2Ujb9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11581 invoked by uid 109); 29 May 2024 10:23:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 May 2024 10:23:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18688 invoked by uid 111); 29 May 2024 10:23:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 May 2024 06:23:05 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 May 2024 06:23:07 -0400
From: Jeff King <peff@peff.net>
To: Chris Burr <christopher.burr@cern.ch>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] Cannot set safe.directory with command-scoped
 configuration when cloning
Message-ID: <20240529102307.GF1098944@coredump.intra.peff.net>
References: <GVAP278MB01511C708AE804393BA3B7A48BF12@GVAP278MB0151.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <GVAP278MB01511C708AE804393BA3B7A48BF12@GVAP278MB0151.CHEP278.PROD.OUTLOOK.COM>

On Tue, May 28, 2024 at 02:16:48PM +0000, Chris Burr wrote:

> According to the documentation I expected to be able to set the
> safe.directory option with either "-c" or "GIT_CONFIG_" environment
> variables. From the "safe.directory" documentation:
> 
> > This config setting is only respected in protected configuration
> > Protected configuration refers to the system, global, and command scopes. 
> > Command scope includes both the GIT_CONFIG_ variables and the "-c" flag.
> 
> This works for operations like "git status" but not "git clone".

Yeah, the problem is that Git clears many repo-related environment
variables when it "switches" from one repo to another. And in the case
of clone, there are two "sides": the clone process in the local repo,
and the upload-pack process which runs in the remote repo. And so when
we spawn upload-pack, we clear the environment, including the config
variables.

And the recent changes in v2.45.1, etc, are for upload-pack to be more
careful about the repository in which it runs (unless safe.directory
says it's OK). So that's where the config is checked, but your values
don't make it there. And that's true of other variables, too. Running
"git -c receive.denyDeletes=false push" won't do what you want.

Now at first glance I think you could argue that the config variables
should be retained in this case. After all, they are attached to the
command you ran, not a specific repository. But the main reason we clear
them is that for most transports, they wouldn't be retained anyway! If
your remote is over http, git://, or even most configurations of ssh
(which will not pass arbitrary config variables), the other side
likewise would not see them. So this is keeping the local-repo case
consistent with other transports.

The workaround is generally to attach the config directly to the
upload-pack process, like:

  git clone -u 'git -c safe.directory="*" upload-pack' ...

But:

  1. Obviously that is horrible and not something users should have to
     know about.

  2. It doesn't always work! If you specify --no-local, then it does,
     because we kick off a single upload-pack process and read
     everything from it. But without that, the local clone process tries
     to optimize things by hard-linking the original files. And that
     code does its own ownership check. So you need:

       git -c safe.directory="*" \
         clone -u 'git -c safe.directory="*" upload-pack' \
	 ...

     to cover both processes.

I'm not sure how to make it more friendly, though. Passing config across
the local-remote barrier is a can of worms, since many servers would not
want to trust client-provided config.

The simplest solution I can think of is that the ownership check should
not go into upload-pack at all. It should be totally in git-clone, which
should check the directory itself (obviously only when it knows the
transport is the local filesystem). That would largely protect the
original case we cared about (accidentally interacting with an untrusted
repo on the local filesystem) and leave other more complex ones
untouched (like git-daemon serving user-owned processes as the "nobody"
user).

But I did just think of this approach, so there might be corner cases
that aren't well covered. And certainly the git-daemon thing _could_ be
a security risk, but I think for the most part if you configured
git-daemon to serve other people's repos, you know what you're doing.

-Peff
