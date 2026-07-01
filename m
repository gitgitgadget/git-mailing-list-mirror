Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B653270545
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893641; cv=none; b=AiHvfuPpMHfXT6x7w5ruz+6ofCGLXmCZlMOb+laTHZZUFKDTpiNcls2ZhYkW2wUSEIyb1WZ7pfhvKqOkloZHgIBQ7j22eaCZqFyE3a58AkIOhCXTYQWkQDRbXXiQaUd4/LU9lpNoOa0dh4u4JFJ5XoCP3VfqK6EpUoGnfP0A8UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893641; c=relaxed/simple;
	bh=mnd21UFXAGVmMUlNVet/PT7vXU6yl1VZiGkYG/lRAa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thKXLClPJ5CcdD7nyI3l1ywZ0WThakMovgbXrInTtDCSlAf47F50r/c9KvmNwdjjheqsVeK5iRzcw7cYlhcw2Eoc656AveqRqhY7TfG0tNYErSrihpofm4GcvWHJtqAAA18TF2zchDvzmlWp5zclKhfnCLbpeZgoZTMnkl0dzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iA9Aqzjz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iA9Aqzjz"
Received: (qmail 77662 invoked by uid 106); 1 Jul 2026 08:13:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mnd21UFXAGVmMUlNVet/PT7vXU6yl1VZiGkYG/lRAa4=; b=iA9Aqzjzj2fFiKyMBRor2mDsrjWm9pmz8Bau1f61HN6QhgJNlakAilYfTBHo9AKihPVdDz00bobzLEQMdZVQa9H7OZwzC7wUl8J86DIE1NeIgagVOzHaeDM+OUgYAEBaxkaO2wuBgoM30ZPD3ndLwdx065KyZjqWJRK0dtvdHIzBwjEIuPQsQOIvGbqrjhcPPteAYII6F8gSUTs6o0sKUWlJOWlQnEjwBW/DaaPdj2L7iNyiQCiC6FRsAaBbyvBSsnS1g8b1rKqpNqRIyoxAaZwFn1XtOEJKboNhAh7LOlczoAaxCrvIhDtMDBNb36CAD4arfSgJmEwKCQLXWNn2Lg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2026 08:13:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 158753 invoked by uid 111); 1 Jul 2026 08:13:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2026 04:13:58 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jul 2026 04:13:58 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: fix leak of rev_info in prepare_bases()
Message-ID: <20260701081358.GB813310@coredump.intra.peff.net>
References: <20260630063944.GA3733670@coredump.intra.peff.net>
 <20260630064301.GB3733961@coredump.intra.peff.net>
 <akOZy-BygZS8fqPM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akOZy-BygZS8fqPM@pks.im>

On Tue, Jun 30, 2026 at 12:26:19PM +0200, Patrick Steinhardt wrote:

> >   make SANITIZE=leak
> >   cd t
> >   GIT_TEST_COMMIT_GRAPH=1 ./t4014-format-patch.sh
> > 
> > which yields many entries like:
> > 
> >   ==git==3687620==ERROR: LeakSanitizer: detected memory leaks
> >   Direct leak of 200 byte(s) in 1 object(s) allocated from:
> >       #0 0x7f4ccba185cb in malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:74
> >       #1 0x55cd452cdd0b in do_xmalloc wrapper.c:55
> >       #2 0x55cd452cdd9d in xmalloc wrapper.c:76
> >       #3 0x55cd45255473 in init_topo_walk revision.c:3845
> >       #4 0x55cd45255bef in prepare_revision_walk revision.c:4017
> >       #5 0x55cd44ffec40 in prepare_bases builtin/log.c:1872
> >       #6 0x55cd450010ec in cmd_format_patch builtin/log.c:2439
> 
> Interesting. Makes me wonder whether we should modify linux-TEST-vars to
> also run with the leak checker enabled. Ideally we'd of course just do
> this for all jobs, but the overhead is probably way too high... yes,
> doing a simple benchmark shows a ~3x hit.
> 
> So this is definitely nothing we want to do for all jobs. But for the
> linux-TEST-vars job it might make sense, as it exercises a bunch of
> non-default code paths.

We already run a special leak job for linux-reftables. Why not turn that
job into "leaks plus reftables plus test-vars"? The only downside would
be potentially hiding leaks found by linux-reftables-leaks if the
test-vars features force us into a difference code path. But looking at
the list, it doesn't seem likely to me. None of them is particularly
ref-related.

In fact, I kind of wonder if we could fold linux-reftables into the
test-vars job completely.

> One thing worth noting: there are still six test suites that are failing
> with this patch: t0095, t3451, t3452, t3453, t4013 and t4211. The t345x
> failures are because of the missing call to `repo_unuse_commit_buffer()`
> in git-history(1), which we already noted elsewhere.
> 
> All of the remaining leaks in t0095, t4013 and t4211 seem to be related
> to bloom filters.

I sent some patches to fix the bloom-filter cases.

Building with OPENSSL_SHA1_UNSAFE turns up more. The core issue is that
recent versions of openssl require an allocation to open a sha1 context,
and we free it in git_hash_final(). So code paths that abort mid-hash
will leak the allocation, and we need a git_hash_discard().

It comes up mostly with csum-file.[ch], since that's where we use the
unsafe variant.

If you further build with OPENSSL_SHA1 (using it for _all_ hash
computations), there are a few more cases. It's hard to care too much
since that isn't a recommended build (and we've even discussed dropping
support for non-dc sha1 totally). But sha256 has the same issue, so
we'll want to fix it eventually (I didn't try leak-checking the
linux-sha256 build, but I expect it would complain a lot).

I have some patches but they need a bit of polish. In particular I think
we'll have to tweak the hash.h #define mess to expose a "discard"
primitive from each implementation (otherwise we have to finalize the
hash to discard, which is a little inefficient). I didn't quite have the
stomach for that tonight.

-Peff
