Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8E2C3254
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771145879; cv=none; b=mZ0WoaC+o+1lcT4F9r6mLrqaB8qRRnn+SJ5x1Yb6Yw1NE2fWm5dldGIStSLhH48Xcel1yQ71u75jEjbsVaMy2/81OogJQSgCF3U62bMt4OXxWcVX1mK7xJFXeUguw6Yo5YRylhBdnKIB+AIioX/O62LnthurtlM7zF/S1wGw/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771145879; c=relaxed/simple;
	bh=IOaekZSVNsGWgD3bNAHwWtW5Xl4yU31gM2sjWtMdFWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qp8UHUnwnT3WJUjcaNJsHbhxA9fTpVOOc9CKKANVfJEI5uJ83DD6DcvfQfSyOdx4TFxuEtc3zw7XNVBNf1IV4p3KWIy6BXQsdjhSl7whGplbJ0Gach/C6IrUK99DNGNJKUYDe7XknDrLalbt2aEFsYQr+5nF/qbQQzBq5tV+4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UPsejCii; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UPsejCii"
Received: (qmail 44654 invoked by uid 109); 15 Feb 2026 08:57:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IOaekZSVNsGWgD3bNAHwWtW5Xl4yU31gM2sjWtMdFWo=; b=UPsejCiiIU4ICy5XznhI3vp9lOhG/n9E83MiUfZzh+1fonR8wSx/87JCccp/ZW1LM8Fjgo3x+39RiARmMZdh82caFXg1PFdkY7I9L16r2VeGvV8K33jbi8L/V/BIrUM6iz2GVfSLtcruZ8v9sKMt/BhC8gzLQYQXkLQ/PUDj1NIvwDWARjH3La/eCQ3lg7ZtlL4JyoP2fMREC/5ggeHIt6D5uDt2QxLG2RkU4lU+4Ak3NfeOXAhFWgUz3bnzrJqAysZwB7ps1e76cqm9SO5eTt0WiGUMuX3Jgcyn9gtn40nBAq/ftLCx7RdlN7l7nejAAUu7gZhV1TSmNuQ0/X91BA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Feb 2026 08:57:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 112977 invoked by uid 111); 15 Feb 2026 08:58:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Feb 2026 03:58:00 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Feb 2026 03:57:55 -0500
From: Jeff King <peff@peff.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] cleaning up ref-filter lstrip/rstrip code
Message-ID: <20260215085755.GA86262@coredump.intra.peff.net>
References: <c752a4a6c750bc485804b43d7b525754e39e5fe0.1771046151.git.collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c752a4a6c750bc485804b43d7b525754e39e5fe0.1771046151.git.collin.funk1@gmail.com>

On Fri, Feb 13, 2026 at 09:15:57PM -0800, Collin Funk wrote:

> I generally don't like the casts like in rstrip_ref_components and
> rstrip_ref_components because they force you to write this:
> 
>     free((char *)free_ptr);
> 
> And the const doesn't really benefit readability, in my opinion.

Agreed. It is especially egregious in this case because the const
variable is called to_free, and so its only purpose is to be non-const. ;)

> That is a bit of a seperate topic than fixing the warning, though, so
> I left them as-is.

It is a separate topic, but I feel like this is a good opportunity to
make this code less horrible. That is, there are some obvious
low-hanging cleanups that make the code more readable, and as a side
effect we clean up the const confusion. In such cases I think it is
worth veering off the path a little.

I was going to catalog the numerous flaws I found, but by the time I
explained them, I had basically written patches and commit messages. So
here is what I would propose instead. I hope I'm not stealing your
thunder nor knocking us too far off our goal.

The first three I hope are no-brainers, and the final one fixes the
glibc const issue. The fourth is perhaps more risky.

  [1/4]: ref-filter: factor out refname component counting
  [2/4]: ref-filter: simplify lstrip_ref_components() memory handling
  [3/4]: ref-filter: simplify rstrip_ref_components() memory handling
  [4/4]: ref-filter: open-code slash search in rstrip_ref_components()

 ref-filter.c | 54 +++++++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

-Peff
