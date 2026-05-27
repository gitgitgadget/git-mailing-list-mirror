Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27BA3E834C
	for <git@vger.kernel.org>; Wed, 27 May 2026 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874033; cv=none; b=DJY3oxUSlEXZPzBOlQybwpQjfgwgEClmYqpRT6au4FmDcVQzYtGV/nvtOyw0DPJeeu9iZYCtlq7gCTSAN2NPA7jrSH+jDvidnXmgJxrM2k2bUYcPFQB0COcW/wGEkuI3eKU3zCy6fa+SJ6ORBT1MzgsFo3gy/iM9L8LzyxCxQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874033; c=relaxed/simple;
	bh=IO0T/j1nd3NlP22mHMulAKivpSLe3Kj/++QJl85M44U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN62SI5Vv0q4g2KMWouFdsT1T6ttdSCtQNgaL9WTcaok64oyhNezQeUBzSsiWexCxZtQ3EJs0Loxq/IjxiTzLwaD59pXaNvy+JZGNUYzINQ6HuGkRV6USsKiteGKChyipbiJzKKYuCxdm1k3EolN0CPON05+QWv24klG/rbmvSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QmH2hc3U; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QmH2hc3U"
Received: (qmail 29007 invoked by uid 106); 27 May 2026 09:27:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IO0T/j1nd3NlP22mHMulAKivpSLe3Kj/++QJl85M44U=; b=QmH2hc3UWmUjNEzRQ1C19eVvSIBs7rDF2fKNbuR8uhi1zELeH/+EK0M0CcZIf7JR7W6fw9xDoWHC5AbL5n8lB62jkd/kgYNEKHJMTWQrwFMW0KNbbwN6NWz6+6maQjtNHZyOgAg+w+viwgdpbIWxT7cIec00REKTUWQfJZMQAZ1bZ4i9DREz7DP0kuJsLNZFgNeMY5zmspSoWGhIVi9auiZHlIk4naHXHTvgiSUGHj9RDh/3w0odDHvM/py+jR9kng0F6SEiJZTSCwbG6WMqxZISbHZUCRUSfV9NmmpZAFSzLabF7LoK11V8OpP83raf1nwZXFqPF1ojdDIDI5hroQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2026 09:27:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 71636 invoked by uid 111); 27 May 2026 09:27:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2026 05:27:12 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 May 2026 05:27:07 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/8] pack-bitmap: consolidate `find_object_pos()` success
 path
Message-ID: <20260527092707.GE981444@coredump.intra.peff.net>
References: <cover.1779207127.git.me@ttaylorr.com>
 <c9a560660949c53575a9b1e81160d25212a1f484.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9a560660949c53575a9b1e81160d25212a1f484.1779207127.git.me@ttaylorr.com>

On Tue, May 19, 2026 at 12:12:44PM -0400, Taylor Blau wrote:

> Both sides of `find_object_pos()` report success in the same way by
> setting the optional `found` out-parameter and return the resolved
> bitmap position.
> 
> Prepare for adding more bookkeeping around object-position lookups by
> storing the result in a local `pos` variable and sharing the success
> return path between the packlist and MIDX cases.

OK. Modulo the missing "pos" fixup, this seems like an obviously correct
refactor.  On its own its hard to judge if it makes things better, so
let's read on.

-Peff
