Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A771FFC69
	for <git@vger.kernel.org>; Sat, 22 Feb 2025 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208860; cv=none; b=W5p9OYWkJ8PujAoAzDDq877NsBbgfw2STRcVQlQcZ057Dw6uh9bDgD05eG03ufG3CNCGmWIbmszRmDee4bF7KZrBihowdXzfPO40wt1W7bVXcqFQMR/+U7elalcqm/5jECnrU4lndVYSweqEHzf4f+oqEFCNEZNhTHYup8nfof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208860; c=relaxed/simple;
	bh=g1ek1/0xUve6dkA4L+aX2OXGYgkM7ZDLdgyNn7AK69w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUPAGFya/5UQjSdkPwxLMkwK6Sk840QQA/v7dL32rqH2ZgCE/i/TAzjD681pqhNn5S5la5nlmsCkS3I3+oIE0pcYIi0g6FZqQjVkBa6RftolHkj6htX3OBLHZN5cBjk2EkD7OfXq5d02uQ1v+WfnNPR54UalqI7M5HbR2dgLVks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VeheV7kS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VeheV7kS"
Received: (qmail 17237 invoked by uid 109); 22 Feb 2025 07:20:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=g1ek1/0xUve6dkA4L+aX2OXGYgkM7ZDLdgyNn7AK69w=; b=VeheV7kSg1rhhEIp9CPH5h+WiOo1HEIph8pFR4xNV1sFKhL8sKOnu6HRf8PKIexOzUE/zUNhDVGrc8jR14xzdwY4TKe4gPAEuS1brNARmTnrMNs+V0GC2xCBqxKgoyexPp6IAcMM1PDDxAJ5vP9VZiSM4fS5l0NUPmVSHnuIbBcC12KrWP3cDoxVOanULiko8509F0vGcjnCC/53tLkIU+0h5aeGEVBjRRw6yrGS8vJgh1gb7XFvu3wRrOVxKDkuyIqYh3yyvnV7e/W4phovDvySby9S99Y24j41uvi6yspLvRgnT6z+duj4x76n95/6W01/cvJxB5B7fNGcP4BB+Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Feb 2025 07:20:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15203 invoked by uid 111); 22 Feb 2025 07:20:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Feb 2025 02:20:48 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 22 Feb 2025 02:20:48 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v2 11/16] rerere: let `rerere_path()` write paths into a
 caller-provided buffer
Message-ID: <20250222072048.GA3096947@coredump.intra.peff.net>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
 <20250207-b4-pks-path-drop-the-repository-v2-11-13cad3c11b8a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-11-13cad3c11b8a@pks.im>

On Fri, Feb 07, 2025 at 12:03:36PM +0100, Patrick Steinhardt wrote:

>  static timestamp_t rerere_last_used_at(struct rerere_id *id)
>  {
> +	struct strbuf buf = STRBUF_INIT;
>  	struct stat st;
> +	int ret;
> +
> +	ret = stat(rerere_path(&buf, id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
>  
> -	return stat(rerere_path(id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
> +	strbuf_release(&buf);
> +	return ret;
>  }

This "int ret" should surely be a timestamp_t, no?

-Peff
