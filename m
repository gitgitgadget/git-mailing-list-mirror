Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901828C009
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623375; cv=none; b=JRTp4ABCx3MZoeK8s3FkbE3zQwI5JlL9aGNWGnl8Apyl+osfjd2yq+KZeNd/+e6gCyqXHCySjmkGS/WXkJ8H5g5AOdt53qjvhuSWSOWnQsKWZgAF9ByDTnPglIHfMiSJjGuhc2B6Op12pQ669lPMjUq92MvBMs7HPPaaVt4V8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623375; c=relaxed/simple;
	bh=epA0p7T3w83a/wMb3xImOdo9Y/USgnYu3Yqwy2kemoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y8K3VtrFutY3yEGAl7Bt1HAtYNracaQNANWRxPhVdbh4ok1QqkzYHSJdzRKk2Q1fJ6LnlLBXAD2Ue9YMWwHo6qhUR/9y1w4IBZwPSoX/Ncg6aiq7g5BLXZXEJfaOAiaQgaV27Gb+JCjDxqz4suSjS1lucWAdy0ySDfHxMclJUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=aEC2xvBS; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="aEC2xvBS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1767623368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ecq7XGwAq3gGGHKxAhaHtlAldo4zf9PrzkAL70FgFBo=;
	b=aEC2xvBSX97xqAVwLCKPaXIfH5R8pX5pUBHdvm2kkx9tQK5kQUk2ZU8eBM76CQUWiE3hyC
	Uj9tCKDL+jlrGe7nOypDFQwfIRgoYj6ruIL33QIldqrgyyBZkA6LX8hQcr9S226aHzxgzV
	8CmzJGaavhyxdCxNyzL1ANn/mEKnzbw=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH v2 2/7] packfile: always declare object info to be
 OI_PACKED
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v2-2-62e3e49072bc@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
 <20251218-b4-pks-odb-read-object-info-improvements-v2-2-62e3e49072bc@pks.im>
Date: Mon, 05 Jan 2026 15:29:02 +0100
Message-ID: <87seckp1zl.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> When reading object info via a packfile we yield one of two types:
>
>   - The object can either be OI_PACKED, which is what a caller would
>     typically expect.
>
>   - Or it can be OI_DBCACHED if it is stored in the delta base cache.
>
> The latter really is an implementation detail though, and callers
> typically don't care at all about the difference. Furthermore, the
> information whether or not it is part of the delta base cache can
> already be derived via the `is_delta` field, so the fact that we discern
> between OI_PACKED and OI_DBCACHED only further complicates the
> interface.
>
> There aren't all that many callers that care about the `whence` field in
> the first place. In fact, there's only three:
>
>   - `packfile_store_read_object_info()` checks for `whence == OI_PACKED`
>     and then populates the packfile information of the object info
>     structure. We now start to do this also for deltified objects, which
>     gives its callers strictly more information.
>
>   - `repack_local_links()` wants to determine whether the object is part
>     of a promisor pack and checks for `whence == OI_PACKED`. If so, it
>     verifies that the packfile is a promisor pack. It's arguably wrong
>     to declare that an object is not part of a promisor pack only
>     because it is stored in the delta base cache.
>
>   - `is_not_in_promisor_pack_obj()` does the same, but checks that a
>     specific object is _not_ part of a promisor pack. The same reasoning
>     as above applies.
>
> Drop the OI_DBCACHED enum completely. None of the callers seem to care
> about the distinction.

Thanks for clarifying these. I agree it makes sense to drop it.

-- 
Cheers,
Toon
