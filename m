Received: from jupiter.mumble.net (jupiter.mumble.net [74.50.56.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84905588F
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.56.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513699; cv=none; b=oZoICWsQXxgcVGFG2oqyRRpTD4AnJsp2rpJ2rMGxoqSl3spEdsT1rNR8Lw++Jf3guJ9bucedL/OGjv1GFYsDW7tpIEE2cAi4p8sm3U8u8hKicG7fUlRFsYiFzSoQAiZZg8FHXtOOsfdu3MgezSKhHNwQuMSROOK2mcvUATgfM3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513699; c=relaxed/simple;
	bh=UuvE2MjPTh0aotXPSh4kX9oSrnagwUed+xvnMCDCUVE=;
	h=To:Subject:Date:From:MIME-Version:Content-Type:Message-Id; b=qoJiY6zT/yI2nHRaVMoLsLkYEkbjNRWysu2pJ9VxNcG4i02xoYOBA8H149jp6Ii27JCXrAaa3dE3BcAwagf1QJsxPSoHCYcKsQZzQOE6co3amZ4iniZWJjaZpAeGJuT9kU6X5qVT5bAugJcU8JJBH3d9RvLTmALGuZfO5ha8NLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campbell.mumble.net; spf=pass smtp.mailfrom=mumble.net; dkim=pass (1024-bit key) header.d=mumble.net header.i=@mumble.net header.b=EqxtY0C3; arc=none smtp.client-ip=74.50.56.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campbell.mumble.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mumble.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mumble.net header.i=@mumble.net header.b="EqxtY0C3"
Received: by jupiter.mumble.net (Postfix, from userid 1014)
	id 766D1609AC; Sat,  2 Nov 2024 02:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mumble.net; s=20240127;
	t=1730513213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L7Af1sXvUNsHiZ/ZmIOOQ/tweCBffCQY5iKFkTKBlKQ=;
	b=EqxtY0C3MTuw4jX5/tEL4lVzDtLoOEKRVYLYjSG1pDiQBNmVBKlF3v4pybCSaqsMhn3luk
	8qUXiFfikrKjW+6NZ7heuD19K/s6ZR1JvHS2Qt8AJCo7hahWWU+djk9VmiQBThudZsTBbV
	u/xYccVPPmox6T0Fy38dg4s9FR7CXks=
To: git@vger.kernel.org
Subject: Synchronous replication on push
Date: Sat, 2 Nov 2024 02:06:53 +0000
From: Taylor R Campbell <git@campbell.mumble.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <20241102020653.766D1609AC@jupiter.mumble.net>

Suppose I have a front end repository:

user@frontend.example.com:/repo.git

Whenever I push anything to it, I want the push -- that is, all the
objects, and all the ref updates -- to be synchronously replicated to
another remote repository, the back end:

git@backend.example.com:/repo.git

If this replication fails -- whether because the back end is down, or
because the front end crashed and rolled back to an earlier state, or
because the back end has been updated independently and rejects a
force push, or whatever -- I want the push to fail.  But, absent these
failures, I want frontend and backend to store the same set of objects
and refs.

(Actually, I want to replicate it to a quorum of multiple back ends
with a three-phase commit protocol -- but I'll start with the
single-replica case for simplicity.)

How can I do this with git?


One option, of course, is to use a replicated file system like
glusterfs, or replicated block store like DRBD.  But that

(a) likely requires a lot more round-trips than git push/send-pack,
(b) can't be used for replication to other git hosts like Github, and
(c) can't be used for other remote transports like git-cinnabar.

So I'd like to do this at the git level, not at the file system or
block store level.


Here are some approaches I've tried:

1. `git clone --mirror -o backend git@backend.example.com:/repo.git'
   to create the front end repository, plus the following pre-receive
   hook in the front end:

	#!/bin/sh
	exec git push backend

   This doesn't work because the pre-receive hook runs in the
   quarantine environment, and `git push' wants to update
   `refs/heads/main', which is forbidden in the quarantine
   environment.

   (However, git push to frontend doesn't actually fail with nonzero
   exit status -- it prints an error message, `ref updates forbidden
   inside quarantine environment', but exits wtih status 0.)

   But maybe the ref update is harmless in this environment.

2. Same as (1), but the pre-receive hook is:

	#!/bin/sh
	unset GIT_QUARANTINE_PATH
	exec git push backend

   This doesn't work because `git push' in the pre-receive hook
   doesn't find anything it needs to push -- the ref update hasn't
   happened yet.

3. Same as (1), but the pre-receive hook assembles a command line of

	exec git push backend ${new0}:${ref0} ${new1}:${ref1} ...,

   with all the ref updates passed on stdin (ignoring the old values).

   This fails because `--mirror can't be combined with refspecs'.

4. Same as (3), but remote.backend.mirror is explicitly disabled after
   `git clone --mirror' finishes.

   On push to the primary, this prints an error message

	remote: error: update_ref failed for ref 'refs/heads/main': ref updates fo=
rbidden inside quarantine environment

   but somehow the push succeeds in spite of this message, and the
   primary and replica both get updated.

   And if I inject an error on push to the replica, by making the
   replica's pre-receive hook fail with nonzero exit status, neither
   primary nor replica is updated and the push fails with an error
   message (`pre-receive hook declined') _and_ nonzero exit status --
   as desired.

   So maybe this actually works, but the error message on _successful_
   pushes is unsettling!

5. Same as (1), but the pre-receive hook assembles a command line of

	exec git send-pack git@backend.example.com:/repo.git \
		${new0}:${ref0} ${new1}:${ref1} ...

   with all the ref updates passed on stdin (ignoring the old values).

   This seems to work, and it propagates errors injected on push to
   the replica, but it is limited to local or ssh remotes, as far as I
   can tell -- it does not appear that git-send-pack works with custom
   remote transports.

Perhaps using mirror clones is the wrong approach here, and perhaps I
should instead explicitly create tracking branches in the primary that
are only updated if the push succeeds -- but this will still require
getting around the quarantine restrictions on git push in the
pre-receive hook.


Is there a way to achieve this (ideally, with plausible extension to a
three-phase commit protocol) that doesn't trigger unsettling nonfatal
error messages and that works with custom remote transports?
