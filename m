Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4E52AE93
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731209; cv=none; b=u9QYMOFDbrojQG24BTRu1SQCEyLwZA5h0+VW4X65J6tPAw/JOkmF/Ndm3rlRI4PRHCM7A0o1ay0cYSVbxoDw+xc5iI22TXXUL9lxNYRZUl5/m6+tq90Ajs9QSxGl3E84vV4+alxTA7Cs6rsc5YY+T28EDXSJmIcyS3zP87CBHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731209; c=relaxed/simple;
	bh=vv0LzXSXSdeG6u0qeVQG74WmDz/hADGJKQStDoUltGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqoOQdAwGTgUmuF3aE34Fiom27w8l+o4kWrpbX2KgCrjObE0y0/FHMQE95zg9DkXten0V+CtccwMM2kI+mQ+QB3uylouN0cC1OdhtUQYiQETSplccQDBBrDtoInrvlkkP+0U6Y3u5kZO3bFRCHBrggXSTJdY/AUD+WrnMpZYsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sarqS5Pr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sarqS5Pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244DAC4CED0;
	Mon,  4 Nov 2024 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730731208;
	bh=vv0LzXSXSdeG6u0qeVQG74WmDz/hADGJKQStDoUltGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sarqS5PrYQ4Tj501Nac+7nPovdSwXI3U8779DYm3CVCwPg6EzFB5UZ+QVYiDMvPyy
	 8hqV8J7fXOgTtoIIPCYSnPv8FxY7+9cm5iCQe4ZA99oekOdo7KS+JKkNNb2tmcVOB6
	 YN/ZwuQhb6YnvSIyo5NrlJYTnUJP/WO958OaSBc4=
Date: Mon, 4 Nov 2024 09:40:06 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Taylor R Campbell <git@campbell.mumble.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	=?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
Subject: Re: Synchronous replication on push
Message-ID: <20241104-real-marmoset-of-success-9a6c8e@meerkat>
References: <ZyY74N_NjmaJ2677@tapette.crustytoothpaste.net>
 <20241104133544.A04D760A95@jupiter.mumble.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104133544.A04D760A95@jupiter.mumble.net>

On Mon, Nov 04, 2024 at 01:35:44PM +0000, Taylor R Campbell wrote:
> > > I'm asking about how to configure a _single_ frontend remote, from the
> > > perspective of developers who are pushing from their development
> > > workstations, so that it replicates to one or many backend stores.
> > > This is, for example, the usage model of Github's proprietary
> > > implementation.
> > 
> > I don't think there's built-in functionality for this and I'm not sure
> > that it can be done without additional software.
> 
> I'm happy to write some additional software.

Alternatively, you can take a look at grokmirror, which is what kernel.org
uses:
https://pypi.org/project/grokmirror/

It's pull-based instead of push-based, for several reasons:

1. We replicate to multiple worldwide frontends, and we expect that some of
   them may be unreachable at the time when we attempt a push
2. This allows us to propagate repository deletes
3. This allows us to propagate details like descriptions and authors

Grokmirror also has a listener daemon that can trigger a pull, so it's
possible to have near-instantaneous replication by notifying the remote node
that a repository has been updated and should be pulled.

-K
