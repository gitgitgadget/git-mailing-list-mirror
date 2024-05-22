Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8FD51E
	for <git@vger.kernel.org>; Wed, 22 May 2024 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716405404; cv=none; b=cEGAPpXkXOKo7LZldokKbDY2QBQ7Hd+ZTfb7HmWoXs1ldLSNyMSfdDQTT5wlB7YykCUZv2cYLH++FnFiYx9pQVVzCv0wyTtyZresIHrxVBB/DkNzOPTXcql0pBCJq5sopMMgWS5bEH6rWBm2REk7P5mR5vNncG4fujKtXX3d3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716405404; c=relaxed/simple;
	bh=uoStTwUxoZcZvMNUqUXpfDv3aaEoFsJaXbHnd1GXweY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OqkVLfHNTRreImq4M6PnhJt9pmmWjUDY9GTOsqtZjn6WxtMGSgga+TDZAAJ3xp5D+ydELRauXod9UZ9hVj2TsasQ/fGMcr1XEPBnCJqhiAnsuVcw0UOqGQA5DTHyRLj5bVWckAcW3fyXgfd+xBRm2XsZIvoXM0broOParkkpR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=n+N0rFTq; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n+N0rFTq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B0433602A;
	Wed, 22 May 2024 15:16:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uoStTwUxoZcZvMNUqUXpfDv3aaEoFsJaXbHnd1
	GXweY=; b=n+N0rFTq7hL28tpsgEvUAlhXQpbCoM3yGOjF1bXRBU0rgxnXFl+bCr
	3yE4kukKFzJiWSONhaxb/Db+xsGwJFzo2S/daYZwUBFhvlG6gehLx1LmaRg6s34r
	83oMbrD5IS4gpDRHZ/hlCSjZQRRG5c81B20nUtre4TA+YvFyPBW/4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5483E36029;
	Wed, 22 May 2024 15:16:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 570CE36028;
	Wed, 22 May 2024 15:16:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tom Hughes <tom@compton.nu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] push: don't fetch commit object when checking existence
In-Reply-To: <20240522133621.1308393-1-tom@compton.nu> (Tom Hughes's message
	of "Wed, 22 May 2024 14:36:21 +0100")
References: <20240522133621.1308393-1-tom@compton.nu>
Date: Wed, 22 May 2024 12:16:32 -0700
Message-ID: <xmqq8r014pyn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CDB9A3D4-186F-11EF-AB75-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Tom Hughes <tom@compton.nu> writes:

> If we're checking to see whether to tell the user to do a fetch
> before pushing there's no need for us to actually fetch the object
> from the remote if the clone is partial.
>
> Because the promisor doesn't do negotiation actually trying to do
> the fetch of the new head can be very expensive as it will try and
> include history that we already have and it just results in rejecting
> the push with a different message, and in behavior that is different
> to a clone that is not partial.

Interesting.  Is this something that is easily testable, perhaps by
preparing a partial clone and try to push from there and checking
the non-existence of the object after seeing that push failed?

Thanks.

> Signed-off-by: Tom Hughes <tom@compton.nu>
> ---
>  remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
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
