Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EA114039A
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272546; cv=none; b=mefg1fRDpgSq6FbhRZz18MHdnpZR0E+u/YiJI8N5iC5W6E1dZawRSBYh1XmlMUFWGmogHoHfoFs0foXmwDsFfPm/3vRi0bX87JlMdNAGypaoKYiYKW3gIcL45qp4MvQ75gVDTyWqXmoYiPrGKSHH6uLk1lzCDwQJpbyeZ9zD6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272546; c=relaxed/simple;
	bh=ZHouNPOUQ07N4hcY5PuamHK0yGSXak3BCnQy7R9Uz8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLNBE/e9seRWtkK2ZGnYcnq8LJL0zVyGcZU4UKpoSd23n4AZlkivPZzDiuYP4wqO2AEJAQ9tBMyxkkkVqbfarSe/5bs7wx7cpf3aH329a3PnuTZQjqPDVFSKA0GMnHUVwn/5wLwyfHaAyBDcQIshWJt/ayD1iHDV6zu6xFBG66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25633 invoked by uid 109); 13 Jun 2024 09:55:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Jun 2024 09:55:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15613 invoked by uid 111); 13 Jun 2024 09:55:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Jun 2024 05:55:41 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Jun 2024 05:55:42 -0400
From: Jeff King <peff@peff.net>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] remote-curl: read in the push report even if we fail
 to finish sending data
Message-ID: <20240613095542.GA817573@coredump.intra.peff.net>
References: <20240612115028.1169183-1-cmn@dwim.me>
 <20240612115028.1169183-5-cmn@dwim.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612115028.1169183-5-cmn@dwim.me>

On Wed, Jun 12, 2024 at 01:50:28PM +0200, Carlos Martín Nieto wrote:

> If we just consume send-pack's output and don't send anything to
> remote-helper, it will not update any of its structures and will report
> "Everything up-to-date" next to the error message.

OK, consuming the output at the helper level makes some sense to me.
But...

> diff --git a/remote-curl.c b/remote-curl.c
> index 0b6d7815fdd..9e45e14afec 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1114,15 +1114,25 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
>  
>  	close(client.in);
>  	client.in = -1;
> -	if (!err) {
> -		strbuf_read(rpc_result, client.out, 0);
> -	} else {
> -		char buf[4096];
> -		for (;;)
> -			if (xread(client.out, buf, sizeof(buf)) <= 0)
> -				break;
> +
> +	/*
> +	 * If we encountered an error, we might still get a report. Consume the
> +	 * rest of the packfile and an extra flush and then we can copy
> +	 * over the report the same way as in the success case.
> +	 */
> +	if (err) {
> +		int n;
> +		do {
> +			n = packet_read(rpc->out, rpc->buf, rpc->alloc, 0);
> +		} while (n > 0);
> +
> +		/* Read the final flush separating the payload from the report */
> +		packet_read(rpc->out, rpc->buf, rpc->alloc, 0);
>  	}

Isn't this existing code already trying to read everything? I think
rpc->out and client.out are synonyms.

So now instead of reading to EOF, we are reading some set number of
packets. This function is used for both fetches and pushes, isn't it? Is
the expected number of packets the same for both? What about
stateless-connect mode?

> +	/* Copy the report of successes/failures */
> +	strbuf_read(rpc_result, client.out, 0);

OK, so this is where we read the result. Which again, only makes sense
for send-pack. And in theory we've synchronized the protocol through the
packet reads above (are we sure that we always enter the read loop above
from a predictable synchronization point in the protocol, given that we
saw an error?).

What if send-pack doesn't send us anything useful (e.g., it hangs up
without sending the report). Shouldn't we take the presence of "err"
being non-zero as an indication that things are not well, even if we
never get to the send-pack report?

-Peff
