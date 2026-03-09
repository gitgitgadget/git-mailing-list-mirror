Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997723EA90
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084363; cv=none; b=mYfe2hcvgl7wiLp5tZfkkwR6AUCFuzslUpXrXXKfMQliFUhVxmmYwVNolVOWoNsb1qlCJdm1L8wy338GcAzX5xHb3cUz7/LmSi39p1AbnIurDXhAMgR99MJzXnEWWXBK+i3I06J1r/EQPIBbXeiE8IZJ4eBNndm4jotiy7DiAgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084363; c=relaxed/simple;
	bh=8K5YfrawnpyB3UtvWigSvN9O+TWP6ivkWMTfiFyRVEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXRHWKlz0bEPlBsiEViXlmymwymDwaYScEh+zLjcWtHs2B5MdgPWCSUtjqosqnXIhAuFftAYr7UIpw3TjBB4jR0QVGc+cxBGh5pUoGl8JDqXLeNLSDBc3MrMMFPGrS/Y5QtgPW75GTkszMzDLB5b3xblrTKtkTEXS3yTYM8kT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VpRb404f; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VpRb404f"
Received: (qmail 49790 invoked by uid 106); 9 Mar 2026 19:26:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8K5YfrawnpyB3UtvWigSvN9O+TWP6ivkWMTfiFyRVEc=; b=VpRb404frfJeqQhTeYDUWr7QafFB7H46nZOB/7eVCxsJhSoCbNHou/6ngpAmSLIrS4Z5E9VUUy1L8cHb8yr6aYYQo9wX/Sgy85cTgVC1ArJqDdOXXQ5IQR6dRRvPO3Vzs8/CdZBMbrwh79my5WaBnUGrf0vMtMTjdOV2ylOqhV7k5rFo5RVS+peBAQaF7WS9gTWB2C8BwDJsZ0YgMNjRshMmydV7DR6LqnkzpuYbw0qqQUZVQR4c2Bf3DwzbR8G7KCNjAdvQLVPmvWm/UYmcqhOMeHw3d72nXr1Ua9jSud9833ZMUYZXmWgU9D6kfMAZgAXD7mi4d6+JAfW6C0BbQQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Mar 2026 19:26:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 458315 invoked by uid 111); 9 Mar 2026 19:26:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Mar 2026 15:26:02 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Mar 2026 15:26:00 -0400
From: Jeff King <peff@peff.net>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: coccinelle to catch pass-by-value?, was: [PATCH v1 1/2] worktree: do
 not pass strbuf by value
Message-ID: <20260309192600.GC309867@coredump.intra.peff.net>
References: <20260308180359.31188-1-deveshigurgaon@gmail.com>
 <20260308180359.31188-2-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260308180359.31188-2-deveshigurgaon@gmail.com>

On Sun, Mar 08, 2026 at 06:03:58PM +0000, Deveshi Dwivedi wrote:

> The function only needs the string values, not the strbuf machinery.
> Switch it to take const char * and update all callers to pass .buf.

Nice catch. I wonder if we can get the compiler or other static analysis
to complain about this mistake. The best I could come up with is:

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 5f06105df6..665f56d070 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -60,3 +60,10 @@ expression E1, E2;
 @@
 - strbuf_addstr(E1, real_path(E2));
 + strbuf_add_real_path(E1, E2);
+
+@@
+expression F, ARG1, ARG2;
+struct strbuf SB;
+@@
+- F(ARG1, SB, ARG2)
++ F(ARG1, &SB, ARG2)

It rewrites a non-pointer argument into a pointer. That's not enough to
actually make the code work, but it would alert a developer that they
needed to follow-through on the rest of it. Or maybe it would just
confuse them without further hints.

I think there may be a way to get coccinelle to just emit an error
message describing the situation, but it relies on python extensions,
which I'm not sure we currently require.

Anyway, your patch is obviously good and anything further we do would
want to come on top of it.

-Peff
