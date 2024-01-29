Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6733F9FE
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552088; cv=none; b=u/M1kPORzZsY6c7wxaWdQAulaDz6TicNG1dYU+FeiFCtZpmIMrODQXHofftob96b77QDpJk+dvdm7MJtG3Q5fWZ7UgH0K1LibI91dmhx2cAfk160ThpG3O1BsrY8A2zjoZFTal/RpbwM5Uhiw0JQuR5PJ+pQxTOzmc+LoFF6IcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552088; c=relaxed/simple;
	bh=kQNO2Ornv3u7AB3RUBLNeU9utHy3tr9JYIttbAyUtfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdGxXPd6OD9YfuPJfnCa503YG67101Gqv1IQkHWT0UZqWkqsJSdlnlj+xtfXIxWEgAiZPIPPDNukOdNWgxigXoY64WeLUMR4hdXJev69PHPryHuFizgnVPQfOO97FpoLlqaZgV32gF1Mwy88RUzLKtQ2VoFZVk6igt2p8hqhXMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 302 invoked by uid 109); 29 Jan 2024 18:14:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jan 2024 18:14:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23639 invoked by uid 111); 29 Jan 2024 18:14:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jan 2024 13:14:42 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Jan 2024 13:14:41 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-bitmap: drop unused `reuse_objects`
Message-ID: <20240129181441.GB3765717@coredump.intra.peff.net>
References: <0bbaf9a3591765161872fb71383263edb0c7ef83.1706328008.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0bbaf9a3591765161872fb71383263edb0c7ef83.1706328008.git.me@ttaylorr.com>

On Fri, Jan 26, 2024 at 11:00:50PM -0500, Taylor Blau wrote:

> This variable is no longer used for doing verbatim pack-reuse (or
> anywhere within pack-bitmap.c) since d2ea031046 (pack-bitmap: don't rely
> on bitmap_git->reuse_objects, 2019-12-18).
> 
> Remove it to avoid an unused struct member.

Good catch. This has been sitting unused for quite some time. I wonder
if there is a way to convince the compiler to tell us about unused
struct fields. I guess that would imply a view of the whole linked
program (though in this case the type is local to a single translation
unit). And would probably produce a horrible number of false positives
for structs defined in system headers.

Possibly static analyzers like coverity could help here, but it does not
seem to find this case (or if it did, I could not find it amidst all of
the false positives).

Anyway, your patch is obviously the right thing to do. :)

-Peff
