Received: from joooj.vinc17.net (joooj.vinc17.net [155.133.131.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601EF3A3E8B
	for <git@vger.kernel.org>; Thu, 14 May 2026 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.133.131.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752533; cv=none; b=iABm9p+0RptfcyWqbw266P3X8IFoRrGhBM2H+Xdg8D0yBEws5QYm+dufdxDkFn6pGHftzm9FNJ/u/5qVzX3xMnubFHVqleVjBmS9FCS8R9VBTlZd1A8AnsBqjmcayU0hgFWv5FKXuGWHMoh9AOCzM6qVa5QxVDB/qVNIJOZA+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752533; c=relaxed/simple;
	bh=qZttiG1ugcOv4tUK5doRCs8LliWzblw1aeTqLquqEQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBo79gJk0x5P3NeHrQxwxdeQl+Wn4k/yO4WhWYU8KQLXDe0yrGskvstMISCWanw5Q2+WtX+M2rbbBuUPplj91DqdlQHuO1AWGGcIBoBpbch1aZzYtS35tm1V8qbL0Z4ouivZ1V7Gv23PUwZykO4HBG+5mh5NYp/88rzazGYH1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=155.133.131.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from smtp-qaa.vinc17.net (2a02-8428-1b1d-4d01-96a9-491d-7b48-ba31.rev.sfr.net [IPv6:2a02:8428:1b1d:4d01:96a9:491d:7b48:ba31])
	by joooj.vinc17.net (Postfix) with ESMTPSA id 8190522A;
	Thu, 14 May 2026 11:55:24 +0200 (CEST)
Received: by qaa.vinc17.org (Postfix, from userid 1000)
	id DFF8BCA4ADB; Thu, 14 May 2026 11:55:22 +0200 (CEST)
Date: Thu, 14 May 2026 11:55:22 +0200
From: Vincent Lefevre <vincent@vinc17.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	j6t@kdbg.org
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
Message-ID: <20260514095522.GA159111@qaa.vinc17.org>
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
 <xmqq8q9migqk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8q9migqk.fsf@gitster.g>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.3.2+116 (f613607b) vl-188789 (2026-05-13)

On 2026-05-14 16:37:39 +0900, Junio C Hamano wrote:
> Michael Montalbo <mmontalbo@gmail.com> writes:
> 
> > @@ -457,6 +457,11 @@ endif::git-diff[]
> >  +
> >  Note that despite the name of the first mode, color is used to
> >  highlight the changed parts in all modes if enabled.
> > ++
> > +Word diff works by finding word-level changes within each hunk of
> > +the line-level diff.  The line-level alignment determines which
> > +changed lines are compared to each other, which can affect the
> > +word-level output.
> 
> The added text may not say anything wrong, but I am not sure how it
> helps the end user to know the way machinery works internally.

Perhaps only the first sentence should be kept and that the following
should be added: "Because of that, using the --ignore-space-change
option is recommended."

Note: Earlier in the discussion, Johannes Sixt suggested -w
(--ignore-all-space), but this is wrong, as

  git diff --word-diff -w <(printf foo) <(printf "f o o")

gives no differences while one has 1 word "foo" vs 3 words "f o o".

However, --ignore-space-change is actually not even sufficient
since

  git diff --ignore-space-change <(printf "foo bar") <(printf "foo\nbar")

finds differences though there are only space changes (thus this
may affect hunks in case --word-diff would be used too). However,
I suppose that the cases where --word-diff --ignore-space-change
would not give a "real word diff" would be quite rare in practice.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)
