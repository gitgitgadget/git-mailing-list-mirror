Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50224379EEF
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775597373; cv=none; b=DKgxBBz3zZyHM+bOnPfxJqUTBPotnSXudqSGoAr8vR//pmdeRnzlOitL9+yPZ/kse3YGx74TZC14wq+lUZz7JG32Ryovqu0barFe82XqxvlgZ+jpPXydG02jG1MU1+OUvcva64QKPI3BMDFuLslKIAQRtReS5WIJOe9Y6EuyRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775597373; c=relaxed/simple;
	bh=lpS2EF4JFZi6facQDiOoFOUkyjl7cUdGCvbHzkURNDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXH8HmzI/W2nxzP/kgumoBvSmTjmFCLvcas/NNiS2G4dHM+oXx8FIzOz9emRzeFhmib1B7Lf8KV20dLAx2IkFnxjgl+AYMQpqIp3d0QvPL4ObKQfaRwomeh06BCuDH/osAYNoXBJP4SbRKxRbue0GjHBUgK3Lm3ZO9gyQ/foRq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=THaE3guh; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="THaE3guh"
Date: Tue, 7 Apr 2026 17:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1775597369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbyXmKgWxTOrg5BToc3uDj5w0oeuIERX1TaGNRc4iW0=;
	b=THaE3guhBQITdJkF2AvWlNiI1rUyGkPjUlikew6USV5uEDuIzR2AUGGOy7uf323F7osgJN
	w0IPECX+TiKl8gK0jLnbwwMxzWLfvw1lNjr7dwESAHuxU36Ccabbni/gj8aW+PNABcovxz
	rRq/zX3gEWZuze1C9dZtblyUlqAcW7s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: Elijah Newren <newren@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	git@vger.kernel.org
Subject: Re: [WIP PATCH] fast-export: emit deletions first
Message-ID: <qrxjw6qtagcfcwbzqjkoy37nu22no6kteskge3lpoyxmumzfqv@35hyc7dys63c>
References: <20260406063607.15353-1-ray@ameretat.dev>
 <xmqqo6jwau34.fsf@gitster.g>
 <20260406212937.GA30202@coredump.intra.peff.net>
 <CABPp-BHhXQc-s8rF1n+AQ0VodX2KuiahcAOcg2msR1eZrUSsCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHhXQc-s8rF1n+AQ0VodX2KuiahcAOcg2msR1eZrUSsCA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On 26/04/06 02:44PM, Elijah Newren wrote:
> On the creator side, I agree that fast-export would definitely want to
> sort its deletes before modifies to avoid D/F conflict issues.  That
> doesn't help with renames, but I agree with you that the answer for
> renames is probably "then don't do that."

fast-export does force 'R'enames (of a to b) to appear after other lines
operating on a, 4ce6fb80 (fast-export: ensure that a renamed file is
printed after all references).

I think all Ds first works for the patterns fast-export actually uses.
According to a comment, the reason it's sorting by depth at all is a
subset of this, to put D a/b before M 120000 a, or similar.

The additional roundtripping tests I'm writing should handle all this, I
hope. I think now is a good time to get round-trips down, since people
might potentially use fast-export | fast-import to switch hash functions
(when commit and tag resigning are fully in fast-import).
