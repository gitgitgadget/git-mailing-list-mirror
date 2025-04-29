Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F922A7ED
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963922; cv=none; b=p1EeU3gxqTRoiHVl3ZrJuhZRdYg2BIUfCSkxKwYLwo0J/7350j1ZZEil5XIV0GnGSdNlE5BKi7vWFH304h4DwhDPc9mOL/IDJxph9CeAjqy87CceiEWof4ux6ZSTZidwm3+6i/O+rBEZufyYIKeQTgtkzJIXs5JOniOzo02QLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963922; c=relaxed/simple;
	bh=3z5x4fogNNlSQdQwse3Yk6Y0ngousHOoBO3bTDynfKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok8WZMxEGqrv4sskwojIqLRu//kgozuSkPgg3FvEx2566eD9CXzznJrNfWgluaQxDG0CNQJGyPxTJeCOEf+Eb9jyLSaq5BBUCsWcZLEzR0iyGCZMBS0DV2zHPwtPgBKE8cr0+ogSiUYzfKI8xqj7bNkXu3bNx+DmajcH8XhdzaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=X4SNdx6C; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="X4SNdx6C"
Received: (qmail 8611 invoked by uid 109); 29 Apr 2025 21:51:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3z5x4fogNNlSQdQwse3Yk6Y0ngousHOoBO3bTDynfKY=; b=X4SNdx6CL0IGsVclwngYKGirZdHt6W+67qDtPMTopoFD52IVW2qYZSLDbZLCLnL3Ryu9oMR5JZh3W9fRYCmgCj1UlTBxIg1JP8pb8oe9gkvkvW27F53C4UFnsBjGfbEU13M8BbF50k8xK81djy+el1uwp12lbg3IQnUxx5s3i+ZKp9+Vk1UQ9keM7c9i8Zcr0xWQ3crjg/I5be9gEVjLQDeah63dpHzh6bxLl6FoYTFzMogaahh3odQodCNAxHENnJM4qXERxoiMkc9LLyXWy0MCmNOq9W1msw4h0orFRawtsxAZfftgeddSQRlSsSqpRJgiK8hI4Cgx2ySiCJB5gA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Apr 2025 21:51:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13501 invoked by uid 111); 29 Apr 2025 21:51:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Apr 2025 17:51:58 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Apr 2025 17:51:55 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [BUG] rebase: can write reflog with uninit. `action` string
Message-ID: <20250429215155.GA36727@coredump.intra.peff.net>
References: <20250428194048.149348-1-code@khaugsbakk.name>
 <ce0f41e4-7d90-4398-a0e9-e8ba69791e57@gmail.com>
 <fbc97d6a-2022-4a64-a2ba-5a7255cd81a6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbc97d6a-2022-4a64-a2ba-5a7255cd81a6@app.fastmail.com>

On Tue, Apr 29, 2025 at 09:40:13PM +0200, Kristoffer Haugsbakk wrote:

> On Tue, Apr 29, 2025, at 11:22, Phillip Wood wrote:
> >> #0  run_git_commit (defmsg=0x555555babe70 "<repo path>/MERGE_MSG", opts=0x7fffffffc070, flags=0) at sequencer.c:1158
> >
> > Thanks for the backtrace. It would be useful to know what's stored in
> > opts->ctx->reflog_message at this point if it's not too much trouble
> > please can you run "print *opts" and "print *opts->ctx" here.
> 
> Today I ran on f65182a99e5 (The ninth batch, 2025-04-24) at
> sequencer.c:1148.  I was never able to reproduce this
> `opts->ctx->reflog_message` having a weird value with GDB today.  The
> reflog was also fine.
> 
> Then I ran without GDB and I got the weird reflog that I expected.

Have you tried building with "make SANITIZE=address,undefined"?

This is a wild guess, but since ctx->reflog_message is pointing to a
static strbuf, it could be a use after free if the strbuf is reallocated
due to another call to reflog_message(), but we are still holding the
old pointer via ctx->reflog_message.

-Peff
