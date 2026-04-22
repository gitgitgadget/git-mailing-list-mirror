Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A1236923B
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841799; cv=none; b=Fimm4dv33OgGAjawJI5rpum4PUwTgZnSIX7h65jl643fX4ZiKIgGPkJSc8haUBB7ws6hWG7bWikp/dTNWy3h/ei5ZaNwgIHAdF7A4uHoKpUgUMwM7w2tRqaw/k0y6c50sg6UVSMKL1R4VpXreGRJUXnyeCT5DVU4D+wWFZJJXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841799; c=relaxed/simple;
	bh=sjfINShFa1oGX1yGVIL2XhKqEXaGS2QE1QP48UzKn6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TLsz/OPyPuE7mWnUD5nxMq3JRkBckW0qJ5Usezbf1ztUNpgyfjMPnaFHtMK5U/RjPju1EHiQazbNNGhTQDPo1URIJhscVRFKaLPrFRG+WKMTMU/sxq1NvmdzNkcdsY/vp6Hr802DCLkm0Hoc9DYP4wYnaFoUKVoYIU1RwVh75sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=tjmvN3fz; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="tjmvN3fz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1776841794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=priP4wgeA/FEoSyPXySLjBmZSQctNH55d5sK1niFVRE=;
	b=tjmvN3fzXAvPtlB0SYk9Qi8ZUWOp8hGM1aCe2U03GhIq+FO6hPUcCJjJIppf/Tw3MfvVDn
	ubEzVOWgqjlx2LtPt4BoxRvAvrMg+/b8TZTamAK9KJgUWKZa/RaBycd4KStEPsfTobkF5W
	RfUNCthwLcXZgx89oESavtb5wnC3NF4=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: Re: [PATCH] generate-configlist: collapse depfile for older Ninja
In-Reply-To: <aehsikCfPm83M9dN@pks.im>
References: <20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com>
 <aehsikCfPm83M9dN@pks.im>
Date: Wed, 22 Apr 2026 09:09:46 +0200
Message-ID: <878qafeait.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Do we really have to make the logic conditional? I would expect that
> this works just fine for newer versions of Ninja and for Make, so it
> feels rather pointless to me to have two modes to worry about.
>
> So wouldn't the below simplified version be sufficient?

I considered that, but I wasn't sure. I went all-in to show what it
could be, but I'm happy to see simplifications.

Now your version doesn't remove the no-op targets from config-list.h.d.
I did some testing, and while Ninja doesn't need those no-op target,
they are also harmless to keep them. Thus I agree your version is
simpler and better. Let me roll another version.

Thanks!

> diff --git a/tools/generate-configlist.sh b/tools/generate-configlist.sh
> index e28054f9e0..f5f42492c6 100755
> --- a/tools/generate-configlist.sh
> +++ b/tools/generate-configlist.sh
> @@ -44,7 +44,9 @@ then
>  	{
>  		printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>  			"$SOURCE_DIR"/Documentation/config/*.adoc |
> -			sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /"
> +			sed -e 's/[# ]/\\&/g' |
> +			tr '\n' ' ' |
> +			sed -e "s/^/$QUOTED_OUTPUT: /" -e 's/ $/\n/'
>  		printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>  			"$SOURCE_DIR"/Documentation/config/*.adoc |
>  			sed -e 's/[# ]/\\&/g'

-- 
Cheers,
Toon
