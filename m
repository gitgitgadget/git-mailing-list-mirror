Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3E1E531
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672175; cv=none; b=mVTrw93LQ8PNQ4Ak8CpT7LcrTSVtnCJ0lPHd/DrBphiTfTkZtJTqDufgixqUepGs9b6ivVFV8XZPWAZh8/Cwv+UMeyP5686oeuhoYmfY4lC2MF5VLHLeLb5XsUfBR3rfN5ZrLwxLDzJGQwOeZ03SWt6jH9VeujmjDRZL/TKw+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672175; c=relaxed/simple;
	bh=+BMeZjkC131l6kl+m+d3bp/iP+hNBNl40cdDvJeU+so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXc06ceWJSR3AkKfg3SymT2x0n4dgCEXNr7Xq5FxY5S5uItDNPZiwFfId6xLCbNGGpQVlVbXhzvOy+gagX1OhKQqBtdtQ1f+4N1U8lsW25+opgLjekyUsS4uRHyK5nHZYk1AqURp4JdiD4t2LVWjlXX/67x87t4vdvGI4q3rr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DfN4r9fC; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DfN4r9fC"
Received: (qmail 1749 invoked by uid 106); 5 Mar 2026 00:56:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+BMeZjkC131l6kl+m+d3bp/iP+hNBNl40cdDvJeU+so=; b=DfN4r9fCxpEYGttCUyUGtcaeHDDe7CGA6Xic+UL7TV8qr8I4Grao2o2TCB7+GkLf1EFn+NkDMqxOxqUcVB2eL1ly+Ucp/uSLM9gxpS5rk2bWkyfTUnMnH6AgYaK+7TSOZpFGFMkXH8Nsp2A0+JAQ3VlRr3zyi6+iTBK0Wv3S++4LPa0SKJ1fL9dcyF7TyHorBiSPh2MaN1IClfM1FEMX7kGWGTI4LLgNVkvRuFmKgnduSAHOaW+ow4indGspgTDOjZaXw0vmgzuocYXZATzcuxiaDpJ1Kd4ZiGj/5gqTAF82ksD/WZDXDNCdB5HmTbGp8iXZ7ts5rNk82OOAmS6FBA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Mar 2026 00:56:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 375995 invoked by uid 111); 5 Mar 2026 00:56:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Mar 2026 19:56:13 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Mar 2026 19:56:11 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 02/10] upload-pack: adapt keepalives based on buffering
Message-ID: <20260305005611.GB4943@coredump.intra.peff.net>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
 <20260303-pks-upload-pack-write-contention-v2-2-7321830f08fe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-2-7321830f08fe@pks.im>

On Tue, Mar 03, 2026 at 04:00:17PM +0100, Patrick Steinhardt wrote:

> The most important edge case here happens in `relay_pack_data()`. When
> we haven't seen the initial "PACK" signature from git-pack-objects(1)
> yet we buffer incoming data. So in the worst case, if each of the bytes
> of that signature arrive shortly before the configured keepalive
> timeout, then we may not send out any data for a time period that is
> (almost) four times as long as the configured timeout.

Thanks for laying out this case. I think this is all-but-impossible in
practice, as anybody writing "PACK" is going to do so all at once. Even
4 separate write() calls would be fine, as long as it does not pause in
between!

I think there's another one, too. If we are getting packfile_uris, and
pack-objects writes half a line, we will pause waiting for the complete
line to show up. This also seems quite unlikely in practice.

> This edge case is rather unlikely to matter in practice. But in a
> subsequent commit we're going to adapt our buffering mechanism to become
> more aggressive, which makes it more likely that we don't send any data
> for an extended amount of time.
> 
> Adapt the logic so that instead of using a fixed timeout on every call
> to poll(3p), we instead figure out how much time has passed since the
> last-sent data.

OK. That should not be too bad to do, though...

> @@ -365,10 +373,14 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  	 */
>  
>  	while (1) {
> +		uint64_t now_ms = getnanotime() / 1000000;

...now we are talking about wall-clock time since the epoch. What
happens if time goes backwards due to a clock reset?

Then now_ms may be less than last_sent_ms, and then here:

> +		} else {
> +			/*
> +			 * The polling timeout needs to be adjusted based on
> +			 * the time we have sent our last package. The longer
> +			 * it's been in the past, the shorter the timeout
> +			 * becomes until we eventually don't block at all.
> +			 */
> +			polltimeout_ms = 1000 * pack_data->keepalive - (now_ms - last_sent_ms);
> +			if (polltimeout_ms < 0)
> +				polltimeout_ms = 0;
> +		}

...we end up with a value higher than the keepalive, and we wait too
long. That's probably an OK outcome for such an exceptional condition.
The worst case if you set your clock back is that we fail to send
keepalives until the next actual data chunk arrives.

>  		if (0 <= pe && (pfd[pe].revents & (POLLIN|POLLHUP))) {
>  			/* Status ready; we ship that in the side-band
>  			 * or dump to the standard error.
>  			 */
>  			sz = xread(pack_objects.err, progress,
>  				  sizeof(progress));
> -			if (0 < sz)
> +			if (0 < sz) {
>  				send_client_data(2, progress, sz,
>  						 pack_data->use_sideband);
> -			else if (sz == 0) {
> +				last_sent_ms = now_ms;
> +			} else if (sz == 0) {
>  				close(pack_objects.err);
>  				pack_objects.err = -1;
>  			}

OK, so here we know we sent data, because we pass along stderr as
quickly as possible. If we got EOF on stderr, that doesn't count as
sending data, because we don't pass along that EOF to the client. Makes
sense.

>  		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
> +			bool did_send_data;
>  			int result = relay_pack_data(pack_objects.out,
>  						     output_state,
>  						     pack_data->use_sideband,
> -						     !!uri_protocols);
> +						     !!uri_protocols,
> +						     &did_send_data);

And then for stdout, we have to ask relay_pack_data() if it sent
anything. That makes sense.

-Peff
