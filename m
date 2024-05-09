Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7317F5
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272457; cv=none; b=k8yiEYn0prBNmO/kdyGCgMo/Zu3zwOLbSpunExcKfiD2GErRA0g+cWR9X0fz8RFcQhEWSJIiEuyRarZuNkgemCcwfhXdninwuDdFKMxNznku8QKSZQwLt+Mp/PHiPlJABlIuf1Pg1YqDtyeDtqZgFYfH0Pl6sCiP2/3qpFSWdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272457; c=relaxed/simple;
	bh=F4d9hLet03BAFr6zG48SF3nCmFwlUXnB93xe1Dj7Qb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ++jJjSxeig4y8LweS/EcsrH3eTfV6+7c1xeo1EgJ7XNqquHMrCbGN3NVEA9Oe3Go4yLQxEdeESSQ4beO7m/+y6GVgHNyD35N1+bAzr5n0d8hSJ3wtOz961VT8g6e9QSNM6zYKps2pFIBPhUMCmdJaaeYF4ZQ71E8VFCU4x6fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6940 invoked by uid 109); 9 May 2024 16:34:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 May 2024 16:34:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31217 invoked by uid 111); 9 May 2024 16:34:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 May 2024 12:34:16 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 May 2024 12:34:14 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] http: add the ability to log progress
Message-ID: <20240509163414.GA1708095@coredump.intra.peff.net>
References: <20240508124453.600871-1-toon@iotcl.com>
 <20240508124453.600871-3-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240508124453.600871-3-toon@iotcl.com>

On Wed, May 08, 2024 at 02:44:51PM +0200, Toon Claes wrote:

> @@ -1457,6 +1458,9 @@ struct active_request_slot *get_active_slot(void)
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
>  	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
>  	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
> +	curl_easy_setopt(slot->curl, CURLOPT_NOPROGRESS, 1L);
> +	curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, NULL);
> +	curl_easy_setopt(slot->curl, CURLOPT_XFERINFOFUNCTION, NULL);

These last two CURLOPTs appeared in 7.32.0, but our INSTALL doc claims
to support back to 7.21.3. Before that you're supposed to use
PROGRESSFUNCTION instead, which has a slightly different signature. I
think you could support both, though it would also be OK to just disable
this extra progress for antique curl.

It might also be reasonable to just bump to 7.32.0 as our minimum. The
last bump was recent via c28ee09503 (INSTALL: bump libcurl version to
7.21.3, 2024-04-02), and the version picked there was arbitrary-ish (it
was something we had happened to depend on accidentally). 7.32.0 is
itself almost 11 years old now.

-Peff
