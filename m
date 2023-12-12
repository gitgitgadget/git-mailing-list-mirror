Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62B899
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 16:52:29 -0800 (PST)
Received: (qmail 4975 invoked by uid 109); 12 Dec 2023 00:52:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 00:52:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8682 invoked by uid 111); 12 Dec 2023 00:52:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Dec 2023 19:52:28 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Dec 2023 19:52:28 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH 0/7] fix segfaults with implicit-bool config
Message-ID: <20231212005228.GB376323@coredump.intra.peff.net>
References: <20231207071030.GA1275835@coredump.intra.peff.net>
 <ZXF-7AMZ_SBltplk@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXF-7AMZ_SBltplk@tanuki>

On Thu, Dec 07, 2023 at 09:14:36AM +0100, Patrick Steinhardt wrote:

> Thanks for working on this topic! I've left a couple of comments, most
> of which are about whether we should retain previous behaviour where we
> generate a warning instead of raising an error for unknown values.

Thanks for taking a look. I see what you're saying about the warnings,
but IMHO it's not worth the extra complexity. Returning early means the
existing code can proceed without worrying about NULLs. Though I suppose
we could have a "warn_error_nonbool()" which issues a warning and
returns 0.

Still, the "return config_error_nonbool()" pattern is pretty
well-established and used for most options. I would go so far as to say
the ones that warn for invalid values are the odd ones out, and probably
should be returning errors as well (though doing so now may not be worth
the trouble and risk of annoyance).

And certainly there should be no regressions in this series; every case
is currently a segfault, so returning an error is a strict improvement.
I'd just as soon stay strict there, as it's easier to loosen later if we
choose than to tighten.

-Peff
