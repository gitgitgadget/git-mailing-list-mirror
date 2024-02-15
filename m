Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B5163AC
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 04:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707972347; cv=none; b=Du+ajPhuSAVSNK6L5gByLSmzbIgnQ6AqFGkI9TMg9yxm/NnFiH6Kndce2RM39BQHnpiwGWwD68qOZb3+dmHspkBuX+qdZH2+CHUJWir7JIOO4xR4pYtLlvAGK14cNGzwNCoPL0QXcSOJMY60j7/1GaCgzw9lqE5dz+LO3sAEuxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707972347; c=relaxed/simple;
	bh=4Zlt794UCa2q4hQaL+Tbg6jx+ow341jFvFED0fiy11s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewr4/VFu+e2VrjD4sTYkLoHn2xjfukByYq7ts2mGuaRmXXc3F0w1nLfJsIe/o97cERo1qtm2GZ27IktUZLhzEosBoKqdCQKXJ5Lzpl2zO1RD+JISKe5GNO4TKUQGCNg0ph8IaV4ciIVZan5k6ZkP4Msgnsh1O8eVochA8nDMkOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17843 invoked by uid 109); 15 Feb 2024 04:39:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Feb 2024 04:39:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11615 invoked by uid 111); 15 Feb 2024 04:39:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Feb 2024 23:39:02 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Feb 2024 23:39:00 -0500
From: Jeff King <peff@peff.net>
To: Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Bo Anderson <mail@boanderson.me>
Subject: Re: [PATCH] t/lib-credential: clean additional credential
Message-ID: <20240215043900.GA2821179@coredump.intra.peff.net>
References: <pull.1664.git.1707959036807.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1664.git.1707959036807.gitgitgadget@gmail.com>

On Thu, Feb 15, 2024 at 01:03:56AM +0000, Bo Anderson via GitGitGadget wrote:

> From: Bo Anderson <mail@boanderson.me>
> 
> 71201ab0e5 (t/lib-credential.sh: ensure credential helpers handle long
> headers, 2023-05-01) added a test which stores credentials with the host
> victim.example.com but this was never cleaned up, leaving residual data
> in the credential store after running the tests.
> 
> Add a cleanup call for this credential to resolve this issue.

Good catch. The patch looks obviously correct.

I'm not surprised nobody noticed until now, as I expect it is pretty
rare for people to run t0303 against system helpers (it is not a problem
for t0301, etc, because they only touch the internal trash directory).

I wonder if we might want something like this, as well, which can catch
leftovers:

diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 716bf1af9f..4183154243 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -6,6 +6,11 @@ test_description='credential-store tests'
 
 helper_test store
 
+helper_test_clean store
+test_expect_success 'test cleanup removes everything' '
+	test_must_be_empty "$HOME/.git-credentials"
+'
+
 test_expect_success 'when xdg file does not exist, xdg file not created' '
 	test_path_is_missing "$HOME/.config/git/credentials" &&
 	test -s "$HOME/.git-credentials"

-Peff
