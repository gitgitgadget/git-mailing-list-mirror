Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3363D9543
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957386; cv=none; b=S4aJ4ENRNmTGfEqmETd7d1OBqVrbOqm1mFTRm64/9CrIyZsvf/YJ4kFSDrXL6EGWptlcp6WBvHKg3DEeEdhm08QB6E6Cx/N8+f0WGxyBiHlKz/CgUS/1mhEqwY7TCK31EKCxS5UodQtGvQczutamuT90E2M/KVoxmVqHtnzeoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957386; c=relaxed/simple;
	bh=gbBWWF+xhGfq+j4id8W8o2sbM3TXOXhcbIWW1Kf13EA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bXE1QQdPUy3LCRWRw7ej7GfM1BLd3FDSAemk/n/g2EcJZBL0k7LvaJZYQERZYUQADbI79CVn5/QhxnzStbueY1yQM4kUo4I4HXaKbkzrRN8juZYdIiiFPTPdYx0S9DiG1cbzbHTfnY26xRPlZRTYFg/pgTFmuB0fZsjjDuWt4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=lrRtytrs; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="lrRtytrs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785957376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WPhQhnjb/VWki5nvX96UjYq6ucmVhUVsqSUncnIrxiQ=;
	b=lrRtytrsVohjFiXnX9R+GZ4EiaYND6FFmOcHdXZU0WmhVzIOqd4N62k2DWHPsrPdlNWMH+
	UFf5V+7EENl6ImMJZ3c81opIHRYPSsRYJXXbZxsKNDZDpH3ctLkR3FM9VitN/VasNt1qky
	DRF5l4sLrq+phlSZctDXRPXS7jZQjXo=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>
Subject: Re: [PATCH 1/4] revision: move bloom keyvec precondition into function
In-Reply-To: <20260718075700.GB22588@coredump.intra.peff.net>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-1-410418f18614@iotcl.com>
 <20260718075700.GB22588@coredump.intra.peff.net>
Date: Wed, 05 Aug 2026 21:16:00 +0200
Message-ID: <87wlu44bv3.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

> On Fri, Jul 17, 2026 at 05:46:59PM +0200, Toon Claes wrote:
>
>> There are currently two callsites calling
>> check_maybe_different_in_bloom_filter(). They both check if
>> revs->bloom_keyvecs_nr is not zero before they call that function.
>> 
>> Move bloom_keyvecs_nr precondition into
>> check_maybe_different_in_bloom_filter() to simplify the code.
>
> Makes sense, but...
>
>> Note that this changes `bloom_ret` to become -1 when there are no Bloom
>> key vectors, which results in `count_bloom_filter_false_positive` not
>> being incremented. This is unobservable, as the Bloom statistics are
>> only reported when key vectors were set up.
>
> This "-1" return is kind of subtle. The function is really a tristate
> returning one of:
>
>   0: no, it's definitely not in the filter
>   1: yes, it's (probably) in the filter
>   -1: we could not even check the filter
>
> But nobody ever cares about the difference between "1" and "-1", because
> the probabilistic data structure means "we could not check" must err on
> the side of "it might be in the filter".

That's not entirely true. The `count_bloom_filter_false_positive`
depends on knowing whether the filter said "maybe" or if no filter was
used at all.

> But that leads to code like:
>
>   if (!bloom_ret)
>
> that _looks_ wrong at first glance (as in "oops, we are not catching -1
> and accidentally treating it the same as 1"). But it's is actually
> correct for the reason above.
>
> The "return -1" you are adding here is not the first (we'd do a similar
> thing if the commit was not found in the graph file). So it is not
> really adding to the confusion.
>
> But as we prepare to make this function public, should we consider
> changing that tristate to a boolean, like:
>
>   false: no, the path is definitely not touched by this commit
>   true: the path could be touched by this commit
>
> It's a minor point, but I think this makes the interface much more
> obvious.

That said, the public function might have a boolean interface, while
the private wrapper still uses the tristate. I'll address in the next
version.


-- 
Cheers,
Toon
