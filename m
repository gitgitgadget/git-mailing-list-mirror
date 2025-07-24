Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA562D4B61
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361738; cv=none; b=jXhTMItQvJAYCqAxSsYKUO+qx+XaMA1+R98nD9GyiSUklkUJl8FZCh0BWAOpuIO4hMRLnOYpq1JdtBWG/tvYU6KG+1knCDTpB7OryLMFJCsY2Eud97TpuChH8fPAbY71J/PGzRYr1AU3OIUFR7aBk+qoyRt6H0n4voS4Jt1Rn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361738; c=relaxed/simple;
	bh=JIJY2FIT1a1qrZbo2t61pla/vR5ZX+67OD8TJKaqPKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LVQRQu2fv7d6hUpALhO5eH1OdsuQZ4jYGolrdU4rJL5G8t+D8f85A0m8d0AY/wJEAcqUw1G74zi7wdNFGmc92wyLX2gtVXeu6qCg46obnRo+rH5I0nMKF//exthKlKbmc7Khi8m3SxpvJ/jH+VYt6OUQMfXdAo4BrYnzT6gwyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=wOV4wXsi; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="wOV4wXsi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753361733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EcCczQr8inEMRT1AYfgYxX6y61VwdVnstikSwN/GLBM=;
	b=wOV4wXsig0PYWidrjepphY2QKH9IR3QP9vI3m/J/iX9tuTmxpWjk3G0yBC/pmC5ZCMgetR
	Kplk6bb+l511S3Mocni4CF8rOqlqoXJP90ykDth3RZvP+FvSzHI6i43NVqeTTDrEni/jQx
	3sMS8zt029echToqFolUtNLkuu7AZtQ=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/8] refs: export `ref_transaction_update_reflog()`
In-Reply-To: <20250722-pks-reflog-append-v1-3-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-3-183e5949de16@pks.im>
Date: Thu, 24 Jul 2025 14:55:24 +0200
Message-ID: <87ms8tkatf.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> In a subsequent commit we'll add another user that wants to write reflog
> entries. This requires them to call `ref_transaction_update_reflog()`,
> but that functino is local to "refs.c".
>
> Export the function to prepare for the change. While at it, drop the
> `flags` field, as all callers are for now expected to use the same flags
> anyway.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 29 +++++++++++------------------
>  refs.h | 15 +++++++++++++++
>  2 files changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 73913b6627b..188989e4113 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1362,27 +1362,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  	return 0;
>  }
>  
> -/*
> - * Similar to`ref_transaction_update`, but this function is only for adding
> - * a reflog update. Supports providing custom committer information. The index
> - * field can be utiltized to order updates as desired. When not used, the
> - * updates default to being ordered by refname.

"not used" is a little ambiguous for me. I had to dig a little and in
transaction_update_cmp() in refs/reftable-backend.c the index is only
considered when the value is non-zero. What do you think about replacing
"not used" with "zero"?

-- 
Cheers,
Toon
