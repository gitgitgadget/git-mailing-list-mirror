Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C027F00F
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777022; cv=none; b=VGaHr49LTqBaOVZS0cjVHzU4DpVbxaXueF5+r4XE763+pJJtRLT9ljjyvg7TbBKgnbNYgtAkxtjlD6gk7raeqzUh34XN7j70Ypkp37KrXsTqAmbjQQypU9Ph8dv3B9YZtyqxPsAyQpDMKdsUsAbcryCXEWCjW+caAmsFlyk0iCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777022; c=relaxed/simple;
	bh=7z+EUKGY6R63H8v9CyEpCQMjYGKPzqhjWHacYd2q620=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSoCFZe2+C4po9kOSrk3hO2ybmMM9nM2jMkqPZsOqiMHjqgmR6ZterzEg11gVCR0ISThztNzxGtYLSSsVlxuvkeSio+DmivpAFZesp8tlWb47SXRkU6z/yuVtwea/TFFVSMq/njeg3C33A/3+UBiLwEC+LT49u634e+KHE4hMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UOdnbvxX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UOdnbvxX"
Received: (qmail 2825 invoked by uid 109); 29 Jul 2025 08:16:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=7z+EUKGY6R63H8v9CyEpCQMjYGKPzqhjWHacYd2q620=; b=UOdnbvxXLeXBdGDhr905E83psqoHXinbRUKGCdAfnuggaGFwZXxH76EimW+8ounxWcrIdjgaeaGB5+31ZB8EN89WDk1acXs5RGVmatEY2P/Q+ZQlSUveLl0GaT3jSkYjbbko8ZAxoOZsUbqwKlDS55LilRod3aU/XexMQH1P+r8Qim3f2Rc91n2YXsXKrprJq3CyzG1KPtx66Jrq6+ffDbdEpj4rIG1eQvBe5W0YhU/bwmvEKshhfetQ9pgJv1FygzLXbB4stqSsEPhofIKLB0gKrDy5ufiiD5Bxd4Er6oJ5quTUJW3wnPvB7T5KqKWKZaJ48qAZ+EuGK3BvV4fdBA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Jul 2025 08:16:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31274 invoked by uid 111); 29 Jul 2025 08:17:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jul 2025 04:17:03 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Jul 2025 04:16:58 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Han Jiang <jhcarl0814@gmail.com>
Subject: Re: [PATCH 3/4] builtin/remote: rework how remote refs get renamed
Message-ID: <20250729081658.GA1842689@coredump.intra.peff.net>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
 <20250728-pks-remote-rename-improvements-v1-3-f654f2b5c5ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-3-f654f2b5c5ae@pks.im>

On Mon, Jul 28, 2025 at 03:08:47PM +0200, Patrick Steinhardt wrote:

> The next-best thing is to do it in two transactions: one to delete all
> the references, and one to recreate the references and their reflogs.
> This signicantly speeds up the operation with the "files" backend. The
> following benchmark renames a remote with 10000 references:

Hmm. I was surprised to see so much reflog code here. It looks like
you're replaying the old reflog entry by entry. But the old code was
leaning on refs_rename_ref() to do the individual renames, which just
asks the backend to handle that for us (so e.g., the files backend just
copies/moves the log files).

So it feels like ideally we'd be able to create a transaction element
for renaming, and then the backends could similarly do what makes sense
for them (and we wouldn't need a bunch of reflog code here).

I guess that does not work with the two delete/create transactions you
end up with here, though. And you need those to worry about D/F
conflicts. But then...how did the original handle D/F conflicts? It kind
of looks like it didn't, as it is doing a mass ref-by-ref rename in the
middle.

If the refs code learned how to order things to handle the D/F conflicts
within a transaction, then we could do a single transaction. And it
could learn about rename primitives.

I dunno. I think that would be nicer, but it's probably not worth
holding up this topic. Your perf numbers are very nice. I guess the
possible flip-side is that the existing code could be faster when
renaming a single ref (so no quadratic behavior) with a pathological
reflog (so moving the file is faster than re-writing all of those logs).

Hmm, yeah. Something like this:

	cat >setup <<-\EOF
	#!/bin/sh

	rm -rf repo
	git init repo
	cd repo

	git init server
	git -C server commit --allow-empty -m foo

	git remote add origin server
	git fetch

	# make the reflog gigantic
	perl -i -ne 'for my $i (1..10**5) { print }' .git/logs/refs/remotes/origin/main
	EOF

	hyperfine -p ./setup -L v old,new './git.{v} -C repo remote rename origin foo'

results in:
  
  Benchmark 1: ./git.old -C repo remote rename origin foo
    Time (mean ± σ):       5.5 ms ±   1.1 ms    [User: 1.5 ms, System: 1.3 ms]
    Range (min … max):     3.6 ms …   9.7 ms    58 runs
  
  Benchmark 2: ./git.new -C repo remote rename origin foo
    Time (mean ± σ):     476.3 ms ±   9.8 ms    [User: 203.6 ms, System: 268.0 ms]
    Range (min … max):   467.8 ms … 498.7 ms    10 runs
  
  Summary
    ./git.old -C repo remote rename origin foo ran
     86.43 ± 16.61 times faster than ./git.new -C repo remote rename origin foo

It's hard to bring myself to care, though. This is a stupidly
pathological reflog, and the absolute time change is peanuts compared to
the per-ref cost you're fixing here.

-Peff
