Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346814A4F4
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582324; cv=none; b=TF1I2fA5sL82R0Bj07WwkkAEPbf/y07iCHiUURFucCFbR9UylKBKYZh7sjcaXXrQT4wjM5v/G79D6ok5VBItWcl9LVcBxPTOdMmd0Rbog+zVcOS6qAu7USx6/vBRwK9emTF9D0SjLpv2JaCzizNnNlGHo0saluBRqXC9J5jA2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582324; c=relaxed/simple;
	bh=JHUT+B1O0x26D8Ez9nsZdb7HYuQN4yl02R8gxNGgV1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t21+CKN2K8jZFanTbQKuPq2JDD9kBappIGscGC2tsAU3Vg2qs02yygL2E8mLJZXOWqz8DWPZQpNso2GwMN5jK3VrPUbtEtzdG2TrWoP2y+PXCyRXlJ5LisX2DIeyAiUEUAWs76HLrXXclDcxUWFNcyYI1HnRq0Sv2lJaUogGXFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26199 invoked by uid 109); 5 Jun 2024 10:12:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Jun 2024 10:12:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28652 invoked by uid 111); 5 Jun 2024 10:11:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jun 2024 06:11:58 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Jun 2024 06:12:00 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 10/12] refs: implement removal of ref storages
Message-ID: <20240605101200.GA3440499@coredump.intra.peff.net>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
 <f9d9420cf93025595e00aa4287bc0cc1a1c067ab.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9d9420cf93025595e00aa4287bc0cc1a1c067ab.1717402363.git.ps@pks.im>

On Mon, Jun 03, 2024 at 11:30:55AM +0200, Patrick Steinhardt wrote:

> +static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
> +					  struct strbuf *err)
> +{
> [...]
> +	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
> +	if (remove_dir_recursively(&sb, 0) < 0) {
> +		strbuf_addf(err, "could not delete refs: %s",
> +			    strerror(errno));
> +		ret = -1;
> +	}
> +	strbuf_reset(&sb);
> +
> +	strbuf_addf(&sb, "%s/logs", refs->base.gitdir);
> +	if (remove_dir_recursively(&sb, 0) < 0) {
> +		strbuf_addf(err, "could not delete logs: %s",
> +			    strerror(errno));
> +		ret = -1;
> +	}
> +	strbuf_reset(&sb);

If removing either of the directories fails, we set ret to "-1". Make
sense. But...

> +	ret = for_each_root_ref(refs, remove_one_root_ref, &data);
> +	if (ret < 0)
> +		ret = -1;

...then we unconditionally overwrite it, forgetting the earlier error.
Either we should jump to the end on the first failure, or if the goal is
to do as much as possible, should we |= the result? I'm not clear why we
assign "ret" and then immediately check it to assign "-1" again.

Is that a mistake, or are we normalizing other negative values? Maybe
just:

  if (for_each_root_ref(refs, remove_one_root_ref, &data) < 0)
	ret = -1;

would work?

-Peff
