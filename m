Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997E31197C
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287359; cv=none; b=D6MG+t87NV2nB5jI/8TFVK8hSxdkxinu6z4CxLbFQJmQFe8qcGCDoPk0ENp7yQi+9CcULnjJzYQT47/jTXiWBioKBVuqSAy6cnWX5eyK1IbZoDcQ4fjZrNZCkk1kexfghuoCoPlNHjt7d358J+T/zJAOpV7R0RHggHft9l6FSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287359; c=relaxed/simple;
	bh=zetKKk7PLXm2oq2WVmBlWyYBx9oqpT1jwmvXGVyQ4V0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S3YNKHZxoxB90mvoqeIHKW+kVjB1D4TBBntAW9MRLztBWMiQ5X0PRJTggeYOV5VzK1hq1ekIthyEHv/DSHpJLE+fR3FdIyLotPDnp+acOX1zzEVe+ff8D1DT36G6NlYWdGl6V0UK3zJKCRTPYAfhhA1rmRdQ7046oyPI7qVhCwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=JdgMo3Ig; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="JdgMo3Ig"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782287355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TM47WyeF/genllMipd2EQlXoFkDyke54PbqFVlW5Rrc=;
	b=JdgMo3IgMVsiYpqufef6i+noBn5bKVGv0O/FHA59vgNk+4r/BPwpJZDETH7HnJAhtcHiSL
	5rFEECHX5uE64F4oaaftx8WeA44Cl/lULpxL71Pf7qLdFXRpZUIKgB+DyB4QGEWhoDmSSO
	hPhvXWkJZXVfqGFc29oAGFxo4g64yUU=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bundle-uri: drain remaining response on invalid
 bundle-uri lines
In-Reply-To: <adkOJLfxs8TNGRjr@denethor>
References: <20260408-toon-bundle-uri-no-uri-v1-1-d4a0e3937eba@iotcl.com>
 <adZ6yyGsoyjm7t0Q@denethor> <adiZTBH_70nrpiHe@pks.im>
 <adkOJLfxs8TNGRjr@denethor>
Date: Wed, 24 Jun 2026 09:49:06 +0200
Message-ID: <87y0g4xtsd.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Hi,

My apologies for digging up this old thread, but it was suddenly brought
back to my attention. Anyhow:

Justin Tobler <jltobler@gmail.com> writes:

> I think it is questionable for a Git server to be sending clients
> malformed bundle-uri configuration.

I will not argue about that.

> Do other Git implementations on the server-side exhibit this same
> behavior? If so, or we reasonably think they could and just want to be
> safe, then I agree that adjusting clients first to ignore invalid
> bundle-uri configuration from the server is reasonable.
>
> Generally, I'm of the mindset that when a server is sending
> malformed/garbage data that the client doesn't expect, the client should
> should be more strict and error out. In this case though, since there
> are known affected Git versions and bundle-uri is an optional feature to
> begin with, it probably doesn't hurt to be more permissive.

Yeah, that's the point I was trying to make. The use of bundle-uri is
optional, and clone can continue without it. The code was intentionally
written to continue when something goes wrong with bundle-uris. But
because of some underlaying issue I was trying to fix with this patch,
the process does not continue.

> On 26/04/10 08:31AM, Patrick Steinhardt wrote:

>> That being said, I also think that we should fix the server side.
>> Whether that needs to be part of this patch series though is a different
>> question. Based on the proposed patch you posted it seems to be trivial
>> enough though, so maybe it's worth it to just add that in as a second
>> patch.
>
> Ya, my main concern was that a client-side fix would mask its root
> cause. As long as it gets addressed though it's fine. I think it would
> be worth adding to this series, but if not I'm happy to send a follow up
> patch to fix it too.

I do not fully agree. My fix doesn't make the issue go away silently,
the user gets a warning message. I think this would cause (at least
some) users to complain to the owner of the server (especially because
bundle-URI is an opt-in feature). But I realize now, this warning isn't
checked in the tests, adding that would have made that more clear.

I do agree though a server-side fix would be advised. But I have no idea
how to best address this. In a previous mail you wrote:

> Naively, I would assume the easiest way to fix the issue on the
> server-side would be the following:
> 
> --- >8 ---
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 3b2e347288..96d38bb80f 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -946,7 +946,7 @@ static int config_to_packet_line(const char *key, const char *value,
>  {
>         struct packet_reader *writer = data;
> 
> -       if (starts_with(key, "bundle."))
> +       if (starts_with(key, "bundle.") && value && *value)
>                 packet_write_fmt(writer->fd, "%s=%s", key, value);
> 
>         return 0;
> ---- >8 ---
>
> A quick check using the tests provided in this patch seems to show them
> passing with the above. If we want, we could also have the server print
> a warning on its end regarding the missing value too.

I don't like this fix, because it papers over the issue, silently. But
then again, what is the best way to inform the server admin there's
something wrong? Adding one line to the log files is easily to be
missed.

-- 
Cheers,
Toon


