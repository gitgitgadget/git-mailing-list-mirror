Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F01373
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 01:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717636497; cv=none; b=pXsNIFuPmFPbbwCLKt2UIgIvuA/j9Jru1Z34h9bsKOOVHkFHMMOECKJpfNPEwPDxD1/rRtdZ8ae1ZquRB3q0S/NafAkLtviezNsQcD2cgzad9zC24w7mcorBmuYX9+oXP3ESIlXmR91dmcMS233v3FAInxo4JgBjh35WaQsyMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717636497; c=relaxed/simple;
	bh=nPd1Lw7H6I+t9QnKfzPynAjyzBTE18fngtdsHb+1tl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGLEKWNGAjmpzb/mLhvIQST918ZgT8mAY5hbyoGQq0soS0s6S3wKBDYg9ELoeGNcuRYGKfv1OGBcNdNUkh464lYZJL4YQZC4lEqdm1BDFuZpwxNtpIvmOFK6p6yEiIlSYHChl8gEydgUYeCcp/ogic/PNksXW/muujdzRzU/PCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4206 invoked by uid 109); 6 Jun 2024 01:14:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 01:14:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3437 invoked by uid 111); 6 Jun 2024 01:14:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jun 2024 21:14:51 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Jun 2024 21:14:53 -0400
From: Jeff King <peff@peff.net>
To: Fred Long <fred_long@fastmail.fm>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
	git@vger.kernel.org
Subject: Re: git fetch --prune fails with "fatal: bad object"
Message-ID: <20240606011453.GA623737@coredump.intra.peff.net>
References: <16919-1717194882-875013@sneakemail.com>
 <xmqqplt1d0k0.fsf@gitster.g>
 <000501dab3b3$51779400$f466bc00$@nexbridge.com>
 <xmqqo78kbqwo.fsf@gitster.g>
 <20240604104437.GD1781455@coredump.intra.peff.net>
 <876fbb07-210e-128e-5289-57ab01761750@fastmail.fm>
 <20240605084718.GD2345232@coredump.intra.peff.net>
 <c2a02982-40a9-6629-05c2-c8de3335f35b@fastmail.fm>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2a02982-40a9-6629-05c2-c8de3335f35b@fastmail.fm>

On Wed, Jun 05, 2024 at 04:43:45PM -0700, Fred Long wrote:

> On 6/5/2024 1:47 AM, Jeff King wrote:
> > 
> > Your local refs should not point to missing objects, though. Each clone
> > should maintain its own consistency. Are you using "git clone --shared"
> > or another scheme involving alternates?
> > 
> I use Google's "repo" script to manage Android repositories. The "repo"
> script runs "git repack -a -d", and I think that's what's removing the
> commits locally. Remotely, our bitbucket server removes commits that are no
> longer referenced.

Using "git repack -a -d" by itself should retain the objects that are
reachable from your local refs/remotes/ refs. But I'd suspect that
"repo" is doing something clever under the hood. I know there's some
support for alternates, and a quick (hah!) "repo init && repo sync" on
the android manifest shows that we end up symlinked objects directories.
So there is ".repo/projects/foo.git" whose objects directory is a
symlink to ".repo/project-objects/foo.git/objects".

I don't know how it is all supposed to work, but naively running "git
repack -a -d" in the "project-objects" version risks corrupting the
"projects" version, because it has no idea what refs are in the latter.

Certainly this warning is ominous:

  https://gerrit.googlesource.com/git-repo/+/refs/tags/v2.45/docs/internal-fs-layout.md#project-objects

-Peff
