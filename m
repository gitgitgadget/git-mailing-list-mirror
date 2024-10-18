Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333CF4084D
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253043; cv=none; b=TckqnefQL7Dlh4IbuopfkNYxNzRJgK1piohnagTPmVgP1NDJvCKO2H7hAJ0wTXxFX/95o+7ZqLxB8Gus3S//Gf3ge3sqKrGbHw3BJ4eb8bZpkxYUncVOdctj1ZljXWk2gK5Q6WoPvFQtCVX3+ujWvaQh9vko4kpfzKZeIU2WnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253043; c=relaxed/simple;
	bh=gtBaL/tliXN1s7wkGgBoCzbsIVhbp9l35Ok6BXBE5E4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EZWEx5NaLHo88CzPblxYYoWJw02i1Rn5NVl+o620szzw+fEkH35Xvmf0dspKTsHnCzC9j7r5nWZy6UiJzK2qYQJmcEZfWgEqG722nIvtILFiUeIeDYXiXNEitwMhlNp1lVbcGxGX5qH9aN0bjutRfvYX9ilGCOthz4328qIr+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=gBOeRPXh; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="gBOeRPXh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1729253037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gtBaL/tliXN1s7wkGgBoCzbsIVhbp9l35Ok6BXBE5E4=;
	b=gBOeRPXhldc0pE4uT7AzMguCVNKV0lAIouCTolluFrntRXggySANLnp3L2izmIfPqA25sD
	AmjgC8adfXeeqhRmEVDrIhZFz70jQOcCIo9WMuKqkIU3Yq5ko3Vwy6+LAxo5Nm3958VQX7
	ueCU9X6Y7P/zrb0v5vUgfysAADXC7dQ=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 20/21] builtin/merge: release outbut buffer after
 performing merge
In-Reply-To: <bc2206aa47e7e8be0642bb4540e7ddec22fbac91.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <bc2206aa47e7e8be0642bb4540e7ddec22fbac91.1728624670.git.ps@pks.im>
Date: Fri, 18 Oct 2024 14:03:48 +0200
Message-ID: <877ca5d3dn.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The `obuf` member of `struct merge_options` is used to buffer output in
> some cases. In order to not discard its allocated memory we only release
> its contents in `merge_finalize()` when we're not currently recursing
> into a subtree.
>
> This results in some situations where we seemingly do not release the
> buffer reliably. We thus have calls to `strbuf_release()` for this
> buffer scattered across the codebase. But we're missing one callsite in
> git-merge(1), which causes a memory leak.
>
> We should ideally refactor this interface so that callers don't have to
> know about any such internals. But for now, paper over the issue by
> adding one more `strbuf_release()` call.

Shall we mark this as #leftoverbits?

--
Toon
