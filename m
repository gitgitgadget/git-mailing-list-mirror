Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263A67262A
	for <git@vger.kernel.org>; Sun, 10 May 2026 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778373411; cv=none; b=UpjqBEIgoAv0SNxcA2rACIA75LTG/hbq0rkcTbBiGJa1vKXTa12PsX5mHPij0qMAjQn4e+jesdlWsGzaZC3hscPmfNtMe9TjiD3fwCbt3CgXbj2fCxRKNBC4yb1262zH1rmve0BaRrPNx9UvJD9sNImcR/EEDbru5i8vBTgGnAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778373411; c=relaxed/simple;
	bh=1k6D1KZ90e1MsGB/U0p8vF1iLl3rMS3kfI6Ju/09o5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5DjBROou718rOYPPUFtePXzVFub9F6tneMdS/+bShiHxrjQUut1BIwfqhigeKdM2HhU8bri+RWWVSBDHvnu2Gq+JVa3RQcKH5WYzFyeS7MjOtzP6zQHL9iry739qMUGfcjPfU/NLJXDvw2U0qr8bxwpgF1MqUtoQeQ2w90Ogf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=KPyjcvG0; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="KPyjcvG0"
Date: Sun, 10 May 2026 02:36:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1778373400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfpKmuAUSaYhnsSYJtoLoISnyKXDffh2BgYmvyx4X08=;
	b=KPyjcvG0RPa2A7J4stTAaSL2tQIDGoLd+Kkv3PM2U+l+v7DAtMh1EUvzH2clnII78eEq5t
	q6ZCkUena888tOE5OuL13as0x+Hhch4/FtCqbsFSUFjKCyj01aqIjpbjKAPoc+rXt7vmrB
	rg+Ox8HlVoftSrunaiER9uoitxbWCdkBiwaImYM+PJhwKockLbp5wpnToAQwCYgM+SFYCn
	mpR/SD29naixAni56eFa/KXOlrkgsB5q/UEf2j1aha1D+uyZMQqBrB578UlO29d1+S9XIN
	MaUMgJoSCcNJn6XDPUdujPI9b/A/H+83Z49B+uof/c2tFJyisHYavxeqZR6zIg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Chris Torek <chris.torek@gmail.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v5] revision.c: implement --max-count-oldest
Message-ID: <af_SX9mQPLxolg4k@exploit>
References: <cover.1777249165.git.mroik@delayed.space>
 <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
 <xmqqjytcdeys.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjytcdeys.fsf@gitster.g>
X-Spamd-Bar: -

On Sat, May 09, 2026 at 08:01:15PM +0900, Junio C Hamano wrote:
> Mirko Faina <mroik@delayed.space> writes:
> 
> > --max-count is a commit limiting option sets a maximum amount of commits
> > to be shown. If a user wants to see only the first N commits of the
> > history (the oldest commits) they'd have to combine --max-count with
> > --skip. This is not very user-friendly.
> > ...
> > +test_expect_success 'log --max-count-oldest=3 --reverse --oneline' '
> > +	test_when_finished rm expect &&
> > +	git log --oneline | tail -n3 | tac >expect &&
> > +	git log --oneline --max-count-oldest=3 --reverse >actual &&
> > +	test_cmp expect actual
> > +'
> 
> "tac" is not portable, and breaks macOS CI jobs.
> 
>   https://github.com/git/git/actions/runs/25591146540/job/75128929633#step:4:2058
> 
> Wouldn't
> 
>   git log --oneline --reverse | head -n3 >expect
> 
> be equivalent?

Yes, will do.

Thank you
