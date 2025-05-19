Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983B155326
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641497; cv=none; b=ukSME9dAVJea5dkU1Vev9uUUI2PI5zMcgK85HL/T3oM5F7csv7Z2hvnTsPxIylJDhLuHfWHwEDX5Mwjbk7wDgblYFYZlxHhkcK6zUrK/+XXlSHkdcOYkIC5VF7AhO8THVsjTV10hHQTrzEj2beWkP3YpMJOnSzyJ4jKa3dZI+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641497; c=relaxed/simple;
	bh=g/2Dcs+EJflLw2qi8HhQ+B53lrl6WUfBXfL1zbpVnoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stVg2Unhu1gsowtdai/JO8Vo/Gk7bM4MtSTNhVI2G80l97SldKyI59VYgOJMvUARgWhwfctWHCRYXKBq5c+gVKQSILw5uyNMdgl+ZXUIxekbsWsJGAI/4biaEY3uRjYboPHFA1OYZlq/nqVr+WskcCaYtZLTWexATXy69B1CTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=En6R7rl1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="En6R7rl1"
Received: (qmail 14789 invoked by uid 109); 19 May 2025 07:58:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=g/2Dcs+EJflLw2qi8HhQ+B53lrl6WUfBXfL1zbpVnoM=; b=En6R7rl1dJ6TNohOSS1qjhydrWGNo4c+Cyc3dfDFkcOOM5Qn1gMenOVnuk9ROE2VPDCrHs94rvXayYyDMlfD1PloqlJs/IXnShpzq/s2kNINbuQrrpnQTjVo22MsmDZIgBZkR9Y5Eo1juWOLNNdX/flutHG7EB/Ot9cyhKwgxosfsEOuTOaz/MZGQUo/tDcl0paozbDhs4T8qZlEmpsN8vukN7mIJAz3O1MJ6Hxh7tKt4/HlfKLWXVsKoS5Qg6R7dTrirT3fLYySdXFpNvE2AEQ/GccMrwbJIr3eflsneNY+sytQE5MWa3U/iDIwCErwLQyUr70F4SsxjDGJj/uQdA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 May 2025 07:58:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25466 invoked by uid 111); 19 May 2025 07:58:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 May 2025 03:58:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 May 2025 03:58:13 -0400
From: Jeff King <peff@peff.net>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/8] string-list: return index directly when inserting
 an existing element
Message-ID: <20250519075813.GF102701@coredump.intra.peff.net>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDW8CcWeq8T9hp@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCoDW8CcWeq8T9hp@ArchLinux>

On Sun, May 18, 2025 at 11:57:15PM +0800, shejialuo wrote:

> When inserting an existing element, "add_entry" would convert "index"
> value to "-1-index" to indicate the caller that this element is in the
> list already.
> 
> However, in "string_list_insert", we would simply convert this to the
> original positive index without any further action. Let's directly
> return the index as we don't care about whether the element is in the
> list by using "add_entry".
> 
> In the future, if we want to let "add_entry" tell the caller, we may add
> "int *exact_match" parameter to "add_entry" instead of converting the
> index to negative to indicate.

I assumed this was in the same boat as the previous change: something we
used to use and now don't. But I don't think we ever did. The "-1-index"
pattern goes all the way back to the beginning of the code.

It does match how other functions like string_list_find_insert_index()
behave. But I think that pattern doesn't make much sense for
add_entry(). After the function returns we know we've either found
something or added it, so the positive index will always point to a
matching entry.

So I think your patches are correct, but I was curious how we got to
this state.

-Peff
