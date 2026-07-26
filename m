Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9825776
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785057717; cv=none; b=B0OcTvyaB8qTfh595nL5Q8WTYqSkpkK1x7zJe57qeWlEzde002h5J9swQYrWp2le3tNncBR/0AUwKlwYKQrfs1VkvmUTHenIcK1zKKEeKAPMsJen8zX6mnOYNK55aEvE9IPJ0unWvTyOUiRrwjgc4hRUHQr/7/0uPw/5WiRr6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785057717; c=relaxed/simple;
	bh=+BkuLRFKwDtVDBNCTjisDpc8vBl09q4YX7ZXV+6zoio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU+P8OYdkiHQZ1c93e1FfrnZwuY6y1bAFieP0sdtC51mejtFAsaXEXBIzO4SVaZq8xxNOhiwHYjC6LT56epiqiisjmibrq2eJdRyGUNXbIfXKCGsimO5BgjgaPXLWUjTJwXfpiZ+RQyg3+fmt/kFQQOponh5ZS7cUSFEyXB+H48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H7nY2Lq3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H7nY2Lq3"
Received: (qmail 57184 invoked by uid 106); 26 Jul 2026 09:21:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+BkuLRFKwDtVDBNCTjisDpc8vBl09q4YX7ZXV+6zoio=; b=H7nY2Lq3WaJ5ofi4kDhVFj58yYKQZ7Ik1eohQiQsFfW8G1lTOsWUnHNhJ7mUZF+9ycnmTxbnMWouWb66M8EvBn3LotVHrsPlfvyqKr8c0ba8vQ0BxxVN3UNbV9pFHebs7s6Heqr0nkvb7PBwtNvvMsDaAjDtW5UEEF9kbi+89LqKII4M/oenrHysMXHPFB0CADrB6IsDy3ocBqLjkM58xMO0LsMaIp2fwgG4LAhIg/3gDtghzkAWGyq6Qod6AY/0nUAH2RvC2W7wsbA4BgDGFVKug/PTv53nrXcZnMSa+0uqiTRqibJnlMp4L0m59YJ8gqeOG9LWboKFcYMWr/IwEA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jul 2026 09:21:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 58285 invoked by uid 111); 26 Jul 2026 09:21:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jul 2026 05:21:58 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Jul 2026 05:21:53 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, ps@pks.im,
	karthik.188@gmail.com, sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: Re: [PATCH v5 0/3] packfile URIs: support concurrent downloads
Message-ID: <20260726092153.GB3529827@coredump.intra.peff.net>
References: <cover.1784874850.git.tnyman@openai.com>
 <cover.1785047139.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1785047139.git.tnyman@openai.com>

On Sat, Jul 25, 2026 at 11:44:45PM -0700, Ted Nyman wrote:

> Changes since v4:
> 
>   * Clarify that the first --index-pack-arg specifies the command and
>     subsequent instances specify its arguments.
>   * Drop assumptions about which concurrent response reaches the
>     staging file first. Either write order exercises the same
>     overlapping-download behavior.
>   * No production code changes.

Thanks. I hadn't really reviewed the code in v4 carefully, but I did so
for v5. I _think_ it is all correct, but it there are a few confusing
bits in the middle patch that might be worth breaking apart for
readability.

I could live with it as-is, though.

-Peff
