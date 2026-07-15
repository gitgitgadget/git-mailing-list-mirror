Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D33B42F7
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 05:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784093238; cv=none; b=mAg+l4h/YBzzs6xmJWw3OBkApq2pdk1Pq9R/ham+G3Qgu4z/RmNMZu1702kzjrz/D46vrGFehHIdo2DIi5T/sT3y4l5IaMisjMFLlpin2Thr0Pc8fpzZ7mEwvVGOt7/e+bRA89OVBu7/tuQTGV2pGX+KrtxKDmw0gPDvOe5sDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784093238; c=relaxed/simple;
	bh=OLkep+UMEf/zBKuz2CB9mCSmDuRXJJ2/YAhjKBcaZ1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KerC1BhAKqOwMk2V0uXTN9vLfMoANiToVaP4g78lw8YKZ5qqDCaATGNcLRF1pMAoGOuF6IDERkN5RYownoi+mar2YyhJlehN7FPrRGk3pNm0H7j/pVvJt062Sav6hz3f4mJUYMjyQCLbT0IMgj6sFGPLzX6Nc9CoHhtXXuDVhns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oh6uvpbm; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oh6uvpbm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784093234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xw0+/kOND48sKmgrCe4mAbvMY2X0w9UE6fUt9ooBOcU=;
	b=oh6uvpbmuQS/CnRiNExmeXziebwkPD7eLXvvdBv8haw93+gLtjEo/tnJhUuo6OtDFDp1jd
	Kk8wTjx8qcDMUNH83eVjmIhZkMyl+T4/3uzVtRy8fsMMzgXI9AIi0Dway4I8uvUjllTGNe
	ddvoSUcF7QdHFYYl0oUiIg8pthqgubE=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
Subject: Re: [PATCH v3 8/9] odb: introduce object filters to
 `odb_for_each_object()`
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-8-b3c65c641073@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
 <20260713-pks-odb-for-each-object-filter-v3-8-b3c65c641073@pks.im>
Date: Wed, 15 Jul 2026 07:27:08 +0200
Message-ID: <874ii0n7pv.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The function `for_each_bitmapped_object()` can be used to iterate
> through all objects covered by a bitmap. The benefit of this function is
> that it allows the caller to efficiently handle some object filters. For
> example, this can be used to filter out objects of a specific type with
> some simple bitmap operations. But callers are currently required to
> manually wire up the use of bitmaps though, and to do so they have to
> reach into internals of a given object database source.
>
> Introduce a new `struct odb_for_each_object_options::filter` field so
> that the interface becomes generic. When set, then a backend may
> optionally use the filter to skip some objects that it would have
> otherwise yielded.
>
> Note that the respective backends are free to ignore this field if they
> cannot meaningfully optimize for a given filter, and consequently
> callers need to verify whether they actually want the returned objects.
> While annoying, we cannot easily lift this restriction anyway as the
> object filter infrastructure supports some filters that cannot be
> answered by the object database alone.
>
> An alternative might be to limit the filters to only those that _can_ be
> answered by backends. But ultimately, the filters that can be answered
> efficiently by the "packed" backend are completely disjunct from those
> that can be answered by the "loose" backend, and consequently the set of
> filters supported by all backends would be empty. Furthermore, it would
> require us to make assumptions about capabilities of future backends,
> which may be able to efficiently handle more filters than current ones.
> So in the end, this alternative would only limit us artificially.
>
> Implement the logic for the "packed" source. Note that we use the new
> function `prepare_source_bitmap_git()` to open the bitmap: as the

Also here: `prepare_bitmap_git_for_source()`

> backend operates on a single object source, we must only use bitmaps
> that belong to that specific source. Otherwise we might yield objects
> that are not part of the source at all, and with multiple sources we
> would enumerate the same bitmap once per source.


-- 
Cheers,
Toon
