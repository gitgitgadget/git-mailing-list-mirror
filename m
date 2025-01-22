Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD8D2135A2
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558147; cv=none; b=hpVUD1GyTXudV3nFuX+v4VsnN5DmF149xZDEImzxwAwAbLF6Grqp3LDGDhyWCHlByQQOUWD0XtBwsOYgqSR24NhFnf8bnnYy0Y2LIINzkEJ7qDADuRp7E60nmNPjwrw0BYzGrvzNbLrHh7pUjLFhaLls+C0E9YRf9dIzF80Fexk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558147; c=relaxed/simple;
	bh=rYdNON7G2MURlnCjLddSblUsIYbJGysWuOABDwuyCiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXT1m1thOtrCdhGvHFY/Bzi1saMF3MSU/p3iCLXp/jW8t9W2IrLNxGfnPruWz9YKSYjmK2xgxTCUrlMIkQ48KdJIU+QbIu8GQb9oTWQcWMFp5nsW3LM5on8xzCHQHS+O51VlFPo21/WrWr/qANVy7ZYrSS2ABbuw5AjhrCFmexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HKoGmpfB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HKoGmpfB"
Received: (qmail 12476 invoked by uid 109); 22 Jan 2025 15:02:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rYdNON7G2MURlnCjLddSblUsIYbJGysWuOABDwuyCiA=; b=HKoGmpfBXEDTu2+djTlt83m4b25S0hvbeZ9IZhAX9KsJ/4ND1dmbpFatFPiljP1jDuBboBq8N9x+NCzZfN5vhe+AIcUCOfy1ZRfYbzxPlzUYfN6carrlD4yP7Yb73PWfg1xxeF8y/qp+p+ZOZL8oURAuk04XjRDGhB/VkjBy9+9428S1c6LX+AKc9DyJQM4bsb7hMoYFGErVgjFzgP3VjANezlSwLvQ3n1wn9V9gmi479RLVX8wvb1PCWppasosMT3rf9B9CTxQWaJgN04Gmo3qS5hsrW+PJtHBpX2icEOZtkC1GWwMKwnVFpAWiGyl6H4XPz+7l6JTxue5RcA8gpg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Jan 2025 15:02:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10972 invoked by uid 111); 22 Jan 2025 15:02:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Jan 2025 10:02:23 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 22 Jan 2025 10:02:22 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, nika@thelayzells.com, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH] refs: fix creation of corrupted reflogs for symrefs
Message-ID: <20250122150222.GA3348514@coredump.intra.peff.net>
References: <20250121215235.GA2753621@coredump.intra.peff.net>
 <20250122100319.2280647-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122100319.2280647-1-karthik.188@gmail.com>

On Wed, Jan 22, 2025 at 11:03:19AM +0100, Karthik Nayak wrote:

> The commit 297c09eabb (refs: allow multiple reflog entries for the same
> refname, 2024-12-16) added logic for reflogs to exit early in
> `lock_ref_for_update()` after obtaining the required lock. This was
> added as a performance optimization as it was assumed that no further
> processing was required for reflog only updates. However this was
> incorrect since for a symref's reflog entry, the update needs to be
> populated with the old_oid value. This is done right after the early
> exit.
> 
> This caused a bug in Git 2.48 where target references of symrefs being
> updated would create a corrupted reflog entry for the symref since the
> old_oid is not populated. Undo the skip in logic to fix this issue and
> also add a test to ensure that such an issue doesn't arise in the
> future.
> 
> The early exit was added as a performance optimization for reflog-only
> updates, but this accidentally broke symref reflog handling. Remove the
> optimization since it wasn't essential to the original changes.

Thanks for the explanation.

> Reported-by: Nika Layzell <nika@thelayzells.com>
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

I don't know if we need my s-o-b to delete a few lines of code, but just
in case:

  Signed-off-by: Jeff King <peff@peff.net>

> +test_expect_success 'update-ref should also create reflog for HEAD' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		test_commit B &&
> +		git rev-parse HEAD >>expect &&

Using ">>" here is unexpected. It's OK because we are in a new repo (so
there is no leftover "expect" file from a previous test) but probably
better to stick to ">" unless we really need to append.

Plus I don't think there is really any need for a new repo. The
important thing is just updating the branch via update-ref (it doesn't
even have to be a rewind, but of course it has to exist already, so a
rewind is the simplest thing).

> +		git update-ref --create-reflog refs/heads/main HEAD~ &&

I agree with Patrick that we are probably better off just getting the
branch name with symbolic-ref.

So all together, something like:

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e2316f1dd4..29045aad43 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2068,4 +2068,13 @@ do
 
 done
 
+test_expect_success 'update-ref should also create reflog for HEAD' '
+	test_commit to-rewind &&
+	git rev-parse HEAD >expect &&
+	head=$(git symbolic-ref HEAD) &&
+	git update-ref --create-reflog "$head" HEAD~ &&
+	git rev-parse HEAD@{1} >actual &&
+	test_cmp expect actual
+'
+
 test_done

-Peff
