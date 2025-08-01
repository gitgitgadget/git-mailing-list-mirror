Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76057233710
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754048312; cv=none; b=QmGqppDScMXczdb78dgWGmhz/ItOL0ySsTwi9etn0NV5eUY1EglFT3tly3sjoWXXCAhs9yPq/fMWXADXNIoNwMFzTUEYkpmHrKLmbUPvkPpJHddB0pLTZlIhsKXwNBZDdD/hMKETe8LI4NUU+pIK6ul1MuDXk+yZQtfAtU4npUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754048312; c=relaxed/simple;
	bh=ZHCukUFalNaEqeGpcUWIeMnU3ZNZ3TMyPlVxazlinm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJtHByGjV4sTNN8OYMG9A7PlDgroZyNAikuVK4mEYh/Hju8QMX/Avn/C1ozMWEhGfXVvhjAq5qt+BBY2xghu7LXxTz2JyOuTXNhFDtI0UKXsvnkjBWVOcIjWL+mo3Y3KDMO2UMbiC29YWTwlUTMzbjcDxko7/rCJo0sQ6SHWxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=C0BSI/d9; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="C0BSI/d9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754048306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=naruUrCfVjg+nDDDu+10BEpfP1s4Thovzjxf2tKjEq8=;
	b=C0BSI/d9ztHivZsRlDpIHHvlQ9W9QR2Yj+iPQNsRxCD/DQPjgqPTVW85ZoT8gG5wR1NKgm
	6hIecRI6+BEN7EYYUmPNSlE8/Wa4Oc6jQGAjji/5NKgQHyJTSZJOblrdkOD5k7WJKOfmjC
	8JPYEO6QcXyWSSFs4bL2zSBBP+s98Fg=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Justin Tobler
 <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>, Jeff King <peff@peff.net>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 3/9] refs: export `ref_transaction_update_reflog()`
In-Reply-To: <20250729-pks-reflog-append-v3-3-9614d310f073@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
 <20250729-pks-reflog-append-v3-3-9614d310f073@pks.im>
Date: Fri, 01 Aug 2025 13:38:16 +0200
Message-ID: <87tt2ruv9z.fsf@iotcl.com>
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
> but that function is local to "refs.c".
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
> index dce5c49ca2b..8aa9f7236a3 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1371,27 +1371,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  	return 0;
>  }
>  
> -/*
> - * Similar to`ref_transaction_update`, but this function is only for adding

Tiniest nit: for some reason the space after "to" fell away.

-- 
Cheers,
Toon
