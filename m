Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0C45FFB8
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405064; cv=none; b=JVHok6INvxUR2nGQ98NG2xDbIRuZQ9ht7qxxH6OfHpyN8ou6cAsa18jo/ufP/NGMaH72qY+HQhdj9nqtc8sTJ8UzFFVDKcm9sdXfrG+y3TZd3r3kRnbCZGqaPrdm6QFBQ6oKz0wCDgpB5gqtFbdtvqXQseW4Q217myHBClUTeUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405064; c=relaxed/simple;
	bh=ykSv7mNIBpvW1PTOJEwS5UVhW7SdBdGHJNEYVmkWtKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9sWkHGjsiccvjWWHfxs9h3PK8B0VOC5jRjTmDgf7yeJCKFq5Cb9cRE0gD9Hw9P0TmYdD8W/uIfky0txrbMPE7Nj7pB5f0Rr77D7HdrAj1FrnslGAXxIFUdoJfk6QNhX1xx1BUApudt5lNzHXGGQklMB2zhZ9rINtuR2LdKGROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dK8TsI4S; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dK8TsI4S"
Received: (qmail 5731 invoked by uid 106); 14 Sep 2026 16:57:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=ykSv7mNIBpvW1PTOJEwS5UVhW7SdBdGHJNEYVmkWtKk=; b=dK8TsI4SvO1b6sPHOA3bLM86Ybl4u//d1SsH18fTVs99UoxBG80b2yrqcDT4T2KinpX4UgO8p7EtQtNXbH0OKzS7/9FR9nziddXYwYfVafCw4KMBAUC//dCZDqLo8VP9xXvzCXvSMPP3sEl1CT0OglPSKVi91DlKqvOKiDxbdRZOx2IHtywsuC2gIdvRXFrkbzfmSJQ8Pp7lAKZGDjtif7vcbQozthcTJx/saleTBbQDsI/Bdb4Gls9hheQ3LT/lRfWiD4PUfL08T4JMHXaDBkQ1vP7qNot6NEueemtee5unCxJgr4dY5hj56zg3RAiMbHJrCU2BAa5ccgFY8OUQ4g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Sep 2026 16:57:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32438 invoked by uid 1000); 14 Sep 2026 16:57:41 -0000
Date: Mon, 14 Sep 2026 12:57:41 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
  Jean Delvare <jdelvare@suse.de>,
  Usman Akinyemi <usmanakinyemi202@gmail.com>, Taylor Blau <me@ttaylorr.com>,
  Junio C Hamano <gitster@pobox.com>,
  =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 3/3] merge-ll: use tempfile API for external driver
 files
Message-ID: <20260914165741.GC32247@peff.net>
References: <20260911171044.GA1609692@coredump.intra.peff.net>
 <20260911171339.GC1610200@coredump.intra.peff.net>
 <CABPp-BFyKaByMYZ212O3cB2GD9OjNJNZEO+krf2GGs9vxFYPhw@mail.gmail.com>
 <aqf1Xzug5jbNDWlV@localhost.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqf1Xzug5jbNDWlV@localhost.localdomain>

On Mon, Sep 14, 2026 at 03:24:33PM +0200, Michal Koutný wrote:

> On Fri, Sep 11, 2026 at 11:10:03AM -0700, Elijah Newren <newren@gmail.com> wrote:
> > But maybe Commit-message-mostly-stolen-from?  Much of your commit
> > message is understandably about tempfile specifics, which the original
> > didn't have.
> 
> It's also OK, if you just add me to the Reported-by: chain ;-)

Thanks, I wanted to make sure I credited you but wasn't sure how. I'll
just do that in the re-roll. :)

-Peff
