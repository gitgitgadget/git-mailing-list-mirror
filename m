Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AC38DE0
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755622; cv=none; b=Eyj9+YlOfRK6iNYFo2U5mhxH84FCNY2jKPDIM3v7S78TOw8YxWzXv1rzS+pkSHN9EPOfR205shZMVtebyhq52ZY/Km2suMKSseYdyxg8OV1B+oIa1We3PFLYVuM9XfKpgLEwzFzmfL8CYYl1GcJBFAX4ZK0Zxn7A7X9dOzi9z2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755622; c=relaxed/simple;
	bh=4LB3RBsR2zpz48xW2SZjKE0GSY/Ilvc3VdvCRLquoQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLC2r19crBmpr6Mp7nWaCTPD41gFiQfSE/8+YwyggVJTTBTPHNWprP7kBQXZrRjKjoGcJzF2Xo8CAHX32wVigsbqWEyGEsM7f1I4wP3wgoatwYfOrFb49J73jMbT+uX8MxIAxYKm4QLaCuIFglANtXhvI1tOZ0KU4IGQPCso0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15811 invoked by uid 109); 15 May 2024 06:46:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 May 2024 06:46:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30984 invoked by uid 111); 15 May 2024 06:47:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 May 2024 02:47:03 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 May 2024 02:46:58 -0400
From: Jeff King <peff@peff.net>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com
Subject: Re: [PATCH] fetch-pack: Remove unused struct 'loose_object_iter'
Message-ID: <20240515064658.GE110841@coredump.intra.peff.net>
References: <20240512005913.342287-1-dave@treblig.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240512005913.342287-1-dave@treblig.org>

On Sun, May 12, 2024 at 01:59:13AM +0100, Dr. David Alan Gilbert wrote:

> 'loose_object_iter' in fetch-pack.c is unused since
> commit 97b2fa08b6b9ee3e ("fetch-pack: drop custom loose object cache")
> Remove it.

Thanks, this was my fault for leaving it in. The patch looks obviously
good.

I wish there was a good way to get the compiler to report on unused
types, but I don't think there is (it's a complicated problem in
general, but file-local ones like this feel like they should be easy to
spot).

Here's a really hacky (and quadratic) attempt to find defined structs
that aren't mentioned elsewhere:

  for i in $(git grep -ho '^struct [a-z_]* {' | cut -d' ' -f2)
  do
	used=$(git grep -Phc "\b$i\b" |
	       perl -ne '$x += $_; END { print $x }')
	echo "$used $i"
  done |
  sort -n

which finds exactly one unused struct, the one in this patch.

-Peff
