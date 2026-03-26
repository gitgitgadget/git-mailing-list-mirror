Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0D34FF40
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551767; cv=none; b=qm8J5Ayz1beP4QCV9vwF9Wif6K00gyPMqhwROJ8A95Jz7hBUUUvskOLI77JsOFjMy14F2FTjoZtszacooobeoqKYg06GTtTHSe9r8aOlhPMnvof4p5EQ3U642SjHrpySypuT94VSvOZh5I7sn2I1tBY7Ods1qsvfrci46bvOPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551767; c=relaxed/simple;
	bh=kHePmVnL0Ll+KRoTEp9DLP3G1E4xna5T3ufCJ0cvU2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRy9BQmbF/ZHIfNudpQAepSv1460w4F7LpIkOWoHk+iulfJ+QLm+xubV8LAkIEXoogccrZO8dI/QmcVGgDrx0YJCXsR3frgigQpmsLZ1bJYQRRpLfiY4e02MkYgj057i4FYipkcqrH+0tJseYXjsUQprb5cdDi+BP7TISDuz5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YifFLWzM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YifFLWzM"
Received: (qmail 155531 invoked by uid 106); 26 Mar 2026 19:02:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kHePmVnL0Ll+KRoTEp9DLP3G1E4xna5T3ufCJ0cvU2I=; b=YifFLWzMkuyjKn2/9MWO8rFmypjGNa85t0vOhYWjcq/kDfubydpI0KMBek5wW+BNhxiJ7aUxVwnBDER74QCIpx1QsCVJ8GOo6PyAJsGUm91v3PMq1LrkRna0OOwln9ZlCKlo2qfs3C3sAn7u8ejUEwm93A58Xl1bqFQXXhPCr+CwAX10x1v3AObI2WHc7nkL9RV0UkrnoWefzoyYCOn3Fd0kiSGX442mx+PWuUDfnQ3ZnDkKnYvK1IkdmqFRzXXDAZQp/EVxIZ8AJ9Y3FVgfmSy18nUSKFqMowYuUy7+1kRKYCQYQnMbD/gAr/MVtV8hI9BJuggZpW/KLFVerFTovg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Mar 2026 19:02:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 215700 invoked by uid 111); 26 Mar 2026 19:02:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2026 15:02:44 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Mar 2026 15:02:43 -0400
From: Jeff King <peff@peff.net>
To: Michael J Gruber <git@grubix.eu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 0/4] fix const issues in revision parser
Message-ID: <20260326190243.GA412983@coredump.intra.peff.net>
References: <cover.1774537954.git.git@grubix.eu>
 <fe9c86af4825a81b2618ae8ffc8be12300058af2.1774537954.git.git@grubix.eu>
 <20260326174204.GC2447148@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326174204.GC2447148@coredump.intra.peff.net>

On Thu, Mar 26, 2026 at 01:42:04PM -0400, Jeff King wrote:

> IMHO the right solution here is to teach the revision-parser not to
> touch the incoming buffers. We do it only to tie off strings, which can
> mostly be replaced with xmemdupz(). That's slightly less efficient, but
> I don't think it would be measurable (it's one allocation that tends to
> happen a handful of times per program execution, and the rest of the
> parsing is going to allocate things like commit structs anyway).
> 
> I have some patches in that direction, but I haven't gotten around to
> polishing them yet.

Here it is. There were a few oddities to untangle, but I think the
result makes the whole thing a bit easier to understand. I may be biased
as the author, though. ;)

  [1/4]: revision: make handle_dotdot() interface less confusing
  [2/4]: rev-parse: simplify dotdot parsing
  [3/4]: revision: avoid writing to const string for parent marks
  [4/4]: rev-parse: avoid writing to const string for parent marks

 builtin/rev-parse.c | 40 +++++++++++++--------------
 revision.c          | 67 +++++++++++++++++++++++----------------------
 2 files changed, 54 insertions(+), 53 deletions(-)

-Peff
