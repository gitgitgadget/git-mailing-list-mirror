Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474221ABCB
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172807; cv=none; b=n2mw6qzIG7QS9gMzlhg6SuT7BtV2fnxCpzj0fMlTgC9Y/d7ZBzqie/K6+loHiW7KuZXJwOfk7zZYnxBCLtPy4mNowvvGNYMXk0k9Hak78cdYdsE8r3Hp3y2Fv6mIMHheqv/b1d8kT0iUBJ5ogo2xDBFMzdf0MbiTTqnXiNrsrE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172807; c=relaxed/simple;
	bh=0rZDN+FwUcOxvP6KTkZkGM4yasPVELfAX7s9tZ4LNNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H36iaC+z/VffoB+PC1JgMu7cww7MUBPTmkzeW8GLCq5yNidnDOo1txm7xCeg4ExEdZLHpxBte47Bje+WgLv5lJZ18byl2wlq5+H9OqlVPiWwad8EnY9aVrDWc93rROujtQMfOLea2iw9Yhm8rJnbdIHin5FSEm4BuitA1qD6Zac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Q5H+/7Vc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Q5H+/7Vc"
Received: (qmail 26904 invoked by uid 109); 22 Jul 2025 08:26:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0rZDN+FwUcOxvP6KTkZkGM4yasPVELfAX7s9tZ4LNNk=; b=Q5H+/7VcPEi2FU7sE6i1NISjK7kJqRkgc4NBQ/j4lBEAoNdaWNH1QT9++xGevTJw6azL7YGsjdi3iJxc6LtNedPsajDyI7ENhhowCwWCQzJiCMHYpBHBaGxP6787yqK0lNZAtAfkLOlxB3zf0byfRs7xr06FS6GmIjIZO1VwIxrzrF2SP63J7dutfHs2J1ANbWBk4b3Lq75gukQlRd9BOEZcNC//MZfjb0RkMJx214VK6+YNG0uED25axAlgKuc5tQCs2hypHdNAmH6hObDTANJ7B7fjQs5RS7e6AwAZhzAzcUUI40e17m4Erk3DpEFvMGhDkkI9oGxIzcoz4j8t5A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jul 2025 08:26:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26616 invoked by uid 111); 22 Jul 2025 08:26:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jul 2025 04:26:48 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Jul 2025 04:26:43 -0400
From: Jeff King <peff@peff.net>
To: Hoyoung Lee <lhywkd22@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] t/helper/test-delta: close fd if fstat() fails
 after second open()
Message-ID: <20250722082643.GD862006@coredump.intra.peff.net>
References: <20250722081219.1086866-1-lhywkd22@gmail.com>
 <20250722081219.1086866-5-lhywkd22@gmail.com>
 <20250722082557.GC862006@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722082557.GC862006@coredump.intra.peff.net>

On Tue, Jul 22, 2025 at 04:25:57AM -0400, Jeff King wrote:

> >  	int output_fd = xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
> >  	if (output_fd != 1) {
> > -		if (dup2(output_fd, 1) < 0)
> > +		if (dup2(output_fd, 1) < 0) {
> >  			close(output_fd);
> >  			die_errno(_("could not redirect output"));
> > +		}
> >  		else
> >  			close(output_fd);
> >  	}
> 
> Ah, I guess you found the problem from patch 3. But it should have been
> squashed in there, not to this patch. (But as I said there, I think we
> should just drop patch 3 entirely).

Er, sorry, I meant patch 2. Counting is hard.

-Peff
