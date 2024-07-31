Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93711A71E7
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410916; cv=none; b=t0MLjPdxuVqO5WpFNltYU3nFWoPmBPmi5JkcRYQunFmhgYgLzPeK765rQvHoDdleEl5fynf3F/fzkYeEHodRhUtJv4ZqeIRKZLyC5kU284GgMTXgrhfkqFH14lpNqS9CrQbJClhEiaFHY8+TyQ9gPwE1WjDLfJAfX2xI0Pb6uss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410916; c=relaxed/simple;
	bh=yS5QtcQClcgmUwQwMj8NNe3lVC+2oAHoEuWgoBNDYDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVJHOkXy04rCB0dcjNCnDk48sPyr15e72ivx+pSEzT5pZy9qQmzl+X50ggQ5j5H+0vqSoYz4DgNfASMfQIcBgkJkmUyqw8kB/HNfzgZN3ouBvofA1sTfrdyJtEegkTZRzYNQ9IWaxCE7PQnkTmReYQNKsHFkVt02TpS9aVX+XIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4841 invoked by uid 109); 31 Jul 2024 07:28:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Jul 2024 07:28:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18279 invoked by uid 111); 31 Jul 2024 07:28:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2024 03:28:37 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 31 Jul 2024 03:28:32 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Michael Petullo" <mike@flyn.org>, git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <20240731072832.GB595974@coredump.intra.peff.net>
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
 <20240727215845.GA1263246@coredump.intra.peff.net>
 <ZqZjRMqpEV_3WIkD@imp.flyn.org>
 <20240728224807.GA1299337@coredump.intra.peff.net>
 <ZqjQi6i2kiY4gcc1@imp.flyn.org>
 <Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
 <xmqqv80m8pha.fsf@gitster.g>
 <ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>

On Tue, Jul 30, 2024 at 11:05:24PM +0000, brian m. carlson wrote:

> The git(1) manual page also says this:
> 
>   If you have an untrusted `.git` directory, you should first clone it
>   with `git clone --no-local` to obtain a clean copy. Git does restrict
>   the set of options and hooks that will be run by `upload-pack`, which
>   handles the server side of a clone or fetch, but beware that the
>   surface area for attack against `upload-pack` is large, so this does
>   carry some risk. The safest thing is to serve the repository as an
>   unprivileged user (either via git-daemon(1), ssh, or using
>   other tools to change user ids). See the discussion in the `SECURITY`
>   section of git-upload-pack(1).
> 
> I think that has been traditionally the policy that we've had here, and
> given that we document that it is safe to do so, I think it should be
> fine.  This documentation apparently came from Peff, who I think should
> be reasonably well informed on such matters.

Right, that was added in v2.45, but I think was just explaining the
long-standing approach.

My understanding of the recent expansion of the ownership checks was
that they were a defense-in-depth. It _should_ be safe to run
upload-pack against an untrusted repository, but it would be easy for us
to accidentally violate that.

But I admit I did not carefully follow all of the discussion around
crossing filesystem boundaries (e.g., symbolic and hard links pointing
outside docker containers that are bind-mounted, or something like
that). I did not find those cases all that compelling from a security
perspective, but again, I didn't look into them that closely.

It could be that "clone" should try to avoid a "--local" clone from a
repo with different ownership, if the local hardlink path is more
dangerous. But that distinction is not something upload-pack even knows
about, so the code would have to go into clone. And then upload-pack
could be free to drop the ownership check. Certainly a lot of people
have complained about it (I had actually thought we reverted it in
v2.45.2, but that was just the extra hooks defense-in-depth; so again, I
may be getting confused about the extra value of the enter_repo()
ownership check that came at the same time).

-Peff
