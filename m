Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15977F2A
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235802; cv=none; b=P6ZedGuXBwaNjd13gisdXHSPoc+et8R7RcAsOPIvvVoaHBuVuHxFSPnwf3kOAnyPuRqNtYXVGr3YEBTGVUWAsUzls2PQ3YLz/TdMm3k5ksCvbviSJca1ksn1fiSLCFgWlof9JnUtf3FmPJjYVS2VKsZLmld34mdjiIRbwEZBNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235802; c=relaxed/simple;
	bh=9nYds4Ki/El2pChf4T2WVOJs8xkijJVUxXSRQKyKVko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ndemy8MtIGOaR6nmMFlHm0shB6cfsohlSflIodp9kC+zEZ2k1NycHy4n9DotbuG84eTadXfaLApRFy3iMavWlBsIHEHs1gvpLppIZeuGS3OoPPm7vKHl6EvNZlBGSB1UxSJIYeCM+Apv0WqIIp9M88Xec+tiS7pnJ7kliJfRHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17822 invoked by uid 109); 12 Mar 2024 09:30:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:30:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28390 invoked by uid 111); 12 Mar 2024 09:30:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:30:04 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:29:59 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] log-tree: take ownership of pointer
Message-ID: <20240312092959.GA96171@coredump.intra.peff.net>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <3b12a8cf393b6d8f0877fd7d87173c565d7d5a90.1709841147.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b12a8cf393b6d8f0877fd7d87173c565d7d5a90.1709841147.git.code@khaugsbakk.name>

On Thu, Mar 07, 2024 at 08:59:35PM +0100, Kristoffer Haugsbakk wrote:

> The MIME header handling started using string buffers in
> d50b69b868d (log_write_email_headers: use strbufs, 2018-05-18). The
> subject buffer is given to `extra_headers` without that variable taking
> ownership; the commit “punts on that ownership” (in general, not just
> for this buffer).
> 
> In an upcoming commit we will first assign `extra_headers` to the owned
> pointer from another `strbuf`. In turn we need this variable to always
> contain an owned pointer so that we can free it in the calling
> function.

Hmm, OK. This patch by itself introduces a memory leak. It would be nice
if we could couple it with the matching free() so that we can see that
the issue is fixed. It sounds like your patch 2 is going to introduce
such a free, but I'm not sure it's complete. It frees the old
extra_headers before reassigning it, but nobody cleans it up after
handling the final commit.

We should also drop the "static" from subject_buffer, if it is no longer
needed. Likewise, any strings that start owning memory (here or in patch
2) should probably drop their "const". That makes the ownership more
clear, and avoids ugly casts when freeing.

-Peff
