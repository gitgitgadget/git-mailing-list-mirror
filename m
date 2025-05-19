Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34E257ACF
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641082; cv=none; b=VKrNwcmoZ9DVDXSJoqPJEjPZEPDfJYO+V6HX0+omiwJxdPu7lwGtilf2ZqPKJy0ouENbrhVw5e3claORmQULjFYwD9XrWxgXdvuSyjqcbUlSwz/2iStEyF/ne8ji9lLxbt3SQfZ5cRTV3zEhSGXA9Lex3j4ZrCr+a928YDmDukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641082; c=relaxed/simple;
	bh=KVzEUVencoKxrPAtwiSIod24VFLF0r/Qg1jDFrgNffo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6fqGkwGI0l/8H4Vsf2+LSj+FMKrfZkLMUsm0iG3BtRU71ASqtMsHoGTTEF8VFnF3/2EyUUBdXzUsQagsiqu57xYCCUDN8+2/SDhe74fHZ4UCyszpSQxMkfmL0rx7896qDT7yPdAB2EnYsRJRZmu3dP6o6/kuuS8z3x5slpbNhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UwniMgFb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UwniMgFb"
Received: (qmail 14751 invoked by uid 109); 19 May 2025 07:51:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KVzEUVencoKxrPAtwiSIod24VFLF0r/Qg1jDFrgNffo=; b=UwniMgFbn6Cq8pQe8e54MV+mcQaFRmZaSIjCCk9zY/K81SDzXyK9SQEOGyL0D2uaVXxvYD+XyLT3pez5ZYPnwXRjNOwq0KsFG5WCBl6y0FkJfhoD9vvD7ju6T55iw7chuMvD4f4v4QmIa8sEsFbLkCXynHx08y/Js9guV7V7Itla/cA8tdk75zBqu5Ty9izA5XGqwTl7LkZBdk0gzGjW0fizmEev8O3xQBvG/eDj6ogA+UtCpXn8mcC/03/guLnGIAvM74dRIhXsNPyCA1bwARbhP5QIEo32MP6vjVs/sDM03/M2mNc9c+rW08gHLvtTlxlxMY2y5Tzs2Rwww27mdg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 May 2025 07:51:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25387 invoked by uid 111); 19 May 2025 07:51:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 May 2025 03:51:24 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 May 2025 03:51:19 -0400
From: Jeff King <peff@peff.net>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/8] string-list: remove unused "insert_at" parameter
 from add_entry
Message-ID: <20250519075119.GE102701@coredump.intra.peff.net>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDU46MmoGPB60b@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCoDU46MmoGPB60b@ArchLinux>

On Sun, May 18, 2025 at 11:57:07PM +0800, shejialuo wrote:

> In "add_entry", we accept "insert_at" parameter which must be either -1
> (auto) or between 0 and `list->nr` inclusive. Any other value is
> invalid. When caller specify any invalid "insert_at" value, we won't
> check the range and move the element, which would definitely cause the
> trouble.
> 
> However, we only use "add_entry" in "string_list_insert" function and we
> always pass the "-1" for "insert_at" parameter. So, we never use this
> parameter to insert element in a user specified position. Let's delete
> this parameter. If there is any requirement later, we need to use a
> better way to do this.

We can see from looking at the code that removing this will not change
the behavior. But that always makes me wonder why it was there in the
first place, and whether we might ever want it.

The answer in this case is that we used to have another function,
string_list_insert_at_index(), which used the extra insert_at parameter.
The idea being that you could call string_list_find_insert_index(),
decide whether there was something already there, and then insert
without repeating the binary search.

But you can see in callers like 63226218ba (mailmap: use higher level
string list functions, 2014-11-24) that this was not really that useful
(in that commit we just try to insert and check the util pointer to see
if we need to add the auxiliary structure).

So the function went away in f8c4ab611a (string_list: remove
string_list_insert_at_index() from its API, 2014-11-24), and I suspect
we won't need it again. (Also, I think these days we'd probably use a
strmap instead anyway).

-Peff
