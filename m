Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040817DE09
	for <git@vger.kernel.org>; Wed, 29 May 2024 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979519; cv=none; b=C5MErsiaDDYz87CdLwJFXBMs7sfR6k2nx1f1VNgudDBUZfSliVrgG3NQdaFpeNzeiz3qTECiphBdPykrVANvgbAzrTBCDSiNIxGFELi0wJagHhr2PjirT/RjMlrrVq06iFyLwCX7ilv7kZtzbw4cLqqx9keoQ1qmxJOeiobJP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979519; c=relaxed/simple;
	bh=anZlfNIwrQKer6GzucAtdQ3Ca06wpuFXNuN2N9qY5lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX069aEraAz5ERA6nCQUqzbBXfrMJMVDEBGSezUi5xBXa3gzEW2kYKNcr+05gFipjEnqI2w2/ty0jnCnuauz3TGEJc/w0WmaAxQM5czZY83ywvLz/F5c0cPwwEEPT85qxjUrt82vjUKoU/CXudIip6mosX9t0D8cOTtCOUcKLtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11625 invoked by uid 109); 29 May 2024 10:45:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 May 2024 10:45:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18902 invoked by uid 111); 29 May 2024 10:45:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 May 2024 06:45:13 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 May 2024 06:45:15 -0400
From: Jeff King <peff@peff.net>
To: Mark Boyd - Q2AAAA <mark.boyd@gsa.gov>
Cc: git@vger.kernel.org
Subject: Re: Inaccurate documentation for core.hooksPath?
Message-ID: <20240529104515.GG1098944@coredump.intra.peff.net>
References: <CABBKgan9hLme+9WTNNVrZXxqO4-VRGiC3RLQgfKFUHAy3QZvDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABBKgan9hLme+9WTNNVrZXxqO4-VRGiC3RLQgfKFUHAy3QZvDA@mail.gmail.com>

On Thu, May 23, 2024 at 03:36:49PM -0400, Mark Boyd - Q2AAAA wrote:

> This documentation says that git only looks for hooks in the
> configured core.hooksPath:
> https://github.com/git/git/blob/master/Documentation/config/core.txt#L499-L504
> 
> However, in my testing, git will run both hooks located in the
> core.hooksPath directory and in the local git repo hooks directory
> (.git/hooks by default). Observation of this behavior is documented in
> https://github.com/cloud-gov/caulking/issues/37.
> 
> Is the behavior I'm seeing the actually expected behavior of git? Or
> are we somehow relying on an edge-case or buggy behavior?

Can you show us a more complete example that runs both hooks? I didn't
see in that issue where it was clear that both were being run. When I
try to make a minimal example, like this:

-- >8 --
git init -q repo
cd repo

echo 'echo >&2 running in-repo hook' >.git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
git commit --allow-empty -m "should have run in-repo hook"

git config core.hookspath $PWD
git commit --allow-empty -m "should have run no hook"

echo 'echo >&2 running external hook' >pre-commit
chmod +x pre-commit
git commit --allow-empty -m "should have run external hook"
-- >8 --

I get the expected output:

  running in-repo hook
  [main (root-commit) 22a8fd5] should have run in-repo hook
  [main ebc5524] should have run no hook
  running external hook
  [main 5ca6b75] should have run external hook

Looking at the code, everything is as I'd expect. Certainly there could
be a bug where it finds the wrong path, but I don't see how it could
ever run _two_ hooks.

-Peff
