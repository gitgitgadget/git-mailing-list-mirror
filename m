Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D23718A93A
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967821; cv=none; b=F+DEXYMa51prvjO711JA+VNn/JPOJzgaGMyoF+76P1zd3BhU1NwjrX7Nrw3583wDEfJuyS8DAlc3eerzvQEfQn8LZE/y6GYrw5n4dU4RyKJJuUsqfmNJXbd9Pu7Jn6XU+egpfwcP4NGJH1Fi98qhdLgNsmzCKfyhnND6h2sUFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967821; c=relaxed/simple;
	bh=ApA638zy7FviaJ0jtIZJdGIy8gD5tH4x1lRxoPecqB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc8LaMfeYNF5IjloLz5+iCdnfRgGnGvrYw55s0eDQNV4Gtna3AajP2XIAALJsfLOlFi+bHphDgGjUMIKbw4Euwo1HhDYcIGfEPk5g8pePel/rZ6Z0woDctiHzE7gfHAmkIli1+Uzx7X79pzHVqWNVn9IXIa4pvVAgiUdIlda5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6668 invoked by uid 109); 29 Aug 2024 21:43:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 21:43:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11786 invoked by uid 111); 29 Aug 2024 21:43:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 17:43:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 17:43:36 -0400
From: Jeff King <peff@peff.net>
To: Pavel Rappo <pavel.rappo@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,
	Git mailing list <git@vger.kernel.org>
Subject: Re: How to turn off rename detection for cherry-pick?
Message-ID: <20240829214336.GA440013@coredump.intra.peff.net>
References: <CAChcVumj41NCAcjzLyDGAyb+-QuL0Ha1AANe67jKVBT8xDRYdg@mail.gmail.com>
 <CAChcVunYDO_KAmEOoWEL2q63_Gzua-Kt3BmE5Snb8==K9Cww1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAChcVunYDO_KAmEOoWEL2q63_Gzua-Kt3BmE5Snb8==K9Cww1w@mail.gmail.com>

On Thu, Aug 29, 2024 at 09:47:52AM +0100, Pavel Rappo wrote:

> The reason I ask this is that we've run into a (probably practically
> rare) case where cherry-pick changes a wrong file. We want to be able
> to detect such cases.

You can pass merge strategy options on the command line. The old
"recursive" strategy has a "no-renames" option, so:

  git cherry-pick --strategy=recursive -Xno-renames feature

generates a modify/delete conflict for your example. Curiously, the
modern default, "ort", does not seem to respect that option. You can
bump up the limit to require exact renames, though, which does prevent
the mismerge in your case. Like:

  git cherry-pick -Xfind-renames=100% feature

There are also other strategies that do not do rename detection, but I
think you are better off using one of the more commonly-used strategies
and just disabling renames. IMHO it's a bug that ort doesn't respect
-Xno-renames.

-Peff
