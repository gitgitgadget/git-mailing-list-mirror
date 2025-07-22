Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52ADDBC
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173319; cv=none; b=VwwRV7lxqoFC3+2ML5T7x1r5Z/kKw9saOu6TsA6UGwPZFFATE6CJiZ1NWH+N3kGcHQS08nlX5miblh1HAcCvmKywbQ8e3uJVdrrDdSn5BsDwkPndvivBnmCnhUbaNmo4cVrgBWLFNgFNeyX1mez+D9kx16+jlq5pY+LArHXU/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173319; c=relaxed/simple;
	bh=Y/sxtydDnCjue6OrqN8wCxFFv0yAUHk1UqC6c9kMTGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5ArcsZQ3LCdxBxTcgOswrCQ7xG3mdJsqa6GvfQsmUYN4BAQS6WD1q1KyLjWVpbjBfqNLLEshIDEGe45KmGYDjx+YJOQOEMEHEW80DP0M09fr9PbIuWPL4K3rHtWLy0Aew25fyQMDCIGgfOXF7AJY+U5xtVKvaxUnu2sQsXZAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WhPPsTlh; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WhPPsTlh"
Received: (qmail 26930 invoked by uid 109); 22 Jul 2025 08:35:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Y/sxtydDnCjue6OrqN8wCxFFv0yAUHk1UqC6c9kMTGk=; b=WhPPsTlhYOeYSxsJAKWGIjEn0V9cGKf4NNBOeEnnxocXKkSIElinReJp7KFjUTVzJpHCwLjs2Fbm48OcsXAwHAz9bfdmCbCNDde3zEMuFI0LLDVc7c7zvhDFDCbCBzNivev7T6hxbQacbSclBbzVvFxQmmLDVEIEvD1d60XzhDFUG5FZSSjIdJfoggdE2ZdURTR7lj0Q4VW4sClyykDVyNt3OXuiVk1ZO4VxZMhZXi7k5Id/QjSkwbUktKSpVzArHG5nDhYYNrzGh2CzTrMPgOTE88rcPAzsMXDeKNUCI4p4wEdO8U8chF9E+1RcsWTrMQz8n4BjlBZ4Ym6cLl3dPA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jul 2025 08:35:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26696 invoked by uid 111); 22 Jul 2025 08:35:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jul 2025 04:35:21 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Jul 2025 04:35:16 -0400
From: Jeff King <peff@peff.net>
To: Hoyoung Lee <lhywkd22@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix resource leaks in various helpers and builtin
 commands
Message-ID: <20250722083516.GE862006@coredump.intra.peff.net>
References: <20250722081219.1086866-1-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722081219.1086866-1-lhywkd22@gmail.com>

On Tue, Jul 22, 2025 at 08:12:15AM +0000, Hoyoung Lee wrote:

> This patch series fixes several cases where file descriptors were not
> properly closed on error paths. The changes affect helper programs and
> a builtin command, and ensure that system resources are correctly
> released before returning from the function.
> 
> Each fix is minimal and follows the existing style of the surrounding
> code. These changes help improve the robustness of the code by avoiding
> potential file descriptor leaks.
> 
> Hoyoung Lee (4):
>   t/helper/test-truncate: close file descriptor after truncation
>   builtin/archive: close file descriptor on dup2() failure
>   t/helper/test-delta: close fd if fstat() fails after open()
>   t/helper/test-delta: close fd if fstat() fails after second open()

I looked through these and I think patches 1, 3, and 4 are all good
(minus the fixup for patch 2 that snuck into patch 4). I responded to
patch 2 in the v1 thread, and i think it should be dropped.

In each case the descriptor is leaked before exiting from the main
function, so they're not practical leaks (the OS will close them for us
anyway). But it seems reasonable to me to close them anyway. It's a good
general practice, and it could help with any tools that try to
auto-detect leaked descriptors.

Out of curiosity, are you using such a tool, or just finding these
manually? I could imagine coverity or some other static analysis tool
finding them. I've never seen a tool which finds descriptor leaks the
way we find memory leaks with LSan, etc. I'd guess it would be hard to
distinguish "reachable" global descriptors that are meant to be held
open versus true leaks (doubly so when we call die() in the middle of a
deep call chain).

One non-obvious thing to consider in reviewing this: sometimes calling
close(), or any other syscall, in an error code path may clobber errno,
breaking a message we may print (or even confusing our caller if they
check errno). But I don't see any problems in these three sites.

-Peff
