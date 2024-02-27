Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F3C56762
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022176; cv=none; b=lE4sILPwPzkRmBO2YPIFfk6ocrsCw+zM0266AWwijO7fSzCZyc23r72TYylje1seJkJFNhlJPLrl0NkSayGrfEtF8z/UF3wnUmSKgLcH+GyF/J+6d6RwxTxgkcb8dFVU5+yZrU7+nZElHAst81LDzQdb70fLienCp+fmuFcJQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022176; c=relaxed/simple;
	bh=MR1lDswHEuaoIFhFi6WLcQXYWESYJ2Uw/ITfc3xKIus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbvjr+NCfP1XQchimHHdNYYMz9MGBp3jzpVdb3GGAhttOuSbKFP5709G7xoXnCoVTXXfn87FpFGzoMzthkjccjYDuz/Q5Sfw6W5C21jTWwlWcNlOnBP1VcX/0hJw4457h3IW9+PkM8LZTT2z9+++ju8z+pDCBeGfjruPh8eSYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11548 invoked by uid 109); 27 Feb 2024 08:22:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Feb 2024 08:22:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7472 invoked by uid 111); 27 Feb 2024 08:22:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Feb 2024 03:22:58 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Feb 2024 03:22:53 -0500
From: Jeff King <peff@peff.net>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v1 3/4] builtin/repack.c: change xwrite to write_in_full
 to allow large sizes.
Message-ID: <20240227082253.GI3263678@coredump.intra.peff.net>
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>
 <20240226220539.3494-4-randall.becker@nexbridge.ca>
 <20240227082027.GH3263678@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227082027.GH3263678@coredump.intra.peff.net>

On Tue, Feb 27, 2024 at 03:20:27AM -0500, Jeff King wrote:

> OK, so we detect the error and return it to the caller. Who is the
> caller? The only use of this function is in repack_promisor_objects(),
> which calls:
> 
>         for_each_packed_object(write_oid, &cmd,
>                                FOR_EACH_OBJECT_PROMISOR_ONLY);
> 
> So when we return the error, now for_each_packed_object() will stop
> traversing, and propagate that error up to the caller. But as we can see
> above, the caller ignores it!

Oh, one other thing I meant to mention: as the test failure you saw was
related to repacking, this seemed like a likely culprit. But the code is
only triggered when repacking promisor objects in a partial clone, and
it didn't look like the test you posted covered that (it was just about
cruft packs). So I would not expect this code to be run at all in the
failing test you saw.

-Peff
