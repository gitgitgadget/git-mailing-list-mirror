Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1F15EFAF
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 23:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753978; cv=none; b=KkoC/GVWgQvPZPU5T5sthp5RQ5Oee/P2VlCBn4ELCoovDN88GCG988WcjXSuCCMEg8LvZC2nkoW6LbuTBOC7z51+vGOHniQ55wAnS40JisWe4KDAf/R6pqfE2sU88w7Fq8nJAKuLYiIe5llwE5i1Yjq0Z/7UDhctzuoQUAAgcGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753978; c=relaxed/simple;
	bh=Idu/SR9g8+OJ3MAzGjX/F3Vsfv8H9gIVa78kTQr3/B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMfPSMBAU3xxnLbTSDO7U3A+S+5ImFx3iloJJwxruGgArdWTbmrPaDaOF/z7/B4vGqBgSB4O0hPrHBY24LMKEJ0BMUtJDc1nDgeYxRC8IcxF7ticJGFCFmjgIsoIoxXfUnWZJhmDSom2QRoqOKr34lrurBTK9gCpcrKxzXbb3R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3109 invoked by uid 109); 18 Jun 2024 23:39:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Jun 2024 23:39:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15922 invoked by uid 111); 18 Jun 2024 23:39:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Jun 2024 19:39:34 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Jun 2024 19:39:35 -0400
From: Jeff King <peff@peff.net>
To: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] attr: fix msan issue in read_attr_from_index
Message-ID: <20240618233935.GB188880@coredump.intra.peff.net>
References: <pull.1747.git.1718654424683.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1747.git.1718654424683.gitgitgadget@gmail.com>

On Mon, Jun 17, 2024 at 08:00:24PM +0000, Kyle Lippincott via GitGitGadget wrote:

> The issue exists because `size` is an output parameter from
> `read_blob_data_from_index`, but it's only modified if
> `read_blob_data_from_index` returns non-NULL. The read of `size` when
> calling `read_attr_from_buf` unconditionally may read from an
> uninitialized value. `read_attr_from_buf` checks that `buf` is non-NULL
> before reading from `size`, but by then it's already too late: the
> uninitialized read will have happened already. Furthermore, there's no
> guarantee that the compiler won't reorder things so that it checks
> `size` before checking `!buf`.
> 
> Make the call to `read_attr_from_buf` conditional on `buf` being
> non-NULL, ensuring that `size` is not read if it's never set.

Yeah, this is the same one I mentioned when bisecting in the other
thread[1]. But I got confused by applying my fixup patch at various
points in the bisection, and thought it _used_ to be a problem, and
isn't anymore. It's the other way around. It was introduced by
c793f9cb08, which moved the NULL check into the helper.

That patch is from Taylor, but I'm listed as a co-author, and I'm almost
certain moving that NULL check was my suggestion. So it's doubly bad
that I didn't figure out what was going on earlier. ;)

Possible UB aside, I doubt this can trigger bad behavior in practice.
But I also wouldn't call it a false positive in MSan. We really are
reading the uninitialized value and passing it. Your fix here is the
obviously correct thing to do.

-Peff

[1] https://lore.kernel.org/git/20240608081855.GA2390433@coredump.intra.peff.net/
