Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46037E10C
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804608; cv=none; b=dx5EvEAhy+fJ/VpmF7x+BCTUjVV52upXUuzGtOf8LtcPT5arSEh38cD7N7WK0zyRL6LS4QpeApTrC6eevcNzThmuoWenS/tWh5CNHiZGF6UpD3220SoYRze2Bg4yOJNP3u43erdW7CA6iyKB5UUhZdKecIF5TYcBinOJf5h+wMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804608; c=relaxed/simple;
	bh=wMXD8PiNp3Z0R3M97iG6i26WcNlQgzxPr+CKfb12aiA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=pZ/NQ7AROLNjWj3D42jRYvIeIPNFzbiw6YW2/tZoVNR5xlFM/s0MgJ6K8Sz1dQuBvuvAxqkNbaCs580KjLXKqiurQvoX1D3dP/TDqQses2MsuejLpD2bRTECmMH8KFbnUMaxYW4W7aqLVkyxG85vd+fyLKU0LGCU9rjYZvL6Mb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=AMvHIWek; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="AMvHIWek"
References: <cover.1706687982.git.ps@pks.im>
 <cover.1706772591.git.ps@pks.im>
 <f134702dc5f656942baafbd80af46ad928ee1449.1706772591.git.ps@pks.im>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1706804601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9FZ80UrXSLGhLV5vfNw5dcB2U8SJ2A2DKNs0ZqwXK9Y=;
	b=AMvHIWekZJl+l06+gvoPepic8UfivIcZoHbNTQ8yW5cEijaL3QMBrsjMDGCtvz+SxRUaIp
	P+kz8hMOy87J+vSusfxkWNPdMVpvc6l3T3KEFZIaesDrwRscjIrRtul92469X+pINA3MaT
	NO7r3MwqSh5ocvxP+roDfMvBbicVuBI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, Junio C
 Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/9] reftable/stack: fix parameter validation when
 compacting range
Date: Thu, 01 Feb 2024 17:15:14 +0100
In-reply-to: <f134702dc5f656942baafbd80af46ad928ee1449.1706772591.git.ps@pks.im>
Message-ID: <87o7d0p38k.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT


Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/reftable/stack.c b/reftable/stack.c
> index d084823a92..b6b24c90bf 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1146,12 +1146,14 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
>  done:
>  	free_names(delete_on_success);
>
> -	listp = subtable_locks;
> -	while (*listp) {
> -		unlink(*listp);
> -		listp++;
> +	if (subtable_locks) {
> +		listp = subtable_locks;
> +		while (*listp) {
> +			unlink(*listp);
> +			listp++;
> +		}
> +		free_names(subtable_locks);
>  	}
> -	free_names(subtable_locks);
>  	if (lock_file_fd >= 0) {
>  		close(lock_file_fd);
>  		lock_file_fd = -1;

Technically, this change is not needed, because `free_names()` deals
with NULL pointers already.

--
Toon
