Received: from mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259A455162
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928745; cv=none; b=uHFqfVpq5zI12Xg16gvxqcPJAlOGlYgPlTrivFb3ybym0gcbfGdxMBvYlf2O8n26d1zVmPE5zL03fCTRKWJeLNhZS5vaEiUBfG03+Jdwdf1X6ZpqAcxDRDozgJqr7Z9uDSIsG1W84m8cfZQq8YdyumcoJRqTk5ERX0Z1Z6ezC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928745; c=relaxed/simple;
	bh=vC16e3M3c/3s2Y0NlkViofR88CwZMEjdi8Xm6T38MrY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqfEMmtvA5aTv/7uZ/2TPtqAi2h0uwbGlwIqxoTsKC9k6gYex/D9M4k1xqu98MSp/gsCN/3Wlv+nMItWuyCtXrJ2k8LtsyExMyRyqqho24YhkzgeZa8ZnVX0AHZVOFhEnpMgpQli11OhwLh2NFYzIGdfdoMCSSAuAWLimYy8ANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0CX3wLCS; arc=none smtp.client-ip=91.218.175.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0CX3wLCS"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vC16e3M3c/3s2Y0NlkViofR88CwZMEjdi8Xm6T38MrY=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787928738; v=1; x=1788533538;
 b=0CX3wLCS2XWKw3o2XfRHd9/ZHZCxziTDZrMcBIbC+biSS9sdlAyXGxN1UzzmWjjPXDqpswGS
 mtgu+UU91aIQTMdBk6La1+O9rxcFkHjRiNcMaOeZLy+FHDZmuMW3JBmtCrJqtQFtU8LZ4sLwaKH
 07jmg659yO+InQP0QOAidx+Q=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 636a430513236455;
	Fri, 28 Aug 2026 14:52:18 +0000
X-Mizu-Trace-ID: 636a430513236455
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 3/8] builtin/clone: refactor handling of
 "--reference{,-if-able}"
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-3-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260825-pks-odb-write-alternates-at-creation-time-v1-3-911513ba95c3@pks.im>
Date: Fri, 28 Aug 2026 16:52:09 +0200
Message-ID: <877blauwkm.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 8c990ce0cc..8eae3ac7d9 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -218,14 +220,20 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
>  	fclose(in);
>  }
>  
> -static void setup_reference(void)
> +static void collect_alternates(struct strvec *alternates)
>  {
> -	int required = 1;
> -	for_each_string_list(&option_required_reference,
> -			     add_one_reference, &required);
> -	required = 0;
> -	for_each_string_list(&option_optional_reference,
> -			     add_one_reference, &required);
> +	if (option_required_reference.nr || option_optional_reference.nr) {

I was about to ask why you're adding this guard, but it looks a lot more
clean with the next commit on top.

> +		struct add_one_alternate_data data = {
> +			.alternates = alternates,
> +			.required = 1,
> +		};
> +
> +		for_each_string_list(&option_required_reference,
> +				     add_one_alternate, &data);
> +		data.required = 0;
> +		for_each_string_list(&option_optional_reference,
> +				     add_one_alternate, &data);
> +	}
>  }

-- 
Laters,
Toon
