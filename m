Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23422D7B1
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766564480; cv=none; b=CmYLrYzhIudOdqfA58fGZAkwe2t8tfaT82JhikzKJYu6kvtf0vfv8Ekz6Dt+hJtofRpySxW2p5qKr+QqHYSxIFNaHHhvn5S2D6b0qkCUs9FYAq0bGJEtZNxqUjtTh1s2oUI8AuVXpYTZWJL7VA6nT0comC1cr5f82KIUk0+bTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766564480; c=relaxed/simple;
	bh=37Hpi8fXlY214/DUotRuuaHjZYC8V9fhz7nZBoV6aY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3ry7DggBc6i2v32SYOHVDMIUXQ1mb+MEFuTL9nUuidq2XmnfPD5M7TyrWdpp5GRrNu+EJZQQiMFWhnXMv5ifjyTMmxtP6Z7MGHIjbOcssvtVT8bz9jQkVPHVFPW3jCFDN4BcGTzLmeahYs7pLanIbANdorHS9UjZFMWcgYlOfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JTIj57eS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JTIj57eS"
Received: (qmail 431207 invoked by uid 109); 24 Dec 2025 08:21:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=37Hpi8fXlY214/DUotRuuaHjZYC8V9fhz7nZBoV6aY8=; b=JTIj57eS29MHqwPtElvPaSdAVXylx2KbapWNu4C0s8O8tdTp2MhE3gvY0sG1HK8MddAaXWObKp6yAk57sLeMC1YCfTwhQinu7p5S7feZF/qZYUSEYYGiE9AUgcyZig9d56srHkXnZ5edCHxs3FSFjbZEQP6UGZeDfrgvkWIXgjE9ZET6sOi3G3FiQGresA7GwqAc4PRInt7lp04brk1PzVDKYs0d9Qzv9/3gcGkKCtdFL5VFLmCgZjhCxqEZEuGTgxtwErz2m+IM2HNZ0x+0RG3rvTiB7Yk3Mf8iyxGapm77V7w0vDIhgyS3NUjAjyACIzOioymTMyoh25MqX+Kz2Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Dec 2025 08:21:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 601151 invoked by uid 111); 24 Dec 2025 08:21:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Dec 2025 03:21:21 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 24 Dec 2025 03:21:16 -0500
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: Possible regression: lost diagnostic message when pushing
 non-commit objects to refs/heads/*
Message-ID: <20251224082116.GA1946629@coredump.intra.peff.net>
References: <CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com>
 <20251224081214.GA1879908@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251224081214.GA1879908@coredump.intra.peff.net>

On Wed, Dec 24, 2025 at 03:12:14AM -0500, Jeff King wrote:

> But in the new batched world that allows partial-batch failures, we
> throw it away. The problem (at least for the files backend) is this code
> in files_transaction_prepare():
> 
>           ret = lock_ref_for_update(refs, update, i, transaction,
>                                     head_ref, &refnames_to_check,
>                                     err);
>           if (ret) {
>                   if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
>                           strbuf_reset(err);
>                           ret = 0;
> 
>                           continue;
>                   }
>                   goto cleanup;
>           }

BTW, you found the regression via receive-pack, but as you can see here
it is really a problem for any batched ref-update caller that sets the
ALLOW_FAILURE flag. So the original sin is not from the commit you found
via bisect, but 23fc8e4f61 (refs: implement batch reference update
support, 2025-04-08). And it affects fetch, too:

  $ git.v2.50.0 fetch . v1.0.0:refs/heads/foo
  error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'
  From .
   ! [new tag]               v1.0.0     -> foo  (unable to update local ref)

  $ git.v2.51.0 fetch . v1.0.0:refs/heads/foo
  From .
   * [new tag]               v1.0.0     -> foo
  error: fetching ref refs/heads/foo failed: invalid new value provided

Actually, I think there is another bug lurking there for fetch. We do
not even mark the failure in the status output anymore!

And I guess "update-ref --batch-updates" suffers from the same lack of
detail:

  $ echo create refs/heads/foo v1.0.0 | git update-ref --batch-updates --stdin
  rejected refs/heads/foo f665776185ad074b236c00751d666da7d1977dbe 0000000000000000000000000000000000000000 invalid new value provided

though it is not technically a regression since the option to ask for
ALLOW_FAILURE did not even exist before --batch-updates. It would be
nice if it gave more details (whether to stderr or in the
machine-readable output).

-Peff
