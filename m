Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC6650
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712762; cv=none; b=GgS3Vji1Jw7woVKAN+75JdyhQCadaoX4P+l4nszsasmjz3x4VvWPh/5+EVCNyZ73TiMI8XXtwhwegWQCCEkRoLylsXB6K2JBm4qiHEUPJoRsgVSfeCWf1Zb1LMox7qNxANLUQJIrLcyrwMbDjiCY7Nrcie8Z0B5+I5RZibNesf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712762; c=relaxed/simple;
	bh=oDFMlJOzygMeMqSNO985te9vQOyIAOSYuevdkgInxaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dojHpsb/iiRsq4QZiHRx0WRRnXvwywqsCsBW2DeQFohkqgBy9l1DnD/dvEDWw9vdcHkqaCh1fTFxRRpOaRMgQU/SqcGLjRC09kekKYJlxLIwsx/fYb7vzFRUopZgSnzM8TQWiG0n/W26AXM5U2+5Bf5545AkUdh7gRlw3m/VA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 530 invoked by uid 109); 20 Jan 2024 01:06:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Jan 2024 01:06:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6720 invoked by uid 111); 20 Jan 2024 01:06:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jan 2024 20:06:01 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Jan 2024 20:05:59 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] reftable/stack: fix race in up-to-date check
Message-ID: <20240120010559.GE117170@coredump.intra.peff.net>
References: <cover.1705585037.git.ps@pks.im>
 <713e51a25c1c4cfa830db97f71cd7c39e85864d4.1705585037.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <713e51a25c1c4cfa830db97f71cd7c39e85864d4.1705585037.git.ps@pks.im>

On Thu, Jan 18, 2024 at 02:41:56PM +0100, Patrick Steinhardt wrote:

> Refactor the code to stop using `stat_validity_check()`. Instead, we
> manually stat(3P) the file descriptors to make relevant information
> available. On Windows and MSYS2 the result will have both `st_dev` and
> `st_ino` set to 0, which allows us to address the first issue by not
> using the stat-based cache in that case. It also allows us to make sure
> that we always compare `st_dev` and `st_ino`, addressing the second
> issue.

I didn't think too hard about the details, but does this mean that
every user of stat_validity_check() has the same issue? The other big
one is packed-refs (for which the code was originally written). Should
this fix go into that API?

-Peff
