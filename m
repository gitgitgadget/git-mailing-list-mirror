Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875EF1F4E3B
	for <git@vger.kernel.org>; Fri, 30 May 2025 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748586459; cv=none; b=Fc8qQBKy7PzrNFwWC7M4HlqgEVdWHjLo/Y/D9WrS+UWm8iY+FviakXoMU1WUhE4wDFcsSyYJY6bGdpp6BAocFePijMAq7Whg3s/PJZrd/hO26eIuh/uQzvVGzc8ppdPDh4tkpiOlPQKO0tC6DBi8avNcg1OOV29XE1wExNr1eoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748586459; c=relaxed/simple;
	bh=irkmLyesBM/ze+Lu5RPPFeQ7E/xOD8iJPeqyFyg4joQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWz/31uxuxUzf3GmZ4n/d9SEUy+hKjEG13XiyK5MAcP7sxKIXxeFz65wSIWdPh74iQnfulmmD5pkXjn0n+F4vh927AXahkNiX23rq4ljFqnyXpCP61LJXBtJAe3Bv+bbLBngoWgrF/HK8KeqigysyKLbCl1tb5JJ7aGeKWh5NxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FO2uTmf/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FO2uTmf/"
Received: (qmail 2214 invoked by uid 109); 30 May 2025 06:27:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=irkmLyesBM/ze+Lu5RPPFeQ7E/xOD8iJPeqyFyg4joQ=; b=FO2uTmf/emm3vQKJ2xRLomSA3JPlKtyV6MDrMwR4otSXLsM6l4heMTZY0Zj+S++9yKmOtS4RQqY/TJpH52tYYfTEpKHSPJx0Ynt2lEFRf5RVOhL8jWaQAxB2Ct49U7kKNuaMcjjDSP9YpONHx/YVthhGCFWaE+jiLxTKmgs5hnv1G/DEjV0PYsNvN0fbhVV51y+9lVXAqeWikz40R4ZOjY/SumgsipvyWksHAY8bt/z3+abzW4DzwT7r4ZXRaXYmjFyCArQNP/LuYPNeplNQSS0cyrUFoQNkO+YpOx07WHog6Y3f5G6zOkUgrkS8cfn6kof+nVQl/e5NpaZnUpVkNg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 May 2025 06:27:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8048 invoked by uid 111); 30 May 2025 06:27:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 May 2025 02:27:38 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 30 May 2025 02:27:33 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] packfile: avoid access(3p) calls for missing packs
Message-ID: <20250530062733.GB1321283@coredump.intra.peff.net>
References: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
 <20250528-pks-pack-avoid-stats-on-missing-v3-0-4cbd0e14bed8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250528-pks-pack-avoid-stats-on-missing-v3-0-4cbd0e14bed8@pks.im>

On Wed, May 28, 2025 at 02:24:09PM +0200, Patrick Steinhardt wrote:

> Changes in v3:
>   - Use a macro to hide away the `(void *)(intptr_t)-1` magic.
>   - Link to v2: https://lore.kernel.org/r/20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im

Thanks, this looks good to me.

-Peff
