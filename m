Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB333CFC
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450910; cv=none; b=lvrJmqLhcccUFjKej+xQ06iwLgMdYQlVi2AkCwM7lhaHVs+sPZijercyR5oAOKyC/bFoUh9v0R8y9UHwIzbkHT3HE5v2Mgm1mCfNoV6/io7Qp0hsNaHa/fOMVss9ix/rlNDYCRrKleOF7LuMxvRsE7mg2Sfom3hWUg+hPypeMqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450910; c=relaxed/simple;
	bh=ilfigXDiqIASp1l6kCaWK7Zpo7yIPKb90oRhSLVYKhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T+aoyzv3Cz7FXKR+J2PTzeQ0EcfdbnqyXB47q9N9gsHjBRFdLrF4+MiqoaIS1NtIXgK4hvxTNl2jNO8ZmyeQqBQ26lZfc3LeaINMG0Gfm6WtffiN+umKuFNtIXGVuPEs7W8NFWCgYxagQBRZLGeblWTuBoSYaX7wC4mjHgLyGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kB+G589W; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kB+G589W"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8902E3AC38;
	Wed, 31 Jul 2024 14:35:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ilfigXDiqIASp1l6kCaWK7Zpo7yIPKb90oRhSL
	VYKhw=; b=kB+G589WtUx7U1y4kQVBNHS5TmG4PrBABNCRTE0DQvv+jBkn06SUpf
	OjuXIl6f3RhhQ0BoonAsVz/8GnY8R0RmSyUWXx41RAOglK2IAkQ7kT0RMq4q3u9J
	IGzr309kqZ9rOZ4e5ihUiUcCV5VZMISvZqgGLrfqfeBz2TDUGOVBo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F2913AC36;
	Wed, 31 Jul 2024 14:35:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F4DE3AC35;
	Wed, 31 Jul 2024 14:35:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/4] promisor-remote: check advertised name or URL
In-Reply-To: <20240731134014.2299361-5-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 31 Jul 2024 15:40:14 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240731134014.2299361-5-christian.couder@gmail.com>
Date: Wed, 31 Jul 2024 11:35:03 -0700
Message-ID: <xmqqbk2d2yw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9B036050-4F6B-11EF-B6BD-BAC1940A682E-77302942!pb-smtp2.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> A previous commit introduced a "promisor.acceptFromServer" configuration
> variable with only "None" or "All" as valid values.
>
> Let's introduce "KnownName" and "KnownUrl" as valid values for this
> configuration option to give more choice to a client about which
> promisor remotes it might accept among those that the server advertised.

A malicous server can swich name and url correspondence.  The URLs
this repository uses to lazily fetch missing objects from are the
only thing that matters, and it does not matter what name the server
calls these URLs as, I am not sure what value, if any, KnownName has,
other than adding a potential security hole.

> In case of "KnownUrl", the client will accept promisor remotes which
> have both the same name and the same URL configured on the client as the
> name and URL advertised by the server.

This makes sense, especially if we had updates to documents I
suggested in my review of [3/4].  If the side effect of "accepting"
a suggested promisor remote were to only use it as a promisor remote
on this side, there is no reason to "accept" the same thing again,
but because the main effect at the protocol level of "accepting" is
to affect the behaviour of the server in such a way that it is now
allowed to omit objects that are requested but would be available
lazily from the promisor remotes in the response, we _do_ need to
be able to respond with the promisor remotes we are willing to and
have been using.

This iteration does not seem to have the true server side support to
slim its response by omitting objects that are available elsewhere,
but I agree that it is a good approach to get the protocol support
right.

Thanks.
