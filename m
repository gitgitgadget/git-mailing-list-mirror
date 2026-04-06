Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A68C8EB
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499323; cv=none; b=rlQQQC2tI+wVr7dZztyi1QDF8cHPW3vekAu3a5l5bvBfZc2vnvnW3Vums0L6psHsam2/1Li7INvIYdvKyE7uMQ5YDsFS4SOeZq+JxxE5h5kRoxoShSCVP5iwMdGayHH0GeNJPYK/ANgaXrPTRhDkD8+TgpwuCAruEsl+4IzOzkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499323; c=relaxed/simple;
	bh=uyi9VwZX917qRxilLIrS16PySFbUl5QDyj2jtG6z/Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7eBN8w77q5jdJO0Nc7yc9zfzPm8xA8aSWIWdhYyLWU8v1xSZS1VIstz5PgkjTNx2NkAT4L5iU+V8jnGH+WRh9WX7xCCEFtqPn8Gf/x3XvwVl60w1OFIlghpfEKF1iEjRncSmIP9rRJe9dnEwVrPWwg/+KdEMM8/YyeOZwhaHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=BZ5/a4Wd; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="BZ5/a4Wd"
Date: Mon, 6 Apr 2026 20:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1775499313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uGr6EkQcBZKHnbIA0kRGWLAHNgM5tzYTn214IjMd/c=;
	b=BZ5/a4WdGLWDkOOPi9TmQ5MW53Sih6RLx81/3JL/6LNASpkXQFYcktqFyi651GzMMmrPPT
	EjcAKHY3Pcboc4rOLay4MqWpmBAR9aM9Xzi2iaMj6gZTUX5gT/CrL1LMiyDxp4dW9WFtCS
	Kh8vEYciImOxXzTzE48AT8zf5o0LXweo3cbTycmSJ35Ysuqz3VZMr1yH0EUTHJ3REF2qfa
	0yM8BRh+a0lW7xM10G5UfUpqlUc5SggeaNnALWdUt6+wAew3Hk5vOqKT9o3gjwARgIkir4
	fY8AoilxDDekS1a6ZEOAMl9nxG2GI+iSHjRgYae6jTjo4uD08T0h+QXdUYWuUA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org, ben.knoble@gmail.com, quentin.bernet@bluewin.ch, 
	gitster@pobox.com, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v3] stash: infer "push" when push-specific options are
 given
Message-ID: <adP3JZhS7IHDuUxm@exploit>
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
 <20260405110953.3316-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405110953.3316-1-deveshigurgaon@gmail.com>
X-Spamd-Bar: -

On Sun, Apr 05, 2026 at 11:09:53AM +0000, Deveshi Dwivedi wrote:
> When "git stash" is run without the "push" subcommand, the command
> tries to assume "push" but rejects any non-option arguments (i.e.,
> pathspecs without "--") to avoid treating a misspelled subcommand
> name as a pathspec.  The only exception is "-p", which sets
> force_assume and allows pathspecs to follow.
> 
> This means "git stash -m foo file" is rejected even though "-m" is
> unambiguously a "push" option, and the user's intent is clear.  The
> same applies to other push-specific options like "--staged",
> "--keep-index", "--include-untracked", and "--pathspec-from-file".
> 
> Expand the set of options that force the "push" assumption to
> include all push-specific options, so that pathspec arguments are
> accepted without requiring "--" or the explicit "push" subcommand
> when the command line already contains a push-only option.
> 
> This was marked as #leftoverbits in [1].
> 
> [1] https://lore.kernel.org/git/xmqqtsu1jipp.fsf@gitster.g/
> 
> Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>

Just realized, "--include-untracked" is not specific only to 'push' as
'show' accepts it too as an argument. "--keep-index" as well, but since
'save' is deprecated I don't think anyone would mind and should be fine
to leave it as is (though this is my opinion, should wait for others to
see what they think).
