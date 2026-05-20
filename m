Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140F3E95A4
	for <git@vger.kernel.org>; Wed, 20 May 2026 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295368; cv=none; b=nEtsVPu323MLTKSYl8ZhlQeysw/lqCV81N6VwHGNcoYHWZxNv5uz8lViMOcLtUtOgnqJRpencjn6s2+IFEdHq4mPjMqcjReslPFRvFchqmEKuEstn39X8+oeVdq11azbx0K7nyJOH5BGybSEegAnt1Cg24lrDe+GQfUBeub9DoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295368; c=relaxed/simple;
	bh=SXjFjpGlVr+Eio7HMTXMC/diB1B4vUlb00K7XrNnOkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlJhtZkApBpmmJ9Adqq7LtFLjMK1nnQBjT3XrAH+2Ptj7XF/fLz68r/+EHRfU6qfnoEdBhamgsbtrioGx86ULZl3z+i3PF0IGeEtzRZzE9t24uZwWLUjqhESM0Xg028FDdYDfUWdnKBOELtz7wUyKTmHHfAUoKlrA2/WSnYtOcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=hI1oJ30l; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="hI1oJ30l"
Date: Wed, 20 May 2026 18:42:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1779295358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iS0tnCz9oOdHjL+PgyRznXcHBAeu9wZiOOjHQ7h3oGY=;
	b=hI1oJ30lQTkkmCSBIn6o+OGwTsqFjuKb8847uYIhEzjJM08LFxmgsc0+EN3V/P5+qh3XDT
	MwE/SWIht+gkJZfiNPy1rHXDDua+PpGT77GPZuSTMZI3y5TQjQJxH0R5s5Ml1A6WiZh8o/
	/JMRwndvVWCqB56pM0z0WvAfPNykuYJR5FC6TrcDR7Fr6DR6vSMa3btQMMi0utlWlRBHFT
	VBq5agDZf2ZMlNDL8TGd3+nzxyRkGjJud89VB/PDx/+KcJSKZQmw1PdYjqHwFnU/IJRhGK
	F4cuMTIsnCPVe/jRAM/fQZs2mgpcHD+omWpj0vFv5lixn/0aReotwTCLVyVfcQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Chris Torek <chris.torek@gmail.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v8] revision.c: implement --max-count-oldest
Message-ID: <ag3kJ_xKY6584De4@exploit>
References: <463cc8e2764edb7de3d379f615f5cfbd0919bfa3.1778887662.git.mroik@delayed.space>
 <8210d60832b9a58aa4d71fc3790e44d8989564ce.1779152064.git.mroik@delayed.space>
 <xmqq7boy4o05.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7boy4o05.fsf@gitster.g>
X-Spamd-Bar: -

On Wed, May 20, 2026 at 03:02:34PM +0900, Junio C Hamano wrote:
> Mirko Faina <mroik@delayed.space> writes:
> 
> > --max-count is a commit limiting option sets a maximum amount of commits
> > to be shown. If a user wants to see only the first N commits of the
> > history (the oldest commits) they'd have to do something like
> >
> >     git log $(git rev-list HEAD | tail -n N | head -n 1)
> >
> > This is not very user-friendly.
> >
> > Teach get_revision() the --max-count-oldest option.
> >
> > Signed-off-by: Mirko Faina <mroik@delayed.space>
> > ---
> 
> This breaks CI
> 
>   https://github.com/git/git/actions/runs/26138986677/job/76880268854#step:4:2072
> 
> Squash something like this to fix.
> 
> --- >8 ---
> Subject: [PATCH] SQUASH??? test portability and other fixes
> 
> * "test_when_finished" should use "rm -f", not an error-detecting
>   "rm", as the execution may not have reached to the point to create
>   the "actual" file it is removing.
> 
> * Do not hide exit status of "git log" by piping its output into
>   another process.
> 
> * Do not expect output of "wc -l" is portable.  macOS puts extra
>   whitespaces in front, while GNU/Linux does not.
> ---
>  t/t4202-log.sh | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Sorry about that. And thank you for the fix.
