Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C4CA64
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914789; cv=none; b=GryyLYnyF0y6cKidtICKA2RBVnJ73Tym32BYUDMprGIfc/tyFf+OsT364Yofusd8gooZ6sACGP5vo9u2WpaZuxChm+D6GAWZBjMHCflxuqlxQfGjJ2IoWfnaOUTnb/Ph4YdIT6aUoVgYnUsR00a4TSHYrXrG6QNekjFgC0moiVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914789; c=relaxed/simple;
	bh=uzuLHoygHrR9+xUyN+aO3zVWEzjB+x0o7FkHCTU18J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgSmtRIEEfg3OQV01uuLMUjZOPsAmvXfB+A7slSkxs+2qbA6eeYzJv2Bh3O2FqG54xHPD3t2707SAX6zd8eZY++/07CSNU1qPXFHr+sPv1siu4MYCQa8XxD1Aa2Jt188RJvr1RbPJ6HJpwQWHtSpClNIB4L1xNhkHo/uxfPAsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QWKZZxUo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QWKZZxUo"
Received: (qmail 10880 invoked by uid 109); 3 Oct 2024 00:19:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uzuLHoygHrR9+xUyN+aO3zVWEzjB+x0o7FkHCTU18J0=; b=QWKZZxUoYm4kN2cJ5yv2aOIghk3P7m9+M+9RlN8zPd4ZFiOvaw2meko4cU00WACI0pfGI8WIejytsR7vylTVdP0B6yVCmZkisVvgDbkV+dQszmpsekLXYKq7q5VnW5ALfiJZ+jnuCLzmN0j1zVnL5HGyRnt8qZ8lQhyUd6BihasjS3PfKxgg1n8G5iWh0WEiKbZ386dOu9O7eaf+4HzR2mNRWcwfZe8RWx/E92GYuT1kaN1nooD1ZTrTHfpW5waZkDSabcMoHb59wJwhpxGcfOoHDSE/9g7o4/4RVmlP+CxjyE9UQab+lT6VCnI+Qxr5ie1GggdZEAhZp1NrGjkc6g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Oct 2024 00:19:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11252 invoked by uid 111); 3 Oct 2024 00:19:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2024 20:19:46 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Oct 2024 20:19:45 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] line-log: protect inner strbuf from free
Message-ID: <20241003001945.GA3486271@coredump.intra.peff.net>
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
 <20241002235639.GB3455554@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002235639.GB3455554@coredump.intra.peff.net>

On Wed, Oct 02, 2024 at 07:56:39PM -0400, Jeff King wrote:

> Good catch. Your analysis looks correct, though I had two questions I
> managed to answer myself:
> 
>   1. This seems like an obvious use-after-free problem. Why didn't we
>      catch it sooner? I think the answer is that most uses of the
>      output_prefix callback happen via diff_line_prefix(), which was not
>      broken by 394affd46d. It's only line-log that was affected.
> 
>      Building with ASan and running:
> 
>        ./git log --graph -L :diff_line_prefix:diff.c
> 
>      shows the problem immediately (and that your patch fixes it).
>      Should we include a new test in this patch?

I think this would do it if you'd like to squash it in. Note that
showing the actual patch is necessary to trigger the problem (since
that's where we free the prefix buf). Unfortunately it makes the
expected output a lot uglier. :(

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 02d76dca28..950451cf6a 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -337,4 +337,32 @@ test_expect_success 'zero-width regex .* matches any function name' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show line-log with graph' '
+	qz_to_tab_space >expect <<-EOF &&
+	* $head_oid Modify func2() in file.c
+	|Z
+	| diff --git a/file.c b/file.c
+	| --- a/file.c
+	| +++ b/file.c
+	| @@ -6,4 +6,4 @@
+	|  int func2()
+	|  {
+	| -    return F2;
+	| +    return F2 + 2;
+	|  }
+	* $root_oid Add func1() and func2() in file.c
+	ZZ
+	  diff --git a/file.c b/file.c
+	  --- /dev/null
+	  +++ b/file.c
+	  @@ -0,0 +6,4 @@
+	  +int func2()
+	  +{
+	  +    return F2;
+	  +}
+	EOF
+	git log --graph --oneline -L:func2:file.c >actual &&
+	test_cmp expect actual
+'
+
 test_done

-Peff
