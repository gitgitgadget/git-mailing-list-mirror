Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8188413D276
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273727; cv=none; b=tlGIM5o7EEuMfNXYgn4SiUykcdlctL9fgzdjUdyDP3MipXeeT+F2V9oTU9wNmaGcu3dvnkjJy0yC8v8R4Z4Vjqn9MmCUVhTfEMU7XDuau3EJS40QQ4pNfYwxa+oQTbSikJTioUSkemz9UDw24G1QgHprk10cg5f1Yn5eZ+V64/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273727; c=relaxed/simple;
	bh=+R3cb6rJgwE8vpTn0cbmXd8LLd/1Uk8YwvSsTIUIIJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI+xgci30VBAL7V7LIC/q82Wv7xKanccKclI8X3QjFeCVfpQbJ4SDFfd1pqjywZQIBQreJyEGOX9wqtNdJtsa9ecR9BZFckGKNnQlrj8EuvD8iHbVA5SEVAPoi4U/iatlxcyOLntENUlxs7YA+tKoTNqTiqe9aHJGPNc8J3q1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26250 invoked by uid 109); 13 Jun 2024 10:15:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Jun 2024 10:15:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15958 invoked by uid 111); 13 Jun 2024 10:15:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Jun 2024 06:15:20 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Jun 2024 06:15:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ci: compile "linux-gcc-default" job with -Og
Message-ID: <20240613101522.GC817573@coredump.intra.peff.net>
References: <cover.1717655210.git.ps@pks.im>
 <cover.1718001244.git.ps@pks.im>
 <03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
 <xmqqed946auc.fsf@gitster.g>
 <xmqqo785olpp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo785olpp.fsf@gitster.g>

On Wed, Jun 12, 2024 at 03:11:30PM -0700, Junio C Hamano wrote:

> By the way, I do not know if any compiler gives us such a feature,
> but if the trick to squelch a false positive were finer grained, I
> would have been much more receptive to the idea of building with
> different optimization level, allowing a bit more false positives.
> 
> The workaround everybody jumps at is to initialize the variable to a
> meaningless value (like 0) and I have explained why it is suboptimal
> already.  But if we can tell less intelligent compilers "we know our
> use of this variable AT THIS POINT is safe", e.g. by annotating the
> above snippet of the code, perhaps like this:
> 
>                 if (ret) {
>                         if (data)
> 				/* -Wno-uninitialized (mtimes_size) */
>                                 munmap(data, mtimes_size);
> 			printf("debug %d\n", (int)mtimes_size);
> 
> then it would be clear to the compiler that understand the
> annotation that inside that "if (data)" block, we know that
> the use of mtimes_size is not using an uninitialized variable.
> 
> For the use of the same variable on the next "debug" line, because
> it is outside of that "if (data)" block, the annotation should have
> no effect, and the compiler is free to do its own analysis and we
> will accept if it finds mtimes_size can be used uninitialized there.
> Any new use added for the same variable will not be masked by a
> meaningless initialization if we can use such a "workaround" to
> squelch false positives.

I agree that such an annotation is much more focused. It's still not
foolproof, though (e.g., we might chance earlier code so that the
data/mtimes_size correlation is no longer true).

I think you could do it with:

			if (data)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wuninitialized"
				munmap(data, mtimes_size);
#pragma GCC diagnostic pop

which is...ugly. There's a _Pragma() operator, too, which I think would
let you make a macro like:

			if (data)
				SUPPRESS("-Wuninitialized", munmap(data, mtimes_size));

which is maybe slightly less horrific? Still pretty magical though.

But if the alternative is to do none of that, and just continue to avoid
looking for warnings with -Os, I prefer that.

-Peff
