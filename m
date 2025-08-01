Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A21DF98F
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049346; cv=none; b=PS4G43S3r8ynOOej+r97Q6GZB7kz/N61Bp97ljkhCGaxjUZwtHap6pheqVkrZM9EHjIZBfq23Uev/ymJZkaZ99yuVNwFjFlhGpw0ZrVDZ9O7cyN0EWX1k+3X4Dq/kcgOUyuM28mkMrg47nd38uKepN/MNCeMUhrdPwQtwEWi3qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049346; c=relaxed/simple;
	bh=t+64I40azU2rt8ZqJurgR6aMTaJDP/c+VAzrE8d/+1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YxuYTUbK+hYTBeDy7h2B60JJ+iyVHOU/iNNFtJccW8Gg0iJ3rEx82GMQQPB+lkzRQ/9pq2xE1xZWPmxXl0DZzrl1t2/3CDd0mfMHCZaKMfShszP+KOz9xumZIdVOSrgir/BbtaeZZsEVd/DlZFRc0D4pWxn8LMBT7mspx1r/WHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=APFK+IwB; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="APFK+IwB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754049341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1s1xnfgbAZJXvWEWKHZp0Z7x0PrhnDUjesE3G6vwlM=;
	b=APFK+IwBDKS4oQVaZML9HfcdT95AL8l+me3p0yOEza4lqWCJPScLhYw6x846s/+W6o94CU
	fJ1T1k8UVoXyf0jQcw/MTcW5+SYt4vACa/oRD97PXwWcuGKC4aZwCd6EBGxFwVpuisgytT
	TTKn9cPZWULQpN4hw2icXOoIgd39lzA=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Justin Tobler
 <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, SZEDER
 =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>, Jeff King <peff@peff.net>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 7/9] refs/files: detect race when generating reflog
 entry for HEAD
In-Reply-To: <20250729-pks-reflog-append-v3-7-9614d310f073@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
 <20250729-pks-reflog-append-v3-7-9614d310f073@pks.im>
Date: Fri, 01 Aug 2025 13:55:31 +0200
Message-ID: <87seibuuh8.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> When updating a reference that is being pointed to HEAD we don't only
> write a reflog message for that particular reference, but also generate
> one for HEAD. This logic is handled by `split_head_update()`, where we:
>
>   1. Verify that the condition actually triggered. This is done by
>      reading HEAD at the start of the transaction so that we can then
>      check whether a given reference update refers to its target.
>
>   2. Queue a new log-only update for HEAD in case it did.
>
> But the logic is unfortunately not free of races, as we do not lock the
> HEAD reference after we have read its target. This can lead to the
> following two scenarios:
>
>   - HEAD gets concurrently updated to point to one of the references we
>     have already processed. This causes us not writing a reflog message
>     even though we should have done so.
>
>   - HEAD gets concurrently updated to point to not point to a reference

That's a little much of pointing, right? ;)

Maybe change it to something like:

    - HEAD gets concurrently updated to no longer point to a reference

-- 
Cheers,
Toon
