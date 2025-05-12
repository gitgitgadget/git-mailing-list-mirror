Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8111EB3D
	for <git@vger.kernel.org>; Mon, 12 May 2025 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055183; cv=none; b=JelLoDrprg12Vn8rPZ1/tLPiKNUaT7iiCdHDjfuPEm6GwUZtNPwzIPAm+Pt7SACkWEH+lHz3YaG+nGhHLXLQlROIBslRt+jKe6Bb3ZQWQlqjA50coYCoUNbfbT2396j7GrEVYSjM3IquHKypxN1eANPdziloohyMa+HczDvYT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055183; c=relaxed/simple;
	bh=Ax3oi60KDjuDhzD9iCn33v0YWQ5/C5Vjd0u5UnooV+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xm157BY2kwCbuBq8hzvo/DqdckGUNycAsHSIbuNLXJz8cvH4abMwvosxA/rfaBtRh8+XF8+fYH4Ah3cCLmYqfm6ZXyexlMtJR+BByx0Gwp8W2CQMSCpV8ThhKrX1nSEu+lbTnCy0kAWtqaunYXLSqIRtBrESvND2/V7H8kHeLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=J3A+NI2L; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="J3A+NI2L"
Received: (qmail 1553 invoked by uid 109); 12 May 2025 13:06:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ax3oi60KDjuDhzD9iCn33v0YWQ5/C5Vjd0u5UnooV+o=; b=J3A+NI2LpaD1LZ88PDyNR1KmalqlYckD6Vl3el6yHEsUdrITxYXiPvOjCLQOgIK7Mc9F2L+/Jur6WyS0iJt2CTOIhmVxFEIKQ2QalDYq7voam3bXrqgpObllEOyGBpOoM/DDEzJ76GSFImU/wjzMnFx/WEUcMkB3ycQoe7ZWAr9ga3A1EmYdB45jAydzqWBOjJYH0dQ8caflnyJ9rpapvWOn5saVwQ9eRQhCUolQUpMoAWPrlkXcq7Bmx0v55VvKzhOA/oy6QwfZJB7dr0DLXV4RFCIX+fvN4I70BYrrxr2EpmobjtSk+MB27BgGUx7XH3eeclnOdxBqC4itw3hmog==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 May 2025 13:06:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6170 invoked by uid 111); 12 May 2025 13:06:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 May 2025 09:06:20 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 May 2025 09:06:19 -0400
From: Jeff King <peff@peff.net>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 2/3] packed-backend: extract snapshot allocation in
 `load_contents`
Message-ID: <20250512130619.GB1191360@coredump.intra.peff.net>
References: <aCCtQDnWII-knmEc@ArchLinux>
 <aCCtzm2bDRSTgEO-@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCCtzm2bDRSTgEO-@ArchLinux>

On Sun, May 11, 2025 at 10:01:50PM +0800, shejialuo wrote:

> "load_contents" would choose which way to load the content of the
> "packed-refs". However, we cannot directly use this function when
> checking the consistency due to we don't want to open the file. And we
> also need to reuse the logic to avoid causing repetition.
> 
> Let's create a new helper function "allocate_snapshot_buffer" to extract
> the snapshot allocation logic in "load_contents" and update the
> "load_contents" to align with the behavior.

This looks good to me. One thing that did give me a slight pause while
reviewing:

>  static int load_contents(struct snapshot *snapshot)
>  {
> -	int fd;
>  	struct stat st;
> -	size_t size;
> -	ssize_t bytes_read;
> +	int ret = 1;
> [...]
> +	if (!allocate_snapshot_buffer(snapshot, fd, &st))
> +		ret = 0;
>  
> -	return 1;
> +	close(fd);
> +	return ret;
>  }

I wanted to see what the semantics of "ret" were, but there aren't any
other assignments. So I think this is equivalent to:

  int ret;
  ...
  ret = allocate_snapshot_buffer(snapshot, fd, &st);

which makes it a little more clear we are just relaying the value from
that function.

Probably not worth re-rolling for that, though.

-Peff
