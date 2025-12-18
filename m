Received: from silly.haxx.se (silly.haxx.se [159.253.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504EC321442
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.253.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766061998; cv=none; b=gXHXmoTfPiRbTirrdtQgUiFmxiJfZdGSwQcfEMlisIbU7PJnEVXos4IBEO0rE24jlFc7EUtSFCz277odSyDFLm9crBksdkGCl/ID2MtMqe/GR+kILV5gAfCZr48Mq7/VXOXNIErxQJd5Et4iEMAHAzzr2S5QiRymF3IMTi9nqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766061998; c=relaxed/simple;
	bh=XeslKwutRDgwRnzh0OCzvCf5FLB/3dAFIrrmEAiI3OY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t2/UymTt5/xCPFD6VPGD9HW+i5hKenNrVknefFqegXOvpgWIRiWK9mySzLjcAC1pRje8hp9/a9TxIAtO2Fh51pJ4w96/ePAp1in6H2shb+2TnZj0zrH8nCJbDwivIuJm5JVokJG/sgh0IW7OJobnHzH7hiyOktICs7gkvIpe9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se; spf=pass smtp.mailfrom=haxx.se; dkim=pass (2048-bit key) header.d=haxx.se header.i=@haxx.se header.b=M7WGAvSe; arc=none smtp.client-ip=159.253.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haxx.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haxx.se header.i=@haxx.se header.b="M7WGAvSe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=haxx.se; s=silly;
	t=1766061431; bh=XeslKwutRDgwRnzh0OCzvCf5FLB/3dAFIrrmEAiI3OY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=M7WGAvSe4PX8YV2KCC8depnEewG44/umHWpqys8VXmfIHVBjzwmA9L/v649hWCYt+
	 5pgYnpq5URhX8mYBCgDHGlAAOgadKjEmD+chaJ+F33rFO7HvL51GLtdo3Z5ttQSSgs
	 DG3BeK2bDFJyFs0c/7c5jawxuBqoas0i19R8CeCgcyxMp3pJYFjtRYXjLQ9Mlbs/D9
	 ZvnpPcx9FlhnU50Lvovl4YO15lXSuhYkLqU2krXoc52hs/QFVBOn5w3NvIVsbcVbb2
	 uLIYtP0i2GaGsRbgcAsFvHbwc6G3Zq8XtsBdhKldkyqdpsQpW0YFMPboOcmbxJHFRJ
	 KNVdDC2E8Tamw==
Received: by silly.haxx.se (Postfix, from userid 1001)
	id D97C165FB9; Thu, 18 Dec 2025 13:37:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by silly.haxx.se (Postfix) with ESMTP id D79B283ADA;
	Thu, 18 Dec 2025 13:37:11 +0100 (CET)
Date: Thu, 18 Dec 2025 13:37:11 +0100 (CET)
From: Daniel Stenberg <daniel@haxx.se>
To: Jeff King <peff@peff.net>
cc: git@vger.kernel.org, Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 0/3] test-suite fixes for upcoming curl 8.18.0
In-Reply-To: <20251218121120.GA3252258@coredump.intra.peff.net>
Message-ID: <613s97no-7021-pp15-79s4-302o39p7n5r8@unkk.fr>
References: <20251218121120.GA3252258@coredump.intra.peff.net>
X-fromdanielhimself: yes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 18 Dec 2025, Jeff King wrote:

> Daniel: I'm cc-ing you in case you want to double-check that curl's behavior 
> changes are all OK before the release. I think it's mostly fine, though the 
> handling of tab versus space in the third patch is perhaps questionable.

Thanks Jeff, allow me to add my comments here on the three patches:

>  [1/3]: t5551: handle trailing slashes in expected cookies output

This is all benign. As you correctly observed, we no longer keep the 
"original" cookie path around and only work with the sanitized version - so 
that's the one stored now. It was already the one used for actual comparisons 
so apart from the change in storage, it *should* not cause any problems.

>  [2/3]: t5563: add missing end-of-line in HTTP header

I believe I made some code checks a little stricter: header lines MUST end 
with at CR or LF (or both) to be treated as a valid one. Your fix for this 
should be good also for older libcurl versions.

>  [3/3]: t5563: relax whitespace assumptions for unfolded headers

This one is material for me to rethink.

I had to completely change our header unfolding logic because we learned that 
we did not apply it early enough, so some header parsing was wrongly done on 
pre-unfolded data. In this process, I also changed the logic that appends the 
following line on the previous line. To avoid having to keep a state, I 
decided to just append the second line onto the first one without trying to 
reduce the whitespace characters to a single one.

I did not fully consider the impact this might have on users such as you. 
Allow me to rework that a little bit further and get the former white-space 
behavior back. Thanks!

-- 

  / daniel.haxx.se
