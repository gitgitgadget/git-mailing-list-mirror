Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3482279912
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637098; cv=none; b=pDFcWBV8h0e6tHvlJ2y7WEnetGgtfDCZzQLYsFd89Vg7RtFWbXSCUiuQwbyGlTcQvvu4LLpg4L7OtF2AtTJiux/0W9mIdvfW0u1K1w6mJ1yP1mdxnmq5tf8AybyYOIPHcUzIBhIQWWlMWzxGvTu3nd7SgWqk4Yis068tnBC3gkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637098; c=relaxed/simple;
	bh=95/CgmvySu37AnO/ocqyXFiP6IAZeLcTBU+jfZj0SLg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XzwSjQQLYYf8S4yrLFLXSdMTygAxLzW13JNr9ojTDCOdKChHFo1dvSeAboEF/HhUUcab289AcR5fQwVWjB02pcus0x5E0brmkvVhjMrxRiLJeBm4xRxmUS8PU1D2flQ3c690VqI6cSjNoirFrlTU9GMBenwFdyepkdnaxKgP2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=i3G8xwGl; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="i3G8xwGl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1744637090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SC1JqMzKWVNsbO4CGPGgzv0HF2e24W4GrwYlpLztLU=;
	b=i3G8xwGlTY6cuGzSW22rv9OXDCcAA5pRSV+0H7AmJ4rktSaH7ESYZqJH8K4x9HRwUBo1QX
	NyfjTXWqUaojPcW80yyh7SkmmmHVAOMjHgU37l60S5WiCHSB/qhOiPft/mM2Z3FP6KLlzH
	SGZgoK8yR6uj0COFbPGc03Fit6vTpX8=
From: Toon Claes <toon@iotcl.com>
To: Xavier Morel <xmo@odoo.com>, git@vger.kernel.org
Subject: Re: git clone --bundle-uri: provide progress feedback?
In-Reply-To: <bdf4c917-f1b2-4c24-9b59-97d8a770d06d@odoo.com>
References: <bdf4c917-f1b2-4c24-9b59-97d8a770d06d@odoo.com>
Date: Mon, 14 Apr 2025 15:24:36 +0200
Message-ID: <87a58i6fl7.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Xavier Morel <xmo@odoo.com> writes:

> I've been looking at `--bundle-uri` for a repository of some size (~5 
> million objects, ~10GB fresh cloned though an aggressive gc get it down 
> to under 2), however from a UX perspective it seems to have a bit of an 
> issue: while normally `git clone` provides pretty extensive progress 
> feedback as far as I can see there is no feedback whatsoever while 
> `clone` is interacting with the bundle, even explicitly setting 
> `--verbose` and `--progress`, at least when the bundle is a local file.
>
> I assume bundle-uri is mostly intended for large repositories, for which 
> even a clone with a bundle uri can take a while, and the lack of any 
> sort of feedback until git reaches out to the actual repository to find 
> what was not in the bundle is somewhat distressing.

I agree the UX isn't great. And I've tried to fix that[1].

Unfortunately we faced some issues in that implementation[2] for which
we didn't find a clean fix. Every solution felt hacky.

We came up with another idea[3], but I've never found time to implement
it, because there are still a few technical details to be figured out[4]
and implement the solution wouldn't be so trivial.

Anyhow, I agree it would nice to implement something like this. But at
the moment I'm unfortunately unable to work on this any time soon.

> And side-note, it might make sense to emit a warning when trying to 
> combine `--bundle-uri` with `--filter`? I assume if any filtering 
> happens it happens only on the reconciliation fetch, which should be 
> extremely small compared to the bundle's size. Experimentally with a 
> sample size of (1) using `--filter=tree:0` with a bundle uri yields a 
> larger repository *and* is slower than leaving the filter out.

Use of bundle URIs with filters isn't supported very well overall. For
instance, if the server is advertising bundles, it's also impossible for
the client to know which/if a bundle is available that matches the
filter they provided. It's a known shortcoming in the current design,
and as far I'm aware there no proposed solution yet.

[1]: https://lore.kernel.org/git/20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com/
[2]: https://lore.kernel.org/git/20250221074854.GC1988395@coredump.intra.peff.net/
[3]: https://lore.kernel.org/git/87o6z43gz8.fsf@iotcl.com/
[4]: https://lore.kernel.org/git/20250221073605.GA1988395@coredump.intra.peff.net/

-- 
Toon
