Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAF3CDBC6
	for <git@vger.kernel.org>; Mon, 25 May 2026 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693349; cv=none; b=YBi6ZkqmUIAFxtr1EyZ4qrWdK9thJBJMLMvzogOqZpMU+x75JhUbS5MCAisdt7Z8Kj/LOHVyeH9DKPwy339kGFWabTIZqyQlcAOh5uWrC61ih2//3EVkFV0wSWLY2uplH7sygs1rrSjDqIRMr+zzfeg2MofOY+2IijJIjZL9etM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693349; c=relaxed/simple;
	bh=YwOpp0PgEiQYNNTH3ZaMbc77Q2kRl4h2KC4dKvNEK0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzQ/99q/1l3gijmibvnxGqGh4Ul4j7zGPXPNhKcWGbeByUzIB6VzDz6iReLp4LqjSOajGnPz17A+Y2sMrhekxSRPYogPgsTyXbODEkvzahL0GpGLr8UrQwy9pvoAiClQr7+QaOQu/dsUKY7tqze2XNJjMox7a/k/5cCIY6oR9xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LoUqyJvM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LoUqyJvM"
Received: (qmail 10087 invoked by uid 106); 25 May 2026 07:15:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YwOpp0PgEiQYNNTH3ZaMbc77Q2kRl4h2KC4dKvNEK0Y=; b=LoUqyJvMuRR3XebQOzb9dDewQ0kuJMxxgSI/mtpmgXdMK+emUMdr2qn6LazGD8qJ9qCnwb9QocUeIfwEycp95rhKGIGiD+DPKkL7/zPGvVQUbfYhGRLS91dgAWcHkRZJs3/1btZAMP6tEiK4bXhArRdISp73GTDnIppofM4Ly5nzKUBznke4+aA3y2xiF9NdeGCSLX+HpeOj+KVBD/dZ8ZaUKs3wv1PTzn/e2Bu/D+9twpNNv/JwyRg1KXMlaEkoh/0B+qdxFSqf+hO0n2u0LYuImdTVEn0Mv9jnUv0QXXh9NCgMAIZin5pE2cQBCRXcNVtEwqMRhipCEVCGoNzZRg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 May 2026 07:15:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13782 invoked by uid 111); 25 May 2026 07:15:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 May 2026 03:15:50 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 May 2026 03:15:45 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 1/3] commit-reach: deduplicate queue entries in
 paint_down_to_common
Message-ID: <20260525071545.GD2737798@coredump.intra.peff.net>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
 <1d3751569ba3a5f0c353fb468578d6c5bcd0b738.1779644541.git.gitgitgadget@gmail.com>
 <20260525070114.GB2737798@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260525070114.GB2737798@coredump.intra.peff.net>

On Mon, May 25, 2026 at 03:01:14AM -0400, Jeff King wrote:

> When we drop all of those queue elements, they'll all be left with the
> ENQUEUED flag set. Should we clear those?
> 
> The ahead_behind() variant doesn't have the same problem, because it
> uses PARENT2 to check for queueing, and then does:
> 
> 	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
> 	repo_clear_commit_marks(r, PARENT2 | STALE);
> 
> So it's cleaning up both flags, whereas paint_down_to_common() is
> already leaving the STALE flag set. I'm not sure how much that matters
> (or if it is even an intentional thing communicated to the caller). But
> now we'd be adding ENQUEUED.

Ah, hmm. We do clear flags in the callers using clear_commit_marks(),
which walks down parent pointers until nobody has a flag we care about
(from all_flags). I'm not 100% sure that ENQUEUED flags will always be
caught that way, but I think the reasoning is roughly: every thing we
queue will either have PARENT1 or PARENT2 set, so we'll keep walking and
clearing flags until we stop seeing those.

-Peff
