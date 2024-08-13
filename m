Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C724C8C
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548279; cv=none; b=s6K2TUQ2ypMYVCK3hFe8GqvhFLPId4uBYP503b7+EhmS2Yh+tJQJZyKox57WYMBuO1tQbw4BUTswZJQ01vEj2avWgGcdFvDFVn7i6WrF7kuMFnWqbzn/YUqzNvgqG+7f+N6VLslEtSGK6gySmhgRxr/laLTGYOLzaHwfrQ83+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548279; c=relaxed/simple;
	bh=cEtS/TYqlPrp39TtfGfz/b/DD6ezhoOwg1MyX5LONl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0akOS5R4J2W0+yNQ84WYKX2c6AUVlpXsgqv/jNWGVkVytcGIDm+Al+E02eUGTzfQYYxawDQo4lr8vUl8HaUf6EZUZ4l/7zBXwHnMZTy5Au2DHwsJ43huExvJGX+EFEooCLHs62UQevS79QZ6lr8AZiuFGX6U/JxomPrrlVqpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3867 invoked by uid 109); 13 Aug 2024 11:24:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Aug 2024 11:24:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6120 invoked by uid 111); 13 Aug 2024 11:24:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Aug 2024 07:24:34 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Aug 2024 07:24:34 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, ArcticLampyrid <ArcticLampyrid@outlook.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] bundle: default to SHA1 when reading bundle headers
Message-ID: <20240813112434.GA968816@coredump.intra.peff.net>
References: <TYWP301MB0563973ECA440E7DAF0F7E89C4852@TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM>
 <cover.1723540604.git.ps@pks.im>
 <7e15c3daf95283f62030fe7b5dd0bbf8e467881a.1723540604.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e15c3daf95283f62030fe7b5dd0bbf8e467881a.1723540604.git.ps@pks.im>

On Tue, Aug 13, 2024 at 11:18:15AM +0200, Patrick Steinhardt wrote:

> This is only a symptom of a deeper issue though. Bundles default to the
> SHA1 object format unless they advertise an "@object-format=" header.
> Consequently, it has been wrong in the first place to use the object
> format used by the current repository when parsing bundles. The
> consequence is that trying to open a bundle that uses a different object
> hash than the current repository will fail:
> 
>     $ git bundle list-heads sha1.bundle
>     error: unrecognized header: ee4b540943284700a32591ad09f7e15bdeb2a10c HEAD (45)

That makes sense. And your test below, which covers a mismatch in the
hash of the bundle vs the containing repo, would have failed even before
the segfault issue. Nice.

> Fix the bug by defaulting to the SHA1 object hash. We already handle the
> "@object-format=" header as expected, so we don't need to adapt this
> part.

Yeah, this fix turned out to be delightfully simple as a result.

Both this patch and the first one look good to me. Thanks for jumping on
this.

-Peff
