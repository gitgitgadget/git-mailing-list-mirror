Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A141684A8
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727410075; cv=none; b=ICJw5vCRiYGAUWg684iSJ7Kg07b0KLaQXKahsT4mLS6P3JfiNynn23axu9EJO5vwCVk/3VbN1HORjzLeAiO1ZDdaMl796RygXgI4kynkkSJfWg7K5ci0ECyHkjSRN/MT81DibzE++MHJTs/7BWPH3m430yXK9KS44zPQp9nTsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727410075; c=relaxed/simple;
	bh=LtiDwbRtZFRA1FojQbi3xHkS4nve+AWoBmNYsmWzgAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0/AaSyA7k1K7ND7BjTUUQUlBE14unRSMAsOGs1U+w+qx1zBCwdmJQZn3REjxXH+a05gug/aPTF3+CL6Jqyapt1hwRB5nugy6/AwK/HMJgCXH6qcQ/YeKXd+AY7+9s0AKTPuMzZPNqx5+Zp1wtkVBbWVRV9gakRb4J5sRpdrQds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4927 invoked by uid 109); 27 Sep 2024 04:07:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Sep 2024 04:07:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9199 invoked by uid 111); 27 Sep 2024 04:07:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Sep 2024 00:07:53 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Sep 2024 00:07:52 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] refs/reftable: reload locked stack when preparing
 transaction
Message-ID: <20240927040752.GA567671@coredump.intra.peff.net>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1727155858.git.ps@pks.im>
 <9ce2d18dff2a655365b609dd86ea484a489c717a.1727155858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ce2d18dff2a655365b609dd86ea484a489c717a.1727155858.git.ps@pks.im>

On Tue, Sep 24, 2024 at 07:33:08AM +0200, Patrick Steinhardt wrote:

> +test_expect_success 'ref transaction: many concurrent writers' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		# Set a high timeout such that a busy CI machine will not abort
> +		# early. 10 seconds should hopefully be ample of time to make
> +		# this non-flaky.
> +		git config set reftable.lockTimeout 10000 &&

I saw this test racily fail in the Windows CI build. The failure is as
you might imagine, a few of the background update-ref invocations
failed:

  fatal: update_ref failed for ref 'refs/heads/branch-21': reftable: transaction failure: I/O error

but of course we don't notice because they're backgrounded. And then the
expected output is missing the branch-21 entry (and in my case,
branch-64 suffered a similar fate).

At first I thought we probably needed to bump the timeout (and EIO was
just our way of passing that up the stack). But looking at the
timestamps in the Actions log, the whole loop took less than 10ms to
run.

So could this be indicative of a real contention issue specific to
Windows? I'm wondering if something like the old "you can't delete a
file somebody else has open" restriction is biting us somehow.

-Peff
