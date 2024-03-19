Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130B1CAB2
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883784; cv=none; b=fZ0qwn8ty+Knivn+F21YQ1Mx3qB352J6LiqZwj7WM1dL5RkTcTAH7HQhcVaN7W9BvRanom7gh1O4SGL+6w9ivfKS9xYJ4+r63+ox3Pave4xTjSxluz4L0l4CrS/tkSCNombGFTsawHRf0MikMfZAHnug0E+xFo53Cf27L1dMgfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883784; c=relaxed/simple;
	bh=I7bHLaSrBkSYo42rko32Hgowz3f13HpZ+oziuZ6B5KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjiO6ZwejrV/gjtrFIE9WiBLrHmQMtYtiKUTyUXKmY7z/KO9alZfTm85CisB4M0tSZfiOsYmra4ajmTCHVo4pNgGo8l4AFUQD2ieF4ymTu0hA8Hpkh2NiNL97esW5a0zPW2c0XPeTmACmm4vnRjlUpU15RfJx5SA6YT27vnmlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3764 invoked by uid 109); 19 Mar 2024 21:29:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Mar 2024 21:29:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11809 invoked by uid 111); 19 Mar 2024 21:29:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 17:29:43 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 17:29:40 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] revision: add a per-email field to rev-info
Message-ID: <20240319212940.GE1159535@coredump.intra.peff.net>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <cover.1710873210.git.code@khaugsbakk.name>
 <9a7102b708e4afe78447e48e4baf5b6d66ca50d1.1710873210.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a7102b708e4afe78447e48e4baf5b6d66ca50d1.1710873210.git.code@khaugsbakk.name>

On Tue, Mar 19, 2024 at 07:35:36PM +0100, Kristoffer Haugsbakk wrote:

> Add `pe_header` to `rev_info` to store per-email headers.

It is only just now that I realized that "pe" stands for per-email
(though to be fair I was not really focused on the intent of the series
when reading v1). Can we just call it per_email_headers or something?

> The next commit will add an option to `format-patch` which will allow
> the user to store headers per-email; a complement to options like
> `--add-header`.
> 
> To make this possible we need a new field to store these headers. We
> also need to take ownership of `extra_headers_p` in
> `log_write_email_headers`; facilitate this by removing constness from
> the relevant pointers.

There are three pointers at play here:

  - ctx.after_subject has its const removed, since it will now always be
    allocated by log_write_email_headers(), and then freed by the
    caller. Makes sense Though it looks like we only free in show_log(),
    and the free in make_cover_letter() is not added until patch 2?

  - rev_info.extra_headers has its const removed here, but I don't think
    that is helping anything. We only use it to write into the "headers"
    strbuf in log_write_email_headers(), which always returns
    headers.buf (or NULL).

  - rev.pe_headers is introduced as non-const because it is allocated
    and freed for each email. That makes some sense, though if we
    followed the pattern of rev.extra_headers, then the pointer is
    conceptually "const" within the rev_info struct, and it is the
    caller who keeps track of the allocation (using a to_free variable).
    Possibly we should do the same here?

I do still think this could be split in a more obvious way, leaving the
pe_headers bits until they are actually needed. Let me see if I can
sketch it up.

-Peff
