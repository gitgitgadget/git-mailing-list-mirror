Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88F4908B6
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728079; cv=none; b=hASfnmEUHss6/02PrstZs0FNQcLTfAFn6hbUwoUpVeAHZsgcIPIP6hDYElQyqA2mcB01l3D5M85/CsOD/8lqiuX5uCMtRU70oqNQZNGjgD1TndqNe6f+YOnaEryRWNPHt7hFLPNqDtTecfXwu2i2jdu8CCCTYQ+mAOoqeo8QcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728079; c=relaxed/simple;
	bh=N607LRfo5Iblv7nP1Y2ejtR4DQazboSymd22N6jdhPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpDp+rlUIlYfYYQjpOzEKcxyc64j92mXV2VvYxAaEonoN3hpIGtTOb7ZwLOQnXCv6SA0K4piMisatEKxeWCG1FRh5ML+9tzAlRd0s4RW8ItRF3HVRppoKqBv4ZnHbhV4MFSnc9BFj4JIFxkQ/XHM670EQlMjmWCpXDURRkIVOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GI/cGCn5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GI/cGCn5"
Received: (qmail 60771 invoked by uid 106); 14 Aug 2026 17:21:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=N607LRfo5Iblv7nP1Y2ejtR4DQazboSymd22N6jdhPw=; b=GI/cGCn5UeAXEFpMBxqL6RciA3RSdIzTUIaHwviVQt1Xh5b9S14W3zLAKLeptOScm80/Q50GfUaBvq9UEqkWnjpr80SaBtb6N21DkUjiNfuPkvFJEgIIOhnASSPBD6iy2SmttVBR7ZyGCRz+x6MarEl2k6MUM8bixV0ONBhxTu+aP2IRl5dldTq0tONHI2QZdqJnT1B92Kwi+j0qSUZ8k+H9Cn+Sf2DwC2CeT54k/GcoBrq0bm4N9UOESVUCDoulGk9o4WsVom77sIz0rCZuiGoLOhXbyigMzH6+UDRwKEVv82MITWcsP421MFLBmNh0Kq4Nb9i3ZY8zsa9zC0gk1Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2026 17:21:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 59269 invoked by uid 111); 14 Aug 2026 17:21:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2026 13:21:13 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Aug 2026 13:21:13 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <20260814172113.GC2563235@coredump.intra.peff.net>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>

On Wed, Aug 12, 2026 at 11:13:57AM +0200, Patrick Steinhardt wrote:

> Fix this by making the comparison self-contained in the object
> database. Instead of using `fspathhash()` and `fspatheq()` we resolve
> "core.ignoreCase" manually and then use the correct comparison function
> based on the result. This requires us to migrate to a `struct hashmap`,
> as the khash interface does not give us the ability to change these
> functions.

By the way, this bit about khash confused me. We can provide whatever
hash and equality functions we want. But I'm guessing maybe the issue is
that in the khash function interface khash expects, there's no extra
"void *" parameter you can use to store the bit to tell you whether to
be case insensitive or not?

-Peff
