Received: from jupiter.mumble.net (jupiter.mumble.net [74.50.56.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E514A91
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.56.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727353; cv=none; b=cVetybZpxMwVseObLc8ZxOuuA0R8NyKE2DHk5atrK7sAeSAre+PFnHF2rIg6NLhbBLrQ3pD2KRjHQ2PJZHJLs8P1QC1drHjvsiE4M6s1Ze7RWK2Udj0cL+kRYtb1sU06xnj181zqvnfn4D3otNBRIQe1bs+Uq2HngvrM4w1Mllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727353; c=relaxed/simple;
	bh=PxSYt187hzyZrip+lh514mqO9EIH9PFVCsNcDtJQlss=;
	h=From:To:CC:In-reply-to:Subject:Date:MIME-Version:Content-Type:
	 Message-Id; b=GYVNb3wfJPuPPFu3jn14XOpuiFC6Suqu/ydI+AWtOLPrVaUNp1/p7MaDtjVgD8Yi8WpPEuqePsaIRtKMYZ6PbNk9vCvjKu1Z5yNxJKjxeRcKcJYiygCfQ32LOIgxcqO790J17Jlm/CxqMzirdFIEfJxGQ8ASwMuDntvecNupFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campbell.mumble.net; spf=pass smtp.mailfrom=mumble.net; dkim=pass (1024-bit key) header.d=mumble.net header.i=@mumble.net header.b=X5gTdAD4; arc=none smtp.client-ip=74.50.56.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campbell.mumble.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mumble.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mumble.net header.i=@mumble.net header.b="X5gTdAD4"
Received: by jupiter.mumble.net (Postfix, from userid 1014)
	id A04D760A95; Mon,  4 Nov 2024 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mumble.net; s=20240127;
	t=1730727344; h=from:from:sender:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=BBd2cA/HWDJIDaZ6Mcdr4fH5Z2iIy+dMOt/jdSh8gWo=;
	b=X5gTdAD4JY3sOiX7ZDTpc3NztjsgO9R2/RpiWl3flO8IIt5IwNolpwYcvwDbmaWEle6wva
	ncJ3CF1w3d79INFhR4YIYsKkpwCEB6qkj2z6fd1TZ7LqTV1Jl2JGZ9Z9WQgD80C/gs68d8
	bLB3fuw2+uCh+i8BjVFRCkzRklDXKiU=
From: Taylor R Campbell <git@campbell.mumble.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
In-reply-to: <ZyY74N_NjmaJ2677@tapette.crustytoothpaste.net> (sandals@crustytoothpaste.net)
Subject: Re: Synchronous replication on push
Date: Mon, 4 Nov 2024 13:35:44 +0000
Sender: Taylor R Campbell <git@campbell.mumble.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20241104133544.A04D760A95@jupiter.mumble.net>

> Date: Sat, 2 Nov 2024 14:49:04 +0000
> From: "brian m. carlson" <sandals@crustytoothpaste.net>
> 
> On 2024-11-02 at 13:35:11, Taylor R Campbell wrote:
> > I'm asking about how to configure a _single_ frontend remote, from the
> > perspective of developers who are pushing from their development
> > workstations, so that it replicates to one or many backend stores.
> > This is, for example, the usage model of Github's proprietary
> > implementation.
> 
> I don't think there's built-in functionality for this and I'm not sure
> that it can be done without additional software.

I'm happy to write some additional software.

But I would like to understand what constraints there are on, e.g.,
pre-receive hooks and the ref updates of git push that make them
collide in the ways I discovered, so that I can understand how to make
that additional software reliable.

For example:

- Can I suppress the local ref updates of the remote in git push, just
  like git send-pack doesn't attempt any local ref updates of the
  remote?  Or can I defer them to the post-receive hook?

  (By `local ref updates of the remote', I mean updates of the refs
  that live in the local repository for the remote.backend.fetch or
  remote.backend.push refspecs, rather than refs that exist in the
  remote repository which obviously I do want to update.)

- Can I use git send-pack with a custom remote transport?

- When I git clone --mirror, explicitly disable the mirror flag, and
  then git push in the pre-receive hook, why is there an error message
  printed even though the push exits with status zero and appears to
  have had all the effects I want?

- What undesirable side effects can git push have in a mirror cloned
  with git clone --mirror, but with the mirror flag subsequently
  disabled?

- What undesirable side effects can git push have in a pre-receive
  hook if I explicitly disable the quarantine environment by unsetting
  GIT_QUARANTINE_PATH in the environment?

> If you really wanted to try to do this with out of the box Git, you
> could create a `pre-receive` hook that did policy controls and then on
> success, took all of the objects from the quarantine and rsynced them
> (without overwriting) to the remote store, and then use the
> `reference-transaction` hook to replicate the reference transaction to
> the remote side via SSH or something.  I haven't tested this, so it
> might or might not work, but you could try it.

Thanks, can you expand on how this would work with the constraints I
listed in my question?  Recapitulating:

   One option, of course, is to use a replicated file system like
   glusterfs, or replicated block store like DRBD.  But that

   (a) likely requires a lot more round-trips than git push/send-pack,
   (b) can't be used for replication to other git hosts like Github, and
   (c) can't be used for other remote transports like git-cinnabar.

It sounds like rsyncing over ssh is incompatible with (b) and (c), but
perhaps I misunderstood what you're getting at.  I tried to see if
there is some way that reference-transaction hooks help me here but
there wasn't anything obvious to me.
