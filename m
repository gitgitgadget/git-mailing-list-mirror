Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E038DE1
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742788206; cv=none; b=Qlfg4Xaw6XKn3JIhxWScwwxuCnNiCNc1R27YjC6RM88fiJP2TSyYtDqE5kqoojxsF7dn7pHSfXq/XDuByz4xJW3FmZN+WhcJkqRzykXu/N2smAE8GzeVLfP+eHWKVySk/PdQL63SxWyT7mv4U/AXBEpEWjBpz6RDk6KhTzXazfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742788206; c=relaxed/simple;
	bh=CN+taw45goUY2IvJrZAtJSRb9ounN/TNnz/Ym4iNZig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loMGlODwfcPdaW3MVvdkNdj771zNDUeZYTm7yjHr5bxRbmNHl1et4ngxzWD7Vd/qShvmcUnZWyCfXV8lv1I5E56G1hX0LsZ+LDbLz3GlfBID6M/iBAfoKDNLr61CxNVydxf4sh58UWsaE4x6Hnqp3opP36SdDzZSMnA3k5Jc5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SZ9HPvgT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SZ9HPvgT"
Received: (qmail 15581 invoked by uid 109); 24 Mar 2025 03:50:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=CN+taw45goUY2IvJrZAtJSRb9ounN/TNnz/Ym4iNZig=; b=SZ9HPvgTHcsLtn5iEJSI5UTQr3ifGMuZdzVGTINRf3ren3vsCD/4Rb27HO9LMXwdaQOjp3JtB1rIE0jbj7c7H+3a7VJI+EW9SY2sCZ1dfkY2cIIKiDoipbbdHWMq2IGTHLCdrOIPiIY/Z+6MOQwvk684vgp74IvjDNpPQbzpx1x4OywrW9LETBEzCGUoQOCnkxhjjdTUCx8iM8S+GARRUNen7k/Hzh87dZmwPEL8vE+Dc5Po/c8FEqjkXmRfGUwaExA52gQ3ucZ/wMVdLatH6musnvgafdnAj+ef65pPleVJK6wnl/9Rnc1E3kWzkWgejxGGGzqVJ6BSl/jl7g2x6w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Mar 2025 03:50:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17391 invoked by uid 111); 24 Mar 2025 03:50:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Mar 2025 23:50:01 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 23 Mar 2025 23:50:01 -0400
From: Jeff King <peff@peff.net>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] pretty: simplify if-else to reduce code duplication
Message-ID: <20250324035001.GC690093@coredump.intra.peff.net>
References: <cover.1742367347.git.martin.agren@gmail.com>
 <5f787ddac2d80391feadb8cf6be379fc8e58652f.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f787ddac2d80391feadb8cf6be379fc8e58652f.1742367347.git.martin.agren@gmail.com>

On Wed, Mar 19, 2025 at 08:23:35AM +0100, Martin Ågren wrote:

> First we look for "auto,", then we try "always,", then we fall back to
> the default, which is to do exactly the same thing as we do for "auto,".
> The amount of code duplication isn't huge, but still: reading this code
> carefully requires spending at least *some* time on making sure the two
> blocks of code are indeed identical.
> 
> Rearrange the checks so that we end with the default case,
> opportunistically consuming the "auto," which may or may not be there.

OK. The duplicated lines are not all that long, but I don't mind
collapsing the cases, especially with the explanatory comment that's
there.

> In the "always," case, we don't actually *do* anything, so if we were
> into golfing, we'd just write the whole thing as a single
> 
>   if (!skip_prefix(begin, "always,", &begin)) {
>     ...
>   }
> 
> If we ever learn something new besides "always," and "auto," we'd need
> to pull things apart again. Plus we still need somewhere to place the
> comment. Let's focus on code de-duplication rather than golfing for now.

Yeah, I think what you wrote in the patch is much better than trying to
golf further.

So looks good to me.

-Peff
