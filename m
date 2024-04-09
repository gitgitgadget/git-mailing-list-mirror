Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74BA376
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621060; cv=none; b=uXtrFxF2N4A4FWDYxFcymjl3MThmpNOeQQmwEjGfdK6rSxySc+Ml0n3HXnAE91IrS+n3Hctym4yaSAZSRl41qjWc0OqtKX77Ryxq+YK0OmHZvb+JbNVBU27PT/LvwPkaacB8xeP7qOYj5a5X70al5vGHhuT+lJc6tY1HQYISR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621060; c=relaxed/simple;
	bh=smcGjZk44wEmQ0CwakodIB0MzHWJ70CkHL7BnMzzccA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwTszYIlL0FFZQpEmIgGBWwaPkFs8VSohEzoIi8IiOP5+eclkV6qborlJwGtdt8wvjXczLL/iGv6sW5tnAiU3NwqwwsUbSPvi/26bH5h0Mwswitj/NCC8R6sT2vwCf2wNA7B6CujiUuQVDYP8USW+TxMyiLsYGQGQ8bQPnThT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31988 invoked by uid 109); 9 Apr 2024 00:04:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Apr 2024 00:04:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30520 invoked by uid 111); 9 Apr 2024 00:04:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Apr 2024 20:04:17 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Apr 2024 20:04:14 -0400
From: Jeff King <peff@peff.net>
To: Paul Smith <psmith@gnu.org>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org,
	Dario Gjorgjevski <dario.gjorgjevski@gmail.com>
Subject: Re: [PATCH] Makefile(s): avoid recipe prefix in conditional
 statements
Message-ID: <20240409000414.GA1647304@coredump.intra.peff.net>
References: <CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
 <9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
 <xmqqle5n8rcr.fsf@gitster.g>
 <606990048585347654f3b4b187ec27f4dc1b85e3.camel@gnu.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <606990048585347654f3b4b187ec27f4dc1b85e3.camel@gnu.org>

On Mon, Apr 08, 2024 at 07:24:16PM -0400, Paul Smith wrote:

> If you wanted to make an even bigger change, which might save some
> hair-pulling down the road but is a very serious decision, you could
> introduce the use of the .RECIPEPREFIX [1] variable to change the
> recipe prefix from TAB to some other character (as it should have been
> when make was created back in the 1970's).
> 
> .RECIPEPREFIX was introduced in GNU Make 3.82, which was released in
> 2010 FYI.

Unfortunately, that's too recent for us. :( We try to keep the GNU make
dependency to 3.81, since that's the latest one Apple ships (because
they're allergic to GPLv3). Obviously it's not impossible to jump past
that and require people to install make via homebrew, etc, but that
makes it a more significant version bump than usual.

I do find it curious that in:

ifdef FOO
	SOME_VAR += bar
endif

the tab is significant for "ifdef" but not for SOME_VAR (at least that
is implied by Taylor's patch, which does not touch the bodies within the
conditionals).

I may just be showing my ignorance of the parsing issue, though. For
anybody else digging into the details, I think the correct link is:

  https://savannah.gnu.org/bugs/index.php?64185

(the commit has the wrong bug number, 64815).

-Peff
