Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9F167264
	for <git@vger.kernel.org>; Wed, 29 May 2024 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972853; cv=none; b=JxzYARDERytfCX4Bkz3Aktq/We+g6IFTWTEzy25mIG9plwU3T8x2e3RiQj/SRCB4cUVNzvRnXGXik5DG2ZkwjBx8Lxx8dKIbWa6qVwr5s+2e16AQGt4lCQCfSJSKSHQmc7Oe9sLD/guJfUnEaBBI0b9AA74iCk0gDpHIU76vJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972853; c=relaxed/simple;
	bh=GYhU+8SmUYRMzPLY5THx8IsHUDYAfb+vv+kfQuBpxS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkfTi1hRRdH/YqBuw5ldlUDtEUGEY2nmPRAdNrxfVvy5gw3r2Z9joad3cG5dc7jCnxYqAyCfrZg/l1nFG/Y/0w3aZa8kl7o5QZXNoXX0reyhfNHlsHTAe31qQBwTtZFM02crcFJh/SVqykUA4ogfhwlMG2fcD8hsMy2bcvp1P1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11369 invoked by uid 109); 29 May 2024 08:54:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 May 2024 08:54:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18091 invoked by uid 111); 29 May 2024 08:53:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 May 2024 04:53:59 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 May 2024 04:54:01 -0400
From: Jeff King <peff@peff.net>
To: Joey Hess <id@joeyh.name>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Revert defense-in-depth patches breaking Git LFS
Message-ID: <20240529085401.GA1098944@coredump.intra.peff.net>
References: <20240514181641.150112-1-sandals@crustytoothpaste.net>
 <0f7597aa-6697-9a70-0405-3dcbb9649d68@gmx.de>
 <ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.net>
 <Zk2_mJpE7tJgqxSp@kitenet.net>
 <fbb89826-0d83-d4f9-bab4-9fba69e0e22d@gmx.de>
 <ZlU94wcstaAHv_HZ@kitenet.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlU94wcstaAHv_HZ@kitenet.net>

On Mon, May 27, 2024 at 10:13:55PM -0400, Joey Hess wrote:

> Johannes Schindelin wrote:
> > > More than one major project; they also broke git-annex in the case where
> > > a git-annex repository, which contains symlinks into
> > > .git/annex/objects/, is pushed to a bare repository with
> > > receive.fsckObjects set. (Gitlab is currently affected[1].)
> > 
> > This added fsck functionality was specifically marked as `WARN` instead of
> > `ERROR`, though. So it should not have failed.
> 
> A git push into a bare repository with receive.fsckobjects = true fails:
> 
> joey@darkstar:~/tmp/bench/bar.git>git config --list |grep fsck
> receive.fsckobjects=true
> joey@darkstar:~/tmp/bench/bar.git>cd ..
> joey@darkstar:~/tmp/bench>cd foo
> joey@darkstar:~/tmp/bench/foo>git push ../bar.git master
> Enumerating objects: 4, done.
> Counting objects: 100% (4/4), done.
> Delta compression using up to 12 threads
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (3/3), 324 bytes | 324.00 KiB/s, done.
> Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
> remote: error: object ea461949b973a70f2163bb501b9d74652bde9e30: symlinkPointsToGitDir: symlink target points to git dir
> remote: fatal: fsck error in pack objects
> error: remote unpack failed: unpack-objects abnormal exit
> To ../bar.git
>  ! [remote rejected] master -> master (unpacker error)
> error: failed to push some refs to '../bar.git'
> 
> So I guess that the WARN doesn't work like you expected it to in this case of
> receive.fsckobjects checking.

This is a long-standing weirdness with the fsck severities. The
fsck_options struct used for fetches/pushes has the "strict" flag set,
which upgrades warnings to errors. But if you manually configure a
severity to "warn", then we respect that.

For example, try:

  git init
  git commit --allow-empty -m 'message with NUL'
  commit=$(git cat-file commit HEAD |
         perl -pe 's/NUL/\0/' |
	 git hash-object -w --stdin -t commit --literally)
  git update-ref HEAD $commit

which is defined as WARN in fsck.h. And hence:

  $ git fsck; echo $?
  warning in commit 09b2d5bda87ffda7a0f36ea80c4b542edf9b9374: nulInCommit: NUL byte in the commit object body
  Checking object directories: 100% (256/256), done.
  0

But that's upgraded to ERROR for transfers:

  $ git init --bare dst.git
  $ git -C dst.git config transfer.fsckObjects true
  $ git push dst.git
  ...
  remote: error: object e6db180f21250e03b633a3684f593ceb7b9cd844: nulInCommit: NUL byte in the commit object body
  remote: fatal: fsck error in packed object
  error: remote unpack failed: unpack-objects abnormal exit
  To dst.git
   ! [remote rejected] main -> main (unpacker error)
  error: failed to push some refs to 'dst.git'

Unless we override it:

  $ git -C dst.git config receive.fsck.nulInCommit warn
  $ git push dst.git
  remote: warning: object 09b2d5bda87ffda7a0f36ea80c4b542edf9b9374: nulInCommit: NUL byte in the commit object body
  To dst.git
   * [new branch]      main -> main

But of course most sites just use the defaults, so all warnings are
effectively errors.

I think it's been this way at least since c99ba492f1 (fsck: introduce
identifiers for fsck messages, 2015-06-22). We've discussed it once or
twice on the list. It mostly seemed like a cosmetic issue to me, but in
this case it looks like it caused functional confusion.

I don't think just turning off the "strict" flag is a good idea, though.
The current severities are all over the place. A missing space in an
ident line is an error, but a tree with a ".git" directory is just a
warning!

So I think we'd first want to straighten out the severities, and then
think about letting warnings bypass transfer fscks. Though it's not
clear to me what hosters would want; pushing to a public site is a great
time to let people know their objects are broken _before_ everyone else
sees them, even if it's "just" a warning. But when you do have old
history with broken objects, the control and incentives are in the wrong
place; every person who wants to interact with the repo has to loosen
their fsck config. So it's not clear to me how aggressive transfer-level
fsck-ing should be.

In the meantime, we also have an "INFO" severity which gets reported but
not upgraded via strict. It sounds like that's what was intended here.
It should be available in all backport versions if we want it; it was
introduced in f27d05b170 (fsck: allow upgrading fsck warnings to errors,
2015-06-22).

-Peff
