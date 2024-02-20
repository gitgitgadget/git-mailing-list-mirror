Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33D3B2A2
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708395143; cv=none; b=JKsW0E64jZamoAroaDVTB/HhBN8EL+y2zsubuf+NXO8gjpJ5jcWEO3SAkDpJ5kuuz50Sw2Hc1ZHOAJmlwsnungam0TSP4Ynzl8XWnBQrqkyV33dw/YAv8rD5nQPlrM4xdwtdTaxV2hvlRf7WD4eBponVRLE7cTZkMePdReqpIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708395143; c=relaxed/simple;
	bh=sicDrfL/8Wq1dbxRHeEy4FuVqc5ydxoPAQel3FqGb7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4ePvA5pCdNfGOBy0Gqy0o8RZ/0s3yhIDs2OtreDNL7HwAHvM6B63Y0j3t1b9aYN/DO0HObrKVCsj8rLY5vevFWaml47knmQFvXA1rylQjH/EdvbdkwBK+ndvcsOpWLitmqFAZcNq7RqZiPYtROcXzym9P4skGgJzXdcLVT99Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23423 invoked by uid 109); 20 Feb 2024 02:12:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Feb 2024 02:12:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18668 invoked by uid 111); 20 Feb 2024 02:12:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Feb 2024 21:12:23 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Feb 2024 21:12:20 -0500
From: Jeff King <peff@peff.net>
To: Maarten Bosmans <mkbosmans@gmail.com>
Cc: git@vger.kernel.org, Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH v2 5/5] notes: use strbuf_attach to take ownership of the
 object contents
Message-ID: <20240220021220.GC2713741@coredump.intra.peff.net>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240218195938.6253-1-maarten.bosmans@vortech.nl>
 <20240218195938.6253-6-maarten.bosmans@vortech.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240218195938.6253-6-maarten.bosmans@vortech.nl>

On Sun, Feb 18, 2024 at 08:59:38PM +0100, Maarten Bosmans wrote:

> @@ -705,12 +703,11 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  		if (!prev_buf)
>  			die(_("unable to read %s"), oid_to_hex(note));
>  		if (size)
> -			strbuf_add(&buf, prev_buf, size);
> +			strbuf_attach(&buf, prev_buf, size, size + 1);
>  		if (d.buf.len && size)
>  			append_separator(&buf);
>  		strbuf_insert(&d.buf, 0, buf.buf, buf.len);
>  
> -		free(prev_buf);
>  		strbuf_release(&buf);
>  	}

Is it possible for "size" to be 0, but prev_buf to be non-NULL? I assume
it is so if the previous note is the empty object (and anyway, we'd have
died earlier if prev_buf was NULL). In that case your patch introduces a
leak (we do not attach prev_buf to buf, but we no longer free prev_buf).

I'm a little skeptical that this is actually increasing the speed of the
command in a measurable way, though. It's one allocation/copy, right
next to a big old strbuf_insert() that is going to splice into an
existing array.

-Peff
