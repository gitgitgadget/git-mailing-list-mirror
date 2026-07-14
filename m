Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1A377A97
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784065786; cv=none; b=sEGijgc+1Gnlc1Io7PJ4jkaXp4LbGUv0NH1Iy+d8KEiEFAazNpKPfXdfdLZ7383BFJgr7RLsLTu6r4gNbiCAS3J9t+Dg65kp9LlvnlyWojLgsTkiO8zXtXyQSdyUBq6kngKwig3QVvQikVMsKToKvwKnZf0saFdNotBZeWQrrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784065786; c=relaxed/simple;
	bh=N4g8k0oQlt7mnXBK2nNXspbxRPs+JWLLWeOtHL5MEhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFSIskvQjYqrOa7Mtq/LSfFkShDP3y1XojoWNFf0cL5I8jJWkKQ4E8iri5MUejjGLN/Czfm7984pD6ilAG7yT0v+o8rJPwVVMCJK/NHII6g02tcMj0xgOg/158xVKrzZw8nlMP/JAOzE5eLdEgeSdOjbSFgukfwKNEroWQBhrYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bR2gTyz7; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bR2gTyz7"
Received: (qmail 25900 invoked by uid 106); 14 Jul 2026 21:49:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=N4g8k0oQlt7mnXBK2nNXspbxRPs+JWLLWeOtHL5MEhA=; b=bR2gTyz7ZiaI/lJf+hOovwJAfk9HIyqadNx1QU3w5Ooqoo5fjapUx2QjDfTb40OMzlQ1vZrwKB3dsRXVewjNJGXrpn7v6mpi/+wDIbkIlYWSxjtnmISs6wW4lmHq7fT1UGWtM3agHuKchwo6wAaQVxuUrQJYBZN/gxAFcez645WcplyE7x2PzvYmfbUASe4XpbcKEvZWil/hxA5tab0k4Zgy1AOvCj6dgJp2rTxDT9QZsvEiuiCN7C7zsGD/BdYNFzgtQKsqZJQTw/VxWnfTaUyNCcvP55xXmY9IA6y2sOQusXvSHQMBzBkGT3Jy3BzXguGjQciwyJLF8RvqWy/TvA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2026 21:49:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 53584 invoked by uid 111); 14 Jul 2026 21:49:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2026 17:49:44 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jul 2026 17:49:41 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: avoid redundant reset in strbuf_getwholeline()
Message-ID: <20260714214941.GB4095533@coredump.intra.peff.net>
References: <d4ffe7fb-f782-4f06-9e3b-f72729d1e225@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4ffe7fb-f782-4f06-9e3b-f72729d1e225@web.de>

On Tue, Jul 14, 2026 at 10:45:59AM +0200, René Scharfe wrote:

> The HAVE_GETDELIM variant of strbuf_getwholeline() calls strbuf_reset()
> on the strbuf before handing it over to getdelim(3).  This is
> unnecessary:
> 
>   - getdelim(3) doesn't care whether the old buffer contents is
>     NUL-terminated and has no access to ->len,
>   - on success getdelim(3) NUL-terminates the buffer and we set ->len,
>   - on error we either call strbuf_init() or strbuf_reset().
> 
> Remove the superfluous preparatory call.

Good catch. In the original version of strbuf_getwholeline() we were
missing that reset on error, which is why this was included. I think
it became redundant in b70904306f (strbuf_getwholeline: NUL-terminate
getdelim buffer on error, 2016-03-05).

-Peff
