Received: from mta1.migadu.com (out-111.mta1.migadu.com [95.215.58.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA36471D04
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928762; cv=none; b=kxcpWPKzSLLcE8Bb0BhfoW94bO6SrXdBwRNCx+ldsd+T5lD0+Z5lbi5IakQKiqOqNTOQkAGszwSDjbS0soLqgHRDPdPXmpHYe4uJ9DvAC1qpBrDaNvk3otomvw2BFrnh+Fr3/uRVRAmU3UCCEDQeE8Ckz1eJU5MDhguqBznXw1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928762; c=relaxed/simple;
	bh=/Qy/s4Wo4G8cx+UCVUtNChiuuAq0E2zOmOYef4zm25Q=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EiKFvSve95WnPstWiYDfoHWDVqriJzkmrh14tF5dNEZQjieuBkqewRYireAl3zONxCXdcvowT/t/4sAU37bCxasqlaaDq9AojvmtDyFuP0jqnZpqRlmNtVN2NRKlVIr2O8hdmcLsldooIoHKmjYqCtmCOG25u0LIqE715NETRco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=cn4kN2n3; arc=none smtp.client-ip=95.215.58.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="cn4kN2n3"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/Qy/s4Wo4G8cx+UCVUtNChiuuAq0E2zOmOYef4zm25Q=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787928757; v=1; x=1788533557;
 b=cn4kN2n3ri/8vUQKwzK7c49V4pC2UlsU6RACDkVb4xHrpz/y2kFQUH+yxKNvyeVRKIIePPvO
 6H+bzAPDDbu5+vOaWPnTmbXWZGWi1CSK2ZCAwXm/kcNyyLDisy+BvvU4yhydwKkHuUC67sxUGbk
 phBRN/hrSG1ogr60QRXQ9mEk=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 417d77b2d73039d8;
	Fri, 28 Aug 2026 14:52:37 +0000
X-Mizu-Trace-ID: 417d77b2d73039d8
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 4/8] builtin/clone: move setup of alternates for shared
 local clones
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-4-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260825-pks-odb-write-alternates-at-creation-time-v1-4-911513ba95c3@pks.im>
Date: Fri, 28 Aug 2026 16:52:30 +0200
Message-ID: <875x0uuwk1.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 8eae3ac7d9..08c8f5a94f 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -220,7 +220,8 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
>  	fclose(in);
>  }
>  
> -static void collect_alternates(struct strvec *alternates)
> +static void collect_alternates(struct strvec *alternates,
> +			       const char *src_repo, bool is_local)
>  {
>  	if (option_required_reference.nr || option_optional_reference.nr) {
>  		struct add_one_alternate_data data = {
> @@ -234,6 +235,16 @@ static void collect_alternates(struct strvec *alternates)
>  		for_each_string_list(&option_optional_reference,
>  				     add_one_alternate, &data);
>  	}
> +
> +	if (is_local) {
> +		struct strbuf commondir = STRBUF_INIT;
> +
> +		get_common_dir(&commondir, src_repo);
> +		if (option_shared)
> +			strvec_pushf(alternates, "%s/objects", commondir.buf);

Also the use of `commondir` seems to be only used if option_shared is
set, but it will be used in an else in a subsequential commit.

> +
> +		strbuf_release(&commondir);
> +	}
>  }

-- 
Laters,
Toon
