Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A248FF71
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972276; cv=none; b=DC5HwAVsmu072TEVs3VP6zFL/0lUbRwMx4WLe+PbxWS0hpyUjmocu6Ir/KK0jqUAdXGnkvQ88ygUZWvMVsinmQLMpewQIM/2SjsNTZPPjSQm+VSr3dtfvxyPT1GAZx/USsgxHbyJT5Sl1TBsayssnTEchjetYayUbBzSoq3DKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972276; c=relaxed/simple;
	bh=DiXM12C30hbAHwgJawtVkGR/X0TycAqnfn5H7vkgV9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flvTnLGJmY1qhItJbVUKaXuaGthqzVDY8VA5FZbHuyFXkQpPMo0rvSEWhSNyJwVGpdEMlBes6CMLKTDdnqenBhtFUQd6D2upWioCMdtCdt93wJ2BtifLXxwx65KApcjeRvtJzag5JcOOZ1CZEjVQeS51EaNrYFsLLxTE1MT4Iss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WidS+xes; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WidS+xes"
Received: (qmail 69253 invoked by uid 106); 14 Oct 2026 10:04:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DiXM12C30hbAHwgJawtVkGR/X0TycAqnfn5H7vkgV9U=; b=WidS+xesPopbnt7c3A1ckMrSlyIG5IxAtR9WvULKRn7ZGesg6ITBWjOTBs+sHH5i/4mCGNupOHEd8Aoifezzxc7xBjaiBmmj65YvedHC+N+BVXEQgGx1mE9a/5b/ZxfnI84K4EqugPQObgGIIB7XHo7GLxpFkhA+3vISJasqNsMwf7TPA3UQ3fjkcWZXGLk0gGtvAbm4vYjOAltuyUudD2dUem9fC/J9IgO7s/17WrIA9VCsQFYXx/cwHEimDqfg4YechLU2qNOtrBTq4ypkVs1NA4zKHroevFcoRNAhuugnwAsDS14D5U84Xe+wSk0jvJ+pvUlyyxOTaRkZu7WfbQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 10:04:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 36098 invoked by uid 111); 14 Oct 2026 10:04:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 06:04:38 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 06:04:32 -0400
From: Jeff King <peff@peff.net>
To: Jun Wu <quark.zju@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: Re: [PATCH 2/2] commit: lock index before reading
Message-ID: <20261014100432.GB1344504@coredump.intra.peff.net>
References: <20261013172315.2997446-1-quark.zju@gmail.com>
 <20261013172315.2997446-3-quark.zju@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013172315.2997446-3-quark.zju@gmail.com>

On Tue, Oct 13, 2026 at 10:23:15AM -0700, Jun Wu wrote:

> Take the index lock before reading the index, in one place, instead
> of separately in each `if` branch.
> 
> `commit` now respects the `core.indexLockTimeout` config.
> 
> History suggests no particular reason for reading before locking:
> - f5bbc3225c (Port git commit to C., 2007-11-08): lock before reading
> - 2888605c64 (builtin-commit: fix partial-commit support, 2007-11-18):
>   seems to accidentally move reading to before locking

Hmm. We may do a lot more work under lock than we used to, running
stat() on the whole repo.

But I think there's a deeper issue here. We're reading the index, _then_
taking the lock, but not necessarily discarding what we read earlier. So
it feels like two processes could race here, with git-commit discarding
some update by another process (like git-add).

If we instrument git-commit like this:

diff --git a/builtin/commit.c b/builtin/commit.c
index 840b6b4083..2a78cb473a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -392,6 +392,8 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	if (repo_read_index_preload(the_repository, &pathspec, 0) < 0)
 		die(_("index file corrupt"));
 
+	sleep(5);
+
 	if (interactive) {
 		char *old_index_env = NULL, *old_repo_index_file;
 		repo_hold_locked_index(the_repository, &index_lock,

that widens the race window. And then something like this:

  echo new content >old-file
  git commit -am foo &
  sleep 1 ;# commit is sleeping in race window

  git add new-file

will clobber the index change from git-add.

And that is true with today's code, not using any timeouts. Adding a
timeout doesn't really change anything, though if you _do_ see lock
contention it is a good sign that you are about to hit the race and
clobber something. ;) So it is widening the window. But the correctness
problem is already there.

I do think your patch fixes the problem. But we probably want to discuss
that in the commit message as a motivation (and likewise, discuss the
fact that we may be holding the lock for longer).

There's probably some kind of hybrid world where we optimistically read
without the lock, then take the lock, and then check (cheaply-ish) that
the index didn't change since what we read. But I don't think we do that
in this code path.

-Peff
