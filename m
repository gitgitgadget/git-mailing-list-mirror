Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B7E56C
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836931; cv=none; b=oA6Uj1LyaOPbpo7XanBI4hh1uo/0J6uEqBcRv8Cx40jZzstDVVAHzZKQ0Xosp2axsc1KJCqR7h8nMp9IeNnmyyPoTzFCipCblzgaOOxOS33DRVCyx69BY0mcJGsRrZemT39Wsu9bXhGuN5rSnof0I/ZkxQ8O+WOViP4Ct/4alZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836931; c=relaxed/simple;
	bh=jLVXcWtvCEczGJQ5Vp1RYT0cwf0XHDc//37ROXiuWto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ai4lgwPT/4WCF5TKlv2jQYUmyEKgLUaOL9mNaBeXg0HE/wfZTa1qmXleWaAK0QeO/VlGzcS465n1PqIfr8kVQgxZMwALxc8RvFTGzp4pToze1SS1YieF/eWWF4Uum6l8G7jzyt2jwp0gCIb3uyIVsymkrlKK3NRBhi2BlAOTCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7570 invoked by uid 109); 8 Jun 2024 08:55:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 08:55:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28764 invoked by uid 111); 8 Jun 2024 08:55:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 04:55:26 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 04:55:28 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] Makefile: add ability to append to CFLAGS and
 LDFLAGS
Message-ID: <20240608085528.GD2390433@coredump.intra.peff.net>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717742752.git.ps@pks.im>
 <d68539834f3827fa3ffe91517e053c043243a378.1717742752.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d68539834f3827fa3ffe91517e053c043243a378.1717742752.git.ps@pks.im>

On Fri, Jun 07, 2024 at 08:46:34AM +0200, Patrick Steinhardt wrote:

> Note that we have to use the `override` directive here such that the
> flags get appended when compiling with `make CFLAGS=x CFLAGS_APPEND=y`.

Another way to do this is just:

diff --git a/Makefile b/Makefile
index 2f5f16847a..9cd3b252ff 100644
--- a/Makefile
+++ b/Makefile
@@ -1446,8 +1446,8 @@ ALL_COMMANDS_TO_INSTALL += git-upload-archive$(X)
 ALL_COMMANDS_TO_INSTALL += git-upload-pack$(X)
 endif
 
-ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
-ALL_LDFLAGS = $(LDFLAGS)
+ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_APPEND)
+ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
 
 ifdef SANITIZE
 SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))

I can't think offhand of any way that your override would not do the
right thing, but:

 - this is roughly the same problem faced by DEVELOPER_CFLAGS, etc, so
   handling it in the same way makes sense to me

 - I always get nervous around make features like "override", as there
   are sometimes corner cases lurking

-Peff
