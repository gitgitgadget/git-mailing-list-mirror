Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6572E3367
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742859999; cv=none; b=ID1HSIHUNyyypK++fwQg3iejGu72psJ9v70AnFcNN0VVhKl3YBrGKQ+2izDgSda1D8xCu+7PqMjnM0pTtwBtBN5p52whw1Ww/kFU80xajbQfc1E2czKaFSKaCCoLP6UQoJzVXDdzi8iLa1Y2PbVwoCwIw+vD7ljNeepelTJ5NZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742859999; c=relaxed/simple;
	bh=3hdJLUfnlxVlYr6kghbbXtDKlYYmAUCRN6gZ0fkacsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmxluJXvpu+xsZpQ/DH8foHeCBQyq5sXaGCbmRW5lzin29uLYTN0yvpWxkOXCwjMVXQskkGtnNz7UJWKjvnM+pxonandeveGZnnkBpUKk3i5To4eohdXQ8HKMSxK2oX1gWfEivru2FmGUBV+EtgmZ9fGIYfx5YBjN1KRnK9QxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E5IQr5eP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E5IQr5eP"
Received: (qmail 24322 invoked by uid 109); 24 Mar 2025 23:46:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3hdJLUfnlxVlYr6kghbbXtDKlYYmAUCRN6gZ0fkacsU=; b=E5IQr5ePe7MLhfpfW0UfdZvdc8b+day+wNBk6GOcEuScqdpYiNdBR42wYmf+z0ZhbMK2bGXgS9bUmyLB02NKUmb8ohG7exwfNAlGQ5kseH0AuS5JnXiIBGosRsdpVlS267m3rjNJzc+ZnzaaSeNXDOX2SzX/XitMD3/7tbyEnT9DET5hQ2zNYZNfnbGgj4WpMlJTAdntF45+4IiFqjYBwQm2/TOydpkHRvmwBYpyr192ZJ4PpJWFQRFSJnyK/DC7ZKs9GrLoildJnvoDy6aVxhYlBv8VtBfRNjCrMijPM4R5roZoTKT2x2B4X9vBDAtYDtk2msL3lugsROpISmTVmg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Mar 2025 23:46:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18021 invoked by uid 111); 24 Mar 2025 23:46:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Mar 2025 19:46:35 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Mar 2025 19:46:35 -0400
From: Jeff King <peff@peff.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org, karthik.188@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3] bulk-checkin: fix sign compare warnings
Message-ID: <20250324234635.GA789136@coredump.intra.peff.net>
References: <20250321200715.3338-1-taahol@utu.fi>
 <20250324214703.7547-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324214703.7547-1-taahol@utu.fi>

On Mon, Mar 24, 2025 at 11:47:03PM +0200, Tuomas Ahola wrote:

> In file bulk-checkin.c, three warnings are emitted by
> "-Wsign-compare", two of which are caused by trivial loop iterator
> type mismatches.  For the third case, the type of `rsize` from
> 
> 			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
> 
> can be changed to size_t as both options of the ternary expression are
> unsigned and the signedness of the variable isn't really needed
> anywhere.
> 
> To prevent `read_result != rsize` making a clash, it is to be noted
> that `read_result` is checked not to hold negative values.  Therefore
> casting the variable to size_t is a safe operation and enough to
> remove the sign-compare warning.

Thanks, this description (and the matching changes in the patch) look
good to me.

-Peff
