Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58FF191F8A
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551731; cv=none; b=DVRbPut3t/hdyIVUdOBEG9jtPCdqYalsYopjUFDoAS2pZa/H3ajMmUMeffARtK3j5uFx2HtLUYEl2J1hCBrPlZl0RAm7tgDxDarA2AtWueFX0F+qUbmxCdhACPRW2FwSjsbIpkOdTD0fFvpFKl/q91BI2xXTy4Qc+nBwkyvQaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551731; c=relaxed/simple;
	bh=nE9RW7KX/TgSM3FkGdyy10sdBd9OQIcF6Fg08iNKqj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PaY+ZETMCLxZcPAiowZ4R3cHZHLlKE2vNDSu1yoH1flZq4SINhgJMNJdnSdalOvKgoin+V96m7pCbDNvyGKivuAUjNLwSFSbcub8IJkXOoaKEhuB0Qx7/o+Zsru7d9l5wzuhiip/XAHPmdQHKuXxza1jINYkQtQ7PNoj6AGWgFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=o9oYbvZ8; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="o9oYbvZ8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1728551725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htDag3S46VDrFlACUc3lZ/WnJGP2Kz2pOH5xGMgV1N0=;
	b=o9oYbvZ8z+pizUAn51dqyqH/dGkJrzreUZfbJqC8UnqrVFW9A95JsYH9f6k1yJSdSBwqZ3
	8y+duMaB677M1+LqouNq+RMsekymbmw9nsK+Y5fFAkbGX+5EI6QBnSHJVMSier/mJa9qZp
	exKJLgWAv1H/aAKWRz2Z3229DREK/K4=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bundle-uri: plug leak in unbundle_from_file()
In-Reply-To: <xmqqle0jmfpf.fsf@gitster.g>
References: <20240826083052.1542228-1-toon@iotcl.com>
 <ZsxQBEpfChQozhF7@tanuki> <xmqqle0jmfpf.fsf@gitster.g>
Date: Thu, 10 Oct 2024 11:15:12 +0200
Message-ID: <875xq0s4in.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Both of two callers of unbundle_from_file() are used as the
> condition of an if() statement, so unbundle() that signals an error
> with -1 wouldn't be a problem, I would think.

> It may not be a bad idea as a #leftoverbits item, after the dust
> settles, to clean up the calling convention in this file (may not be
> limited to the code path that reaches this function) to follow the
> usual "signal success with 0, failures are signalled with a negative
> value".  Then we can just return the value we got from a failing
> read_bundle_header(), just the same way we return the value we got
> from a failing unbundle().

I just submitted v2 which preserves the original return values as
before. I'll leave changing any return value to a #leftoverbits series
to addresses them together.

--
Toon
