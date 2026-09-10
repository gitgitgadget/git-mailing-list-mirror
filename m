Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B82568552
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067117; cv=none; b=oYGL8BiQGeiNzGqTapxyeHPzkXGY61x36VgsqJCEAeUYg9jb640rLcup/b0k8K8UQkhWuhwGNcIJiS8iXqrr3y2ahAdGxopEmFCUP2gLkv2nMn0W+2IV761qDIrZq4CAoIfvzskElcP9kS+E4aBq+I+QqsH31FQGvseo5BdHwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067117; c=relaxed/simple;
	bh=lAv8kBwEIyII4OC6dDhSS9h0nxK2sYLfyx7aOqEjLQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqI7+QWlg7etnxg/WmqKfLu9DimhD2gXQp7tzoIlRePLWUcumZOXGqgQG4U6P2SUva7i0FamG6W0/1OtKRV7Zu8aZUWdM0oyWDVgzHwXJi0bvrN+Wy1yGjUkfDfsy3pVyACwvTGq76paQTF1JPjw7VL//2WhZFqmFXfKj7EIrmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XJmX1BZz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XJmX1BZz"
Received: (qmail 32653 invoked by uid 106); 10 Sep 2026 19:05:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lAv8kBwEIyII4OC6dDhSS9h0nxK2sYLfyx7aOqEjLQY=; b=XJmX1BZzPka8sn3CsNL0TucvJ+3TbVV/8+uIQrhwbA7rsId+snK2e2u/+ApqoJSc3WMdXuVr8BTsPVBxH9ZvaDSGJ35vNdba5ZeiI+rs7M9Qgmh5PN84k6ptjYTolXDFGU23bYxM1Tcl7A7nM57Da6O9xYKc8419aeEvNPFMp2CJ0wo7GGBC+4MGjVMO4A6wAjnLDDz/tshm9+t+fnTiQqU51Lfwt7hIuMuICpVfx6jyJPwz9+rsIlZnX4e82KaLf7ke5GcdUmzdTqyms5XQRfdNk0h+AYB7I2HfWy4MABTuqatTCNFaU6p71/z9UxzHfC+XG4bNwBBBwPz107ancg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2026 19:05:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 160420 invoked by uid 111); 10 Sep 2026 19:05:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2026 15:05:13 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Sep 2026 15:05:13 -0400
From: Jeff King <peff@peff.net>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
Cc: ben.knoble@gmail.org, git@vger.kernel.org, gitster@pobox.com,
	gitster@pobox.me
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
Message-ID: <20260910190513.GB903701@coredump.intra.peff.net>
References: <20260910155247.GA251185@coredump.intra.peff.net>
 <20260910175416.115280-1-ub4nal@mail.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910175416.115280-1-ub4nal@mail.ru>

On Thu, Sep 10, 2026 at 08:54:15PM +0300, Vsevolod Myalitsin wrote:

> > I'm really not sure why anybody would use those other flags, though (or
> > even --system, for that matter). After reading the thread again, I get
> > why we want "--global" for advice that only affects new repository
> > creation (like defaultBranchName), since otherwise it could never have
> > any effect. But why would you ever want --system?
> 
> I initially looked at Junio's suggestion and, based on his experience,
> didn't argue with it, and then I didn't come back to that message. I
> think the patch should contain not + enum config_scope scope_hint; but
> + bool is_global_hint;, since I myself can't find any scenarios where
> advice should be disabled at the system level.

Yeah, it feels like handling arbitrary scopes is introducing all of
these extra questions. But all we really need is that original bool you
had. I think there's some YAGNI principle here, too. Later if somebody
comes along and really wants to advise the user to use "git config
--system", they can do the bool-to-scope conversion then. I'd be
surprised if that happens.

-Peff
