Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8F15FBB3
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454706; cv=none; b=aQrlU78JN3U2vPMWyhjq3ldFWYcgAQvHMbXanoHRaLBtVPQzOBdUBTIRHy0TZfw1Wc0cpyv5THDozk8ZTov6oY94Q6M+BOA1k/a8cJzrvH5Co+CW3qBe0fek1BGv+fE7X7j+aM9S6TDUs9t5JR5H1fOHFbiSVDeRhyc6uT/Hh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454706; c=relaxed/simple;
	bh=u8zt1xcF7Xx8Bbasj5J2EvbG1Z5s3Vs0rmrYfbPjFdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9Fa8RwKeDwDePEzegGnJv3PzFiI3PCLparFXyY/Ek2RIjXB8dSKhOI6oyPg6JMA1l2O6JnNv7Ip0hpvNyO6C03/kWd95/qptV3yTJ7oRDGgBD/NUhjgnXYAzxm1lZWM6ONn/D6BSfp4di6u+vQC+xS0Xj7AEqp03WF4HLy067c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 30986 invoked by uid 109); 23 May 2024 08:58:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 08:58:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28363 invoked by uid 111); 23 May 2024 08:58:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 04:58:20 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 04:58:14 -0400
From: Jeff King <peff@peff.net>
To: Tom Hughes <tom@compton.nu>
Cc: gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v2] push: don't fetch commit object when checking
 existence
Message-ID: <20240523085814.GA1306938@coredump.intra.peff.net>
References: <xmqq8r014pyn.fsf@gitster.g>
 <20240522201559.1677959-1-tom@compton.nu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240522201559.1677959-1-tom@compton.nu>

On Wed, May 22, 2024 at 09:15:40PM +0100, Tom Hughes wrote:

> diff --git a/remote.c b/remote.c
> index 2b650b813b..20395bbbd0 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1773,7 +1773,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>  		if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
>  			if (starts_with(ref->name, "refs/tags/"))
>  				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
> -			else if (!repo_has_object_file(the_repository, &ref->old_oid))
> +			else if (!repo_has_object_file_with_flags(the_repository, &ref->old_oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
>  				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
>  			else if (!lookup_commit_reference_gently(the_repository, &ref->old_oid, 1) ||
>  				 !lookup_commit_reference_gently(the_repository, &ref->new_oid, 1))

This makes sense to me, as we're just speculatively asking "do we have
the object". I think for that reason it would also be reasonable to use
OBJECT_INFO_QUICK here, which would avoid a fruitless re-scan of the
local objects/ directory. We often pair the two[1].

In practice, though, I think fetching the missing object is going to be
much more expensive than a local re-scan. We tend to notice the latter
only when you have a large number of objects to check, and here we're
basically limited by the number of non-fast-forward refs you're trying
to push.

So I also think it would be OK to leave it here and only do QUICK if
somebody ever notices it.

-Peff

[1] We've talked about unifying those two flags, since they so often
    come together. There's some discussion in:

      https://lore.kernel.org/git/20191011220822.154063-1-jonathantanmy@google.com/

    that they could become one flag, but these two:

      https://lore.kernel.org/git/20190909222101.GB31319@sigill.intra.peff.net/

      https://lore.kernel.org/git/20200322054916.GB578498@coredump.intra.peff.net/

    argue that QUICK implies SKIP_FETCH, but not always the other way
    around. (Obviously getting a bit off topic for your patch; if
    anything, I think this call site would just use both for now).
