Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F928592D;
	Thu, 21 Mar 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042526; cv=none; b=oRRffQ/GpjooewL00CpXSCj5ZRHRVdVmC0qQMlI5PkwfRNFhDkVAVtuTOE5QCq4aOR4ygK0k13bAIzivDn/mM6FhlnVU7ERcpLU+h87hN6xM624CQsE2i5M5698jchVE2FbX6gC6mw9eqmtxt0SteEjQ9KCDfWCH8a0y2MV6LjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042526; c=relaxed/simple;
	bh=+uhI7J53JlvlWc/YQJLBFyTaJDV1zzxxVBCEtD/Z+E8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mKrayTxFI4Oy8u43bmdMZj/BbtHxfl0PB5AYZA5wq8I0lsshm12sd4QAjJgJfhgltm1Do+ZTpsZmbUOHvWY2NrBbs7B+uxnpP7GJBsdFk6Xat2pvNiq0sdPktWWuzLf1kl/oO/FKG62gUxsq/0neNmEC8PzkNwZxZwI9MMxkIZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZwnVUT/e; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZwnVUT/e"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D73A1EB8CA;
	Thu, 21 Mar 2024 13:35:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+uhI7J53JlvlWc/YQJLBFyTaJDV1zzxxVBCEtD
	/Z+E8=; b=ZwnVUT/eHj+JnMlmyJhYCN3xEKKCcG5YAdsLs5HwfBnsirSxWhWjYY
	O+o6PM2suMInbKnilceZpAuV9FCYtYbAVOkZKRYSMGTpZHdM0X78DrUj8114JCSa
	im7GW1EcF5Ipj8Gfbj9vzMANSH1qfFgiLs2/DsjM3Avv8anxpJ7g8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 83AAE1EB8C8;
	Thu, 21 Mar 2024 13:35:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E53101EB8C7;
	Thu, 21 Mar 2024 13:35:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Chuck Lever <chuck.lever@oracle.com>,
  rsbecker@nexbridge.com,  Jeff King <peff@peff.net>,
  linux-nfs@vger.kernel.org
Subject: Re: [PATCH] reftable: fix tests being broken by NFS'
 delete-after-close semantics
In-Reply-To: <8ac5e94a3930cdd2aee9ea86acda3155674b635c.1711035529.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 21 Mar 2024 16:39:52 +0100")
References: <ZfBwZTL9zqDsac5m@manet.1015granger.net>
	<8ac5e94a3930cdd2aee9ea86acda3155674b635c.1711035529.git.ps@pks.im>
Date: Thu, 21 Mar 2024 10:35:19 -0700
Message-ID: <xmqqsf0j8p48.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 641419CE-E7A9-11EE-9373-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>  	while ((d = readdir(dir))) {
> -		if (!strcmp(d->d_name, "..") || !strcmp(d->d_name, "."))
> +		/*
> +		 * Besides skipping over "." and "..", we also need to
> +		 * skip over other files that have a leading ".". This
> +		 * is due to behaviour of NFS, which will rename files
> +		 * to ".nfs*" to emulate delete-on-last-close.
> +		 *
> +		 * In any case this should be fine as the reftable
> +		 * library will never write files with leading dots
> +		 * anyway.
> +		 */
> +		if (starts_with(d->d_name, "."))
>  			continue;

Sounds good.  We should count what we positively consider what we
wrote, not random cruft somebody else might have dropped in the
directory, and this is a good first thing to do.

Will queue.  Thanks.
