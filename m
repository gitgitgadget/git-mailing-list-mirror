Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA0854654
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557137; cv=none; b=RVKpnEkOgO6OEgJqwCvmfvhezSrCmMOQhzIS50se/xyKahyBfdLdaWXiEpS9KZPRtwq11Qo7v3HZotlgtGNk8e7kVIS9nfaKPgSEtvlhf0PE5UNQ0px3VFyHjTqn/9h3GfVaPObiev4FFGTQ7KcTN+HKAb9DTKkZ/p92k0oc7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557137; c=relaxed/simple;
	bh=bKAcXQBN8Otx/mMBA8tSDZdy1NeBod0bcVlu4/GyJgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXRWTwGSd9kb+uSdP+uQC9yOEKBbl8v7O31BVfhs1pw/Rz7nmL9j9UyEfL+qGJ5y3zoRJ5xuyvAfW/fG0urKkUtqRn7b3wJi1SuTvf9XhB1rpzdgEY2nbWaoPgT+s9/+LiLrjtQMays2PyDEEJrpDWgiLFxxpsd0HMQ0AQhkpVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U+mEpbsd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U+mEpbsd"
Received: (qmail 5643 invoked by uid 109); 3 Jul 2025 15:38:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bKAcXQBN8Otx/mMBA8tSDZdy1NeBod0bcVlu4/GyJgs=; b=U+mEpbsdqVwi7qlIm9bsWa/oZhM2MnHbJSpvpH1jtwkiX8jmey0tTlK1FnBEc8wkQD27LlEfSn7KmLyIpBYOybuYxagx8XeQleXBHtpbT4BzgAfkwwT37KDDv9HFtcMSG6dmyMIdgvjl1DEH/dVlO08IF9rZNKgdE7x2zo41OjEtpluo87IM/6WrUJgstvSnk8J1jtKxivQQVyBGxYhs89YhNhfAFbZlylZR6rZ09We1lX4f0OClxJRdx53hMyhWREU3Sf6xHvL0Ukdjb8cO1mfpVoOqk0wRzutXHtofYJTFBgariK2XvPrBDR2B4dm75xDa0o+CUrKHJqtFw0UK4A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Jul 2025 15:38:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1025 invoked by uid 111); 3 Jul 2025 15:38:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Jul 2025 11:38:54 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Jul 2025 11:38:53 -0400
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] send-pack: clean up extra_have oid array
Message-ID: <20250703153853.GC1309870@coredump.intra.peff.net>
References: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>

On Fri, Jun 27, 2025 at 03:09:04PM -0700, Jacob Keller wrote:

> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Commit c8009635785e ("fetch-pack, send-pack: clean up shallow oid
> array", 2024-09-25) cleaned up the shallow oid array in cmd_send_pack,
> but didn't clean up extra_have, which is still leaked at program exit.
> I suspect the particular tests in t5539 don't trigger any additions to
> the extra_have array, which explains why the tests can pass leak free
> despite this gap.

Thanks, this looks good. At the time I did that other commit, I was
focused on just bug-hunting the leaks reported by the tests. So I missed
this one.

> I didn't check to see why the t5539 tests don't leak. This leak occured for
> me in a day-to-day run with my local git build that happened to still have
> sanitizers enabled:

The tests are leak-free now, but I suspect we have a lot of
slightly-exotic command invocations like this that still leak. It might
be nice to beef up the test coverage, but I'm OK with just fixing them,
too.

-Peff
