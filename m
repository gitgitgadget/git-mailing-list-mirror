Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DAC3D813C
	for <git@vger.kernel.org>; Mon,  4 May 2026 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777900108; cv=none; b=bilLkXLEPYAgePZfH9U0wwg/+EBbAiNqpk+VXUz5b6ENVQ0tnln9XZTqxihd1qGmLxCSZefSqaIkCMcE8t26OLIFD/FPAZ7UvlyfdX6Hdnd1ZxqRDhxMOUmAJAyBxAJuURd+QvXcf1PZvesojjQYgak5/ofVRHIaBoR+J7owS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777900108; c=relaxed/simple;
	bh=/3xvvbJMoNn8Zatm7nDDgGp20DMJC+N+BukflLY4ZZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Glr/a8EI6vzMnNGbdYXS1hFY10rTra3ddfwzbY7T5alDn2/EIPRxw2ij4xlJg7UvG+3GMNDA8UO4g2qeW0vA3zk1I6De4xJHAGOcCkzpYA/ugx+TkUo/RGZZ8mT0vkoT23polk/dSo/YpuuNbalGwSeVzcSyaLvtEheTXN6Gj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=NqhWaLi6; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="NqhWaLi6"
Date: Mon, 4 May 2026 15:08:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1777900096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kE/rkjLJARrqkWJOjZWPw0uIunZiopb8rlcvMuzrQZs=;
	b=NqhWaLi62HzBwcCKFfXeB+Vx0VycpGdT+55HftrkCQFPUsOBXQ72EuHuMsM13+MWtw74B/
	OALJ6mN0B2Rp9dRjaxlQM7zPUcFauM+3MAtiwtxU4uphXmGRDIsvGCrxPsd2XWzCj/sEpW
	E96SPZAuYk4/SyJvXBB29aljDACKKGAvCGkq2JXZ65U+w8zsoaYswD+1iqV2xbz0XMIjHo
	uf0bVxiZtFKEboKlA2WBrSC47EXejewcq3JV97G2xp64clFHtA2mmnCAyGEc58YGsO6EMJ
	aQVaiCwTyiQ688dKqXtJPPORiJ3Xcr965HbbjG33PhG3IKJcnvCOJUBDwmvFxw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Chris Torek <chris.torek@gmail.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v5] revision.c: implement --max-count-oldest
Message-ID: <afiZigRf8cSrEM_L@exploit>
References: <cover.1777249165.git.mroik@delayed.space>
 <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
 <xmqqik93px8s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqik93px8s.fsf@gitster.g>
X-Spamd-Bar: -

On Mon, May 04, 2026 at 02:19:47PM +0900, Junio C Hamano wrote:
> Mirko Faina <mroik@delayed.space> writes:
> 
> > --max-count is a commit limiting option sets a maximum amount of commits
> > to be shown. If a user wants to see only the first N commits of the
> > history (the oldest commits) they'd have to combine --max-count with
> > --skip. This is not very user-friendly.
> 
> To use "--skip=<n>" for this purose, you'd need to know how many
> records are going to be omitted to begin with, but that means you'd
> run the command without count limitation once only to find out how
> many records there are.  "not very user-friendly" sounds like an
> understatement of the year.
> 
> They can do with something silly like
> 
>     git rev-list ... |
>     tail -n N |
>     xargs -n1 git show ...
> 
> and that does count as "not very user-friendly", I would think.

Will reword in v6.

> > Teach get_revision() the --max-count-oldest option.
> >
> > Signed-off-by: Mirko Faina <mroik@delayed.space>
> > ---
> >  Documentation/rev-list-options.adoc |  3 ++
> >  revision.c                          | 77 +++++++++++++++++++++++++++--
> >  revision.h                          |  2 +
> >  t/t4202-log.sh                      | 14 ++++++
> >  4 files changed, 93 insertions(+), 3 deletions(-)
> 
> It looks like this needs measurably smaller damage to the codebase
> than the other --reverse=before approach ;-).

Yes, the control flow of the program is also easier to read.

Thanks
